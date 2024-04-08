#include<stdio.h>
#include<stdbool.h>

void findWaitingTime(int p[], int n, int bt[], int wt[], int qt) {
    int ct=0;
    int rt[n];
    int total_wt=0;
    for(int i = 0; i<n; i++) {
        rt[i]=bt[i];
    }
    while(1) {
        int done=1;
        for(int i=0; i<n; i++) {
            if(rt[i]>0) {
                done=0;
                if(rt[i]>qt) {
                    ct+=qt;
                    rt[i] -= qt;
                }
                else {
                    ct += rt[i];
                    total_wt += ct - bt[i];
                    rt[i] = 0;
                }
            }
        }
        if(done==1) {
            break;
        }
    }
}

void turnAroundTime(int p[], int n, int bt[], int wt[], int tat[]) {
    for(int i=0; i<n; i++) {
        tat[i] = bt[i] + wt[i];
    }
}

void rr(int p[], int n, int bt[], int quantum) {
    int wt[n], tat[n], total_wt=0, total_tat=0;
    findWaitingTime(p, n, bt, wt, quantum);
    turnAroundTime(p, n, bt, wt, tat);
    
    printf("Process\t BT\t WT\t TAT\n");
    for(int i=0; i<n; i++) {
        total_wt += wt[i];
        total_tat += tat[i];
        printf("P%d\t %d\t %d\t %d\n", i+1, bt[i], wt[i], tat[i]);
    }
    
    printf("Avg waiting time: %f\n", (float)total_wt/(float)n);
    printf("Avg turn around time: %f\n", (float)total_tat/(float)n);
}

int main() 
{ 
    int processes[] = { 1, 2, 3}; 
    int n = sizeof processes / sizeof processes[0]; 
    int burst_time[] = {10, 5, 8}; 
    int quantum = 2; 
    printf("1");
    // rr(processes, n, burst_time, quantum); 
    return 0; 
} 