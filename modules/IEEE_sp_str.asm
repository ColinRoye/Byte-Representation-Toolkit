.text

.globl IEEE_sp_str

IEEE_sp_str:
    # zero
    li $t0, 0x00000000
    beq $t0, $a0, zero
    li $t0, 0x80000000
    beq $t0, $a0, zero


    # -Inf
    li $t0, 0xFF800000
    beq $t0, $a0, neg_Inf

    # +Inf
    li $t0 0x7F800000
    beq $t0, $a0, pos_Inf

    #NaN

    li $t1 0x7FFFFFFF
    bgt $a0, $t1, skip_iss
    li $t1 0x7F800001
    blt $a0, $t1, skip_iss

    b NaN_
    skip_iss:




    li $t1 0xFFFFFFFF
    bgt $a0, $t1, skip_iss_2
    li $t1 0xFF800001
    blt $a0, $t1, skip_iss_2

    b NaN_
    skip_iss_2:

    move $t9, $a0

    li $t0, 0
    #sign
    andi $t1, $a0, 0x80000000

    beqz $t1, positive_over
      li $a0, 0x2D #is negative
      li $v0, 11
      syscall
    positive_over:

    li $a0, 1 #1
    li $v0, 1
    syscall

    li $a0, 0x2E #.
    li $v0, 11
    syscall

    move $t3, $t9
    li $t0, 0 #iterator
    li $t1, 23
    sll $t3, $t3, 9

    loop_frac_IEEE_sp_str:
    bge $t0, $t1 loop_frac_IEEE_sp_str_over
    andi $t4, $t3, 0x80000000

    beqz $t4, print_zero
    print_one:
    li $a0, 0x31
    b print_over
    print_zero:
    li $a0, 0x30
    print_over:

    li $v0, 11
    syscall

    sll $t3, $t3, 1
    addiu $t0, $t0, 1
    b loop_frac_IEEE_sp_str

    loop_frac_IEEE_sp_str_over:

    addiu $sp, $sp, -8
    sw $t9, 0($sp)
    sw $ra, 4($sp)
    jal floating_point_str_call
    lw $ra, 4($sp)
    lw $t9, 0($sp)
    addiu $sp, $sp, 8

    sll $t9, $t9, 1
    srl $t9, $t9, 24
    addiu $t9, $t9, -0x7F
    move $a0, $t9
    li $v0, 1
    syscall

    jr $ra

    zero:
      li $v0, 4
      la $a0, zero_str
      syscall
      jr $ra

    neg_Inf:
      li $v0, 4
      la $a0, neg_infinity_str
      syscall
      jr $ra
    pos_Inf:
      li $v0, 4
      la $a0, pos_infinity_str
      syscall
      jr $ra
    NaN_:
      li $v0, 4
      la $a0, NaN_str
      syscall
      jr $ra

    floating_point_str_call:
        li $v0, 4
        la $a0, floating_point_str
        syscall

        jr $ra



    #
    #
    # srl $t1, $a0, 23
    # andi $t1, $t1, 0xFF
    #
    #
    # li $v0, 11
    # syscall
