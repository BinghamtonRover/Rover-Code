#include "subsystems_ros2/utils.hpp"

#include <cmath>
#include <stdexcept>

namespace subsystems_ros2
{

double nmeaToDecimal(double nmea_value)
{
  int degrees = static_cast<int>(nmea_value / 100);
  double minutes = std::fmod(nmea_value, 100.0);
  return degrees + minutes / 60.0;
}

std::unique_ptr<GpsCoordinates> parseNmea(const std::string & sentence)
{
  std::vector<std::string> parts;
  size_t start = 0;
  size_t end = sentence.find(',');
  while (end != std::string::npos) {
    parts.push_back(sentence.substr(start, end - start));
    start = end + 1;
    end = sentence.find(',', start);
  }
  parts.push_back(sentence.substr(start));

  if (parts.empty()) {
    return nullptr;
  }
  const std::string & tag = parts[0];

  auto coords = std::make_unique<GpsCoordinates>();
  if (tag.size() >= 3 && tag.substr(tag.size() - 3) == "GGA") {
    if (parts.size() < 10) return nullptr;
    double lat = nmeaToDecimal(std::stod(parts[2]));
    double lon = nmeaToDecimal(std::stod(parts[4]));
    if (parts[3] == "S") lat *= -1;
    if (parts[5] == "W") lon *= -1;
    int quality = std::stoi(parts[6]);
    RTKMode rtk_mode = RTKMode::RTK_NONE;
    if (quality == 4) rtk_mode = RTKMode::RTK_FIXED;
    else if (quality == 5) rtk_mode = RTKMode::RTK_FLOAT;
    coords->set_latitude(lat);
    coords->set_longitude(lon);
    coords->set_altitude(std::stod(parts[9]));
    coords->set_rtk_mode(rtk_mode);
    return coords;
  } else if (tag.size() >= 3 && tag.substr(tag.size() - 3) == "RMC") {
    if (parts.size() < 7) return nullptr;
    double lat = nmeaToDecimal(std::stod(parts[3]));
    if (parts[4] == "S") lat *= -1;
    double lon = nmeaToDecimal(std::stod(parts[5]));
    if (parts[6] == "W") lon *= -1;
    coords->set_latitude(lat);
    coords->set_longitude(lon);
    return coords;
  } else if (tag.size() >= 3 && tag.substr(tag.size() - 3) == "GLL") {
    if (parts.size() < 5) return nullptr;
    double lat = nmeaToDecimal(std::stod(parts[1]));
    if (parts[2] == "S") lat *= -1;
    double lon = nmeaToDecimal(std::stod(parts[3]));
    if (parts[4] == "W") lon *= -1;
    coords->set_latitude(lat);
    coords->set_longitude(lon);
    return coords;
  }
  return nullptr;
}

std::string parseOscString(const std::string & data, size_t & offset)
{
  if (offset >= data.size()) {
    return "";
  }
  size_t start = offset;
  while (offset < data.size() && data[offset] != '\0') {
    ++offset;
  }
  std::string result(data.data() + start, offset - start);
  ++offset;
  while (offset % 4 != 0) {
    ++offset;
  }
  return result;
}

void writeOscString(std::vector<uint8_t> & buffer, const std::string & str)
{
  for (char c : str) {
    buffer.push_back(static_cast<uint8_t>(c));
  }
  buffer.push_back(0);
  while (buffer.size() % 4 != 0) {
    buffer.push_back(0);
  }
}

std::vector<uint8_t> buildOscMessage(const std::string & address, const std::vector<std::string> & args)
{
  std::vector<uint8_t> message;
  writeOscString(message, address);
  std::string tags = ",";
  for (const auto & arg : args) {
    (void)arg;
    tags += "s";
  }
  writeOscString(message, tags);
  for (const auto & arg : args) {
    writeOscString(message, arg);
  }
  return message;
}

}  // namespace subsystems_ros2
