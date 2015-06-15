
 //initializing function 
(Simplefunction.test)
@0 
 D = A 

 //adding a zero 

//push D to stack
@SP 
 A = M 
 M=D 
 @SP 
 M = M + 1 

 //adding a zero 

//push D to stack
@SP 
 A = M 
 M=D 
 @SP 
 M = M + 1 

//referencing LCL 
@0 
 D = A 
 @LCL 
 D = M + D 
 
//push value addressed by D to stack
A=D 
 D=M 
 @SP 
 A = M 
 M=D 
 @SP 
 M = M + 1 

//referencing LCL 
@1 
 D = A 
 @LCL 
 D = M + D 
 
//push value addressed by D to stack
A=D 
 D=M 
 @SP 
 A = M 
 M=D 
 @SP 
 M = M + 1 

//pop stack to D
@SP 
 AM = M -1 
 D = M 

//using this operator: +
@SP 
 A=M-1 
 M = M+D 
 
//negate or not 
@SP 
 A=M-1 
 M=!M 

//referencing ARG 
@0 
 D = A 
 @ARG 
 D = M + D 
 
//push value addressed by D to stack
A=D 
 D=M 
 @SP 
 A = M 
 M=D 
 @SP 
 M = M + 1 

//pop stack to D
@SP 
 AM = M -1 
 D = M 

//using this operator: +
@SP 
 A=M-1 
 M = M+D 
 
//referencing ARG 
@1 
 D = A 
 @ARG 
 D = M + D 
 
//push value addressed by D to stack
A=D 
 D=M 
 @SP 
 A = M 
 M=D 
 @SP 
 M = M + 1 

//pop stack to D
@SP 
 AM = M -1 
 D = M 

//using this operator: -
@SP 
 A=M-1 
 M = M-D 
 
//returning from SimpleFunction

//put frame in R13 
@LCL 
 D=M 
 @R13 
 M=D 

//put return in R14
@5 
 D=D-A 
 @R14 
 M=D 

//pop stack to D
@SP 
 AM = M -1 
 D = M 
@ARG 
 A=M 
 M=D 
@ARG 
 D=A+1 
 @SP 
 M =D 

//restore segments
@R13 
 M=M-1 
 A=M 
 D=M 
 @THAT 
 M=D 
@R13 
 M=M-1 
 A=M 
 D=M 
 @THIS 
 M=D 
@R13 
 M=M-1 
 A=M 
 D=M 
 @ARG 
 M=D 
@R13 
 M=M-1 
 A=M 
 D=M 
 @LCL 
 M=D 
@R13 
 M=M-1 
 A=M 

//jump to return address
0;JMP 
 