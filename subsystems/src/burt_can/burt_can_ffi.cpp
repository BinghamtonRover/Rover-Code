#include "burt_can.hpp"
#include "burt_can.h"

#include <cstdlib>

BurtCan* BurtCan_create(const char* interface, int32_t readTimeout, BurtCanType type) {
  auto obj = new burt_can::BurtCan(interface, readTimeout, type);
  return reinterpret_cast<BurtCan*>(obj);
}

void BurtCan_free(BurtCan* pointer) {
  auto obj = reinterpret_cast<burt_can::BurtCan*>(pointer);
  obj->dispose();
  free(obj);
}

BurtCanStatus BurtCan_open(BurtCan* pointer) {
  auto obj = reinterpret_cast<burt_can::BurtCan*>(pointer);
  return obj->open();
}

BurtCanStatus BurtCan_send(BurtCan* pointer, const NativeCanMessage* message) {
  auto obj = reinterpret_cast<burt_can::BurtCan*>(pointer);
  return obj->send(message);
}

BurtCanStatus BurtCan_receive(BurtCan* pointer, NativeCanMessage* message) {
  auto obj = reinterpret_cast<burt_can::BurtCan*>(pointer);
  return obj->receive(message);
}

BurtCanStatus BurtCan_close(BurtCan* pointer) {
  auto obj = reinterpret_cast<burt_can::BurtCan*>(pointer);
  return obj->dispose();
}

NativeCanMessage* NativeCanMessage_create() {
  NativeCanMessage* pointer = new NativeCanMessage();
  pointer->data = new uint8_t[8];
  return pointer;
}

void NativeCanMessage_free(NativeCanMessage* pointer) {
  free(pointer->data);
  free(pointer);
}
