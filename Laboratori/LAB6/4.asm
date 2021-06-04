    .data
vettore: .word 4, 1 , 33 , 15, 1, 7 
DIM= 6

    .text
    .globl main

    .ent main
main:
    la $a0, vettore
    li $a1, DIM
    jal massimo

    move $a0, $v0
    li $v0, 1
    syscall

    li $v0, 10
    syscall
    .end main

    .ent massimo
massimo:
    lw $v0, ($a0)
    li $t0, 1

    loop1:
    add $a0, $a0, 4
    lw $t1, ($a0)

    ble $t1, $v0, skip
    move $v0, $t1
    skip:

    add $t0, $t0, 1
    bne $t0, $a1, loop1

    jr $ra
    .end massimo