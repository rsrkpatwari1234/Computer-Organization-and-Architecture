###########################################################################
# Assignment no. : 7
# Problem no. : 3
# Semester : 5
# Group no. : 13
# Group members : Atharva Naik Roshan (18CS10067), Radhika Patwari (18CS10062) 
###########################################################################

####################### Data segment ######################################
.data
space:         .asciiz " "              # a space string
new_line:      .asciiz   "\n"           # a newline string
colonsp:       .asciiz ": "             # a colon string with space
array:         .word     9              # an array of word, for storing values

msg_display:           .asciiz   "Input the value of the 9 integers :"
msg_input:             .asciiz   "Input each value: "
input_val:             .asciiz   "Input value#"
original_array:        .asciiz   "Original Array :"
input_val_to_search:   .asciiz   "Input value to be searched : "
sorted_array_msg:      .asciiz   "Sorted Array : "
msg_Found:             .asciiz   "Value is present in the array."
msg_Index:             .asciiz   "Value is present at index : "
msg_NotFound:          .asciiz   "Value is not present in the array."
####################### Data segment ######################################

####################### Text segment ######################################
.text
.globl  main
main:
     # printing message
     li   $v0, 4                   # 4 = print_string syscall
     la   $a0, msg_display         # load string message to argument register $a0
     syscall                       # issue a system call

     # printing a new line
     li   $v0, 4                   # 4 = print_string syscall
     la   $a0, new_line            # load line to argument register $a0
     syscall                       # issue a system call
     
     # setting base address before taking input integers
     la   $t0, array               # load array to $t0
     addi   $t1, $zero, 9          # load size = 9 to $t1
     li   $t2, 0                   # loop runner, starting from 0

receive_values_loop:               # taking array elements from the user

     # while ($t2 < $t1) : required # of input integers have been taken : terminate 
     bge  $t2, $t1, receive_values_end      

     # input an integer from the user
     li   $v0, 4              # 4 = print_string syscall
     la   $a0, input_val      # load receive_values_loop_iter_string to argument register $a0
     syscall                  # issue a system call
     li   $v0, 1              # 1 = print_int syscall
     addi $a0, $t2, 1         # load (runner + 1) to argument register $a0
     syscall                  # issue a system call
     li   $v0, 4              # 4 = print_string syscall
     la   $a0, colonsp        # load colonsp to argument register $a0
     syscall                  # issue a system call

     li   $v0, 5              # 5 = read_int syscall
     syscall                  # issue a system call
     sw   $v0, 0($t0)         # store returned value from syscall in the array

     addi $t0, $t0, 4         # increment array pointer by 4
     addi $t2, $t2, 1         # increment loop runner by 1
     j    receive_values_loop # jump back to the beginning of the loop

receive_values_end:           # printing the original array
     # Original array message
     li   $v0, 4              # 4 = print_string syscall
     la   $a0, original_array # load string message to argument register $a0
     syscall                  # issue a system call

     # printing a new line
     li   $v0, 4                   # 4 = print_string syscall
     la   $a0, new_line            # load line to argument register $a0
     syscall                       # issue a system call

     jal  arrayPrint               # call print routine for printing the original array

Sorting_array:                # sorting the array using Insertion sorting technique
     la   $t0, array            # storing the base address of array in $t0 register
     move $a0, $t0            # setting 1st parameter of InsertionSort() as base address of array
     addi $t1, $zero, 9       # storing size of array temporarily in $t1
     move $a1, $t1            # setting 2nd parameter of InsertionSort() as # of elements of the array
     jal InsertionSort        # calling the InsertionSort() for sorting the array

     jal  arrayPrint          # call print routine : Printing the sorted array

value_to_search:
     # ask the user to input the value to be searched
     li   $v0, 4                        # 4 = print_string syscall
     la   $a0, input_val_to_search      # load input_val_to_search string message to argument register $a0.
     syscall                            # issue a system call

     addi $sp, $sp, -4       # adjust stack pointer for 1 item 
     sw   $s0, 0($sp)        # save previous value of s0 in stack

     # take input from the user
     li $v0, 5                # for read_int
     syscall                  # argument in $v0
     move $a0, $v0            # argument in $a0

     move $s0, $a0             # saving the value to be searched in save register s0

