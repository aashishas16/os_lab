#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>

void zombie_process() {
    pid_t child_pid = fork();

    if (child_pid == 0) {  // Child process
        printf("Child process with PID: %d\n", getpid());
        printf("Child process exiting without wait.\n");
        exit(0);
    } else if (child_pid > 0) {  // Parent process
        printf("Parent process with PID: %d\n", getpid());
        sleep(5);  // Sleep to ensure child becomes zombie
        printf("Parent process exiting.\n");
    } else {
        perror("Fork failed");
        exit(1);
    }
}

void orphan_process() {
    pid_t pid = fork();
    
    if(pid > 0){
        printf("Parent process exiting\n");
    } else if (pid == 0) {
        printf("Child process start: PID = %d", getpid());
        sleep(10); 
        printf("Child process exiting\n");
    } else {
        perror("Fork failed");
        exit(EXIT_FAILURE);
    }
}

int main() {
   
    
    return 0;
}


#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <signal.h>

// Function to daemonize the process
void daemonize() {
    
    pid_t pid = fork();
    if (pid < 0) {
        exit(EXIT_FAILURE);
    }
    if (pid > 0) {
        exit(EXIT_SUCCESS);
    }

    umask(0);

    pid_t sid = setsid();
    if (sid < 0) {
        exit(EXIT_FAILURE);
    }

   
    close(STDIN_FILENO);
    close(STDOUT_FILENO);
    close(STDERR_FILENO);

    // Handle signals for graceful termination
    signal(SIGTERM, SIG_DFL);
    signal(SIGINT, SIG_IGN);
}

int main() {
    // Daemonize the process
    daemonize();

    // Daemon process starts here
    // For demonstration, let's just make it sleep
    while (1) {
        sleep(1);
    }

    return 0;
}
