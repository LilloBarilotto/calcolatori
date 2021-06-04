    .data
    .text
    .globl main
    .ent main

main:
    jal stampaTriangolo

    li $a0, '\n'
    li $v0, 11
    syscall
    li $v0, 11
    syscall

    jal stampaQuadrato

    li $v0, 10
    syscall
    .end main

    .ent stampaTriangolo
stampaTriangolo:
    #   t0 = Num* ----------- t1 = max * per line (First loop) ------------ t2 = counter        (Nested loop)

    li  $t0, 8
    li  $t1, 1

    stampaTriangololoop1:
    li $a0, '*' # char need to be print
    li  $t2, 0
    stampaTriangololoop2:

    li $v0, 11
    syscall

    addi $t2, $t2, 1 
    bne $t2, $t1, stampaTriangololoop2

    li $a0, '\n'
    li $v0, 11
    syscall

    addi $t1, $t1, 1
    ble $t1, $t0, stampaTriangololoop1

    jr $ra
    .end stampaTriangolo

    .ent stampaQuadrato
stampaQuadrato:
    #   t0 = Num* per row
    #   t1 = counter (First loop)
    #   t2 = counter        (Nested loop)

    li  $t0, 8
    li  $t1, 0

    stampaQuadratoloop1:
    li $a0, '*' # char need to be print
    li  $t2, 0
    stampaQuadratoloop2:

    li $v0, 11
    syscall

    addi $t2, $t2, 1 
    bne $t2, $t0, stampaQuadratoloop2

    li $a0, '\n'
    li $v0, 11
    syscall

    addi $t1, $t1, 1
    blt $t1, $t0, stampaQuadratoloop1

    jr $ra
    .end stampaQuadrato