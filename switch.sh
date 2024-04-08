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



