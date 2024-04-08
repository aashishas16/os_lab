#include <stdio.h>
#include <signal.h>
#include <unistd.h>

void sigint_handler(int signal){
    if(signal == SIGINT){
        printf("signal received");
    }
}

int main(){
    signal(SIGINT, sigint_handler);

    printf("waiting for SIGINT signal..");

    while(1){
        sleep(1);
    }
}