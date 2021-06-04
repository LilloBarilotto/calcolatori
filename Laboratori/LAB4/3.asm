.data

x: .space 16  # 4 word of 4 byte
y: .space 16  # 4 word of 4 byte
matrix: .space 64   # matrix of 4x4

N=4

.text
.globl main
.ent main

main:
la $t1, x
la $t2, y

li $t0, 0
loop_to_save_x:
li $v0, 5
syscall
sw $v0, ($t1) 

add $t0, $t0, 1
add $t1, $t1, 4
bne $t0, N, loop_to_save_x

li $t0, 0
loop_to_save_y:
li $v0, 5
syscall
sw $v0, ($t2)

add $t0, $t0, 1
add $t2, $t2, 4
bne $t0, N, loop_to_save_y


# t0 counter upperloop
# t1 counter nestedloop
# t2 box to save x_i
# t3 box to save y_i
# t4 save address of x
# t5 save address of y

# t6 save address of matrix
# t7 save result of x_i*y_i

la $t6, matrix
la $t4, x
li $t0, 0
upper_loop:

lw $t2, ($t4)

la $t5, y
li $t1, 0
nested_loop:

lw $t3, ($t5)
mult $t2, $t3
mflo $t7

sw $t7, ($t6)
add $t6, $t6, 4


add $t5, $t5, 4
add $t1, $t1, 1
bne $t1, N, nested_loop

add $t4, $t4, 4
add $t0, $t0, 1
bne $t0, N, upper_loop


li $v0, 10
syscall
.end main