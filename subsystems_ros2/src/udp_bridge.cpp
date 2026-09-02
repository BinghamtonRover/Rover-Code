#include <atomic>
#include <memory>
#include <mutex>
#include <string>
#include <unordered_map>
#include <vector>

#include "boost/asio.hpp"
#include "rclcpp/rclcpp.hpp"
#include "subsystems_ros2/msg/wrapped_protobuf.hpp"
#include "subsystems_ros2/utils.hpp"
#include "subsystems_ros2/generated/core.pb.h"
#include "subsystems_ros2/generated/status.pb.h"
#include "subsystems_ros2/generated/video.pb.h"
#include "subsystems_ros2/generated/wrapper.pb.h"

namespace subsystems_ros2
{

// The Dashboard expects each rover program (Subsystems, Video, Autonomy, ...) to speak the BURT
// handshake on its own port. The ROS2 programs only publish/subscribe ROS topics, so this bridge
// impersonates them over UDP: it answers handshakes addressed to each device and relays data
// between the UDP socket and the corresponding ROS topics.
constexpr int VIDEO_PORT = 8002;

class UdpBridge : public rclcpp::Node
{
public:
  UdpBridge()
  : Node("udp_bridge"),
    socket_(io_context_, boost::asio::ip::udp::endpoint(boost::asio::ip::udp::v4(), DEFAULT_PORT))
  {
    this->declare_parameter<int>("port", DEFAULT_PORT);
    this->declare_parameter<int>("video_port", VIDEO_PORT);
    this->declare_parameter<int>("max_clients", 5);
    stopped_.store(false);

    incoming_pub_ = this->create_publisher<WrappedProtobuf>("/burt/incoming", 100);
    outgoing_sub_ = this->create_subscription<WrappedProtobuf>(
      "/burt/outgoing", 100,
      std::bind(&UdpBridge::onOutgoing, this, std::placeholders::_1));

    // Video program bridge: publish UDP-received commands for the video program,
    // and relay VideoData / command echoes back out over UDP to connected dashboards.
    video_command_pub_ = this->create_publisher<WrappedProtobuf>("/burt/video_command", 100);
    video_data_sub_ = this->create_subscription<WrappedProtobuf>(
      "/burt/video_data", 100,
      std::bind(&UdpBridge::onVideoData, this, std::placeholders::_1));
    video_echo_sub_ = this->create_subscription<WrappedProtobuf>(
      "/burt/video_command_echo", 100,
      std::bind(&UdpBridge::onVideoData, this, std::placeholders::_1));

    this->get_parameter("video_port", video_port_);
    video_socket_.open(boost::asio::ip::udp::v4());
    video_socket_.bind(boost::asio::ip::udp::endpoint(boost::asio::ip::udp::v4(), video_port_));

    startReceive();
    startVideoReceive();
    io_thread_ = std::thread([this]() { io_context_.run(); });
    video_io_thread_ = std::thread([this]() { video_io_context_.run(); });

    heartbeat_timer_ = this->create_wall_timer(
      std::chrono::seconds(1), std::bind(&UdpBridge::checkHeartbeats, this));

    RCLCPP_INFO(this->get_logger(), "UDP bridge listening on port %d (video on port %d)",
      DEFAULT_PORT, video_port_);
  }

  ~UdpBridge()
  {
    stopped_.store(true);
    boost::system::error_code ec;
    socket_.close(ec);
    video_socket_.close(ec);
    io_context_.stop();
    video_io_context_.stop();
    if (io_thread_.joinable()) {
      io_thread_.join();
    }
    if (video_io_thread_.joinable()) {
      video_io_thread_.join();
    }
  }

private:
  using WrappedProtobuf = subsystems_ros2::msg::WrappedProtobuf;

  void startReceive()
  {
    if (stopped_.load()) {
      return;
    }
    recv_buffer_.resize(65535);
    socket_.async_receive_from(
      boost::asio::buffer(recv_buffer_), sender_endpoint_,
      [this](const boost::system::error_code & error, std::size_t bytes_transferred)
      {
        if (!error && bytes_transferred > 0) {
          handlePacket(bytes_transferred);
        }
        if (!stopped_.load()) {
          startReceive();
        }
      });
  }

  void handlePacket(std::size_t size)
  {
    WrappedMessage wrapper;
    if (!wrapper.ParseFromArray(recv_buffer_.data(), static_cast<int>(size))) {
      RCLCPP_WARN(this->get_logger(), "Received malformed UDP packet");
      return;
    }

    if (wrapper.name() == Connect::descriptor()->full_name()) {
      Connect heartbeat;
      heartbeat.ParseFromString(wrapper.data());
      handleHeartbeat(heartbeat);
      return;
    }
    if (wrapper.name() == UpdateSetting::descriptor()->full_name()) {
      UpdateSetting settings;
      settings.ParseFromString(wrapper.data());
      handleSettings(settings);
      return;
    }

    WrappedProtobuf msg;
    msg.name = wrapper.name();
    msg.data.assign(wrapper.data().begin(), wrapper.data().end());
    incoming_pub_->publish(msg);
  }

