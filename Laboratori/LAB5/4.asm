.data

#  DIAGONAL
#   .word   1, 0, 0, 0
#   .word   0, 2, 0, 0
#   .word   0, 0, 3, 0
#   .word   0, 0, 0, 4

#  NOT SIM
#   .word   1, 0, 2, 0
#   .word   0, 2, 0, 0
#   .word   4, 0, 3, 0
#   .word   0, 0, 0, 4

#  SIMM
#   .word   1, 1, 2, 3
#   .word   1, 2, 3, 4
#   .word   2, 3, 4, 5
#   .word   3, 4, 5, 6

matrix:
   .word   1, 1, 2, 3
   .word   1, 2, 3, 4
   .word   2, 3, 4, 5
   .word   3, 4, 5, 6

DIM=4

.text 
.globl main
.ent main

main:
# $s0= matrix[0][0]
# $s1= counter of row
# $s2  counter of column
# $s3  counter of all = dim*dim
# $s4 = 2,1,0 (def=2)
# $s5  =DIM

# $s6 = take sum of all number not in diagonal, at least if !=0 it's not diagonal matrix
# $t0 = matrix[s1,s2]
# $t1 = matrix[s2,s1]
# $t2 = &(matrix+ s1*DIM + s2) OR &(matrix + s2*DIM + s1)



la $s0, matrix
li $s4, 2
li $s5, DIM
li $s6, 0

mult $s5,$s5
mflo $s3


li $s1, 0
loop1:

move $s2, $s1
loop2:
beq $s1, $s2, not_important

mult $s1, $s5
mflo $t2
add $t2, $t2, $s0
add $t2, $t2, $s2

lw $t0, ($t2)

mult $s2, $s5
mflo $t2
add $t2, $t2, $s0
add $t2, $t2, $s1

lw $t1, ($t2)
# HO SALVATO matrix[a,b] e matrix[b,a]

bne $t0,$t1, errore
add $s6, $s6, $t0

not_important:
addi $s2, $s2, 4
bne $s2, $s3, loop2

addi $s1, $s1, 4
bne $s2, $s3, loop1

beq $s6, $0, end

li $s4, 1

j end

errore:
li $s4, 0

end:
li $v0, 1       
move $a0, $s4
syscall

li $v0, 10
syscall
.end main