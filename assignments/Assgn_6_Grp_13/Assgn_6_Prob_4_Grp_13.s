###########################################################################
# Assignment no. : 6
# Problem no. : 4
# Semester : 5
# Group no. : 13
# Group members : Radhika Patwari (18CS10062), Atharva Naik Roshan (18CS10067)
###########################################################################

####################### Data segment ######################################
.data
msg1_input:    .asciiz "Enter the first argument (16-bit signed integer): "
msg1_arg:      .asciiz "The first argument is: "

msg2_input:    .asciiz "Enter the second argument (16-bit signed integer): "
msg2_arg:      .asciiz "The second argument is: "

msg1_incorrect:.asciiz "Incorrect Input!First argument is not within the range (-2^15 to 2^15-1). "
msg2_incorrect:.asciiz "Incorrect Input!Second argument is not within the range (-2^15 to 2^15-1). "

msg_result:    .asciiz "The Product obtained after applying Booth's multiplication is: "

newline:       .asciiz "\n"

####################### Data segment ######################################

####################### Text segment ######################################
.text
.globl main
main:
     # save s0 and s1 in the stack
     addi $sp, $sp, -8        # adjust stack pointer for 2 items 
     sw   $s0, 0($sp)         # save previous value of s0 in stack
     sw   $s1, 4($sp)         # save previous value of s1 in stack

     # take first input
     la $a0, msg1_input       # message string in $a0, pseudoinstruction
     li $v0, 4                # Prepare to print the message
     syscall                  # print the message

     li $v0, 5                # for read_int
     syscall                  # argument in $v0
     move $a0, $v0            # argument in $a0

     move $s0, $a0            # save register $s0 contains the first argument  

     # Print first argument to make sure....debug step
     li  $v0, 4               # for print_str
     la  $a0, msg1_arg        # preparing to print the message
     syscall                  # print the string

     li  $v0, 1               # for print_int
     move $a0, $s0            # get argument back in $a0
     syscall                  # print the argument

     # print the new line
     li  $v0, 4               # for print_str
     la  $a0, newline         # preparing to print the newline
     syscall                  # print the newline

     # take second input
     la $a0, msg2_input       # message string in $a0, pseudoinstruction
     li $v0, 4                # Prepare to print the message
     syscall                  # print the message

     li $v0, 5                # for read_int
     syscall                  # argument in $v0
     move $a0, $v0            # argument in $a0

     move $s1, $a0            # save register $s1 contains the second argument  

     # Print second argument to make sure....debug step
     li  $v0, 4               # for print_str
     la  $a0, msg2_arg        # preparing to print the message
     syscall                  # print the string

     li  $v0, 1               # for print_int
     move $a0, $s1            # get argument back in $a0
     syscall                  # print the argument

     # s0 : first argument
     # s1 : second argument

     # sanity check to ensure that both the arguments are within range of 16-bit signed integers
     addi $t0, $zero, -32768  # setting t0=(-2^15)   : lower bound for 16-bit signed integers
     addi $t1, $zero, 32767   # setting t1=(2^15-1)  : upper bound for 16-bit signed integers

     slt $t2, $s0, $t0                  # if (s0<(-2^15)) t2=1 else t2=0 
     bne $t2, $zero, Wrong_input1       # if (t2==1) then print wrong input

     sgt $t2, $s0, $t1                  # if (s0>(2^15-1)) t2=1 else t2=0 
     bne $t2, $zero, Wrong_input1       # if (t2==1) then print wrong input

     slt $t2, $s1, $t0                  # if (s1<(-2^15)) t2=1 else t2=0 
     bne $t2, $zero, Wrong_input2       # if (t2==1) then print wrong input

     sgt $t2, $s1, $t1                  # if (s1>(2^15-1)) t2=1 else t2=0 
     bne $t2, $zero, Wrong_input2       # if (t2==1) then print wrong input
    
     # call to Booth multiplication computing function
     move $a0, $s0           # 1st param of Booth function is s0 
     move $a1, $s1           # 2nd param of Booth function is s1
     jal  seq_mult_booth     # jump to seq_mult_booth procedure and store PC value in $ra

     # v0 : final multiplied value returned by Booth's multiplication function

     move $t0, $v0           # storing the product value temporarily in t0 

     # Print a newline and output
     li  $v0, 4               # for print_str
     la  $a0, newline         # preparing to print the newline
     syscall                  # print the newline
     
     # Print product value obtained after multiplication
     li  $v0, 4               # for print_str
     la  $a0, msg_result      # preparing to print the message 
     syscall                  # print the string
 
         
     move $a0, $t0            # get result in $a0
     li  $v0, 1               # for print_int
     syscall                  # print the result

     lw   $s0, 0($sp)         # restoring the previous value of s0 stored in stack
     lw   $s1, 4($sp)         # restoring the previous value of s1 stored in stack
     addi $sp, $sp, 8         # restoring the previous value of stack pointer

     j Exit                   # call the Exit function for exit syscall


