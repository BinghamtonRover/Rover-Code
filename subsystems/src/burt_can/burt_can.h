#ifndef BURT_CAN_H
#define BURT_CAN_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef enum BurtCanType {
	CAN = 0,
	CANFD = 1,
} BurtCanType;

// No 0 value to ensure we always set a status
typedef enum BurtCanStatus {
	OK = 1,
	// Errors when opening and closing
	SOCKET_CREATE_ERROR = 2,
	INTERFACE_PARSE_ERROR = 3,
	BIND_ERROR = 4,
	CLOSE_ERROR = 5,
	// CANFD errors
	MTU_ERROR = 6,
	CANFD_NOT_SUPPORTED = 7,
	FD_MISC_ERROR = 8,
	// IO errors
	WRITE_ERROR = 9,
	READ_ERROR = 10,
	FRAME_NOT_FULLY_READ = 11,
} BurtCanStatus;

typedef struct NativeCanMessage {
	uint32_t id;
	uint8_t length;
	uint8_t flags;
	uint8_t* data;
} NativeCanMessage;

struct BurtCan;
typedef struct BurtCan BurtCan;

BurtCan* BurtCan_create(const char* interface, int32_t readTimeout, BurtCanType type);
void BurtCan_free(BurtCan* pointer);

BurtCanStatus BurtCan_open(BurtCan* pointer);
BurtCanStatus BurtCan_send(BurtCan* pointer, const NativeCanMessage* message);
BurtCanStatus BurtCan_receive(BurtCan* pointer, NativeCanMessage* message);
BurtCanStatus BurtCan_close(BurtCan* pointer);

NativeCanMessage* NativeCanMessage_create();
void NativeCanMessage_free(NativeCanMessage* pointer);

#ifdef __cplusplus
}
#endif

#endif
