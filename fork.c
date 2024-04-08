#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main() {
    pid_t pid;

    // Attempt to create a child process
    pid = fork();

    switch(pid) {
        case -1:
            perror("Failed to create child process");
            exit(EXIT_FAILURE);
        case 0:
            // Child process
            printf("Child PID: %d\n", getpid());
            printf("Child PPID: %d\n", getppid());
            break;
        default:
            // Parent process
            printf("Parent PID: %d\n", getpid());
            printf("Parent PPID: %d\n", getppid());
            break;
    }

    return 0;
}
