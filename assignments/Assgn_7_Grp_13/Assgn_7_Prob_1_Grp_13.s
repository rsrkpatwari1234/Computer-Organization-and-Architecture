###########################################################################
# Assignment no. : 7
# Problem no. : 1
# Semester : 5
# Group no. : 13
# Group members : Atharva Naik Roshan (18CS10067), Radhika Patwari (18CS10062) 
###########################################################################

####################### Data segment ######################################
.data
input:         .space 31 # input taken from user
output:        .space 31 # output (lowercase)
input_msg:     .asciiz "Enter the upper case string :\n"
output_msg:    .asciiz "The string in lower case is :\n"
newline:       .asciiz "\n"

####################### Data segment ######################################

# MAX SIZE OF INPUT STRING IS 31 (30 characters)

####################### Text segment ######################################
.text
.globl main
main:
        li $v0, 4           # prepare to print string
        la $a0, input_msg   # message asking for lowercase string (store in $a0 as argument for print)
        syscall             # print the prompt for the input

        li $v0, 8       # prepare to take string as input
        li $a1, 31      # max size of input string
        la $a0, input   # store the string in $a0
        syscall
      
        li $t0, 0       # the register for storing the iterator variable 

    while_loop:
        lb $t1, input($t0)          # load the ascii value of the ith character into $t1, with i being stored in $t0
        beq $t1, 0, exit_loop       # test condition to exit the loop
        blt $t1, 'A', not_upper     # b is < 'A' then got to not upper case
        bgt $t1, 'Z', not_upper     # b is > 'Z' then got to not upper case
        addi $t1, $t1, 32           # add 32 to the ascii code to shift a character from 'A' to 'Z' to lower case 
        sb $t1, output($t0)         # store in output at the position stored in $t0

    not_upper:              # if not upper case then copy as it is and move the iterator forward
        sb $t1, output($t0) # store the char at index specified by $t0
        addi $t0, $t0, 1    # increment the iterator variable register
        j while_loop        # jump back to the while loop

    exit_loop:      # block that excecutes after the while loop

    li $v0, 4           # prepare to print string
    la $a0, output_msg  # message announcing the lowercase output (store in $a0 as argument for print)
    syscall             # print pre-output message

    li $v0, 4       # prepare to print string
    la $a0, output  # store the ouput string(lowercase) in $a0 (argument for printing)
    syscall         # print the output

    li $v0, 10      # for exiting
    syscall
####################### Text segment ######################################