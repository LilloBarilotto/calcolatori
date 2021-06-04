     .data
matrix: .word 1, 2
        .word 3, 4
    .text
    .globl main
    .ent main

main:
    la  $s0, matrix
    lw  $a0, 0($s0)
    lw  $a1, 4($s0)
    lw  $a2, 8($s0)
    lw  $a3, 12($s0)
    
    add $sp, $sp, -4
    sw  $ra, ($sp)

    jal determinante2x2

    move $a0, $v0
    li $v0, 10
    syscall

    lw $ra, ($sp)
    add $sp, $sp, 4

    jr $ra

    .end main
 
#   ------------------------------------------------------

    .ent determinante2x2
determinante2x2: 

    mult $a0, $a3
    mflo $v0

    mult $a1, $a2
    mflo $t0

    sub $v0, $v0, $t0
    
    jr $ra 
    .end determinante2x2