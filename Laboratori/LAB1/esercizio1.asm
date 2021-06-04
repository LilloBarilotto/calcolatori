  .data
n1: .byte 10      #10 --> 0x0a
n2: .byte 0x10    #16*1=16 --->0x10
n3: .byte '1'     #char '1' --> 49 --> 0x31
res: .space 1     #43--> 0x2b = 16*2 + 11= 43

  .text
  .globl main
  .ent main

  main:
  lb $t0, n1
  lb $t1, n2
  lb $t2, n3

  add  $t3, $t0, $t2
  sub  $t3, $t3, $t1

  sb $t3, res

  li  $v0, 10
  syscall
  .end main
