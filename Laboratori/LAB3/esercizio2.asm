.data
  msg1: .asciiz "Guarda che sei andato in overflow non sei su 32bit"
  msg2: .asciiz "Errore hai fatto una .-."
.text
.globl main
.ent main

main:
add $t0, $0 , '0'
add $t1, $0 , '9'
add $t2, $0 , '\n'

add $t3, $0, 10
add $s0, $0, $0

loop:
li $v0, 12
syscall

blt $v0, $t0, p
bgt $v0, $t1, p

sub   $v0, $v0, $t0
mult  $s0, $t3
mflo  $s0
add   $s0, $s0, $v0

j    loop        # loooooop

p:
beq $v0, $t2, ok

add   $v0, $0, 4
la    $a0, msg2
syscall

j    end        # jump toend

ok:
mfhi   $t4
bne    $t4, $0, target  # ifhi==  then

move $a0, $s0
li $v0, 1
syscall
j    end

target:
add   $v0, $0, 4
la    $a0, msg1
syscall

end:
li  $v0, 10
syscall
.end main
