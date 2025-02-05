// Client side implementation of UDP client-server model 
#include <bits/stdc++.h> 
#include <stdlib.h> 
#include <unistd.h> 
#include <string.h> 
#include <sys/types.h> 
#include <sys/socket.h> 
#include <arpa/inet.h> 
#include <netinet/in.h> 

   
#define PORT     8005 
#define MAXLINE  1024 
#define SLEEP    1000000 
   
// Driver code 
int main() { 
    int sockfd; 
    char buffer[MAXLINE]; 
    const char *hello = "Hello from client"; 
    struct sockaddr_in     servaddr; 
   
    // Creating socket file descriptor 
    if ( (sockfd = socket(AF_INET, SOCK_DGRAM, 0)) < 0 ) { 
        perror("socket creation failed"); 
        exit(EXIT_FAILURE); 
    } 
   
    memset(&servaddr, 0, sizeof(servaddr)); 
       
    // Filling server information 
    servaddr.sin_family = AF_INET; 
    servaddr.sin_port = htons(PORT); 
    servaddr.sin_addr.s_addr = INADDR_ANY; 
       
    int n;
    socklen_t len; 
    long long i = 0;
    while(true){    
        usleep(SLEEP);
        int r = sendto(sockfd, (const char *)hello, strlen(hello), 
            MSG_CONFIRM, (const struct sockaddr *) &servaddr,  
                sizeof(servaddr)); 
        std::cout<< r <<std::endl; 
        std::cout<<"Hello message " << i << " sent."<<std::endl; 
        i++;
        if(r == -1){
            std::cout << "There was an error sending UDP" << std::endl;
            std::cout << "Ernno: " << errno << std::endl;
            std::cout << strerror(errno) << std::endl;
        }
               
        // n = recvfrom(sockfd, (char *)buffer, MAXLINE,  
        //             MSG_WAITALL, (struct sockaddr *) &servaddr, 
        //             &len); 
        // buffer[n] = '\0'; 
        // std::cout<<"Server :"<<buffer<<std::endl; 
    }   
       
    close(sockfd); 
    return 0; 
}