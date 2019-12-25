.data
head: .asciiz "||~~~~~~ Welcome to CAO Lab Project Execution Process ~~~~~~||\n||~~~~~~ Own By : 3A Group ~~~~~~||"
question: .asciiz "\n\n\nWhat you want to do?\nPlease select from given option\n"
choise: .asciiz "1-Bubble Sort\n2-Selection Sort\n3-Insertion Sort\n4-Merge Sort\n5-Quick Sort\n0-Exit\n"
error: .asciiz "Invalid Input"
ok: .asciiz "OK"
exit: .asciiz "Sussessfully Exit"
str0: .asciiz "\n~~~~~~~~~Selection sorts~~~~~~~~~\n"
str1:.asciiz "Enter the size of Array :"
str2:.asciiz "Insert the array elements :\n"
str3:.asciiz "The sorted Array is : \n"
str5:.asciiz "\n"
spc: .asciiz " "
bubble: .asciiz "\n~~~~~~~~~Bubble Sort~~~~~~~~~\n"
.align 4
Table: .space 1000
msg0: .asciiz "Enter Size of Array : "
msg1: .asciiz "Insert the array element : "
msg2: .asciiz " "
msg3: .asciiz "\nThe sorted Array is : "
insertion: .asciiz "\n~~~~~~~~~Insertion Sort~~~~~~~~~\n"
.eqv MAX_LEN_BYTES 4000
input_data:        .space    MAX_LEN_BYTES
input_msg:         .asciiz "Enter size of Array: "
input_msg_2:         .asciiz "Input integers: "
input_msg_4: .asciiz "\nThe Sorted Array is : \n "
input_msg_space:        .asciiz    " "
input_msg_open_bracket: .asciiz    "[ "
input_msg_close_bracket: .asciiz    "]"
error_msg: .asciiz "\n The list size cannot be less than or equal to 0 ! \n "
merge: .asciiz "\n~~~~~~~~~Merge Sort~~~~~~~~~\n"
Sorted_Array:	.asciiz		"\nThe Sorted Array is : ["
Space:		.asciiz		", "
Bracket:	.asciiz		"]"
c: 	.word 0:100 #int c[100] is global
array1:	.word 1,4,7,10,25,3,5,13,17,21 # should be  10 size
array2:	.word 56,3,46,47,34,12,1,5,10,8,25,29,31,50,4,5   #should be 16
quick: .asciiz "\n~~~~~~~~~Quick Sort~~~~~~~~~\n"
Array:		.word	86, 177, 40, 77, 60, 45, 136, 73, 57, 95, 8, 170, 98, 1, 158, 95, 150, 55, 68, 138, 85, 172, 61, 198, 135
Array_size:	.space	4
msg_before:	.asciiz	"before : "
msg_after:	.asciiz "after : "
msg_space:	.asciiz " "
msg_newL:	.asciiz "\n"


.text
la $a0,head 
li $v0,4
syscall
recall:
la $a0,question
li $v0,4
syscall
la $a0,choise
li $v0,4
syscall

li $v0,5
syscall
move $t0,$v0
beq $t0,0,exitcall
bge $t0,6,errorcall
blt $t0,1,errorcall
beq $t0,1,main01
beq $t0,2,main2
beq $t0,3,main03
beq $t0,4,main04
beq $t0,5,main05
li $v0,10
syscall



.text
.globl main01
main01:
la $a0,bubble
li $v0,4
syscall
la $a0,msg0
li $v0,4
syscall
li $v0,5
syscall
ble $v0,0,invalid_size
subi $s0,$v0,1
add $s0,$zero,$s0
addi $t0,$zero,0
in:
li $v0,4
la $a0,msg1
syscall
li $v0,5
syscall
add $t1,$t0,$zero
sll $t1,$t0,2
add $t3,$v0,$zero
sw $t3,Table ( $t1 )
addi $t0,$t0,1
slt $t1,$s0,$t0
beq $t1,$zero,in

la $a0,Table
addi $a1,$s0,1 #a1=6
#call buble_sort
jal buble_sort

