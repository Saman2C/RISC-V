add a0, zero, zero #max
addi a1, zero, 80 #addr
addi a2, zero, 9  #n-1
blt a2, zero, 80
lw t1, 0(a1)
sltu t2, a0, t1
beq zero, t2, 8 #8=FLAG
add a0, zero, t1
addi a1, a1, 4 #<- FLAG
addi a2, a2, -1
jal t3, -28