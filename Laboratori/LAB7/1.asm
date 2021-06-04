    .data
N= 5
    .text
    .globl main
    .ent main

main:
    li $v0, 5
    syscall
    move $t0, $v0

    li $v0, 5
    syscall
    move $t1, $v0

    li $v0, 5
    syscall
    move $t2, $v0

    li $v0, 5
    syscall
    move $t3, $v0


    li $s0, 8
    li $s1, 4
    li $s2, 27
    li $s3, 9
    li $s4, 64
    li $s5, 16

    # a0
    li $a0, $t0
    add $a0, $a0, $t1
    add $a0, $a0, $t2
    add $a0, $a0, $t3

    # a1
    mult $t0, $s0
    mflo $a1
    mult $t1, $s1
    mflo $t9
    add $a1, $a1, $t9
    mult $t1, 2
    mflo $t9
    add $a1, $a1, $t9
    add $a1, $a1, $t3

    # a2
    mult $t0, $s2
    mflo $a2
    mult $t1, $s3
    mflo $t9
    add $a2, $a2, $t9
    mult $t2, 3
    mflo $t9
    add $a1, $a1, $t9
    add $a1, $a1, $t3

    # a3
    mult $t0, $s4
    mflo $a3
    mult $t1, $s5
    mflo $t9
    add $a3, $a3, $t9
    mult $t2, 4
    mflo $t9
    add $a1, $a1, $t9
    add $a1, $a1, $t3

    #  pushhh N
    li $t9, N

    add $sp , $sp, -16
    sw  $t0,  12($sp)
    sw  $t1,  8($sp)
    sw  $t2,  4($sp)
    sw  $t3,  0($sp)


    add $sp, $sp, -4
    sw  $t9, 0($sp)

    # ----------- call function
    jal polinomio


    #   pooop N (but only to restore my $sp)
    #   lw $t9, 0($sp)
    add $sp, $sp, 4

    lw  $t3,  0($sp)
    lw  $t2,  4($sp)
    lw  $t1,  8($sp)
    lw  $t0,  12($sp)
    add $sp, $sp, 16

    li $v0, 10
    syscall
    .end main


    .ent polinomio
polinomio:
    # take N (but not change the $sp because the pop was done by caller)
    # and do N= N-3
    lw  $t3, 0($sp)
    add $t3, $t3, -4

    sub $t0, $a1, $a0
    sub $t1, $a2, $a1
    sub $t2, $a3, $a2 

    # PUSH of $s0-$s2
    add $sp, $sp, -12
    sw  $s0, $sp, 8($sp)
    sw  $s1, $sp, 4($sp)
    sw  $s2, $sp, 0($sp)

    sub $s0, $t1, $t0
    sub $s1, $t2, $t1
    sub $s2, $s1, $s0

    move $v0, $a3

do_:beq $t3, $0, end

    add $s1, $s1, $s2
    add $t2, $t2, $s1
    add $v0, $v0, $t2

    add $t3, $t3, -1
    j do_

end:
    # POP of $s0-$s2 of caller
    lw  $s2, $sp, 0($sp)
    lw  $s1, $sp, 4($sp)
    lw  $s0, $sp, 8($sp)
    add $sp, $sp, 12

    jr $ra

    .end polinomio