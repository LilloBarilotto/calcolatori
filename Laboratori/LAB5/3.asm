.data   
msg1: .asciiz  "Ha soluzioni reali"
msg2: .asciiz  "Non ha soluzioni reali"

.text
.globl main
.ent main

main:
la $a0, msg1

#   save a
li $v0, 5
syscall
move $s0, $v0

#   save b
li $v0, 5
syscall
move $s1, $v0

#   save c 
li $v0, 5
syscall
move $s2, $v0


#   $t0 = b^2 - 4ac

#   $t0 = b^2
mult $s1, $s1
mflo $t0

#   $t1 = 4ac
mult  $s0, $s2
mflo $t1
li $t9, 4
mult  $t1, $t9
mflo $t1

#   $t0 = b^2 - 4ac = $t0 - $t1
sub $t0, $t0, $t1

bge $t0, $0, end 

no_reali:
la $a0, msg2

end:
li  $v0, 4
syscall

li  $v0, 10
syscall
.end main