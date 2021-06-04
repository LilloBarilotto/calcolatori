NUM = 5
DIM = NUM * 4
SCONTO = 30
ARROTONDA = 1
    .data
prezzi: .word 39, 1880, 2394, 1000, 1590
scontati: .space DIM
    
    .text
    .globl main
    .ent main

main:  
la $a0, prezzi
la $a1, scontati
li $a2, NUM
li $a3, SCONTO
li $t0, ARROTONDA
subu $sp, 4       
sw $t0, ($sp)
jal calcola_sconto

addu $sp, 4

move $a0, $v0
li   $v0, 1
syscall

li $v0, 10
syscall

.end main

    .ent calcola_sconto
calcola_sconto:
    lw $t1, 0($sp) # arrotonda
    li $t0, 0
    li $t4, 100
    li $v0, 0

while: beq $t0, $a2, end

    lw $t2, 0($a0)  # valore iniziale

    mult $t2, $a3   
    mflo $t3        
    div  $t3, $t4
    mflo $t3        # da togliere = val iniz * sconto /100

    beq  $t1, $0, ok
    mfhi $t5
    blt  $t5, 50, ok
    sub $t3, $t3, 1

ok:
    add $v0, $v0, $t3  
    sub $t2, $t2, $t3

    sw  $t2, 0($a1)
    add $a0, $a0, 4
    add $a1, $a1, 4
    add $t0, $t0, 1
    j while

end:
    jr $ra
    .end calcola_sconto