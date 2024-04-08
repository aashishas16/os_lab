#include<sys/types.h>
#include<stdio.h>
#include<stdlib.h>

int main() {
    int i;
    system("clear");
    pid_t pid;
    printf("Enter choice: ");
    scanf("%d", &i);
    printf("Original Process PID: %d PPID: %d\n\n", getpid(), getppid());
    switch (i)
    {
    case 1: pid = fork();
            if(pid>0) {
                printf("parent process pid: %d and ppid: %d\n", getpid(), getppid());
            }
            else {
                printf("child process pid: %d and ppid: %d\n", getpid(), getppid());
            }
        break;
    case 2: pid = fork();
            if(pid==0) {
                printf("child process pid: %d and ppid: %d\n", getpid(), getppid());
            }
            else {
                printf("parent process pid: %d and ppid: %d\n", getpid(), getppid());
            }
        break;
    case 3: pid = fork();
            if(pid!=0) {
                printf("parent process pid: %d and ppid: %d\n", getpid(), getppid());
            }
            else {
                printf("child process pid: %d and ppid: %d\n", getpid(), getppid());
            }
        break;
    case 4: pid = fork();
            if(pid<0) {
                perror("fork error");
            }
            exit(1);
        break;
    
    default:
        break;
    }
}