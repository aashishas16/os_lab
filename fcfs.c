#include <stdio.h>

struct Process {
    int id;
    int arrival_time;
    int burst_time;
};

void fcfs(struct Process processes[], int n) {
    int total_waiting_time = 0;
    int total_turnaround_time = 0;

    printf("Process\tWaiting Time\tTurnaround Time\n");

    int current_time = 0;
    for (int i = 0; i < n; ++i) {
        // Waiting time for current process
        int waiting_time = current_time - processes[i].arrival_time;
        if (waiting_time < 0)
            waiting_time = 0;
        
        // Turnaround time for current process
        int turnaround_time = waiting_time + processes[i].burst_time;

        printf("%d\t%d\t\t%d\n", processes[i].id, waiting_time, turnaround_time);

        total_waiting_time += waiting_time;
        total_turnaround_time += turnaround_time;

        // Update current time
        current_time += processes[i].burst_time;
    }

    // Calculate average waiting and turnaround time
    float avg_waiting_time = (float)total_waiting_time / n;
    float avg_turnaround_time = (float)total_turnaround_time / n;

    printf("\nAverage Waiting Time: %.2f\n", avg_waiting_time);
    printf("Average Turnaround Time: %.2f\n", avg_turnaround_time);
}

int main() {
    struct Process processes[] = {
        {1, 0, 5},
        {2, 1, 3},
        {3, 2, 8},
        {4, 3, 6},
        {5, 4, 1}
    };

    int n = sizeof(processes) / sizeof(processes[0]);

    fcfs(processes, n);

    return 0;
}
