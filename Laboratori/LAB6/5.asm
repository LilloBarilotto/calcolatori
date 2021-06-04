    .data
    .text
    .globl main
    .ent main

main:

    li  $a0, 6
    li  $a1, 3

    jal c_n_k
    move $a0, $v0
    li $v0, 1
    syscall

    li $v0, 10
    syscall

    .end main



# $a0=n
# $a1=k

    .ent c_n_k
c_n_k:
    bne $a1, $0, do_real_thing

    li $v0, 1
    jr $ra

do_real_thing:
    # im caller and im saving $a0, $a1, $ra return address
    add $sp, $sp, -12
    sw $ra, 8($sp)
    sw $a1, 4($sp)
    sw $a0, 0($sp)

    add $a1, $a1, -1
    add $a0, $a0, -1

    jal c_n_k

    # restore the value
    lw $a0, 0($sp)
    lw $a1, 4($sp)
    lw $ra, 8($sp)
    add $sp, $sp, 12

    mult $a0, $v0
    mflo $v0
    
    div $v0, $a1
    mflo $v0

    jr $ra
    .end c_n_k