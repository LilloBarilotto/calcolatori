    .data
ora_in:     .byte 12, 47
ora_out:    .byte 18, 14
X:          .byte 1
Y:          .byte 40

            .text
            .globl main
            .ent main
main:
            la $a0, ora_in # indirizzo di ora_in
            la $a1, ora_out # indirizzo di ora_out
            lbu $a2, X
            lbu $a3, Y
            jal costoParcheggio

            move $a0, $v0
            li $v0, 1
            syscall

            li $v0, 10
            syscall
            .end main

            .ent costoParcheggio
costoParcheggio:

            # $a0, $a1 ind vettori orari
            # $a2, $a3 X euro per Y periodo minuti
            # $s0 ora inizio in soli minuti
            # $s1 ora fine in minuti

            # $s2 min di periodo
            # $s3 periodi completati
            # $v0 costo parcheggio

            li $t0, 60  

            # orario inizio
            lb $t1, 0($a0)  # hour
            lb $t2, 1($a0)  # minute
                        
            mult $t0, $t1
            mflo $s0        # min_tot_start= hour*60+minute
            add $s0, $s0, $t2

            # orario fine
            lb $t1, 0($a1)  # hour
            lb $t2, 1($a1)  # minute

            mult $t0, $t1
            mflo $s1
            add $s1, $s1, $t2

            # fine - inizio
            sub $s2, $s1, $s0

            div $s2, $a3
            mflo $s3
            mfhi $t3 # resto, o periodi incompleti

            beq $t3, $0, end_if_costoParcheggio
            add $s3, $s3, 1

            mult $s3, $a2
            mflo $v0

            end_if_costoParcheggio:
            jr $ra
            .end costoParcheggio