  void handleHeartbeat(const Connect & heartbeat)
  {
    if (heartbeat.receiver() != SUBSYSTEMS) {
      return;
    }
    auto source = std::make_pair(sender_endpoint_.address().to_string(), sender_endpoint_.port());
    {
      std::lock_guard<std::mutex> lock(destinations_mutex_);
      destinations_[source] = std::chrono::steady_clock::now();
    }

    Connect response;
    response.set_sender(SUBSYSTEMS);
    response.set_receiver(heartbeat.sender());
    sendMessage(wrapMessage(response), source);
  }

  void handleSettings(const UpdateSetting & settings)
  {
    auto source = std::make_pair(sender_endpoint_.address().to_string(), sender_endpoint_.port());
    sendMessage(wrapMessage(settings), source);
  }

  void onOutgoing(const WrappedProtobuf::SharedPtr msg)
  {
    WrappedMessage wrapper;
    wrapper.set_name(msg->name);
    wrapper.set_data(std::string(msg->data.begin(), msg->data.end()));
    sendWrapper(wrapper);
  }

  void sendWrapper(const WrappedMessage & wrapper)
  {
    std::string data = wrapper.SerializeAsString();
    std::vector<std::pair<std::string, int>> destinations;
    {
      std::lock_guard<std::mutex> lock(destinations_mutex_);
      destinations.reserve(destinations_.size());
      for (const auto & [dest, last_seen] : destinations_) {
        destinations.push_back(dest);
      }
    }
    for (const auto & dest : destinations) {
      try {
        boost::asio::ip::udp::endpoint endpoint(
          boost::asio::ip::address::from_string(dest.first), dest.second);
        socket_.send_to(boost::asio::buffer(data), endpoint);
      } catch (const std::exception & e) {
        RCLCPP_WARN(this->get_logger(), "Failed to send UDP message: %s", e.what());
      }
    }
  }

  void sendMessage(const WrappedMessage & wrapper, const std::pair<std::string, int> & destination)
  {
    try {
      std::string data = wrapper.SerializeAsString();
      boost::asio::ip::udp::endpoint endpoint(
        boost::asio::ip::address::from_string(destination.first), destination.second);
      socket_.send_to(boost::asio::buffer(data), endpoint);
    } catch (const std::exception & e) {
      RCLCPP_WARN(this->get_logger(), "Failed to send UDP message: %s", e.what());
    }
  }

  void checkHeartbeats()
  {
    auto now = std::chrono::steady_clock::now();
    {
      std::lock_guard<std::mutex> lock(destinations_mutex_);
      for (auto it = destinations_.begin(); it != destinations_.end();) {
        if (std::chrono::duration_cast<std::chrono::seconds>(now - it->second).count() > 3) {
          it = destinations_.erase(it);
        } else {
          ++it;
        }
      }
      std::lock_guard<std::mutex> video_lock(video_destinations_mutex_);
      for (auto it = video_destinations_.begin(); it != video_destinations_.end();) {
        if (std::chrono::duration_cast<std::chrono::seconds>(now - it->second).count() > 3) {
          it = video_destinations_.erase(it);
        } else {
          ++it;
        }
      }
    }
    bool any_destinations = false;
    bool any_video_destinations = false;
    {
      std::lock_guard<std::mutex> lock(destinations_mutex_);
      any_destinations = !destinations_.empty();
      any_video_destinations = !video_destinations_.empty();
    }
    if (any_destinations) {
      Connect heartbeat;
      heartbeat.set_sender(SUBSYSTEMS);
      heartbeat.set_receiver(DASHBOARD);
      sendWrapper(wrapMessage(heartbeat));
    }
    if (any_video_destinations) {
      Connect heartbeat;
      heartbeat.set_sender(VIDEO);
      heartbeat.set_receiver(DASHBOARD);
      std::string data = wrapMessage(heartbeat).SerializeAsString();
      std::lock_guard<std::mutex> lock(video_destinations_mutex_);
      for (const auto & [dest, last_seen] : video_destinations_) {
        try {
          boost::asio::ip::udp::endpoint endpoint(
            boost::asio::ip::address::from_string(dest.first), dest.second);
          video_socket_.send_to(boost::asio::buffer(data), endpoint);
        } catch (const std::exception & e) {
          RCLCPP_WARN(this->get_logger(), "Failed to send video heartbeat: %s", e.what());
        }
      }
    }
  }

  // ----- Video program bridge (impersonates Device.VIDEO on its own port) -----

