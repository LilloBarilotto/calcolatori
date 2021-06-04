.data
 vet: .space 80     # 4byte per element = 20 element
 MAXINDEX=20
.text
.globl main
.ent main

main:

add $t3, $t3, 2     # contatore
la  $s0, vet

add $t1, $0, 1
add $t2, $0, 1

sw  $t1, ($s0)       # scrivo i primi due elementi nel vettore
add $s0, $s0, 4
sw  $t2, ($s0)

# $t1, vet[i-1]
# $t2, vet[i-2]
# $t0, vet[i]

loop:

add $t0, $t1, $t2  # vet[i]= vet[i-1] + vet[i-2]
add $s0, $s0, 4
sw  $t0, ($s0)

add $t2, $t1, $0    # riscrivo i vet[i-1] e vet[i-2]
add $t1, $t0, $0

add $t3, $t3, 1

bne $t3, MAXINDEX, loop

li  $v0, 10
syscall
.end main
