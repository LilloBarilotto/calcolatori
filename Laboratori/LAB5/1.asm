.data
 variable: .word 3141592653     

.text
.globl main
.ent main

main:

lw $t0, variable
addi $t1, $0, 10

move $s0, $sp

loop1:

divu $t0, $t1
mfhi $t2
mflo $t0

addi $sp, $sp, -4
sw $t2, 0($sp)

bne $t0, $0, loop1 


loop2:

lw $a0, 0($sp)
addi $sp, $sp, 4

addi $a0, $a0, '0'
li  $v0, 11
syscall

bne $sp, $s0, loop2

li  $v0, 10
syscall
.end main
