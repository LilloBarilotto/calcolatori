DIM = 5
    .data
vet1: .word 56, 12, 98, 129, 58
vet2: .word 1, 0, 245, 129, 12
risultato: .space DIM
    
    .text

    .globl main
    .ent main
main:
la $a0, vet1
la $a1, vet2
la $a2, risultato
li $a3, DIM

jal CalcolaDistanzaH

li $v0, 10
syscall

    .end main



    .ent CalcolaDistanzaH
CalcolaDistanzaH:
    
    li $t0, 0
    li $t4, 2

while:
    beq $t0, $a3, end_

    lw $t1, 0($a0)
    lw $t2, 0($a1)

    li $t3, 0   # numero bit diversi
nested_while:
    beq $t1, $t2, end_nested
    
    div $t1, $t4
    mflo $t1
    mfhi $t5 # resto di t0

    div $t2, $t4
    mflo $t2
    mfhi $t6 # resto di t1    

    beq $t5, $t6, nested_while
    
    add $t3, $t3, 1
    j nested_while

end_nested:
    sb  $t3, 0($a2)


    #  CODICE INUTILE, SERVE SOLO A STAMPARE PER CHI NON SI FIDA
    move $t8, $a0
    move $a0, $t3
    li $v0, 1
    syscall
    move $a0, $t8 
    #   FINE CODICE INUTILE, POTETE RIMUOVERLO SENZA PROBLEMI <3
    
    add $a2, $a2, 1 
    add $a0, $a0, 4
    add $a1, $a1, 4

    add $t0, $t0, 1
    j while
end_:     
    jr $ra
    .end CalcolaDistanzaH