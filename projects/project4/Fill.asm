@SCREEN
D = A 
@screen-loc
M = D

//check for pressed key
(KEY-LOOP)
@24576
D = M
@B-LOOP
D; JGT //need to go to the blacken loop if greater than zero
@W-LOOP
D; JEQ //otherwise go to w-loop

(B-LOOP)
@screen-loc
D = M
A = D
M = -1
@screen-loc
M = M + 1
@KEY-LOOP
0; JMP

(W-LOOP)
@screen-loc
D = M
A = D
M = 0
@screen-loc
M = M - 1
@KEY-LOOP
0; JMP 


