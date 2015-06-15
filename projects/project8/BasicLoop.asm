
//referencing constant
@0 
 D=A 

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
(Loop_start) 

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

//pop stack to D
@SP 
 AM = M -1 
 D = M 

//using this operator: +
@SP 
 A=M-1 
 M = M+D 
 
//referencing LCL 
@0 
 D = A 
 @LCL 
 D = M + D 
 
//pop stack to address in D
@R13 
 M=D 
 @SP 
 AM = M -1 
 D = M 
 @R13 
 A=M 
 M = D 

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
 
//referencing ARG 
@0 
 D = A 
 @ARG 
 D = M + D 
 
//pop stack to address in D
@R13 
 M=D 
 @SP 
 AM = M -1 
 D = M 
 @R13 
 A=M 
 M = D 

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

//conditional goto label

//pop stack to D
@SP 
 AM = M -1 
 D = M 
@Loop_start 
D;JNE 

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