#print table
li $v0,4
la $a0,msg3
syscall
la $t0,Table
#s0=5
add $t1,$zero,$zero
printtable:
lw $a0,0($t0)
li $v0,1
syscall
li $v0,4
la $a0,msg2
syscall
addi $t0,$t0,4
addi $t1,$t1,1
slt $t2,$s0,$t1
beq $t2,$zero,printtable

j recall
#li $v0,10
#syscall

buble_sort:
#a0=address of table
#a1=sizeof table
add $t0,$zero,$zero #counter1( i )=0

loop1:
addi $t0,$t0,1 #i++
bgt $t0,$a1,endloop1 #if t0 < a1 break;

add $t1,$a1,$zero #counter2=size=6
loop2:

bge $t0,$t1,loop1 #j < = i

#slt $t3,$t1,$t0
#bne $t3,$zero,loop1

addi $t1,$t1,-1 #j--

mul $t4,$t1,4 #t4+a0=table[j]
addi $t3,$t4,-4 #t3+a0=table[j-1]
add $t7,$t4,$a0 #t7=table[j]
add $t8,$t3,$a0 #t8=table[j-1]
lw $t5,0($t7)
lw $t6,0($t8)

bgt $t5,$t6,loop2

#switch t5,t6
sw $t5,0($t8)
sw $t6,0($t7)
j loop2

endloop1:
jr $ra



.text
main2:		.globl	main
		la	$a0, str0		# Print of str0
		li	$v0, 4			#
		syscall		
main: 
		la	$a0, str1		# Print of str1
		li	$v0, 4			#
		syscall				#

		li	$v0, 5			# Get the array size(n) and
		syscall				# and put it in $v0
		move	$s2, $v0
		
		beq $s2,0,invalid_size
		sll	$s0, $v0, 2		# $s0=n*4
		sub	$sp, $sp, $s0		# This instruction creates a stack
						# frame large enough to contain
						# the array
		la	$a0, str2		#
		li	$v0, 4			# Print of str2
		syscall				#

		move	$s1, $zero		# i=0
for_get:	bge	$s1, $s2, exit_get	# if i>=n go to exit_for_get
		sll	$t0, $s1, 2		# $t0=i*4
		add	$t1, $t0, $sp		# $t1=$sp+i*4
		li	$v0, 5			# Get one element of the array
		syscall				#
		sw	$v0, 0($t1)		# The element is stored
						# at the address $t1
		#la	$a0, str5
		#li	$v0, 4
		#syscall
		addi	$s1, $s1, 1		# i=i+1
		j	for_get
exit_get:	move	$a0, $sp		# $a0=base address af the array
		move	$a1, $s2		# $a1=size of the array
		jal	isort			# isort(a,n)
						# In this moment the array has been 
						# sorted and is in the stack frame 
		la	$a0, str3		# Print of str3
		li	$v0, 4
		syscall

		move	$s1, $zero		# i=0
for_print:	bge	$s1, $s2, exit_print	# if i>=n go to exit_print
		sll	$t0, $s1, 2		# $t0=i*4
		add	$t1, $sp, $t0		# $t1=address of a[i]
		lw	$a0, 0($t1)		#
		li	$v0, 1			# print of the element a[i]
		syscall				#

		la	$a0, spc
		li	$v0, 4
		syscall
		addi	$s1, $s1, 1		# i=i+1
		j	for_print
exit_print:	add	$sp, $sp, $s0		# elimination of the stack frame 
              
		j recall
		
		#li	$v0, 10			# EXIT
		#syscall			#
		
		
# selection_sort
isort:		addi	$sp, $sp, -20		# save values on stack
		sw	$ra, 0($sp)
		sw	$s0, 4($sp)
		sw	$s1, 8($sp)
		sw	$s2, 12($sp)
		sw	$s3, 16($sp)

		move 	$s0, $a0		# base address of the array
		move	$s1, $zero		# i=0

		subi	$s2, $a1, 1		# lenght -1
isort_for:	bge 	$s1, $s2, isort_exit	# if i >= length-1 -> exit loop
		
		move	$a0, $s0		# base address
		move	$a1, $s1		# i
		move	$a2, $s2		# length - 1
		
		jal	mini
		move	$s3, $v0		# return value of mini
		
		move	$a0, $s0		# array
		move	$a1, $s1		# i
		move	$a2, $s3		# mini
		
		jal	swap

		addi	$s1, $s1, 1		# i += 1
		j	isort_for		# go back to the beginning of the loop
		
