# Colin Roye
# croye
# 110378271

.data
# Command-line arguments
num_args: .word 0
addr_arg0: .word 0
addr_arg1: .word 0
addr_arg2: .word 0
addr_arg3: .word 0
no_args: .asciiz "You must provide at least one command-line argument.\n"

# Error messages
invalid_operation_error: .asciiz "INVALID_OPERATION\n"
invalid_args_error: .asciiz "INVALID_ARGS\n"

# Output strings
zero_str: .asciiz "Zero\n"
neg_infinity_str: .asciiz "-Inf\n"
pos_infinity_str: .asciiz "+Inf\n"
NaN_str: .asciiz "NaN\n"
floating_point_str: .asciiz "_2*2^"

# Miscellaneous strings
nl: .asciiz "\n"

# Put your additional .data declarations here, if any.


# Main program starts here
.text
.globl main
main:
    # Do not modify any of the code before the label named "start_coding_here"
    # Begin: save command-line arguments to main memory
    sw $a0, num_args
    beq $a0, 0, zero_args
    beq $a0, 1, one_arg
    beq $a0, 2, two_args
    beq $a0, 3, three_args
four_args:
    lw $t0, 12($a1)
    sw $t0, addr_arg3
three_args:
    lw $t0, 8($a1)
    sw $t0, addr_arg2
two_args:
    lw $t0, 4($a1)
    sw $t0, addr_arg1
one_arg:
    lw $t0, 0($a1)
    sw $t0, addr_arg0
    j start_coding_here
zero_args:
    la $a0, no_args
    li $v0, 4
    syscall
    j exit
    # End: save command-line arguments to main memory

start_coding_here:

part_1:
  a:

    lw $t1, addr_arg0
    lbu $t2,  1($t1)# null terminator
    lbu $t1,  0($t1)# arg

    li $t0, 0
    bne $t2, $t0, invalid_operation_error_call

    li $t0, 0x32
    beq $t1, $t0, b
    li $t0, 0x46
    beq $t1, $t0, b
    li $t0, 0x43
    beq $t1, $t0, b

    b invalid_operation_error_call

  b:

    lw $t0, addr_arg0
    lbu $t0,  0($t0)# arg

    li $t1, 0x32
    beq $t1, $t0, check_num
    li $t1, 0x46
    beq $t1, $t0, check_num

    b c

    check_num:
    lw $t1, num_args
    #lbu $t1,  0($t1)

    li $t2, 2

    beq $t1, $t2, c
    b invalid_args_error_call

  c:

    lw $t0, addr_arg0
    lbu $t0,  0($t0)# arg

    li $t1, 0x43

    bne $t1, $t0, part_2

    lw $t1, num_args
    #lbu $t1,  0($t1)

    li $t2, 4

    beq $t1, $t2, part_2
    b invalid_args_error_call


  part_2:

    lw $t0, addr_arg0
    lbu $t0,  0($t0)# arg
    li $t1, 0x32
    bne $t0, $t1, part_3

    lw $t1, addr_arg1 # string 1's and 0's


    li $t2, 0 #iterator
    li $t3, 0 #sum
    li $t4, 1 #2^n
    li $t5, 2 #const
    loop_p2:
      #t6 is current char
      addu $t6, $t2, $t1
      lbu $t6, 0($t6)

      li $t7, 0
      beq $t6, $t7, loop_end

      li $t7, 32
      bge $t2, $t7, invalid_args_error_call
      #30 = 0
      #31 = 1
      li $t9, 0 #is valid char flag
      li $t0, 0x30
      beq $t6, $t0, is_0
      li $t0, 0x31
      beq $t6, $t0, is_1
      b continue
      is_0:
        li $t9, 1 #is valid char flag
        li $t0, 0
      b continue
      is_1:
        li $t9, 1 #is valid char flag
        li $t0, 1
      continue:
      beqz $t9, invalid_args_error_call




      bgtz $t2, skip_p2
      move $t8, $t0
      skip_p2:

      #is neg?
      li $t9, 0
      beq $t8, $t9, flip_over

      #flip bits
      beqz $t0, is_fliped_1

      is_fliped_0:
      li $t0, 0
      b flip_over
      is_fliped_1:
      li $t0, 1
      flip_over:

      #mul sum by 2
      sll $t3, $t3, 1
      #add current
      addu $t3, $t3, $t0

      addiu $t2, $t2, 1 #add to iterator
      b loop_p2

    loop_end:


      li $t0, 0
      beq $t8, $t0, neg_over
      li $t2, -1
      mul $t3, $t3, $t2
      addi $t3, $t3, -1
      neg_over:


      li $v0, 1
      move  $a0, $t3
      syscall



  part_3:

    lw $t0, addr_arg0
    lbu $t0,  0($t0)# arg
    li $t1, 0x46
    bne $t0, $t1, part_4

    lw $t1, addr_arg1


  part_4:

    lw $t0, addr_arg0
    lbu $t0,  0($t0)# arg
    li $t1, 0x43
    bne $t0, $t1, exit

    lw $t1, addr_arg1
    lw $t2, addr_arg2
    lw $t3, addr_arg3




exit:
    li $v0, 10   # terminate program
    syscall

invalid_args_error_call:
    li $v0, 4
    la $a0, invalid_args_error
    syscall
    li $v0, 10
    syscall

invalid_operation_error_call:
    li $v0, 4
    la $a0, invalid_operation_error
    syscall
    li $v0, 10
    syscall
