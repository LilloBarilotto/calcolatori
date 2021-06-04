    .data
year: .word 1945, 2008, 1800, 2006, 1748, 1600
result: .space 6
length: .byte 6

    .text
    .globl main
    .ent main

main:
    la  $a0, year
    la  $a1, result
    la  $t0, length
    lb  $a2, 0($t0)

    jal bisestile 

    li $v0, 10
    syscall

    .end main


    .ent bisestile
bisestile:

    li  $t0, 0
    li  $t8, 100
    li  $t7, 4
    li  $t9, 400

while:
    beq $t0, $a2, end

    lw  $t1, 0($a0)

    # if anno divisibile per 100
    div $t1, $t8
    mfhi $t2

    bne $t2, $0, else_maybe_4

    div $t1, $t9
    mfhi $t2

    bne $t2, $0, non_bisestile
    j is_bisestile


else_maybe_4:
    div $t1, $t7
    mfhi $t2

    bne $t2, $0, non_bisestile
    j is_bisestile



non_bisestile:
    li  $t3, 0
    j fine_if_else
is_bisestile:
    li  $t3, 1

fine_if_else:


    # uso questo solo per fare il print del risultato per sicurezza...
    move $t4, $a0
    move $a0, $t3
    li  $v0, 1
    syscall
    move $a0, $t4
    # fine mio controllo non inerente all'esercizio


    sb  $t3, 0($a1)
    add $a1, $a1, 1
    add $a0, $a0, 4
    add $t0, $t0, 1
    j while

end:
    jr $ra
    .end bisestile