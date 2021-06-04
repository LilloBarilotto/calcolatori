      .data
var1: .byte 'm'
var2: .byte 'i'
var3: .byte 'p'
var4: .byte 's'
var5: .byte 0 #NULL, '\0' carattere terminatore stringa
OFFSET= 'A'-'a'

      .text
      .globl main
      .ent main
main:

lb $t0, var1
add $t0, $t0, OFFSET
sb  $t0, var1

lb $t0, var2
add $t0, $t0, OFFSET
sb  $t0, var2

lb $t0, var3
add $t0, $t0, OFFSET
sb  $t0, var3

lb $t0, var4
add $t0, $t0, OFFSET
sb  $t0, var4

la $a0, var1
li $v0,4
syscall

li  $v0, 10
syscall
.end main
