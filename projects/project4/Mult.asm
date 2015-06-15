@total
M = 0
(LOOP)
@R0
D=M 	//set D to R0
@DONE //jump if finished
D;JEQ
@R1
D=M 	//set D to R1
@total
M = D + M //total + R1. need to do this R0 times
@R0
M = M -1
@LOOP
0;JMP
(DONE)

@total
D = M
@R2
M = D

0;JMP
