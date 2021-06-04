#da mem a register, sub and print, from register to mem

.data
num: .word 3000000000
.text
.globl main
.ent main

main:
  lw $t0, num

  subu $t0,$t0, 1000000000
  # addi $t0, $t0, -1

  #print the value on $t0
  li $v0,1
  move $a0, $t0
  syscall

  sw $t0, num

  li $v0,10
  syscall
  .end main
