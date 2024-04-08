#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>

int main() {
    pid_t child_pid = fork();

    if (child_pid < 0) {
        // Error forking
        perror("fork");
        exit(1);
    }

    if (child_pid > 0) {
        // Parent process
        printf("Parent process (PID: %d) terminates\n", getpid());
        exit(0);
    } else {
        // Child process
        sleep(5); // Simulate some work
        printf("Child process (PID: %d) parented by init (PID: %d)\n", getpid(), getppid());
        exit(0);
    }

    return 0;
}
// #NAME -Anish Mondal
// #ENROLLMENT - 22MCA006