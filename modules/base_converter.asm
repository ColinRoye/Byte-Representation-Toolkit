84.text

.globl base_converter

base_converter:

    li $v0, 84
    syscall
    move $t0, $a0

    
    li $v0, 84
    syscall
    move $t1, $a1


    li $v0, 84
    syscall
    move $t2, $a2


    div $v0, $v0, $a1

    #32 bit remainder in HI
    #32 bit remainder in LOW
