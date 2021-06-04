.data
matrix: .word 154, 123, 109, 86,    4,  0    # $t7
        .word 412, -23,-231,  9,   50,  0    # $t7
        .word 123, -24,  12, 55,  -45,  0    # $t7
        .word   0,   0,   0,   0,   0,  0    # $t7
            # $s0, $s1, $s2, $s3, $s4, $s5           
            # matrix of 4x4

tabella: .word js0, js1, js2, js3, js4

I=3
J=5

.text
.globl main
.ent main

main:

# t0 counter upperloop
# t1 counter nestedloop
# t6 save address of matrix
# t7 save temp result of row
# $s0-5 temp result of column
# t8 temp (xi, yi)

# t4 save shift of $t1 of 2
# t3 save register to jump to modify s0-5

la $t6, matrix

li $s0, 0
li $s1, 0
li $s2, 0
li $s3, 0
li $s4, 0
li $s5, 0

li $t0, 0
upper_loop:

li $t7, 0
li $t1, 0
nested_loop:

lw $t8, ($t6)
add $t6, $t6, 4
add $t7, $t7, $t8

sll $t4, $t1, 2
lw $t3, tabella($t4)
jr  $t3


js0:
add $s0, $s0, $t8
j end_switch

js1:
add $s1, $s1, $t8
j end_switch

js2:
add $s2, $s2, $t8
j end_switch

js3:
add $s3, $s3, $t8
j end_switch

js4:
add $s4, $s4, $t8
j end_switch

end_switch:

add $t1, $t1, 1
bne $t1, J, nested_loop

sw $t7, ($t6)
add $t6, $t6, 4

add $s5, $s5, $t7

add $t0, $t0, 1
bne $t0, I, upper_loop

# save the last row with result
sw $s0, 0($t6)
sw $s1, 4($t6)
sw $s2, 8($t6)
sw $s3, 12($t6)
sw $s4, 16($t6)

add $s5, $s5, $s0
add $s5, $s5, $s1
add $s5, $s5, $s2
add $s5, $s5, $s3
add $s5, $s5, $s4

sw $s5, 20($t6)

li $v0, 10
syscall
.end main