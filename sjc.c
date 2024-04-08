#include <stdio.h>

struct Process {
    int id;
    int arrival_time;
    int burst_time;
};

void sjf(struct Process processes[], int n) {
    int total_waiting_time = 0;
    int total_turnaround_time = 0;

    printf("Process\tWaiting Time\tTurnaround Time\n");

    int current_time = 0;
    int remaining[n];
    for (int i = 0; i < n; ++i)
        remaining[i] = processes[i].burst_time;

    int completed = 0;
    while (completed != n) {
        int min_burst_time = __INT_MAX__;
        int shortest = -1;
        for (int i = 0; i < n; ++i) {
            if (processes[i].arrival_time <= current_time && remaining[i] < min_burst_time && remaining[i] > 0) {
                min_burst_time = remaining[i];
                shortest = i;
            }
        }

        if (shortest == -1) {
            current_time++;
            continue;
        }

        // Process shortest job
        remaining[shortest]--;
        current_time++;

        if (remaining[shortest] == 0) {
            completed++;
            // Calculate waiting and turnaround time for completed process
            int turnaround_time = current_time - processes[shortest].arrival_time;
            int waiting_time = turnaround_time - processes[shortest].burst_time;

            printf("%d\t%d\t\t%d\n", processes[shortest].id, waiting_time, turnaround_time);

            total_waiting_time += waiting_time;
            total_turnaround_time += turnaround_time;
        }
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

    sjf(processes, n);

    return 0;
}
