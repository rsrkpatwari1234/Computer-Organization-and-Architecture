###########################################################################
# Assignment no. : 6
# Problem no. : 2
# Semester : 5
# Group no. : 13
# Group members : Atharva Roshan Naik (18CS10067), Radhika Patwari (18CS10062)
###########################################################################

####################### Data segment ######################################
.data
msg_input:   .asciiz "Enter n (n >= 2): "
is_comp:    .asciiz "The number is composite\n"
is_prime:   .asciiz "The number is prime\n"
neg_error:  .asciiz "Please enter n >= 2\n"
msg_result:   .asciiz "The sum is: "
newline:   .asciiz "\n"
####################### Data segment ######################################

####################### Text segment ######################################
.text
.globl main
main:
        li $t1, 2               # set $t1 to 2
        li $t2, 1               # set $t2 to 1

        la $a0, msg_input       # ask for the a natural number greater than 1
        li $v0, 4               # prepare for printing string message
        syscall                 # print message

        li $v0, 5               # prepare for reading integer
        syscall                 # read from terminal and store in $v0
        move $a1, $v0           # transfer argument to $a1 

        bgt $a1, $t2, EndLoop   # skip the loop if argument is valid (>1)

        Loop1: 
            la $a0, neg_error   # show error message for invalid input (<2)
            li $v0, 4           # prepare for printing string message
            syscall             # print message

            la $a0, msg_input   # ask for the a natural number greater than 1
            li $v0, 4           # prepare for printing string message
            syscall             # print message

            li $v0, 5           # prepare for reading integer
            syscall             # read from terminal and store in $v0
            move $a1, $v0       # transfer argument to $a1

            blt $a1, $t1, Loop1 # break out of/skip loop if 

        EndLoop:
            li $t0, 1           # set $t0 to 1 (tester variable to check for divisbility)

        # naive algo to brute force and check divisbilty for all numbers less than the number itself
        Loop:                       # loop to check divisibility for all numbers less than n, if n is the input
            addi $t0, $t0, 1        # increment the tester variable (first valued checked is 2)
            rem $a2, $a1, $t0       # compute remainder of the argument with the tester
            bne $a2, $zero, Loop    # break out of loop if remainder is 0, otherwise continue. 
            # Loop will definitely terminate as eventually the tester will become the number itself

            # if after exiting the loop, the tester variable is equal to n, 
            # then the number is prime, as it is not divisible by any integer >1 and <n
            bne $t0, $a1, Else      # jump off to Else statement (the case when tester is not n, i.e. it is composite)
            li  $v0, 4              # prepare for printing string message
            la  $a0, is_prime       # show message that the number is prime
            syscall                 # print the string
            j Endif                 # skip to end of if-else statement (Avoid fall through to Else)

            Else:                   # Else (Composite number case)
                li  $v0, 4          # prepare for printing string message
                la  $a0, is_comp    # show message that the number is composite
                syscall             # print message

            Endif:                  # end of the if (exit the program)
            
                li $v0, 10
                syscall             # exit
           
####################### Text segment ######################################