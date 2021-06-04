     .data
matrix: .word 1, 0, 5
        .word 2, -1, 0
        .word 7, -2, 0 
    .text
    .globl main
    .ent main

main:
    la  $s0, matrix
    lw  $a0, 0($s0)     # a1
    lw  $a1, 4($s0)     # b1
    lw  $a2, 8($s0)     # c1
    lw  $a3, 12($s0)    # a2
  
    lw  $t0, 16($s0)
    lw  $t1, 20($s0)
    lw  $t2, 24($s0)
    lw  $t3, 28($s0)
    lw  $t4, 32($s0)        

    add $sp, $sp, -4
    sw  $ra, ($sp)

    add $sp, $sp, -20
    sw  $t0, 0($sp)     # b2
    sw  $t1, 4($sp)     # c2
    sw  $t2, 8($sp)     # a3
    sw  $t3, 12($sp)    # b3
    sw  $t4, 16($sp)    # c3

    jal determinante3x3
    add $sp, $sp, 20

    move $a0, $v0
    li $v0, 1
    syscall

    lw $ra, ($sp)
    add $sp, $sp, 4

    jr $ra

    .end main
 #   ------------------------------------------------------

    .ent determinante3x3
determinante3x3:

    move $t0, $sp   # save temp $sp pt.1
    # PUSH $s0-$s5 in stack (if the main doesn't use them...
    # .. it's not important for me, i'm caller, this is my job if I wanna use them <3 )
    add $sp, $sp, -24
    sw  $s0, 0($sp)     # result det3x3
    sw  $s1, 4($sp)     # $a0 (a1)
    sw  $s2, 8($sp)     # $a1 (b1)
    sw  $s3, 12($sp)    # $a2 (c1)
    sw  $s4, 16($sp)    # $a3 (a2)
    sw  $s5, 20($sp)    # here i'm going to save the last $sp to take argument from caller

    # store result, last $sp and other a0-3
    move $s0, $0
    add $s5, $sp, 24

    move $s1, $a0
    move $s2, $a1
    move $s3, $a2
    move $s4, $a3

    # do 3x3 Without cycle
    # save $ra because i'm calling determinante2x2
    add $sp, $sp, -4
    sw  $ra, 0($sp)

    # first det2x2
    lw $a0, 0($s5)
    lw $a1, 4($s5)
    lw $a2, 12($s5)
    lw $a3, 16($s5)

    jal determinante2x2

    mult $v0, $s1
    mflo $s0

    # second det2x2
    move $a0, $s4
    lw  $a1, 4($s5)
    lw  $a2, 8($s5)
    lw  $a3, 16($s5)

    jal determinante2x2

    mult $v0, $s2
    mflo $t0
    sub $s0, $s0, $t0

    # third det2x2
    move $a0, $s4
    lw  $a1, 0($s5)
    lw  $a2, 8($s5)
    lw  $a3, 12($s5)

    jal determinante2x2

    mult $v0, $s3
    mflo $t0
    add $s0, $s0, $t0

    # enddd tadaaaa
    move $v0, $s0

    # restore first $ra
    lw  $ra, ($sp)
    add $sp, $sp, 4

    # restore $s5-$s0 POP
    sw  $s5, 20($sp)    
    sw  $s4, 16($sp)    
    sw  $s3, 12($sp)    
    sw  $s2, 8($sp)     
    lw  $s1, 4($sp)
    lw  $s0, 0($sp)
    add $sp, $sp, 24


    jr $ra 
    .end determinante3x3

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