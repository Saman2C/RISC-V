add a0 10, zero, zero #max
addi a1	11, zero, 4 #addr
addi a2 12, zero, 9  #n-1
blt a2 12, zero, 80
lw t1 6, 0(a1)
sltu t2 7, a0 10, t1 6
beq zero, t2 7, 8 #8=FLAG
add a0 10, zero, t1 6
addi a1 11, a1 11, 4 #<- FLAG
addi a2 12, a2 12, -1
jal t3 28, -28