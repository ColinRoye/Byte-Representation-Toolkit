.text

.globl base_converter

base_converter:
    # $a0 number in a base
    # $a1 base we are converting from
    # $a2 base we are converting to
    # $t5 number in a base
    # $t6 base we are converting from
    # $t7 base we are converting to


###save to base

    addiu $sp, $sp, -12
    sw $ra, 0($sp)
    sw $a2, 4($sp)
    sw $a1, 8($sp)

    jal to_decimal
    lw $ra, 0($sp)
    lw $a1, 4($sp) #move the to base to the second arg in the next func
    sw $a2, 8($sp) #swaped
    addiu $sp, $sp, 12





    move $a0, $v0


    addiu $sp, $sp, -4
    sw $ra, 0($sp)
    jal dec_to_base
    lw $ra, 0($sp)
    addiu $sp, $sp, 4
    jr $ra


    return_bc:


    #print value


    dec_to_base:
    li $t1, 0
    li $t5, 0
    beqz $a0, print_zero_dtb

    move $t3, $a0

    loop_dtb_bc:
    beqz $t3 continue_dtb

    #sll $t1, $t1, 4
    #format output for part 4
    div $t3, $a2
    mflo $t3
    mfhi $t0


    addiu $sp, $sp -1
    sb $t0, 0($sp)

    addiu $t5, $t5, 1
    addu $t1, $t1, $t0



    b loop_dtb_bc
    continue_dtb:

    li $v0, 1
    print_loop_dtb:
    beqz $t5, finish__dtb

    lbu $a0, 0($sp)
    addiu $sp, $sp 1


    syscall
    beqz $t5, finish__dtb

    addiu $t5, $t5, -1
    b print_loop_dtb
    finish__dtb:
    jr $ra

    print_zero_dtb:
    li $v0, 1
    li $a0, 0
    syscall
    jr $ra


    to_decimal:
    # $t5 number in a base
    # $t6 base we are converting from
    # $t7 base we are converting to
    move $t5, $a0
    move $t6, $a1
    move $t7, $a2

    #mult, add inc power
    li $t0, 0 #iterator
    li $t1, 1 #power
    li $t3, 0 #sum
    loop_td_bc:
    lbu $t4, 0($t5)
    beqz $t4, finished_td_bc

    move $a0, $t4

    addiu $sp, $sp, -24
    sw $t0, 0($sp)
    sw $t1, 4($sp)
    sw $t2, 8($sp)
    sw $t3, 12($sp)
    sw $t4, 16($sp)
    sw $ra, 20($sp)
    jal charToHex
    lw $t0, 0($sp)
    lw $t1, 4($sp)
    lw $t2, 8($sp)
    lw $t3, 12($sp)
    lw $t4, 16($sp)
    lw $ra, 20($sp)
    addiu $sp, $sp, 24

    bge $v0, $a1, invalid_args_error_call


    beqz $t0, skip_mult_bc_tn
    mul $t3, $t3, $t6
    skip_mult_bc_tn:

    addu $t3, $t3, $v0


    addiu $t5, $t5, 1
    addiu $t0, $t0, 1
    b loop_td_bc
    finished_td_bc:

    move $v0, $t3

    jr $ra


.include "./charToHex.asm"
