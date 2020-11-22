###########################################################################
# Assignment no. : 6
# Problem no. : 1
# Semester : 5
# Group no. : 13
# Group members : Radhika Patwari (18CS10062), Atharva Naik Roshan (18CS10067)
###########################################################################

####################### Data segment ######################################
.data
msg1_input:    .asciiz "Enter the first argument (positive number): "
msg1_arg:      .asciiz "The first argument is: "

msg2_input:    .asciiz "Enter the second argument (positive number): "
msg2_arg:      .asciiz "The second argument is: "

msg1_incorrect:.asciiz "Incorrect Input!First argument is not positive. "
msg2_incorrect:.asciiz "Incorrect Input!Second argument is not positive. "

msg_result:    .asciiz "The calculated gcd is: "

newline:       .asciiz "\n"
####################### Data segment ######################################

####################### Text segment ######################################
.text
.globl main
main:
     #take first input
     la $a0, msg1_input       # message string in $a0, pseudoinstruction
     li $v0, 4                # Prepare to print the message
     syscall                  # print the message

     li $v0, 5                # for read_int
     syscall                  # argument in $v0
     move $a0, $v0            # argument in $a0

     # Print first argument to make sure....debug step
     move $t0, $a0            # temporary register $t0 contains the argument   
     li  $v0, 4               # for print_str
     la  $a0, msg1_arg        # preparing to print the message
     syscall                  # print the string

     li  $v0, 1               # for print_int
     move $a0, $t0            # get argument back in $a0
     syscall                  # print the argument

     #print the new line
     li  $v0, 4               # for print_str
     la  $a0, newline         # preparing to print the newline
     syscall                  # print the newline

     #take second input
     la $a0, msg2_input       # message string in $a0, pseudoinstruction
     li $v0, 4                # Prepare to print the message
     syscall                  # print the message

     li $v0, 5                # for read_int
     syscall                  # argument in $v0
     move $a0, $v0            # argument in $a0

     # Print second argument to make sure....debug step
     move $t1, $a0            # temporary register $t0 contains the argument   
     li  $v0, 4               # for print_str
     la  $a0, msg2_arg        # preparing to print the message
     syscall                  # print the string

     li  $v0, 1               # for print_int
     move $a0, $t1            # get argument back in $a0
     syscall                  # print the argument

     # t0 : first argument
     # t1 : second argument

     # sanity check to ensure that both the arguments are positive
     slt $t2, $zero, $t0                # check if t0<0 , if true then t2=1 else t2=0
     beq $t2, $zero, Wrong_input1       # if t2=1 then argument is negative : Print wrong input

     slt $t2, $zero, $t1                # check if t1<0 , if true then t2=1 else t2=0
     beq $t2, $zero, Wrong_input2       # if t2=1 then argument is negative : Print wrong input
    
     # GCD calculation
     beq $t0, $t1, Print         # if both arguments are equal,print the gcd directly
     Loop:                       
     sgt $t2, $t0, $t1           # if (t0>t1) then t2=1 else t2=0 
     beq $t2, $zero, update      # if (t2==1) then update t0=t0-t1
     sub $t0, $t0, $t1           # else update t1=t1-t0
     Check:                      # termination step for the Loop
     bne $t0, $t1, Loop          # Loop runs till both the arguments are unequal

Print:
     #Print the new line
     li  $v0, 4               # for print_str
     la  $a0, newline         # preparing to print the newline
     syscall                  # print the newline
     
     # Print GCD value
     li  $v0, 4               # for print_str
     la  $a0, msg_result      # preparing to print the message 
     syscall                  # print the string
        
     move $a0, $t0            # get result in $a0
     li  $v0, 1               # for print_int
     syscall                  # print the result

     j Exit                   # call the Exit syscall


update:                       # updation step for t1>t0 case
     sub $t1, $t1,$t0         # t1=t1-t0
     j Check                  # return back to Loop termination step for checking condition
    
Wrong_input1:                 #Printing appropriate message for non-positive arguments
     # print new line
     li  $v0, 4               # for print_str
     la  $a0, newline         # preparing to print the newline
     syscall                  # print the newline

	# Message for incorrect first input
     la $a0, msg1_incorrect   # message string in $a0, pseudoinstruction
     li $v0, 4                # Prepare to print the message
     syscall                  # print the message
     j Exit

Wrong_input2:                 # Printing appropriate message for non-positive arguments
     # print new line
     li  $v0, 4               # for print_str
     la  $a0, newline         # preparing to print the newline
     syscall                  # print the newline

	# Message for incorrect second input
     la $a0, msg2_incorrect   # message string in $a0, pseudoinstruction
     li $v0, 4                # Prepare to print the message
     syscall                  # print the message

Exit:
     li $v0, 10
     syscall                  # exit
           
####################### Text segment ######################################