isort_exit:	lw	$ra, 0($sp)		# restore values from stack
		lw	$s0, 4($sp)
		lw	$s1, 8($sp)
		lw	$s2, 12($sp)
		lw	$s3, 16($sp)
		addi	$sp, $sp, 20		# restore stack pointer
		jr	$ra			# return


# index_minimum routine
mini:		move	$t0, $a0		# base of the array
		move	$t1, $a1		# mini = first = i
		move	$t2, $a2		# last
		
		sll	$t3, $t1, 2		# first * 4
		add	$t3, $t3, $t0		# index = base array + first * 4		
		lw	$t4, 0($t3)		# min = v[first]
		
		addi	$t5, $t1, 1		# i = 0
mini_for:	bgt	$t5, $t2, mini_end	# go to min_end

		sll	$t6, $t5, 2		# i * 4
		add	$t6, $t6, $t0		# index = base array + i * 4		
		lw	$t7, 0($t6)		# v[index]

		bge	$t7, $t4, mini_if_exit	# skip the if when v[i] >= min
		
		move	$t1, $t5		# mini = i
		move	$t4, $t7		# min = v[i]

mini_if_exit:	addi	$t5, $t5, 1		# i += 1
		j	mini_for

mini_end:	move 	$v0, $t1		# return mini
		jr	$ra


# swap routine
swap:		sll	$t1, $a1, 2		# i * 4
		add	$t1, $a0, $t1		# v + i * 4
		
		sll	$t2, $a2, 2		# j * 4
		add	$t2, $a0, $t2		# v + j * 4

		lw	$t0, 0($t1)		# v[i]
		lw	$t3, 0($t2)		# v[j]

		sw	$t3, 0($t1)		# v[i] = v[j]
		sw	$t0, 0($t2)		# v[j] = $t0

		jr	$ra



.globl main03

main03:
start_input:
	la $a0,insertion
	li $v0,4
	syscall
	la $a0, input_msg       # Output message to input size of the list
	li $v0, 4		   # Setting $v0 to print the message
	syscall

	la $a0, input_data      # address of input_msg

	li $v0, 5               # system call for keyboard input, we get the size of the list
	syscall

 	addi $s0,$v0,0      #size of our list is at $s0
  	
  	ble $s0,0, invalid_size #We should check for the inputs which the user shouldn't be allowed to
  	
input_loop:
  	la $a0, input_msg_2      # Output message to input numbers
  	li $v0, 4		   # Setting $v0 to print the message
  	syscall

  	la $a0, input_data     # address of input_msg_2

  	li $v0, 5                # system call for keyboard input, we get the size of the list
  	syscall
  
  	sw $v0,0($sp)            #store the input integer to sp's address
  	addi $sp, $sp, -4        #move sp to one more byte down
  	addi $t7, $t7, 1         #increase loop counter i
  	blt $t7,$s0, input_loop  #if we still didn't complete the list, loop
  
  	sll $t1,$s0,2            #the amount of bytes we pushed sp
  	add $sp,$sp,$t1         #we move to the top of in the memory, to our first element
  
  	and $t7,$t7,$zero        #$t0 will be our loop counter i again, this time for the insertion sort
  	add $s1,$zero,$sp        #we make a copy of our current $sp
 

  
insertion_sort_loop_1:		 #this loop is doing insertion for each element beginning from index 1
  	addi $t7,$t7,1           #increment the loop counter by 1
  	beq $t7,$s0, print_sorted_list #when finished, print the outputlist
  	sll $t1,$t7,2            #we'll move to the current elements address
  	sub $sp,$s1,$t1          #we move the start $sp to the $t1'th element's address
  
insertion_sort_loop_2:			#this loop is doing insertion for each element in the outer loop "insertion_sort_loop_1"
  	lw $a0,0($sp)			#load the current element
  	lw $a1,4($sp)			#check the element right in front of that
  	blt $a0,$a1, switch_them	#if the later element is less than the previous one, switch them
  	j   insertion_sort_loop_1	#if the order is correct, move to next element in the outer loop
 

