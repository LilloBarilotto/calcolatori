.data
matrix: .space 400   # matrix of 10x10

N=11

.text
.globl main
.ent main

main:
# t1 counter upperloop
# t2 counter nestedloop

# t6 save address of matrix
# t3 save result of x_i*y_i

la $t6, matrix
li $t1, 1
upper_loop:

li $t2, 1
nested_loop:

mult $t1, $t2
mflo $t3

sw $t3, ($t6)
add $t6, $t6, 4

add $t2, $t2, 1
bne $t2, N, nested_loop

add $t1, $t1, 1
bne $t1, N, upper_loop

li $v0, 10
syscall
.end main