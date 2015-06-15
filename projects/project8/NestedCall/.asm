
 //initializing function 
(Sys.init)
@0 
 D = A 

 //calling function, store state 
@Sys.main.RETURNADDRESS 
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
 @0 
 D=D-A 
 @ARG 
 M=D 

 //transfer control 
@Sys.main 
 0;JMP
(Sys.main.RETURNADDRESS)

//referencing temp
@6 
 D = A 

//pop stack to address in D
@R13 
 M=D 
 @SP 
 AM = M -1 
 D = M 
 @R13 
 A=M 
 M = D 

//writing label
(Loop) 

//unconditional goto label
@Loop 
D;JMP 

 //initializing function 
(Sys.main)
@0 
 D = A 

//referencing constant
@123 
 D=A 

//push D to stack
@SP 
 A = M 
 M=D 
 @SP 
 M = M + 1 

 //calling function, store state 
@Sys.add12.RETURNADDRESS 
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

 //transfer control 
@Sys.add12 
 0;JMP
(Sys.add12.RETURNADDRESS)

//referencing temp
@5 
 D = A 

//pop stack to address in D
@R13 
 M=D 
 @SP 
 AM = M -1 
 D = M 
 @R13 
 A=M 
 M = D 

//referencing constant
@246 
 D=A 

//push D to stack
@SP 
 A = M 
 M=D 
 @SP 
 M = M + 1 

//returning from Sys

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
 A=M 
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
 
 //initializing function 
(Sys.add12)
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

 //adding a zero 

//push D to stack
@SP 
 A = M 
 M=D 
 @SP 
 M = M + 1 

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

//referencing constant
@12 
 D=A 

//push D to stack
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
 
//returning from Sys

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
 A=M 
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
 