search:                       # applying Recursive Binary search technique in the sorted array
     la $t0, array            # storing the base address of array in $t0 register
     move $a0, $t0            # setting 1st parameter of BinarySearch() as base address of array
     move $a1, $zero          # setting 2nd parameters of BinarySearch() as lower index
     addi $t1, $zero, 8       # setting upper index for bianry search as 8 (total 9 integers in array)
     move $a2, $t1            # setting 3rd parameter of BinarySearch() as upper index
     move $a3, $s0            # setting 4rt parameter of BinarySearch() as the element to be searched
     jal BinarySearch         # callling the Binary search procedure with the sorted array

     addi $t1, $zero, -1   
     beq  $v0, $t1, elementNotFound        # checking if -1 is returned by BinarySearch() function -> value not found

     move $t2, $v0             # if value of found, store the index of searched element temporarily in $t2

     # printing a value found message
     li   $v0, 4              # 4 = print_string syscall
     la   $a0, msg_Found      # load msg_Found to argument register $a0
     syscall                  # issue a system call

     # printing the new line 
     li   $v0, 4              # 4 = print_string syscall
     la   $a0, new_line       # load new_line to argument register $a0
     syscall                  # issue a system call

     # printing the index of the sorted array where the element is found
     li   $v0, 4              # 4 = print_string syscall
     la   $a0, msg_Index      # load msg_Index to argument register $a0
     syscall                  # issue a system call

     li  $v0, 1               # for print_int
     move $a0, $t2            # get argument back in $a0
     syscall                  # print the argument

     lw $s0, 0($sp)           # restoring the previous value of s0 stored in stack
     addi $sp, $sp, 4         # restoring the previous value of stack pointer 

     j exit                   # call the exit function for exit syscall

elementNotFound:              # output message if searched element is not found 
     li   $v0, 4              # 4 = print_string syscall
     la   $a0, msg_NotFound   # load msg_NotFound to argument register $a0
     syscall                  # issue a system call
     j exit                   # call the exit function for exit syscall

InsertionSort:

     li   $t2, 1                        # outer loop counter 
     
     outer_loop:                        # section that excutes from 1 to n-1 (all elements except the first), i.e. the outer loop
          bge  $t2, $a1, end_loop       # while (t2 < $a1)
          move $t3, $t2                 # copy $t2 to $t3, t3 is inner loop counter
     inner_loop:                        # section that sorts the subarray arr[0 .. t2]  
          mul  $t4, $t3, 4              # multiply $t3 with 4, and store in $t4
          add  $t0, $a0, $t4            # add the array address with $t4 to get arr[t3]
          bgt  $t3, $zero, sort_subarray# t3 > 0 (sort subarray if needed)
          j    inc_step                 # jump to incrementing global counter (t2) if t3 <= 0
     sort_subarray:                     # section that contains the test condition for deciding if arr[0 .. t2] is sorted or not                
          lw   $t7, 0($t0)              # load array[$t3] to $t7
          lw   $t6, -4($t0)             # load array[$t3 - 1] to $t6
          blt  $t7, $t6, swap           # while (array[$t3] < array[$t3 - 1])
     inc_step:                          # section for incrementing the global counter, t2
          addi $t2, $t2, 1              # increment t2 by 1
          j    outer_loop               # jump to the outer loop
     swap:                              # section for swapping arr[t3] and arr[t3-1] and performing updates on inner loop counter
          # the 3 instructions below swap arr[t3] and arr[t3-1]
          lw   $t5, -4($t0)
          sw   $t7, -4($t0)             
          sw   $t5, 0($t0)             
          addi $t3, $t3, -1            # decrement the inner loop counter
          j    inner_loop              # jump to the start of the inner loop
     end_loop:                         # instructions after the sorting loop finishes execution
          # to print a message before displaying the sorted array  
          li   $v0, 4              
          la   $a0, sorted_array_msg   
          syscall
          # printing a new line
          li   $v0, 4                   # 4 = print_string syscall
          la   $a0, new_line            # load line to argument register $a0
          syscall                       # issue a system call                      

     jr $ra      