Exit03:   
   # Exit program
   li $v0, 10
   syscall
   
switch_them:				#switching two elements $a0 and $a1, $a1 was the previous one
	sw $a1,0($sp)
 	sw $a0,4($sp)
 	addi $sp,$sp,4
 	beq $s1,$sp, insertion_sort_loop_1	#if we've moved to the first element, we move directly to the outer loop
 	j  insertion_sort_loop_2		#if we didn't switch with the first element with index 0, we still have more checks to do
 

print_sorted_list:				#printing the sorted list
  	addi $a2,$zero,3			#arranging $a2 and $a3 so that we proceed afterwards to next step: removing duplicates
  
  	la $a0, input_msg_4       		# Output message to input size of the list
  	li $v0, 4		   		# Setting $v0 to print the message
  	syscall
 
print_list:
 	la $a0, input_msg_open_bracket       # Set the message to open the bracket
 	li $v0, 4		              # Setting $v0 to print the message
 	syscall
  
	addi $t2,$zero,0       		#loop counter for printing
	add $sp,$s1,$zero     		 #setting $sp back to the top of the list

output_loop:		#main loop which moves one by one on the list and prints that element
	lw $a0,0($sp)
	li $v0, 1
	syscall
	subi $sp,$sp, 4
	addi $t2,$t2,1
	la $a0, input_msg_space       # Output message is space to distinguish different elements
	li $v0, 4		      # Setting $v0 to print the message
	syscall

	blt $t2,$s0, output_loop      #if we still have elements remaining elements, we keep on printing
 
	la $a0, input_msg_close_bracket       # When the list is finished, set the message to close the bracket
	li $v0, 4		              # Setting $v0 to print the message
	syscall
	beq $a2,$a3,insertion_sort_loop_1     #this $a2, $a3 comparison resulting true means we do the search now
	#exit
	j recall
invalid_size:
  	la $a0, error_msg        # Output message to input numbers
  	li $v0, 4		   # Setting $v0 to print the message
  	syscall
	#exit
	j recall




.text
main04:
Main4:
	la $a0,merge
	li $v0,4
	syscall	
	la $a0, array2		# load address of array to $a0 as an argument
	addi $a1, $zero, 0 	# $a1 = low	
	addi $a2, $zero, 15 	# $a2 = high
	jal Mergesort		# Go to MergeSort 
	la  $a0, Sorted_Array	# Print prompt: "Sorted Array: ["
	li  $v0, 4		# MIPS call for printing prompts
	syscall     		
	jal Print		# Go to Print to print the sorted array
	la  $a0, Bracket	# Prints the closing bracket for the array
	li  $v0, 4		# MIPS call for printing prompts
	syscall
	
	
	#li  $v0, 10		# Done!
	#syscall
	j recall
Mergesort: 
	slt $t0, $a1, $a2 	# if low < high then $t0 = 1 else $t0 = 0  
	beq $t0, $zero, Return	# if $t0 = 0, go to Return
	
	addi, $sp, $sp, -16 	# Make space on stack for 4 items
	sw, $ra, 12($sp)	# save return address
	sw, $a1, 8($sp)	       	# save value of low in $a1
	sw, $a2, 4($sp)        	# save value of high in $a2

	add $s0, $a1, $a2	# mid = low + high
	sra $s0, $s0, 1		# mid = (low + high) / 2
	sw $s0, 0($sp) 		# save value of mid in $s0
				
	add $a2, $s0, $zero 	# make high = mid to sort the first half of array
	jal Mergesort		# recursive call to MergeSort
	
	lw $s0, 0($sp)		# load value of mid that's saved in stack 
	addi $s1, $s0, 1	# store value of mid + 1 in $s1
	add $a1, $s1, $zero 	# make low = mid + 1 to sort the second half of array
	lw $a2, 4($sp) 		# load value of high that's saved in stack
	jal Mergesort 		# recursive call to MergeSort
	
	lw, $a1, 8($sp) 	# load value of low that's saved in stack
	lw, $a2, 4($sp)  	# load value of high that's saved in stack
	lw, $a3, 0($sp) 	# load value of mid that's saved in stack and pass it to $a3 as an argument for Merge
	jal Merge		# Go to Merge 	
				
	lw $ra, 12($sp)		# restore $ra from the stack
	addi $sp, $sp, 16 	# restore stack pointer
	jr  $ra

