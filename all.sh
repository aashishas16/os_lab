<<aa

echo "enter a year"
read year

if [[ $((year % 400)) -eq 0 ]] ; then
  echo "$year is a leap year."
else
  echo "$year is not a leap year."
fi

aa











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

 










#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <unistd.h>

// Signal handler function for user-defined signal SIGUSR1
void sigusr1_handler(int signal) {
    printf("Caught SIGUSR1 signal\n");
}

int main() {
    // Registering the signal handler for SIGUSR1
    signal(SIGUSR1, sigusr1_handler);

    printf("Sending SIGUSR1 signal to self...\n");

    // Sending SIGUSR1 signal to self
    kill(getpid(), SIGUSR1);

    // Waiting for a short time to allow signal handling
    sleep(1);

    printf("Attempting to catch SIGKILL...\n");

    // Attempting to catch SIGKILL - this will not work
    if (signal(SIGKILL, sigusr1_handler) == SIG_ERR) {
        printf("Cannot catch SIGKILL\n");
    }

    // Sending SIGKILL signal to self
    kill(getpid(), SIGKILL);

    // Waiting for a short time to allow signal handling
    sleep(1);

    printf("Attempting to catch SIGSTOP...\n");

    // Attempting to catch SIGSTOP - this will not work
    if (signal(SIGSTOP, sigusr1_handler) == SIG_ERR) {
        printf("Cannot catch SIGSTOP\n");
    }

    // Sending SIGSTOP signal to self
    kill(getpid(), SIGSTOP);

    // Waiting for a short time to allow signal handling
    sleep(1);

    printf("Finished\n");

    return 0;
}

















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



// Banker's Algorithm
#include <stdio.h>
int main()
{
	// P0, P1, P2, P3, P4 are the Process names here

	int n, m, i, j, k;
	n = 5; // Number of processes
	m = 3; // Number of resources
	int alloc[5][3] = { { 0, 1, 0 }, // P0 // Allocation Matrix
						{ 2, 0, 0 }, // P1
						{ 3, 0, 2 }, // P2
						{ 2, 1, 1 }, // P3
						{ 0, 0, 2 } }; // P4

	int max[5][3] = { { 7, 5, 3 }, // P0 // MAX Matrix
					{ 3, 2, 2 }, // P1
					{ 9, 0, 2 }, // P2
					{ 2, 2, 2 }, // P3
					{ 4, 3, 3 } }; // P4

	int avail[3] = { 3, 3, 2 }; // Available Resources

	int f[n], ans[n], ind = 0;
	for (k = 0; k < n; k++) {
		f[k] = 0;
	}
	int need[n][m];
	for (i = 0; i < n; i++) {
		for (j = 0; j < m; j++)
			need[i][j] = max[i][j] - alloc[i][j];
	}
	int y = 0;
	for (k = 0; k < 5; k++) {
		for (i = 0; i < n; i++) {
			if (f[i] == 0) {

				int flag = 0;
				for (j = 0; j < m; j++) {
					if (need[i][j] > avail[j]){
						flag = 1;
						break;
					}
				}

				if (flag == 0) {
					ans[ind++] = i;
					for (y = 0; y < m; y++)
						avail[y] += alloc[i][y];
					f[i] = 1;
				}
			}
		}
	}

	int flag = 1;
	
	for(int i=0;i<n;i++)
	{
	if(f[i]==0)
	{
		flag=0;
		printf("The following system is not safe");
		break;
	}
	}
	
	if(flag==1)
	{
	printf("Following is the SAFE Sequence\n");
	for (i = 0; i < n - 1; i++)
		printf(" P%d ->", ans[i]);
	printf(" P%d", ans[n - 1]);
	}
	

	return (0);

	
}

























#!/bin/bash

# Function to perform arithmetic operations
# arithmetic_operations() {
#     echo "Enter two numbers:"
#     read num1
#     read num2

#     echo "Select operation:"
#     echo "1. Addition"
#     echo "2. Subtraction"
#     echo "3. Multiplication"
#     echo "4. Division"
#     read choice

#     case $choice in
#         1) echo "Result: $(($num1 + $num2))" ;;
#         2) echo "Result: $(($num1 - $num2))" ;;
#         3) echo "Result: $(($num1 * $num2))" ;;
#         4) echo "Result: $(($num1 / $num2))" ;;
#         *) echo "Invalid choice" ;;
#     esac
# }

# arithmetic_operations



#!/bin/bash

