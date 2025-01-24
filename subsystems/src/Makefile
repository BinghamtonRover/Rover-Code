.PHONE: all clean

all: burt_can/burt_can.so libserialport.so install

burt_can/burt_can.so: burt_can/*.h burt_can/*.cpp burt_can/*.hpp
	make -C burt_can shared

clean: 
	rm -f *.o *.so *.exp *.lib *.obj *.out
	rm -f burt_can/*.so
	rm -f libserialport/*.so
	rm -f ../*.so
	make -C burt_can clean

SerialCommand = gcc
SerialCommand += libserialport/serialport.c
SerialCommand += libserialport/timing.c
SerialCommand += libserialport/linux.c
SerialCommand += libserialport/linux_termios.c
SerialCommand += -DLIBSERIALPORT_ATBUILD  # Defines a preprocessor command
SerialCommand += -I. # Includes <config.h> from this dir
SerialCommand += -fPIC  # Position-independent code. Useful for shared libraries
SerialCommand += -std=c99 -Wall -Wextra -pedantic -Wmissing-prototypes -Wshadow  # Misc options
SerialCommand += -shared -o libserialport.so  # Output to a shared library

libserialport.so: libserialport/serialport.c libserialport/timing.c libserialport/linux.c libserialport/linux_termios.c
	$(SerialCommand)
	sudo cp libserialport.so /usr/lib

install: burt_can/burt_can.so libserialport.so
	sudo cp libserialport.so /usr/lib
	make -C burt_can install
