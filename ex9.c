#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <unistd.h>

// Signal handler function for user-defined signal SIGUSR1
void sigusr1_handler(int signal) {
    printf("Caught SIGUSR1 signal\n");
}

int main() {
    // Registering the signal handler for SIGUSR1
    signal(SIGUSR1, sigusr1_handler);

    printf("Sending SIGUSR1 signal to self...\n");

    // Sending SIGUSR1 signal to self
    kill(getpid(), SIGUSR1);

    // Waiting for a short time to allow signal handling
    sleep(1);

    printf("Attempting to catch SIGKILL...\n");

    // Attempting to catch SIGKILL - this will not work
    if (signal(SIGKILL, sigusr1_handler) == SIG_ERR) {
        printf("Cannot catch SIGKILL\n");
    }

    // Sending SIGKILL signal to self
    kill(getpid(), SIGKILL);

    // Waiting for a short time to allow signal handling
    sleep(1);

    printf("Attempting to catch SIGSTOP...\n");

    // Attempting to catch SIGSTOP - this will not work
    if (signal(SIGSTOP, sigusr1_handler) == SIG_ERR) {
        printf("Cannot catch SIGSTOP\n");
    }

    // Sending SIGSTOP signal to self
    kill(getpid(), SIGSTOP);

    // Waiting for a short time to allow signal handling
    sleep(1);

    printf("Finished\n");

    return 0;
}
