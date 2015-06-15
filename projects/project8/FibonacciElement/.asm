
 //initializing function 
(Sys.init)
@0 
 D = A 

//referencing constant
@4 
 D=A 

//push D to stack
@SP 
 A = M 
 M=D 
 @SP 
 M = M + 1 

 //calling function, store state 
@Main.fibonacci.RETURNADDRESS 
D=A 

//push D to stack
@SP 
 A = M 
 M=D 
 @SP 
 M = M + 1 

 //put LCL on stack 
@LCL 
 D=M 

//push D to stack
@SP 
 A = M 
 M=D 
 @SP 
 M = M + 1 

 //put ARG on stack 
@ARG 
 D=M 

//push D to stack
@SP 
 A = M 
 M=D 
 @SP 
 M = M + 1 

 //put THIS on stack 
@THIS 
 D=M 

//push D to stack
@SP 
 A = M 
 M=D 
 @SP 
 M = M + 1 

 //put THAT on stack 
@THAT 
 D=M 

//push D to stack
@SP 
 A = M 
 M=D 
 @SP 
 M = M + 1 

 //move ARG to first argument 
@SP
 D=M 
 @5 
 D=D-A 
 @1 
 D=D-A 
 @ARG 
 M=D 
@SP 
 D=M 
 @LCL 
 M=D

 //transfer control 
@Main.fibonacci 
 0;JMP
(Main.fibonacci.RETURNADDRESS)

//writing label
(While) 

//unconditional goto label
@While 
D;JMP 