seq_mult_booth:               # Booth's multiplication algorithm
      
     #a0 : multiplicand
     #a1 : multiplier

     addi $sp, $sp, -20       # adjust stack for 5 items 
     sw   $s2, 0($sp)         # save previous value of s2 in stack
     sw   $s3, 4($sp)         # save previous value of s3 in stack
     sw   $s4, 8($sp)         # save previous value of s4 in stack
     sw   $s5, 12($sp)        # save previous value of s5 in stack
     sw   $s6, 16($sp)        # save previous value of s6 in stack

     add $s2, $zero, $zero   # Extra LSB value of multiplier , initialised with 0
     move $s3, $a0           # saving multiplicand value
     move $s4, $a1           # saving multiplier value
     add $s5, $zero,$zero    # initialising register for storing final product
     addi $s6, $zero, 16     # loop counter for analysing 16-bits of multiplier

     Loop:                   # loop for performing Booth algorithm for all 16-bits of multiplier
     bne $s6, $zero, check_prev_lsb      # if (# of remaining bits > 0) perform Booth's algorithm

     move $v0, $s5           # store the final product value in the return register

     lw   $s2, 0($sp)        # restore the previous value of save register $s2
     lw   $s3, 4($sp)        # restore the previous value of save register $s3
     lw   $s4, 8($sp)        # restore the previous value of save register $s4
     lw   $s5, 12($sp)       # restore the previous value of save register $s5
     lw   $s6, 16($sp)       # restore the previous value of save register $s6
     addi $sp, $sp, 20       # restore the previous position of stack pointer

     jr $ra                  # return back to the calling function address which is stored in $ra


check_prev_lsb:              # checking the previous LSB value of multiplier
     beq $s2, $zero, prev_lsb_0       # moving to cases depending upon whether the value is 0/1
     j prev_lsb_1

prev_lsb_0:                   # previous LSB is 0, now check the current LSB of multiplier
     andi $t0, $s4, 1         # storing LSB of multiplier in $t0
     beq $t0, $zero, case_00  # if current LSB of multiplier is 0, goto case 00
     j case_10                # else goto case 10

prev_lsb_1:                   # previous LSB is 1, now check the current LSB of multiplier
     andi $t0, $s4, 1         # storing LSB of multiplier in $t0
     beq $t0, $zero, case_01  # if current LSB of multiplier is 0, goto case 01
     j case_11                # else goto case 11

case_00:
     j shift                  # no action required, just perform the required shifting

case_01:
     add $s5, $s5, $s3        # perform addition of shifted version of multiplicand to final product value
     j shift

case_10:
     sub $s5, $s5, $s3        # perform subtraction of shifted version of multiplicand from final product value
     j shift

case_11:
     j shift                  # no action required, just perform the required shifting


shift:                        # perform the left shift of multiplicand and right shift of multiplier  
     andi $t0, $s4, 1         # extracting the current LSB value of multiplier
     move $s2, $t0            # re-initialising previous LSB value with new LSB value of multiplier
     srl $s4, $s4, 1          # right shift of multiplicand
     sll $s3, $s3, 1          # left shift of multiplier
     addi $s6, $s6, -1        # decreasing the loop counter by 1
     j Loop                   # going back to Booth'a algorithm termination condition

Wrong_input1:                 #Printing appropriate message for argument outside range
     #print new line
     li  $v0, 4               # for print_str
     la  $a0, newline         # preparing to print the newline
     syscall                  # print the newline

	#Message for incorrect first input
     la $a0, msg1_incorrect   # message string in $a0, pseudoinstruction
     li $v0, 4                # Prepare to print the message
     syscall                  # print the message
     j Exit                   # exit syscall

Wrong_input2:                 #Printing appropriate message for argument outside range
     #print new line
     li  $v0, 4               # for print_str
     la  $a0, newline         # preparing to print the newline
     syscall                  # print the newline

	#Message for incorrect second input
     la $a0, msg2_incorrect   # message string in $a0, pseudoinstruction
     li $v0, 4                # Prepare to print the message
     syscall                  # print the message

Exit:
     li $v0, 10
     syscall                  # exit
           
####################### Text segment ######################################

