#include <stdio.h>
#include <signal.h>
#include <unistd.h>

// Signal handler function
void sigint_handler(int signal) {
    printf("Caught SIGINT signal\n");
}

int main() {
    // Registering the signal handler
    signal(SIGINT, sigint_handler);

    printf("Waiting for SIGINT signal...\n");

    // Infinite loop to keep the program running
    while(1) {
        sleep(1);
    }

    return 0;
}