# Function to check if alphabet is vowel or not
# check_vowel() {
#     echo "Enter an alphabet (uppercase or lowercase):"
#     read alphabet

#     case $alphabet in
#         [aeiouAEIOU]) echo "$alphabet is a vowel." ;;
#         [a-zA-Z]) echo "$alphabet is not a vowel." ;;
#         *) echo "Invalid input" ;;
#     esac
# }

# check_vowel


#!/bin/bash

# Function to calculate percentage and grade using switch case
calculate_percentage_switch() {
    echo "Enter marks for Physics, Chemistry, Biology, Mathematics, and Computer (separated by spaces):"
    read physics chemistry biology mathematics computer

    total_marks=$((physics + chemistry + biology + mathematics + computer))
    percentage=$(( (total_marks * 100) / 500 ))

    # Switch case for grade calculation based on percentage
    case $percentage in
        100) grade="A" ;;
        [9][0-9]) grade="A" ;;
        [8][0-9]) grade="B" ;;
        [7][0-9]) grade="C" ;;
        [6][0-9]) grade="D" ;;
        [4-5][0-9]) grade="E" ;;
        *) grade="F" ;;
    esac

    echo "Percentage: $percentage%, Grade: $grade"
}

calculate_percentage_switch

































#!/bin/bash

# Function to perform arithmetic operations
# arithmetic_operations() {
#     echo "Enter two numbers:"
#     read num1
#     read num2

#     echo "Select operation:"
#     echo "1. Addition"
#     echo "2. Subtraction"
#     echo "3. Multiplication"
#     echo "4. Division"
#     read choice

#     case $choice in
#         1) echo "Result: $(($num1 + $num2))" ;;
#         2) echo "Result: $(($num1 - $num2))" ;;
#         3) echo "Result: $(($num1 * $num2))" ;;
#         4) echo "Result: $(($num1 / $num2))" ;;
#         *) echo "Invalid choice" ;;
#     esac
# }

# arithmetic_operations



#!/bin/bash

# Function to check if alphabet is vowel or not
# check_vowel() {
#     echo "Enter an alphabet (uppercase or lowercase):"
#     read alphabet

#     case $alphabet in
#         [aeiouAEIOU]) echo "$alphabet is a vowel." ;;
#         [a-zA-Z]) echo "$alphabet is not a vowel." ;;
#         *) echo "Invalid input" ;;
#     esac
# }

# check_vowel


#!/bin/bash

# Function to calculate percentage and grade using switch case
calculate_percentage_switch() {
    echo "Enter marks for Physics, Chemistry, Biology, Mathematics, and Computer (separated by spaces):"
    read physics chemistry biology mathematics computer

    total_marks=$((physics + chemistry + biology + mathematics + computer))
    percentage=$(( (total_marks * 100) / 500 ))

    # Switch case for grade calculation based on percentage
    case $percentage in
        100) grade="A" ;;
        [9][0-9]) grade="A" ;;
        [8][0-9]) grade="B" ;;
        [7][0-9]) grade="C" ;;
        [6][0-9]) grade="D" ;;
        [4-5][0-9]) grade="E" ;;
        *) grade="F" ;;
    esac

    echo "Percentage: $percentage%, Grade: $grade"
}

calculate_percentage_switch
































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









































#include <stdio.h>

// Define the maximum number of processes
#define MAX_PROCESSES 5

// Define the time quantum for round-robin scheduling
#define TIME_QUANTUM 2

// Structure to represent a process
struct Process {
    int id;             // Process ID
    int arrival_time;   // Arrival time of the process
    int burst_time;     // Burst time of the process
    int remaining_time; // Remaining burst time of the process
};

// Function to perform round-robin scheduling
void round_robin(struct Process processes[], int n) {
    int current_time = 0; // Current time
    int completed_processes = 0; // Number of completed processes

    // Continue scheduling until all processes are completed
    while (completed_processes < n) {
        // Iterate through all processes
        for (int i = 0; i < n; i++) {
            // If the process has arrived and still has remaining burst time
            if (processes[i].arrival_time <= current_time && processes[i].remaining_time > 0) {
                printf("Executing process P%d at time %d\n", processes[i].id, current_time);

                // Execute the process for TIME_QUANTUM or remaining time, whichever is smaller
                int time_slice = TIME_QUANTUM < processes[i].remaining_time ? TIME_QUANTUM : processes[i].remaining_time;
                processes[i].remaining_time -= time_slice;
                current_time += time_slice;

                // If the process has completed
                if (processes[i].remaining_time == 0) {
                    printf("Process P%d completed at time %d\n", processes[i].id, current_time);
                    completed_processes++;
                }
            }
        }
    }
}

