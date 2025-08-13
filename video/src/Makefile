.SILENT:
.PHONY: shared clean

shared: bin/realsense_ffi.so
	sudo cp bin/realsense_ffi.so /usr/lib 

bin/realsense_ffi.so: obj/realsense_ffi.o obj/realsense_internal.o
	mkdir -p bin
	g++ -Wall -Werror -shared -fPIC obj/realsense_ffi.o obj/realsense_internal.o -lrealsense2 -o bin/realsense_ffi.so

obj/realsense_internal.o: realsense_internal.hpp realsense_internal.cpp
	mkdir -p obj
	g++ -Wall -Werror -fPIC -c realsense_internal.cpp -o obj/realsense_internal.o

obj/realsense_ffi.o: realsense_ffi.h realsense_ffi.cpp
	mkdir -p obj
	g++ -Wall -Werror -fPIC -c realsense_ffi.cpp -o obj/realsense_ffi.o

clean: 
	rm -rf bin obj
	sudo rm -f /usr/lib/realsense_ffi.so 
