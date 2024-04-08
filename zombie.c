#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main() {
    pid_t pid = fork();

    if (pid < 0) {
        perror("Fork failed");
        exit(EXIT_FAILURE);
    } else if (pid == 0) {
        // Child process
        printf("Child process is running\n %d"  , getpid());
    
        // Child process does not exit, becomes a zombie
        while (1) {

            sleep(1);
        }
        exit(EXIT_SUCCESS); // This line is unreachable
    } else {
        // Parent process
        printf("Parent process created child with PID: %d\n", pid);
        sleep(5); // Parent process sleeps for 5 seconds
        printf("Parent process exiting\n");
    }

    return EXIT_SUCCESS;
}
