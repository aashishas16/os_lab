#include<stdio.h>

void findWaitingTime(int p[], int n, int bt[], int wt[]) {
    wt[0]=0;
    for(int i=1; i<n; i++) {
        wt[i]=bt[i-1]+wt[i-1];
    }
}

void findTatTime(int p[], int n, int bt[], int wt[], int tat[]) {
    for(int i=0; i<n; i++) {
        tat[i]=bt[i]+wt[i];
    }
}

void priorityFunc(int p[], int n, int bt[], int priority[]) {
    int wt[n], tat[n], total_wt=0, total_tat=0;

    for(int i=0; i<n; i++) {
        int index = i;
        for(int j=i+1; j<n; j++) {
            if(priority[j] > priority[index]) {
                index=j;
            }
        }
        int temp=bt[i];
        bt[i] = bt[index];
        bt[index] = temp;
        
        temp = p[i];
        p[i] = p[index];
        p[index] = temp;

        temp = priority[i];
        priority[i] = priority[index];
        priority[index] = temp;
    }

    findWaitingTime(p, n, bt, wt);
    findTatTime(p, n, bt, wt, tat);

    printf("Process\t BT\t Pr\t WT\t TAT\n");
    for(int i=0; i<n; i++) {
        total_wt += wt[i];
        total_tat += tat[i];
        printf("P%d\t %d\t %d\t %d\t %d\n", p[i], bt[i], priority[i], wt[i], tat[i]);
    }
    
    printf("Avg waiting time: %f\n", (float)total_wt/(float)n);
    printf("Avg turn around time: %f\n", (float)total_tat/(float)n);
}

int main() {
    int processes[] = {1, 2, 3};
    int n = sizeof(processes)/sizeof(processes[0]);
    int burst_time[] = {10, 5, 8};
    int priority[] = {2, 0, 1};
    priorityFunc(processes, n, burst_time, priority);
    return 0;
}