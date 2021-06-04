     .data
N= 19
    .text
    .globl main
    .ent main

main:
    li $a0, N

    jal sequenzaDiCollatz
    
    move $a0, $v0
    li $v0, 1       
    syscall 
    
    li $v0, 10
    syscall

    .end main
 
#   ------------------------------------------------------

    .ent sequenzaDiCollatz
sequenzaDiCollatz: 
    add $sp, $sp, -4
    sw  $ra, 0($sp)

    li $s0, 0
    move $v0, $a0

do_: beq $v0, 1, end_sequenzaDiCollatz

    jal calcolaSuccessivo
    move $a0, $v0
    add $s0, $s0, 1
    
    j do_

end_sequenzaDiCollatz:
    lw $ra, 0($sp)
    add $sp, $sp, 4
    
    move $v0, $s0
    
    jr $ra 
    .end sequenzaDiCollatz

#   ------------------------------------------------------

    .ent calcolaSuccessivo
calcolaSuccessivo:

    andi $t0, $a0, 0x01
    beq $t0, $0, isEven

    # isOdd
     li $t1, 3
    mult $a0, $t1
    mflo $v0
    add $v0, $v0, 1 
    j end

isEven:
    srl $v0,$a0,1

end:
    jr $ra
    .end calcolaSuccessivo