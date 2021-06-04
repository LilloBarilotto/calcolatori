.data

SOMMA=0
SOTTRAZIONE=1
MOLTIPLICAZIONE=2
DIVISIONE=3

opa: .word 2043
opb: .word 5
res: .space 4 

msg1: .asciiz "Errore hai fatto una .-."

.text
.globl main
.ent main

main:
li $t2, 0
lw $t0, opa
lw $t1, opb

li $v0, 5
syscall

beq $v0, SOMMA, summ
beq $v0, SOTTRAZIONE, subb
beq $v0, MOLTIPLICAZIONE, multip
beq $v0, DIVISIONE, divis

la $a0, msg1
li $v0, 4
syscall

j end

summ:
add $t2, $t0, $t1
j end

subb:
sub $t2, $t0, $t1
j end

multip:
mult  $t0, $t1
mflo $t2
j end

divis:
div $t0, $t1
mflo $t2
j end


end:
la $t3, res
sw $t2, 0($t3)

li $v0, 10
syscall
.end main