
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

 //initializing function 
(Main.fibonacci)
@0 
 D = A 

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
@2 
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

 //comparing 
@R13 
 M=-1 
 @SP 
 AM=M-1 
 D=M-D 
 @TRUE0 
 D;JLT 
 @R13 
 M=M+1 
 (TRUE0)
 @R13 
 D=M 

//push D to stack
@SP 
 A = M 
 M=D 
 @SP 
 M = M + 1 

//conditional goto label

//pop stack to D
@SP 
 AM = M -1 
 D = M 
@If_true 
D;JNE 

//unconditional goto label
@If_false 
D;JMP 

//writing label
(If_true) 

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

//returning from Main

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
 
//writing label
(If_false) 

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
@2 
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

//using this operator: -
@SP 
 A=M-1 
 M = M-D 
 
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
@1 
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

//using this operator: -
@SP 
 A=M-1 
 M = M-D 
 
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

//pop stack to D
@SP 
 AM = M -1 
 D = M 

//using this operator: +
@SP 
 A=M-1 
 M = M+D 
 
//returning from Main

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
 