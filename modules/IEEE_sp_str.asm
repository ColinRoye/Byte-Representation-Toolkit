.text

.globl IEEE_sp_str

IEEE_sp_str:
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

    sll $t9, $t9, 1
    srl $t9, $t9, 24
    addiu $t9, $t9, -0x7F
    move $a0, $t9
    li $v0, 1
    syscall




    #
    #
    # srl $t1, $a0, 23
    # andi $t1, $t1, 0xFF
    #
    #
    # li $v0, 11
    # syscall
jr $ra
