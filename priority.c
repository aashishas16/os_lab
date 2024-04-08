#include <stdio.h>

// Process structure
struct process {
    int pid; // Process ID
    int priority; // Priority (lower value = higher priority)
    int burst_time; // Burst time
};

// Function to perform Priority Scheduling
void priority_scheduling(struct process processes[], int n) {
    int total_time = 0;
    int i, j;
    
    // Sort the processes based on priority
    for(i = 0; i < n - 1; i++) {
        for(j = 0; j < n - i - 1; j++) {
            if(processes[j].priority > processes[j+1].priority) {
                // Swap
                struct process temp = processes[j];
                processes[j] = processes[j+1];
                processes[j+1] = temp;
            }
        }
    }
    
    printf("Priority Scheduling:\n");
    printf("PID\tPriority\tBurst Time\n");
    for(i = 0; i < n; i++) {
        printf("%d\t%d\t\t%d\n", processes[i].pid, processes[i].priority, processes[i].burst_time);
        total_time += processes[i].burst_time;
    }
    printf("\nTotal Time: %d\n\n", total_time);
}

int main() {
    // Example processes
    struct process processes[] = {
        {1, 2, 8},
        {2, 1, 4},
        {3, 3, 9},
        {4, 4, 5}
    };
    
    int n = sizeof(processes) / sizeof(processes[0]);
    
    // Priority Scheduling
    priority_scheduling(processes, n);
    
    return 0;
}
