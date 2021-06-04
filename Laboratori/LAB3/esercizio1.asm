.data
  msg1: .asciiz "Ok tutto apposto ciao"
  msg2: .asciiz "Errore hai fatto una .-."
.text
.globl main
.ent main

main:
add $t0, $0 , '0'
add $t1, $0 , '9'
add $t2, $0 , '\n'

loop:
li $v0, 12
syscall

blt $v0, $t0, p
bgt $v0, $t1, p

j    loop        # loooooop

p:
beq $v0, $t2, ok

add   $v0, $0, 4
la    $a0, msg2
syscall

j    end        # jump toend

ok:
add   $v0, $0, 4
la    $a0, msg1
syscall

end:
li  $v0, 10
syscall
.end main
