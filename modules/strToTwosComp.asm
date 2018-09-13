.text
.globl strToTwosComp

strToTwosComp:

    move $t1, $a0
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

      move $v0, $t3

      jr $ra
