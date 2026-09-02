#include <gtest/gtest.h>
#include "subsystems_ros2/utils.hpp"
#include "subsystems_ros2/generated/gps.pb.h"
#include "subsystems_ros2/generated/wrapper.pb.h"

using namespace subsystems_ros2;

TEST(UtilsTest, WrapMessageSetsNameAndData)
{
  GpsCoordinates coords;
  coords.set_latitude(12.34);
  coords.set_longitude(56.78);

  WrappedMessage wrapper = wrapMessage(coords);
  EXPECT_EQ(wrapper.name(), GpsCoordinates::descriptor()->full_name());
  EXPECT_FALSE(wrapper.data().empty());

  GpsCoordinates parsed;
  EXPECT_TRUE(parsed.ParseFromString(wrapper.data()));
  EXPECT_DOUBLE_EQ(parsed.latitude(), 12.34);
  EXPECT_DOUBLE_EQ(parsed.longitude(), 56.78);
}

TEST(UtilsTest, NmeaToDecimalConvertsCorrectly)
{
  // 1230.0000 -> 12.5 degrees
  EXPECT_DOUBLE_EQ(nmeaToDecimal(1230.0), 12.5);
  // 0.0 -> 0.0
  EXPECT_DOUBLE_EQ(nmeaToDecimal(0.0), 0.0);
  // 4512.3456 -> 45 + 12.3456/60
  EXPECT_DOUBLE_EQ(nmeaToDecimal(4512.3456), 45.0 + 12.3456 / 60.0);
}

TEST(UtilsTest, ParseGgaSentence)
{
  // $GPGGA,123519,4807.038,N,01131.324,E,1,08,0.9,545.4,M,46.9,M,,*47
  std::string sentence = "$GPGGA,123519,4807.038,N,01131.324,E,1,08,0.9,545.4,M,46.9,M,,*47";
  auto coords = parseNmea(sentence);
  ASSERT_NE(coords, nullptr);
  EXPECT_NEAR(coords->latitude(), 48.1173, 1e-4);
  EXPECT_NEAR(coords->longitude(), 11.5220, 1e-4);
  EXPECT_NEAR(coords->altitude(), 545.4, 1e-4);
  EXPECT_EQ(coords->rtk_mode(), RTKMode::RTK_NONE);
}

TEST(UtilsTest, ParseGgaSentenceWithRtkFixed)
{
  std::string sentence = "$GPGGA,123519,4807.038,N,01131.324,E,4,08,0.9,545.4,M,46.9,M,,*47";
  auto coords = parseNmea(sentence);
  ASSERT_NE(coords, nullptr);
  EXPECT_EQ(coords->rtk_mode(), RTKMode::RTK_FIXED);
}

TEST(UtilsTest, ParseRmcSentence)
{
  std::string sentence = "$GPRMC,123519,A,4807.038,N,01131.324,E,022.4,084.4,230394,003.1,W*6A";
  auto coords = parseNmea(sentence);
  ASSERT_NE(coords, nullptr);
  EXPECT_NEAR(coords->latitude(), 48.1173, 1e-4);
  EXPECT_NEAR(coords->longitude(), 11.5220, 1e-4);
}

TEST(UtilsTest, ParseGllSentence)
{
  std::string sentence = "$GPGLL,4807.038,N,01131.324,E,123519,A,A*57";
  auto coords = parseNmea(sentence);
  ASSERT_NE(coords, nullptr);
  EXPECT_NEAR(coords->latitude(), 48.1173, 1e-4);
  EXPECT_NEAR(coords->longitude(), 11.5220, 1e-4);
}

TEST(UtilsTest, ParseUnsupportedSentenceReturnsNull)
{
  std::string sentence = "$GPVTG,054.7,T,034.4,M,005.5,N,010.2,K*48";
  EXPECT_EQ(parseNmea(sentence), nullptr);
}

TEST(UtilsTest, BuildOscMessageWithNoArgs)
{
  auto message = buildOscMessage("/ahrs/zero", {});
  // "/ahrs/zero" is 10 chars -> 12 bytes, "," -> 4 bytes, total 16
  EXPECT_EQ(message.size(), 16u);
  std::string expected = "/ahrs/zero";
  for (size_t i = 0; i < expected.size(); ++i) {
    EXPECT_EQ(message[i], static_cast<uint8_t>(expected[i]));
  }
  EXPECT_EQ(message[10], 0u);
  EXPECT_EQ(message[12], ',');
}

TEST(UtilsTest, BuildOscMessageWithArgs)
{
  auto message = buildOscMessage("/test", {"hello", "world"});
  // "/test" -> 8 bytes, ",ss" -> 4 bytes, "hello" -> 8 bytes, "world" -> 8 bytes = 28
  EXPECT_EQ(message.size(), 28u);
}

TEST(UtilsTest, ParseOscString)
{
  std::string data;
  data += "/euler";
  data.append(2, '\0');  // pad to 8 bytes
  data += ",fff";
  data.append(4, '\0');  // pad to 8 bytes
  ASSERT_EQ(data.size(), 16u);

  size_t offset = 0;
  EXPECT_EQ(parseOscString(data, offset), "/euler");
  EXPECT_EQ(offset, 8u);
  EXPECT_EQ(parseOscString(data, offset), ",fff");
  EXPECT_EQ(offset, 16u);
}

int main(int argc, char ** argv)
{
  ::testing::InitGoogleTest(&argc, argv);
  return RUN_ALL_TESTS();
}