  void startVideoReceive()
  {
    if (stopped_.load()) {
      return;
    }
    video_recv_buffer_.resize(65535);
    video_socket_.async_receive_from(
      boost::asio::buffer(video_recv_buffer_), video_sender_endpoint_,
      [this](const boost::system::error_code & error, std::size_t bytes_transferred)
      {
        if (!error && bytes_transferred > 0) {
          handleVideoPacket(bytes_transferred);
        }
        if (!stopped_.load()) {
          startVideoReceive();
        }
      });
  }

  void handleVideoPacket(std::size_t size)
  {
    WrappedMessage wrapper;
    if (!wrapper.ParseFromArray(video_recv_buffer_.data(), static_cast<int>(size))) {
      RCLCPP_WARN(this->get_logger(), "Received malformed UDP packet on the video port");
      return;
    }

    if (wrapper.name() == Connect::descriptor()->full_name()) {
      Connect heartbeat;
      heartbeat.ParseFromString(wrapper.data());
      handleVideoHeartbeat(heartbeat);
      return;
    }

    // Anything else addressed to the video program (eg, VideoCommand) goes to ROS.
    WrappedProtobuf msg;
    msg.name = wrapper.name();
    msg.data.assign(wrapper.data().begin(), wrapper.data().end());
    video_command_pub_->publish(msg);
  }

  void handleVideoHeartbeat(const Connect & heartbeat)
  {
    if (heartbeat.receiver() != VIDEO) {
      return;
    }
    auto source = std::make_pair(
      video_sender_endpoint_.address().to_string(), video_sender_endpoint_.port());
    {
      std::lock_guard<std::mutex> lock(video_destinations_mutex_);
      video_destinations_[source] = std::chrono::steady_clock::now();
    }

    Connect response;
    response.set_sender(VIDEO);
    response.set_receiver(heartbeat.sender());
    try {
      std::string data = wrapMessage(response).SerializeAsString();
      boost::asio::ip::udp::endpoint endpoint(
        boost::asio::ip::address::from_string(source.first), source.second);
      video_socket_.send_to(boost::asio::buffer(data), endpoint);
    } catch (const std::exception & e) {
      RCLCPP_WARN(this->get_logger(), "Failed to send video heartbeat response: %s", e.what());
    }
  }

  void onVideoData(const WrappedProtobuf::SharedPtr msg)
  {
    WrappedMessage wrapper;
    wrapper.set_name(msg->name);
    wrapper.set_data(std::string(msg->data.begin(), msg->data.end()));
    std::string data = wrapper.SerializeAsString();

    std::lock_guard<std::mutex> lock(video_destinations_mutex_);
    for (const auto & [dest, last_seen] : video_destinations_) {
      try {
        boost::asio::ip::udp::endpoint endpoint(
          boost::asio::ip::address::from_string(dest.first), dest.second);
        video_socket_.send_to(boost::asio::buffer(data), endpoint);
      } catch (const std::exception & e) {
        RCLCPP_WARN(this->get_logger(), "Failed to send video data: %s", e.what());
      }
    }
  }

  boost::asio::io_context io_context_;
  boost::asio::io_context video_io_context_;
  boost::asio::ip::udp::socket socket_;
  boost::asio::ip::udp::socket video_socket_{video_io_context_};
  boost::asio::ip::udp::endpoint sender_endpoint_;
  boost::asio::ip::udp::endpoint video_sender_endpoint_;
  std::thread io_thread_;
  std::thread video_io_thread_;
  std::vector<uint8_t> recv_buffer_;
  std::vector<uint8_t> video_recv_buffer_;
  std::atomic<bool> stopped_{false};
  int video_port_ = VIDEO_PORT;

  rclcpp::Publisher<WrappedProtobuf>::SharedPtr incoming_pub_;
  rclcpp::Subscription<WrappedProtobuf>::SharedPtr outgoing_sub_;
  rclcpp::TimerBase::SharedPtr heartbeat_timer_;

  rclcpp::Publisher<WrappedProtobuf>::SharedPtr video_command_pub_;
  rclcpp::Subscription<WrappedProtobuf>::SharedPtr video_data_sub_;
  rclcpp::Subscription<WrappedProtobuf>::SharedPtr video_echo_sub_;

  struct PairHash
  {
    std::size_t operator()(const std::pair<std::string, int> & p) const
    {
      return std::hash<std::string>()(p.first) ^ std::hash<int>()(p.second);
    }
  };

  std::mutex destinations_mutex_;
  std::unordered_map<std::pair<std::string, int>, std::chrono::steady_clock::time_point, PairHash> destinations_;

  std::mutex video_destinations_mutex_;
  std::unordered_map<std::pair<std::string, int>, std::chrono::steady_clock::time_point, PairHash> video_destinations_;
};

}  // namespace subsystems_ros2

int main(int argc, char ** argv)
{
  rclcpp::init(argc, argv);
  rclcpp::spin(std::make_shared<subsystems_ros2::UdpBridge>());
  rclcpp::shutdown();
  return 0;
}