int main() {
    // Initialize some sample processes
    struct Process processes[MAX_PROCESSES] = {
        {1, 0, 6, 6}, // Process P1: Arrival time = 0, Burst time = 6
        {2, 2, 4, 4}, // Process P2: Arrival time = 2, Burst time = 4
        {3, 4, 8, 8}, // Process P3: Arrival time = 4, Burst time = 8
        {4, 6, 3, 3}, // Process P4: Arrival time = 6, Burst time = 3
        {5, 8, 5, 5}  // Process P5: Arrival time = 8, Burst time = 5
    };

    // Perform round-robin scheduling on the processes
    round_robin(processes, MAX_PROCESSES);

    return 0;
}











#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>

void ChildProcess(); /* child process prototype */
void ParentProcess(); /* parent process prototype */

int main() {
    pid_t pid;
    pid = fork();
    
    if (pid == 0)
        ChildProcess();
    else if (pid > 0)
        ParentProcess();
    else {
        fprintf(stderr, "Fork failed\n");
        return 1;
    }
    
    return 0;
}

void ChildProcess() {
    printf("Child process running\n");
    // Child process code goes here
}

void ParentProcess() {
    printf("Parent process running\n");
    // Parent process code goes here
}














#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <string.h>

int main(int argc, char* argv[]) {
    pid_t pid = 0;
    pid_t sid = 0;
    FILE *fp = NULL;
    int i = 0;

    pid = fork();

    if (pid < 0) {
        printf("Fork failed!\n");
        exit(1);
    }

    if (pid > 0) {
        printf("PID of child process: %d\n", pid);
        exit(0);
    }

    umask(0);

    sid = setsid();

    if (sid < 0) {
        exit(1);
    }

    close(STDIN_FILENO);
    close(STDOUT_FILENO);
    close(STDERR_FILENO);

    fp = fopen("mydaemonfile.txt", "w");

    if (fp == NULL) {
        perror("Failed to open file");
        exit(1);
    }

    while (i < 10) {
        sleep(1);
        fprintf(fp, "%d\n", i);
        fflush(fp);
        i++;
    }

    fclose(fp);

    return 0;
}




#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/wait.h> // Added for waitpid()

int main() {
    int pid = fork();

    if (pid > 0) {
        printf("in parent process\n");
        waitpid(pid, NULL, 0); // Wait for child to finish
    } else if (pid == 0) {
        sleep(10);
        printf("in child process\n");
        return 0;
    } else {
        printf("Fork failed\n");
        return 1;
    }
    
    printf("Parent finishes execution and exits while the child process is still executing and is called an orphan process now.\n");
    
    return 0;
}













#include <sys/types.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include <sys/wait.h> // for waitpid()

int main() {
    pid_t childPid = fork();
    
    if (childPid < 0) {
        // Error handling if fork fails
        perror("Fork failed");
        exit(EXIT_FAILURE);
    } else if (childPid == 0) {
        // Child process
        printf("Child process with PID: %d\n", getpid());
        exit(EXIT_SUCCESS); // Child exits normally
    } else {
        // Parent process
        printf("Parent process with PID: %d\n", getpid());
        waitpid(childPid, NULL, 0); // Parent waits for child to terminate
        printf("Child process with PID: %d has terminated.\n", childPid);
    }
    
    return 0;
}













#!/bin/bash
#Shell script to get five numbers from the command line and print out their sum:
if [ "$#" -ne 5 ]; then
    echo "Usage: $0 <num1> <num2> <num3> <num4> <num5>"
    exit 1
fi

sum=$(( $1 + $2 + $3 + $4 + $5 ))
echo "Sum of the numbers: $sum"




#!/bin/bash
#Shell script to find palindrome numbers from command-line arguments:ch
for num in "$@"; do
    reverse=$(echo "$num" | rev)
    if [ "$num" = "$reverse" ]; then
        echo "$num is a palindrome."
    fi
done










#!/bin/bash
#Script for e-voting using command-line arguments:



if [ "$#" -ne 4 ]; then
    echo "Usage: $0 <voter_id> <voter_name> <candidate_id> <vote>"
    exit 1
fi

voter_id=$1
voter_name=$2
candidate_id=$3
vote=$4

if ! [[ "$voter_id" =~ ^[0-9]+$ ]]; then
    echo "Invalid voter ID. Please enter a valid numeric ID."
    exit 1
fi