Return:
	jr $ra 			# return to calling routine
	
Merge:
	add  $s0, $a1, $zero 	# $s0 = i; i = low
	add  $s1, $a1, $zero 	# $s1 = k; k = low
	addi $s2, $a3, 1  	# $s2 = j; j = mid + 1

While1: 
	blt  $a3,  $s0, While2	# if mid < i then go to next While loop
	blt  $a2,  $s2, While2	# if high < j then go to next While loop
	j  If			# if i <= mid && j <=high
	
If:
	sll  $t0, $s0, 2	# $t0 = i*4
	add  $t0, $t0, $a0	# add offset to the address of a[0]; now $t2 = address of a[i]
	lw   $t1, 0($t0)	# load the value at a[i] into $t1
	sll  $t2, $s2, 2	# $t1 = j*4
	add  $t2, $t2, $a0	# add offset to the address of a[0]; now $t2 = address of a[j]
	lw   $t3, 0($t2)	# load the value of a[j] into $t3	
	blt  $t3, $t1, Else	# if a[j] < a[i], go to Else
	la   $t4, c		# Get start address of c
	sll  $t5, $s1, 2	# k*4
	add  $t4, $t4, $t5	# $t4 = c[k]; $t4 is address of c[k]
	sw   $t1, 0($t4)	# c[k] = a[i]
	addi $s1, $s1, 1	# k++
	addi $s0, $s0, 1	# i++
	j    While1		# Go to next iteration
	
Else:
	sll  $t2, $s2, 2	# $t1 = j*4
	add  $t2, $t2, $a0	# add offset to the address of a[0]; now $t2 = address of a[j]
	lw   $t3, 0($t2)	# $t3 = whatever is in a[j]	
	la   $t4, c		# Get start address of c
	sll  $t5, $s1, 2	# k*4
	add  $t4, $t4, $t5	# $t4 = c[k]; $t4 is address of c[k]
	sw   $t3, 0($t4)	# c[k] = a[j]
	addi $s1, $s1, 1	# k++
	addi $s2, $s2, 1	# j++
	j    While1		# Go to next iteration
	
While2:
	blt  $a3, $s0, While3 	# if mid < i
	sll $t0, $s0, 2		# # $t6 = i*4
	add $t0, $a0, $t0	# add offset to the address of a[0]; now $t6 = address of a[i]
	lw $t1, 0($t0)		# load value of a[i] into $t7
	la  $t2, c		# Get start address of c
	sll $t3, $s1, 2         # k*4
	add $t3, $t3, $t2	# $t5 = c[k]; $t4 is address of c[k]
	sw $t1, 0($t3) 		# saving $t7 (value of a[i]) into address of $t5, which is c[k]
	addi $s1, $s1, 1   	# k++
	addi $s0, $s0, 1   	# i++
	j While2		# Go to next iteration
	

While3:
	blt  $a2,  $s1, For_Initializer	#if high < j then go to For loop
	sll $t2, $s2, 2    	# $t6 = j*4
	add $t2, $t2, $a0  	# add offset to the address of a[0]; now $t6 = address of a[j]
	lw $t3, 0($t2)     	# $t7 = value in a[j]
	
	la  $t4, c		# Get start address of c
	sll $t5, $s1, 2	   	# k*4
	add $t4, $t4, $t5  	# $t5 = c[k]; $t4 is address of c[k]
	sw $t3, 0($t4)     	# $t4 = c[k]; $t4 is address of c[k]
	addi $s1, $s1, 1   	# k++
	addi $s2, $s2, 1   	# j++
	j While3		# Go to next iteration

For_Initializer:
	add  $t0, $a1, $zero	# initialize $s5 to low for For loop
	addi $t1, $a2, 1 	# initialize $t3 to high+1 for For loop
	la   $t4, c		# load the address of array c into $s7	
	j    For
