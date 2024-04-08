#include<stdio.h>

void findWaitingTime(int p[], int n, int bt[], int wt[]) {
    wt[0] = 0;
    for(int i=1; i<n; i++) {
        wt[i] = bt[i-1] + wt[i-1];
    }
}

void findTurnAroundTime(int p[], int n, int bt[], int wt[], int tat[]) {
    for(int i=0; i<n; i++) {
        tat[i]=bt[i]+wt[i];
    }
}

void sjf(int p[], int n, int bt[]) {
    int wt[n], tat[n], total_wt=0, total_tat=0;

    for(int i=0; i<n; i++) {
        int index = i;
        for(int j=i+1; j<n; j++) {
            if(bt[j] < bt[index]) {
                index=j;
            }
        }
        int temp=bt[i];
        bt[i] = bt[index];
        bt[index] = temp;
        
        temp = p[i];
        p[i] = p[index];
        p[index] = temp;
    }
    
    findWaitingTime(p, n, bt, wt);
    findTurnAroundTime(p, n, bt, wt, tat);
    
    printf("Process\t BT\t WT\t TAT\n");
    for(int i=0; i<n; i++) {
        total_wt += wt[i];
        total_tat += tat[i];
        printf("P%d\t %d\t %d\t %d\n", p[i], bt[i], wt[i], tat[i]);
    }
    
    printf("Avg waiting time: %f\n", (float)total_wt/(float)n);
    printf("Avg turn around time: %f\n", (float)total_tat/(float)n);
}

int main() {
    int processes[] = {1, 2, 3};
    int n = sizeof(processes)/sizeof(processes[0]);
    int burst_time[] = {10, 5, 8};
    sjf(processes, n, burst_time);
    return 0;
}