echo "$voter_id,$voter_name,$candidate_id,$vote" >> votes.csv

echo "Vote successfully recorded for $voter_name. Thank you for voting!"








#!/bin/bash

#9. Write a  shell script to find the sum of all even numbers between 1 to n using for loop.

echo "Enter the value of n: "
read n

sum=0
for (( i=2; i<=n; i+=2 ))
do
    sum=$((sum + i))
done

echo "Sum of even numbers from 1 to $n is: $sum"













#!/bin/bash

#8. Write a shell script to check whether a number is palindrome or not.

echo "Enter a number: "
read num

reverse=0
temp=$num

while [ $num -gt 0 ]
do
    digit=$((num % 10))
    reverse=$((reverse * 10 + digit))
    num=$((num / 10))
done

if [ $temp -eq $reverse ]
then
    echo "Palindrome"
else
    echo "Not Palindrome"
fi


#!/bin/bash

#7. Write a shell script to count number of digits in a number.

echo "Enter a number: "
read num

count=0
while [ $num -ne 0 ]
do
    num=$((num/10))
    count=$((count+1))
done

echo "Number of digits: $count"







#!/bin/bash

#6. Write a  shell script to print the multiplication table using for loop.

echo "Enter a number: "
read num

echo "Multiplication table of $num:"
for (( i=1; i<=10; i++ ))
do
    echo "$num x $i = $((num*i))"
done







#!/bin/bash

#5. Write a shell script to print the Fibonacci series up to n terms.

echo "Enter the number of terms: "
read n

a=0
b=1
echo "Fibonacci Series up to $n terms:"
for (( i=0; i<n; i++ ))
do
    echo -n "$a "
    fn=$((a + b))
    a=$b
    b=$fn
done





#!/bin/bash

#4. Write a  shell script to find a number prime or not using for loop.

echo "Enter a number: "
read num

flag=0
for (( i=2; i<=$num/2; i++ ))
do
    if [ $((num%i)) -eq 0 ]
    then
        flag=1
        break
    fi
done

if [ $flag -eq 0 ]
then
    echo "$num is a prime number."
else
    echo "$num is not a prime number."
fi









#!/bin/bash

#3. Write a shell script to calculate the factorial of a number using while loop.

echo "Enter a number: "
read num

factorial=1
while [ $num -gt 1 ]
do
    factorial=$((factorial * num))
    num=$((num - 1))
done

echo "Factorial is: $factorial"






#!/bin/bash

#2. Write a shell script to print all natural numbers in reverse (from n to 1). - using while loop.5

echo "Enter the value of n: "
read n

while [ $n -ge 1 ]
do
    echo $n
    n=$((n-1))
done







#!/bin/bash

#1. Write a shell script to print all natural numbers from 1 to n. - using while loop.

echo "Enter the value of n: "
read n

i=1
while [ $i -le $n ]
do
    echo $i
    i=$((i+1))
done







#!/bin/bash

echo "Enter a number: "
read num

flag=0
for (( i=2; i<=$num/2; i++ ))
do
    if [ $((num%i)) -eq 0 ]
    then
        flag=1
        break
    fi
done

if [ $flag -eq 0 ]
then
    echo "$num is a prime number."
else
    echo "$num is not a prime number."
fi









































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


































#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main() {
    pid_t pid;

    // Attempt to create a child process
    pid = fork();

    switch(pid) {
        case -1:
            perror("Failed to create child process");
            exit(EXIT_FAILURE);
        case 0:
            // Child process
            printf("Child PID: %d\n", getpid());
            printf("Child PPID: %d\n", getppid());
            break;
        default:
            // Parent process
            printf("Parent PID: %d\n", getpid());
            printf("Parent PPID: %d\n", getppid());
            break;
    }

    return 0;
}




















#include <stdio.h>
#include <signal.h>
#include <unistd.h>

void sigint_handler(int signal){
    if(signal == SIGINT){
        printf("signal received");
    }
}

int main(){
    signal(SIGINT, sigint_handler);

    printf("waiting for SIGINT signal..");

    while(1){
        sleep(1);
    }
}




































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




























#include <stdio.h>
#include <signal.h>
#include <unistd.h>

// Signal handler function
void sigint_handler(int signal) {
    printf("Caught SIGINT signal\n");
}

int main() {
    // Registering the signal handler
    signal(SIGINT, sigint_handler);

    printf("Waiting for SIGINT signal...\n");

    // Infinite loop to keep the program running
    while(1) {
        sleep(1);
    }

    return 0;
}















#include <stdio.h>

