#include <stdio.h>

// Process structure
struct process {
    int pid; // Process ID
    int remaining_time; // Remaining time for execution
};

// Function to perform Round Robin Scheduling
void round_robin_scheduling(struct process processes[], int n, int time_quantum) {
    int total_time = 0;
    int i, j;
    
    printf("Round Robin Scheduling:\n");
    printf("PID\tRemaining Time\n");
    while(1) {
        int all_done = 1;
        for(i = 0; i < n; i++) {
            if(processes[i].remaining_time > 0) {
                all_done = 0;
                if(processes[i].remaining_time > time_quantum) {
                    printf("%d\t%d\n", processes[i].pid, time_quantum);
                    total_time += time_quantum;
                    processes[i].remaining_time -= time_quantum;
                }
                else {
                    printf("%d\t%d\n", processes[i].pid, processes[i].remaining_time);
                    total_time += processes[i].remaining_time;
                    processes[i].remaining_time = 0;
                }
            }
        }
        if(all_done)
            break;
    }
    printf("\nTotal Time: %d\n\n", total_time);
}

int main() {
    // Example processes
    struct process processes[] = {
        {1, 8},
        {2, 4},
        {3, 9},
        {4, 5}
    };
    
    int n = sizeof(processes) / sizeof(processes[0]);
    
    // Round Robin Scheduling
    round_robin_scheduling(processes, n, 2); // Assuming time quantum of 2 units
    
    return 0;
}