For:
	slt $t7, $t0, $t1  	# $t4 = 1 if $s5 < $s2
	beq $t7, $zero, sortEnd	# if $t4 = 0, go to sortEnd
	sll $t2, $t0, 2   	# $s5 * 4 to get the offset
	add $t3, $t2, $a0	# add the offset to the address of a => a[$t7]
	add $t5, $t2, $t4	# add the offset to the address of c => c[$t5]
	lw  $t6, 0($t5)		# loads value of c[i] into $t6
	sw $t6, 0($t3)   	# save the value at c[$t0] to a[$t0]; a[i] = c[i]
	addi $t0, $t0, 1 	# increment $t0 by 1 for the i++ part of For loop
	j For 			# Go to next iteration

sortEnd:
	jr $ra			# return to calling routine		
Print:
	add $t0, $a1, $zero 	# initialize $t0 to low
	add $t1, $a2, $zero	# initialize $t1 to high
	la  $t4, array2		# load the address of the array into $t4
	
Print_Loop:
	blt  $t1, $t0, Exit	# if $t1 < $t0, go to exit
	sll  $t3, $t0, 2	# $t0 * 4 to get the offset
	add  $t3, $t3, $t4	# add the offset to the address of array to get array[$t3]
	lw   $t2, 0($t3)	# load the value at array[$t0] to $t2
	move $a0, $t2		# move the value to $a0 for printing
	li   $v0, 1		# the MIPS call for printing the numbers
	syscall
	
	addi $t0, $t0, 1	# increment $t0 by 1 for the loop 
	la   $a0, Space		# prints a comma and space between the numbers
	li   $v0, 4		# MIPS call to print a prompt
	syscall
	j    Print_Loop		# Go to next iteration of the loop
	
Exit:
	jr $ra			# jump to the address in $ra; Go back to main
	




.text
.globl main05

main05:

# store the number of elements
	la 		$a0,quick
	li 		$v0,4
	syscall
	la		$t0, Array_size
	la		$t1, Array
	sub		$t2, $t0, $t1
	srl		$t2, $t2, 2
	sw		$t2, 0($t0)
	
# print "before : "
	li		$v0, 4
	la		$a0, msg_before
	syscall
# print Array
	jal		PRINT
	
# Call quick sort
	la		$a0, Array
	li		$a1, 0
	# a2 = Array_size - 1
	lw		$t0, Array_size
	addi	$t0, $t0, -1
	move	$a2, $t0
	# function call
	jal		QUICK
	
# print "after : "
	li		$v0, 4
	la		$a0, msg_after
	syscall
# print Array
	jal		PRINT

	
# end program
	#li		$v0, 10
	#syscall
	j 		recall

PRINT:
## print Array
	la		$s0, Array
	lw		$t0, Array_size
Loop_main1:
	beq		$t0, $zero, Loop_main1_done
	# make space
	li		$v0, 4
	la		$a0, msg_space
	syscall
	# printing Array elements
	li		$v0, 1
	lw		$a0, 0($s0)
	syscall
	
	addi	$t0, $t0, -1
	addi	$s0, $s0, 4
	
	j		Loop_main1
	
Loop_main1_done:
	# make new line
	li		$v0, 4
	la		$a0, msg_newL
	syscall
	jr		$ra

QUICK:
## quick sort

# store $s and $ra
	addi	$sp, $sp, -24	# Adjest sp
	sw		$s0, 0($sp)		# store s0
	sw		$s1, 4($sp)		# store s1
	sw		$s2, 8($sp)		# store s2
	sw		$a1, 12($sp)	# store a1
	sw		$a2, 16($sp)	# store a2
	sw		$ra, 20($sp)	# store ra

# set $s
	move	$s0, $a1		# l = left
	move	$s1, $a2		# r = right
	move	$s2, $a1		# p = left

# while (l < r)
Loop_quick1:
	bge		$s0, $s1, Loop_quick1_done
	