// Define the maximum number of processes
#define MAX_PROCESSES 5

// Define the time quantum for round-robin scheduling
#define TIME_QUANTUM 2

// Structure to represent a process
struct Process {
    int id;             // Process ID
    int arrival_time;   // Arrival time of the process
    int burst_time;     // Burst time of the process
    int remaining_time; // Remaining burst time of the process
};

// Function to perform round-robin scheduling
void round_robin(struct Process processes[], int n) {
    int current_time = 0; // Current time
    int completed_processes = 0; // Number of completed processes

    // Continue scheduling until all processes are completed
    while (completed_processes < n) {
        // Iterate through all processes
        for (int i = 0; i < n; i++) {
            // If the process has arrived and still has remaining burst time
            if (processes[i].arrival_time <= current_time && processes[i].remaining_time > 0) {
                printf("Executing process P%d at time %d\n", processes[i].id, current_time);

                // Execute the process for TIME_QUANTUM or remaining time, whichever is smaller
                int time_slice = TIME_QUANTUM < processes[i].remaining_time ? TIME_QUANTUM : processes[i].remaining_time;
                processes[i].remaining_time -= time_slice;
                current_time += time_slice;

                // If the process has completed
                if (processes[i].remaining_time == 0) {
                    printf("Process P%d completed at time %d\n", processes[i].id, current_time);
                    completed_processes++;
                }
            }
        }
    }
}

int main() {
    // Initialize some sample processes
    struct Process processes[MAX_PROCESSES] = {
        {1, 0, 6, 6}, // Process P1: Arrival time = 0, Burst time = 6
        {2, 2, 4, 4}, // Process P2: Arrival time = 2, Burst time = 4
        {3, 4, 8, 8}, // Process P3: Arrival time = 4, Burst time = 8
        {4, 6, 3, 3}, // Process P4: Arrival time = 6, Burst time = 3
        {5, 8, 5, 5}  // Process P5: Arrival time = 8, Burst time = 5
    };

    // Perform round-robin scheduling on the processes
    round_robin(processes, MAX_PROCESSES);

    return 0;
}











#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>

void ChildProcess(); /* child process prototype */
void ParentProcess(); /* parent process prototype */

int main() {
    pid_t pid;
    pid = fork();
    
    if (pid == 0)
        ChildProcess();
    else if (pid > 0)
        ParentProcess();
    else {
        fprintf(stderr, "Fork failed\n");
        return 1;
    }
    
    return 0;
}

void ChildProcess() {
    printf("Child process running\n");
    // Child process code goes here
}

void ParentProcess() {
    printf("Parent process running\n");
    // Parent process code goes here
}














#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <string.h>

int main(int argc, char* argv[]) {
    pid_t pid = 0;
    pid_t sid = 0;
    FILE *fp = NULL;
    int i = 0;

    pid = fork();

    if (pid < 0) {
        printf("Fork failed!\n");
        exit(1);
    }

    if (pid > 0) {
        printf("PID of child process: %d\n", pid);
        exit(0);
    }

    umask(0);

    sid = setsid();

    if (sid < 0) {
        exit(1);
    }

    close(STDIN_FILENO);
    close(STDOUT_FILENO);
    close(STDERR_FILENO);

    fp = fopen("mydaemonfile.txt", "w");

    if (fp == NULL) {
        perror("Failed to open file");
        exit(1);
    }

    while (i < 10) {
        sleep(1);
        fprintf(fp, "%d\n", i);
        fflush(fp);
        i++;
    }

    fclose(fp);

    return 0;
}




#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/wait.h> // Added for waitpid()

int main() {
    int pid = fork();

    if (pid > 0) {
        printf("in parent process\n");
        waitpid(pid, NULL, 0); // Wait for child to finish
    } else if (pid == 0) {
        sleep(10);
        printf("in child process\n");
        return 0;
    } else {
        printf("Fork failed\n");
        return 1;
    }
    
    printf("Parent finishes execution and exits while the child process is still executing and is called an orphan process now.\n");
    
    return 0;
}













#include <sys/types.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include <sys/wait.h> // for waitpid()

int main() {
    pid_t childPid = fork();
    
    if (childPid < 0) {
        // Error handling if fork fails
        perror("Fork failed");
        exit(EXIT_FAILURE);
    } else if (childPid == 0) {
        // Child process
        printf("Child process with PID: %d\n", getpid());
        exit(EXIT_SUCCESS); // Child exits normally
    } else {
        // Parent process
        printf("Parent process with PID: %d\n", getpid());
        waitpid(childPid, NULL, 0); // Parent waits for child to terminate
        printf("Child process with PID: %d has terminated.\n", childPid);
    }
    
    return 0;
}













