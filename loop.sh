# #!/bin/bash

# echo "Enter the value of n:"
# read n

# i=1
# while [ $i -le $n ]
# do
#     echo $i
#     i=$((i+1))
# done


# #!/bin/bash

# echo "Enter the value of n:"
# read n

# while [ $n -ge 1 ]
# do
#     echo $n
#     n=$((n-1))
# done

#!/bin/bash

# echo "Enter a number:"
# read num

# factorial=1
# while [ $num -gt 1 ]
# do
#     factorial=$((factorial * num))
#     num=$((num - 1))
# done

# echo "Factorial is $factorial"




#!/bin/bash

# echo "Enter a number:"
# read num

# prime="true"

# for (( i=2; i<=num/2; i++ ))
# do
#     if [ $((num%i)) -eq 0 ]
#     then
#         prime="false"
#         break
#     fi
# done

# if [ "$prime" = "true" ]
# then
#     echo "$num is prime"
# else
#     echo "$num is not prime"
# fi

#!/bin/bash

# echo "Enter the number of terms:"
# read n

# a=0
# b=1
# echo "Fibonacci series:"
# echo $a
# echo $b

# for (( i=2; i<n; i++ ))
# do
#     c=$((a+b))
#     echo $c
#     a=$b
#     b=$c
# done

#!/bin/bash

# echo "Enter a number:"
# read num

# echo "Multiplication table for $num:"
# for (( i=1; i<=10; i++ ))
# do
#     echo "$num x $i = $((num*i))"
# done

#!/bin/bash

# echo "Enter a number:"
# read num

# count=0

# while [ $num -gt 0 ]
# do
#     num=$((num/10))
#     count=$((count+1))
# done

# echo "Number of digits: $count"

#!/bin/bash

# echo "Enter a number:"
# read num

# original=$num
# reverse=0

# while [ $num -gt 0 ]
# do
#     remainder=$((num%10))
#     reverse=$((reverse*10+remainder))
#     num=$((num/10))
# done

# if [ $original -eq $reverse ]
# then
#     echo "$original is a palindrome"
# else
#     echo "$original is not a palindrome"
# fi

#!/bin/bash

# echo "Enter a number:"
# read n

# sum=0
# for (( i=2; i<=n; i+=2 ))
# do
#     sum=$((sum + i))
# done

# echo "Sum of even numbers from 1 to $n is $sum"


#!/bin/bash

# echo "Enter a number:"
# read n

# i=1
# while [ $i -le $n ]
# do
#     if [ $((i % 2)) -eq 1 ]
#     then
#         echo $i
#     fi
#     i=$((i+1))
# done
