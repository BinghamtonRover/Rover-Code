#include <cstring>
#include <unistd.h>

// Linux headers
#include <linux/can.h>
#include <linux/can/raw.h>
#include <net/if.h>
#include <sys/ioctl.h>
#include <sys/socket.h>

#include <cstring>
#include <stdio.h>
#include <fcntl.h>
#include <stdlib.h>
#include <string.h>
#include <iostream>

#include "burt_can.hpp"

void printError() {
	std::cout << "Error from C code (" << errno << "): " << strerror(errno) << std::endl;
}

burt_can::BurtCan::BurtCan(const char* interface, int32_t readTimeout, BurtCanType mode) :
	interface(interface),
	readTimeout(readTimeout),
	mode(mode) { }

BurtCanStatus burt_can::BurtCan::open() {
	// Declare structs
	struct sockaddr_can address;
	struct ifreq ifr;

	// Open the socket
	handle = socket(PF_CAN, SOCK_RAW, CAN_RAW);
	if (handle < 0) {
		printError();
		return BurtCanStatus::SOCKET_CREATE_ERROR;
	}
	int value = fcntl(handle, F_SETFL, SOCK_NONBLOCK);
	if (value < 0) {
		printError();
		return BurtCanStatus::SOCKET_CREATE_ERROR;
	}

	// Define the interface we'll use on the socket
	strcpy(ifr.ifr_name, interface);
	ioctl(handle, SIOCGIFINDEX, &ifr);
	if (!ifr.ifr_ifindex) {
		printError();
		return BurtCanStatus::INTERFACE_PARSE_ERROR;
	}

	if (mode == BurtCanType::CANFD) {  // Switch to FD mode
		int mtu = ifr.ifr_mtu;
		int enableFD = 1;

		if (ioctl(handle, SIOCGIFMTU, &ifr) < 0) {
			printError();
			return BurtCanStatus::MTU_ERROR;
		} else if (mtu != CANFD_MTU) {
			printError();
			return BurtCanStatus::CANFD_NOT_SUPPORTED;
		} else if (setsockopt(handle, SOL_CAN_RAW, CAN_RAW_FD_FRAMES, &enableFD, sizeof(enableFD))) {
			printError();
			return BurtCanStatus::FD_MISC_ERROR;
		}
	}

	// Configure CAN options
	address.can_family = AF_CAN;
	address.can_ifindex = ifr.ifr_ifindex;
	struct timeval tv;
		tv.tv_sec = readTimeout;
		tv.tv_usec = 0;
	setsockopt(handle, SOL_SOCKET, SO_RCVTIMEO, (const char*) &tv, sizeof(struct timeval));

	// Bind the socket to the address
	if (bind(handle, (struct sockaddr*) &address, sizeof(address)) < 0) {
		printError();
		return BurtCanStatus::BIND_ERROR;
	}
	return BurtCanStatus::OK;
}

BurtCanStatus burt_can::BurtCan::send(const NativeCanMessage* frame) {
	// Copy the CanFrame to a can_frame and send it.
	can_frame raw;
	raw.can_id = frame->id;
	// raw.can_id |= CAN_EFF_FLAG;
	raw.len = frame->length;
	std::memcpy(raw.data, frame->data, 8);
	int size = sizeof(raw);
	if (write(handle, &raw, size) == size) {
		return BurtCanStatus::OK;
	} else {
		printError();
		return BurtCanStatus::WRITE_ERROR;
	}
}

BurtCanStatus burt_can::BurtCan::receive(NativeCanMessage* frame) {
	can_frame raw;
	long bytesRead = read(handle, &raw, sizeof(raw));
	if (bytesRead < 0) {
		if (errno == 11) return BurtCanStatus::OK;
		printError();
		return BurtCanStatus::READ_ERROR;
	} else if (bytesRead < (long) sizeof(raw)) {
		return BurtCanStatus::FRAME_NOT_FULLY_READ;
	} else {
		// First bit is the EFF flag. Remove it before parsing
		uint32_t id = (raw.can_id << 1) >> 1;
		frame->id = id;
		frame->length = raw.len;
		std::memcpy(frame->data, raw.data, 8);
		return BurtCanStatus::OK;
	}
}

BurtCanStatus burt_can::BurtCan::dispose() {
	if (close(handle) < 0) {
		printError();
		return BurtCanStatus::CLOSE_ERROR;
	} else {
		return BurtCanStatus::OK;
	}
}

burt_can::BurtCan::~BurtCan() {
	dispose();
}
