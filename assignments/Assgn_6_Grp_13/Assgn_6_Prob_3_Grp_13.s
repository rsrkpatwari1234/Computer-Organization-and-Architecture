###########################################################################
# Assignment no. : 6
# Problem no. : 3
# Semester : 5
# Group no. : 13
# Group members : Atharva Roshan Naik (18CS10067), Radhika Patwari (18CS10062) 
###########################################################################

####################### Data segment ######################################
 .data
msg_arg1:   .asciiz "Enter multiplicand: "
msg_arg2:   .asciiz "Enter multiplier: "
out_of_range_error:  .asciiz "One of the operands is out of bounds\n"
neg_error:  .asciiz "Please enter a positive integer\n"
msg_result:   .asciiz "The product is: "
neg_ans:    .asciiz "The product can't be printed in 32 bits\n"
newline:   .asciiz "\n"
####################### Data segment ######################################

####################### Text segment ######################################
.text
.globl main
.ent main
main:
        la $a0, msg_arg1                # ask for the first argument
        li $v0, 4                       # prepare for printing string message
        syscall                         # print message

        li $v0, 5                       # prepare for reading integer
        syscall                         # read from terminal and store in $v0
        move $t0, $v0                   # transfer argument to $t0

        blt $t0, $zero, Exit_neg        # jump to Exit neg if argument 1 is negative

        la $a0, msg_arg2                # ask for the second argument
        li $v0, 4                       # prepare for printing string message
        syscall                         # print message

        li $v0, 5                       # prepare for reading integer
        syscall                         # read from terminal and store in $v0
        move $t1, $v0                   # transfer argument to $t1

        blt $t1, $zero, Exit_neg        # jump to Exit neg if argument 2 is negative
        j No_neg_error                  # jump to no neg error to avoid fall throught to Exit_neg
        
        # exit if any of the arguments is negative
        Exit_neg:
            la $a0, neg_error      # show error message if any one of the arguments is negative
            li $v0, 4              # prepare for printing string message
            syscall                # print message
            
            li $v0, 10
            syscall                # exit             

        No_neg_error:           # continue from here if both arguments are non-negative
        move $a0, $t0           # transfer mulitplicand/arg-1 to $a0 
        move $a1, $t1           # transfer multiplier/arg-2 to $a1

        li $t1, 65535           # store max representable 16 bit integer in $t1

        # range checking (whether both lie in first 16 bits)
        bgt $a0, $t1, Exit_out_of_bounds    # check if first argument is within capacity
        bgt $a1, $t1, Exit_out_of_bounds    # check if second argument is within capacity
        j Within_bounds                     # jump to Within_bounds if both arguments <= 65535
        
        # exit if any of the arguments is out of bounds
        Exit_out_of_bounds:
            la $a0, out_of_range_error      # show error message if any one of the arguments is out of range (>65535)
            li $v0, 4                       # prepare for printing string message
            syscall                         # print message
            
            li $v0, 10
            syscall                         # exit      

        Within_bounds:                      # arguments within bounds (<= 65535)
        jal seq_mult_unsigned               # call seq_mult_unsigned procedure

        blt $v0, $zero, Negative_ans        # handle case with negative product output
        j Normal_exit                       # exit if product is negative

        Negative_ans:
            li $v0, 4                       # prepare for printing string message
            la, $a0, neg_ans                # show error message if the answer is negative (32nd bit is set to 1)
            syscall                         # print message

            li $v0, 10
            syscall                         # exit    

        Normal_exit:
            move $a0, $v0                   # transfer $v0 to $a0
            li  $v0, 1                      # prepare for printing integer
            syscall                         # print integer

            li $v0, 4                       # prepare for printing string message
            la $a0, newline                 # print a newline character
            syscall                         # print message

            li $v0, 10
            syscall                         # exit         
            .end main

        .globl seq_mult_unsigned 
        .ent seq_mult_unsigned

####################### Text segment ######################################

####################### Procedure calls ###################################
seq_mult_unsigned:
        # save stack pointer
        addi $sp, $sp, -4
        sw $s0, 0($sp)

        li $v0, 0           # initialise v0 to 0 (product register)
        li $t3, 0           # loop counter

        For_Loop:           # for loop
        andi $t2, $a0, 1    # check if last bit is 1
        bne $t2, 1, Temp    # jump if last bit is not 1
        addu $v0, $v0, $a1  # unsigned addtition of mulitplier
        Temp:
            sllv $a1, $a1, 1            # shift $a1 to left (part of algo)
            srl $a0, $a0, 1             # shift right/ remove LSB from $a0
            bgt $a0, $zero, For_Loop    # exit For_loop if $a0 becomes zero
        
        # restore stack pointer
        lw $s0, 0($sp)
        addi $sp, $sp, 4
        
        # exit procedure 
        jr $ra
        .end seq_mult_unsigned
        
####################### Procedure calls ###################################