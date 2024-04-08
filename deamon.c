#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
int main() {
    pid_t pid = fork();
     if (pid > 0) {
        exit(0); }
    if (pid < 0) {
        perror("fork");
       }
   if(pid==0)
   {
//    setsid(); 
//     chdir("/"); 
    close(STDIN_FILENO);
    close(STDOUT_FILENO);
    close(STDERR_FILENO);
    int n=10;
    while (n--) {
    printf("wring in files \n");
        FILE *log_file = fopen("/home/jrvis/Documents/college/mydaemon.log", "a");

        if (log_file != NULL) {
            fprintf(log_file, "Daemon process running\n");
            fclose(log_file); }

        sleep(1);
   }
 
    }
    return 0; 
}
