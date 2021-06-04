.data
  pari: .asciiz "Il numero e' pari"
  dispari: .asciiz "Il numero e' dispari"
.text
.globl main
.ent main

main:
li $v0, 5
syscall

move  $t0, $v0
and $t0, $t0, 1 # or sll $t0, $t0, 31

beq $t0, $0, p

la $a0, dispari
li $v0, 4
syscall
j    end        # jump to end

p:
la $a0, pari
li $v0, 4
syscall

end:
li  $v0, 10
syscall
.end main