# while (arr[l] <= arr[p] && l < right)
Loop_quick1_1:
	li		$t7, 4			# t7 = 4
	# t0 = &arr[l]
	mult	$s0, $t7
	mflo	$t0				# t0 =  l * 4bit
	add		$t0, $t0, $a0	# t0 = &arr[l]
	lw		$t0, 0($t0)
	# t1 = &arr[p]
	mult	$s2, $t7
	mflo	$t1				# t1 =  p * 4bit
	add		$t1, $t1, $a0	# t1 = &arr[p]
	lw		$t1, 0($t1)
	# check arr[l] <= arr[p]
	bgt		$t0, $t1, Loop_quick1_1_done
	# check l < right
	bge		$s0, $a2, Loop_quick1_1_done
	# l++
	addi	$s0, $s0, 1
	j		Loop_quick1_1
	
Loop_quick1_1_done:

# while (arr[r] >= arr[p] && r > left)
Loop_quick1_2:
	li		$t7, 4			# t7 = 4
	# t0 = &arr[r]
	mult	$s1, $t7
	mflo	$t0				# t0 =  r * 4bit
	add		$t0, $t0, $a0	# t0 = &arr[r]
	lw		$t0, 0($t0)
	# t1 = &arr[p]
	mult	$s2, $t7
	mflo	$t1				# t1 =  p * 4bit
	add		$t1, $t1, $a0	# t1 = &arr[p]
	lw		$t1, 0($t1)
	# check arr[r] >= arr[p]
	blt		$t0, $t1, Loop_quick1_2_done
	# check r > left
	ble		$s1, $a1, Loop_quick1_2_done
	# r--
	addi	$s1, $s1, -1
	j		Loop_quick1_2
	
Loop_quick1_2_done:

# if (l >= r)
	blt		$s0, $s1, If_quick1_jump
# SWAP (arr[p], arr[r])
	li		$t7, 4			# t7 = 4
	# t0 = &arr[p]
	mult	$s2, $t7
	mflo	$t6				# t6 =  p * 4bit
	add		$t0, $t6, $a0	# t0 = &arr[p]
	# t1 = &arr[r]
	mult	$s1, $t7
	mflo	$t6				# t6 =  r * 4bit
	add		$t1, $t6, $a0	# t1 = &arr[r]
	# Swap
	lw		$t2, 0($t0)
	lw		$t3, 0($t1)
	sw		$t3, 0($t0)
	sw		$t2, 0($t1)
	
# quick(arr, left, r - 1)
	# set arguments
	move	$a2, $s1
	addi	$a2, $a2, -1	# a2 = r - 1
	jal		QUICK
	# pop stack
	lw		$a1, 12($sp)	# load a1
	lw		$a2, 16($sp)	# load a2
	lw		$ra, 20($sp)	# load ra
	
# quick(arr, r + 1, right)
	# set arguments
	move	$a1, $s1
	addi	$a1, $a1, 1		# a1 = r + 1
	jal		QUICK
	# pop stack
	lw		$a1, 12($sp)	# load a1
	lw		$a2, 16($sp)	# load a2
	lw		$ra, 20($sp)	# load ra
	
# return
	lw		$s0, 0($sp)		# load s0
	lw		$s1, 4($sp)		# load s1
	lw		$s2, 8($sp)		# load s2
	addi	$sp, $sp, 24	# Adjest sp
	jr		$ra

If_quick1_jump:

# SWAP (arr[l], arr[r])
	li		$t7, 4			# t7 = 4
	# t0 = &arr[l]
	mult	$s0, $t7
	mflo	$t6				# t6 =  l * 4bit
	add		$t0, $t6, $a0	# t0 = &arr[l]
	# t1 = &arr[r]
	mult	$s1, $t7
	mflo	$t6				# t6 =  r * 4bit
	add		$t1, $t6, $a0	# t1 = &arr[r]
	# Swap
	lw		$t2, 0($t0)
	lw		$t3, 0($t1)
	sw		$t3, 0($t0)
	sw		$t2, 0($t1)
	
	j		Loop_quick1
	
Loop_quick1_done:
	
# return

	lw		$s0, 0($sp)		# load s0
	lw		$s1, 4($sp)		# load s1
	lw		$s2, 8($sp)		# load s2
	addi	$sp, $sp, 24	# Adjest sp
	jr		$ra


la $a0,ok
li $v0,4
syscall
li $v0,10
syscall

errorcall:
la $a0,error
li $v0,4
syscall
li $v0,10
syscall
exitcall:
la $a0,exit
li $v0,4
syscall
li $v0,10
syscall
