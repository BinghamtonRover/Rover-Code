#include "lidar.h"

#include <cstdlib>
#include <unistd.h> 

#define SLEEP    1000000 

int main() {
	auto lidar = Lidar_create();
    usleep(SLEEP * 5);
	while(true){    
        usleep(SLEEP);
        getStatus(lidar);
        if (lidar->statusCode != 0) {
        	exit(1);
        }
    }
}
