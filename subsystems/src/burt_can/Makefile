shared: burt_can.so

burt_can.so: burt_can.cpp
	g++ -Wall -Werror -fPIC -c burt_can.cpp -o burt_can.o
	g++ -Wall -Werror -fPIC -c burt_can_ffi.cpp -o burt_can_ffi.o
	g++ -shared -fPIC burt_can.o burt_can_ffi.o -o burt_can.so

clean: 
	rm -rf *.o *.so
	sudo rm -f /usr/lib/burt_can.so

install: burt_can.so
	sudo cp burt_can.so /usr/lib
