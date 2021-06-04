    .ent calcolaSuccessivo
calcolaSuccessivo:

    andi $t0, $a0, 0x00000001
    beq $t0, $0, isEven

    # isOdd
    srl $v0,$a0,1
    j end

isEven:
    mult $a0, 3
    mflo $v0
    add $v0, $v0, 1 

end:
    jr $ra
    .end calcolaSuccessivo