.text

.globl base_converter

base_converter:

    move $t0, $a0
    move $t1, $a2

    move $a0, $a1
    li $v0, 84
    syscall
    move $t1, $a1

    move $a0, $t1
    li $v0, 84
    syscall
    move $t2, $a2

    move $a0, $t0

    # $a0 number in a base
    # $a1 base we are converting from
    # $a2 base we are converting to
    move $a0, $t0
    move $a1, $t1
    move $a2, $t2


    addiu $sp, $sp, -4
    sw $ra, 0($sp)
    jal to_decimal
    lw $ra, 0($sp)
    addiu $sp, $sp, 4

    move $a0, $v0
    li $v0, 34
    syscall


    li $v0, 10
    syscall


    addiu $sp, $sp, -4
    sw $ra, 0($sp)
    jal to_base
    lw $ra, 0($sp)
    addiu $sp, $sp, 4


    return_bc:


    #print value

    jr $ra
    #32 bit remainder in HI
    #32 bit remainder in LOW


    # $a0 number in a base
    # $a1 base we are converting from
    # $a2 base we are converting to
    to_decimal:
    #mult, add inc power
    li $t0, 0 #iterator
    li $t1, 1 #power
    li $t3, 0 #sum
    loop_td_bc:
    beqz $a0, finished_td_bc
    andi $t2, $a0 0x00000001

    mul $t3, $t3, $t1

    mul $t1, $t1, $a1
    srl $a0, $a0, 1
    addiu $t0, $t0, 1
    b loop_td_bc
    finished_td_bc:

    move $v0, $t3

    jr $ra

    to_base:
    #add shift, add shift
    li $t0, 0 #iterator
    loop_low_bc:

    addiu $t0, $t0, 1
    b loop_low_bc

    jr $ra
