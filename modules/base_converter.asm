84.text

.globl base_converter

base_converter:

    li $v0, 84
    syscall
    move $t0, $a0

    move $a0, $a1
    li $v0, 84
    syscall
    move $t1, $a1

    move $a0, $a2
    li $v0, 84
    syscall
    move $t2, $a2

    # $a0 number in a base
    # $a1 base we are converting from
    # $a2 base we are converting to
    move $a0, $t0
    move $a1, $t1
    move $a2, $t2
    
    bgt $t1, $t2, lower_cvt

    addiu $sp, $sp, -4
    sw $ra, 0($sp)









    return_bc:

    #print value

    jr $ra
    #32 bit remainder in HI
    #32 bit remainder in LOW

    base_converter_to_higher_base:
    #mult, add inc power
    jr $ra

    base_converter_to_lower_base:
    #add shift, add shift
    jr $ra
