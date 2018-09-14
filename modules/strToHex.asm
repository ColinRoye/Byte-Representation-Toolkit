.text

.globl strToHex

strToHex:
    li $t0, 0 #iterator
    li $t1, 0 #sum
    li $t2, 16
    loop_strToHex:

      li $t5, 8
      bge $t0, $t5, return_strToHex
      sll $t1, $t1, 4


      addu $t3, $a0, $t0
      lbu $t3, 0($t3)

      li $t4, 0x46
      bgt $t3, $t4, invalid_args_error_call

      li $t4, 0x30
      blt $t3, $t4, invalid_args_error_call

      li $t4, 0x39
      bgt $t3, $t4 a_to_f

      zero_to_nine:
      addiu $t3, $t3, -0x30

      b continue_strToHex

      a_to_f:
      li $t4 0x41
      blt $t3, $t4, invalid_args_error_call

      addiu $t3, $t3, -0x37

      continue_strToHex:

      addu $t1, $t1, $t3
      addiu $t0, $t0, 1
      b loop_strToHex

      return_strToHex:

            addu $t3, $a0, $t0
            addiu $t3, $t3, -1
            lbu $t3, 1($t3)
            beqz $t3, skip_sth
            b invalid_args_error_call
            skip_sth:


      move $v0, $t1

    jr $ra
