.data   
msg1: .asciiz  "E' palindroma"
msg2: .asciiz  "Non e' palindroma"

.text
.globl main
.ent main

main:

la $a0, msg1
move $s0, $sp
move $s1, $sp

loop1:
li  $v0, 12
syscall

beq $v0, '\n', loop2 

addi $sp, $sp, -4
sw $v0, 0($sp)

j loop1

loop2:
ble $s0, $sp, end

lw $t0, 0($sp)
addi $sp, $sp, 4

addi $s0, $s0, -4
lw $t1, 0($s0)

bne $t1, $t0, no_palindroma

j loop2


no_palindroma:
la $a0, msg2

end:
li  $v0, 4
syscall

move $sp, $s1

li  $v0, 10
syscall
.end main