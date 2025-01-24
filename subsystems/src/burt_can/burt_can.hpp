#ifndef BURT_CAN_HPP
#define BURT_CAN_HPP

#include <stdint.h>
#include "burt_can.h"

namespace burt_can {

	class BurtCan {
		public: 
			BurtCan(const char* interface, int32_t readTimeout, BurtCanType = BurtCanType::CAN);
			~BurtCan();
			BurtCan(const BurtCan&) = delete;  // do not allow copying
			BurtCan& operator=(const BurtCan&) = delete;  // do not allow equality checks

			BurtCanStatus open();
			BurtCanStatus send(const NativeCanMessage* message);
			BurtCanStatus receive(NativeCanMessage* message);
			BurtCanStatus dispose();

		private: 
			int handle = -1;
			const char* interface;
			int32_t readTimeout = 3;  // ms
			BurtCanType mode;
	};
}
#endif
