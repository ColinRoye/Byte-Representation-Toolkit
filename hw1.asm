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
    bne $t2, $t0, args_err

    li $t0, 0x32
    beq $t1, $t0, b
    li $t0, 0x46
    beq $t1, $t0, b
    li $t0, 0x43
    beq $t1, $t0, b

    args_err:
    li $v0, 4
    la $a0, invalid_operation_error
    syscall
    li $v0, 10
    syscall

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

    li $v0, 4
    la $a0, invalid_args_error
    syscall
    li $v0, 10
    syscall

  c:

    lw $t0, addr_arg0
    lbu $t0,  0($t0)# arg

    li $t1, 0x43

    bne $t1, $t0, part_2

    lw $t1, num_args
    #lbu $t1,  0($t1)

    li $t2, 4

    beq $t1, $t2, part_2

    li $v0, 4
    la $a0, invalid_args_error
    syscall
    li $v0, 10
    syscall

  part_2:
































exit:
    li $v0, 10   # terminate program
    syscall