#!/bin/bash
#Shell script to get five numbers from the command line and print out their sum:
if [ "$#" -ne 5 ]; then
    echo "Usage: $0 <num1> <num2> <num3> <num4> <num5>"
    exit 1
fi

sum=$(( $1 + $2 + $3 + $4 + $5 ))
echo "Sum of the numbers: $sum"




#!/bin/bash
#Shell script to find palindrome numbers from command-line arguments:ch
for num in "$@"; do
    reverse=$(echo "$num" | rev)
    if [ "$num" = "$reverse" ]; then
        echo "$num is a palindrome."
    fi
done










#!/bin/bash
#Script for e-voting using command-line arguments:



if [ "$#" -ne 4 ]; then
    echo "Usage: $0 <voter_id> <voter_name> <candidate_id> <vote>"
    exit 1
fi

voter_id=$1
voter_name=$2
candidate_id=$3
vote=$4

if ! [[ "$voter_id" =~ ^[0-9]+$ ]]; then
    echo "Invalid voter ID. Please enter a valid numeric ID."
    exit 1
fi

echo "$voter_id,$voter_name,$candidate_id,$vote" >> votes.csv

echo "Vote successfully recorded for $voter_name. Thank you for voting!"








#!/bin/bash

#9. Write a  shell script to find the sum of all even numbers between 1 to n using for loop.

echo "Enter the value of n: "
read n

sum=0
for (( i=2; i<=n; i+=2 ))
do
    sum=$((sum + i))
done

echo "Sum of even numbers from 1 to $n is: $sum"













#!/bin/bash

#8. Write a shell script to check whether a number is palindrome or not.

echo "Enter a number: "
read num

reverse=0
temp=$num

while [ $num -gt 0 ]
do
    digit=$((num % 10))
    reverse=$((reverse * 10 + digit))
    num=$((num / 10))
done

if [ $temp -eq $reverse ]
then
    echo "Palindrome"
else
    echo "Not Palindrome"
fi


#!/bin/bash

#7. Write a shell script to count number of digits in a number.

echo "Enter a number: "
read num

count=0
while [ $num -ne 0 ]
do
    num=$((num/10))
    count=$((count+1))
done

echo "Number of digits: $count"







#!/bin/bash

#6. Write a  shell script to print the multiplication table using for loop.

echo "Enter a number: "
read num

echo "Multiplication table of $num:"
for (( i=1; i<=10; i++ ))
do
    echo "$num x $i = $((num*i))"
done







#!/bin/bash

#5. Write a shell script to print the Fibonacci series up to n terms.

echo "Enter the number of terms: "
read n

a=0
b=1
echo "Fibonacci Series up to $n terms:"
for (( i=0; i<n; i++ ))
do
    echo -n "$a "
    fn=$((a + b))
    a=$b
    b=$fn
done





#!/bin/bash

#4. Write a  shell script to find a number prime or not using for loop.

echo "Enter a number: "
read num

flag=0
for (( i=2; i<=$num/2; i++ ))
do
    if [ $((num%i)) -eq 0 ]
    then
        flag=1
        break
    fi
done

if [ $flag -eq 0 ]
then
    echo "$num is a prime number."
else
    echo "$num is not a prime number."
fi









#!/bin/bash

#3. Write a shell script to calculate the factorial of a number using while loop.

echo "Enter a number: "
read num

factorial=1
while [ $num -gt 1 ]
do
    factorial=$((factorial * num))
    num=$((num - 1))
done

echo "Factorial is: $factorial"






#!/bin/bash

#2. Write a shell script to print all natural numbers in reverse (from n to 1). - using while loop.5

echo "Enter the value of n: "
read n

while [ $n -ge 1 ]
do
    echo $n
    n=$((n-1))
done







#!/bin/bash

#1. Write a shell script to print all natural numbers from 1 to n. - using while loop.

echo "Enter the value of n: "
read n

i=1
while [ $i -le $n ]
do
    echo $i
    i=$((i+1))
done







#!/bin/bash

echo "Enter a number: "
read num

flag=0
for (( i=2; i<=$num/2; i++ ))
do
    if [ $((num%i)) -eq 0 ]
    then
        flag=1
        break
    fi
done

if [ $flag -eq 0 ]
then
    echo "$num is a prime number."
else
    echo "$num is not a prime number."
fi








