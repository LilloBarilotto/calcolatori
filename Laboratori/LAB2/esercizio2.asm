.data
  errore: .asciiz "Errore non in byte"
.text
.globl main
.ent main

main:
#$t0=A
#$t1=B
#$t2 caso di errore
#t3 maschera per vedere se va oltre 1 byte
#t4,t5 operazioni di calcolo
#t6 maschera per lasciare solo 1 byte iniziale
li $t3, 0xFFFFFF00
li $t6, 0x000000FF

li $v0, 5
syscall
move  $t0, $v0 #A=$t0
and $t2,$t0,$t3
bne $t2, $0, error

li $v0, 5
syscall
move  $t1, $v0 #B=$t1
and $t2,$t1,$t3
bne $t2, $0, error

xor $t4, $t1, $t0 # A XOR B
not $t5, $t1 # NOT B
and $t5, $t5, $t0 # (NOT B) AND A
not $t5, $t5 # NOT ((NOT B) AND A)
or  $t5, $t5, $t4 # NOT ((NOT B) AND A) OR (A XOR B)

move $a0, $t5
and  $a0, $a0, $t6
li $v0, 1
syscall
j    end        # jump to end

error:
la $a0, errore
li $v0, 4
syscall

end:
li  $v0, 10
syscall
.end main
