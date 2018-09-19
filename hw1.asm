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

    lw $a0, addr_arg1 # string 1's and 0's
    jal strToTwosComp

      move $a0, $v0
      li $v0, 1
      syscall

  part_3:

    lw $t0, addr_arg0
    lbu $t0,  0($t0)# arg
    li $t1, 0x46
    bne $t0, $t1, part_4

    lw $a0, addr_arg1

    jal strToHex

    move $a0, $v0
    jal IEEE_sp_str

  part_4:

    lw $t0, addr_arg0
    lbu $t0,  0($t0)# arg
    li $t1, 0x43
    bne $t0, $t1, exit

    lw $a0, addr_arg1
    lw $a1, addr_arg2
    lw $a2, addr_arg3

    move $t0, $a0
    move $t2, $a2

    move $a0, $a1
    li $v0, 84
    syscall
    move $t1, $v0

    move $a0, $t2
    li $v0, 84
    syscall
    move $t2, $v0


    # $a0 number in a base
    # $a1 base we are converting from
    # $a2 base we are converting to
    move $a0, $t0
    move $a1, $t1
    move $a2, $t2


    jal base_converter


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

                      li $t0, 0x7FFFFFFF
                      bgt $v0, $t0, invalid_args_error_call




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


                        charToHex:
                        li $t4, 0x46
                        bgt $a0, $t4, invalid_args_error_call

                        li $t4, 0x30
                        blt $a0, $t4, invalid_args_error_call

                        li $t4, 0x39
                        bgt $a0, $t4 a_to_f_cth

                        zero_to_nine_cth:
                        addiu $a0, $a0, -0x30

                        b continue_strToHex_cth

                        a_to_f_cth:
                        li $t4 0x41
                        blt $a0, $t4, invalid_args_error_call

                        addiu $a0, $a0, -0x37

                        continue_strToHex_cth:
                        move $v0, $a0

                        jr $ra
