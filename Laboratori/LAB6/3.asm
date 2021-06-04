    .data
parola: .asciiz "cIaO"
    .text
    .globl main


    .ent main
main:
    la $s1, parola

    loop:
    lb $a0, ($s1)
    beq $a0, 0, end

    jal converter
    sb $v0, ($s1)  

    add $s1, $s1, 1
    j loop

    end:  

    la $a0, parola
    li $v0, 4
    syscall

    li $v0, 10
    syscall
    .end main

    .ent converter
converter:
    li $t0, 'a'
    li $t1, 'z'

    blt $a0, $t0, mover
    bgt $a0, $t1, mover

    add $a0, $a0, -32
    
    mover:
    move $v0, $a0

    jr $ra
    .end converter