BinarySearch:                        # performing Binary search on the sorted array
     slt $t0, $a2, $a1               # check if (upper index < lower index)
     beq $t0, $zero, checkCases      # if no then perform binary search

     addi $v0, $zero, -1             # else return -1

     jr $ra                          # return back to the calling function

checkCases:  
     # find middle index of the lower and upper boundaries  
     sub $t0, $a2, $a1               # calculate (upper index - lower index)
     srl $t0, $t0, 1                 # calculate (upper index - lower index)/2
     add $t0, $a1, $t0               # compute middle index as [lower index + (upper - lower)/2]

     # t0 : contain the middle index

     mul  $t1, $t0, 4                # find the address corresponding to middle index
     add  $t2, $a0, $t1
     lw   $t3, 0($t2)                # setting t3 = array[middle index]

saveValues:                          # save the required values in the memory stack 
     addi $sp, $sp, -12              # adjust stack pointer for 3 items 
     sw   $a1, 0($sp)                # save lower index value in stack
     sw   $a2, 4($sp)                # save upper index value in stack
     sw   $ra, 8($sp)                # save the current address of caller function in the stack

     beq $t3, $a3, found             # if array[mid] == query then FOUND
     slt $t4, $t3, $a3               # if array[mid] < query then go to lowerStack
     bne $t4, $zero, lowerStack
     j upperStack                    # if array[mid] > query then go to upperStack

lowerStack:                  # Reset the boundaries for making the recursive call of Binary Search()
     addi $a1, $t0, 1        # Set [Lower index = mid + 1]
     jal  BinarySearch       # make a recursive call to BinarySearch()
     j    checkIfFound       # restore the saved values in the stack
     
upperStack:                  # Reset the boundaries for making the recursive call of Binary Search()
     addi $a2, $t0, -1       # Set [Lower index = mid + 1]
     jal  BinarySearch       # make a recursive call to BinarySearch()
     
checkIfFound:
     lw   $a1, 0($sp)        # restoring the previous value of Lower Index from stack
     lw   $a2, 4($sp)        # restoring the previous value of Upper Index from stack
     lw   $ra, 8($sp)        # restoring the previous value of return address of caller function from stack 
     addi $sp, $sp, 12       # restoring the stack pointer back to its previous value
     
     jr   $ra                # returning back to the calling function

found:                       # if the element is found
     move   $v0, $t0         # return the value of middle index where element is found
     jr   $ra                # return back to the calling function

arrayPrint:
     print_loop_prep:         
          la   $t0, array               # storing base address of array temporarily in t0
          addi   $t1, $zero,8           # storing size of array temporarily in t1
          li   $t2, 0                   # loop counter , initialised with 0 
     print_loop:                        # Iterative loop for printing array elements
          bge  $t2, $t1, print_end      # Loop run till [loop variable < size of array]

          # syscall for printing an integer
          li   $v0, 1                   # 1 = print_int syscall    
          lw   $a0, 0($t0)              # setting a0 = array[i] for i = 0 to n-1
          syscall                       # syscall 

          # syscall for printing a space to separate the array values
          li   $v0, 4                   # 4 = print_string syscall   
          la   $a0, space               # set the space message to be printed
          syscall                       # make a syscall

          addi $t0, $t0, 4              # increase array pointer by 4 as each int takes 4 bytes memory
          addi $t2, $t2, 1              # increment loop counter by 1 at the end of each iteration
          j    print_loop               # loop
     print_end:               
          # finally print a new line after printing all elements of the array     
          li   $v0, 4                   # 4 = print_string syscall 
          la   $a0, new_line            # storing the new_line message
          syscall                       # make a syscall
          jr   $ra                      # return back to the calling function

exit:
     li   $v0, 10             # 10 = exit syscall
     syscall                  # issue a system call

####################### Text segment ######################################

