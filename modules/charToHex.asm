.text
.globl charToHex

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
