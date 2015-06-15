
//referencing constant
@10 
 D=A 

//push D to stack
@SP 
 A = M 
 M=D 
 @SP 
 M = M + 1 

//referencing this, local, that, or args
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
 A = M 
 M = D 

//referencing constant
@21 
 D=A 

//push D to stack
@SP 
 A = M 
 M=D 
 @SP 
 M = M + 1 

//referencing constant
@22 
 D=A 

//push D to stack
@SP 
 A = M 
 M=D 
 @SP 
 M = M + 1 

//referencing this, local, that, or args
@2 
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
 A = M 
 M = D 

//referencing this, local, that, or args
@1 
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
 A = M 
 M = D 

//referencing constant
@36 
 D=A 

//push D to stack
@SP 
 A = M 
 M=D 
 @SP 
 M = M + 1 

//referencing this, local, that, or args
@6 
 D = A 
 @THIS 
 D = M + D 
 
//pop stack to address in D
@R13 
 M=D 
 @SP 
 AM = M -1 
 D = M 
 @R13 
 A = M 
 M = D 

//referencing constant
@42 
 D=A 

//push D to stack
@SP 
 A = M 
 M=D 
 @SP 
 M = M + 1 

//referencing constant
@45 
 D=A 

//push D to stack
@SP 
 A = M 
 M=D 
 @SP 
 M = M + 1 

//referencing this, local, that, or args
@5 
 D = A 
 @THAT 
 D = M + D 
 
//pop stack to address in D
@R13 
 M=D 
 @SP 
 AM = M -1 
 D = M 
 @R13 
 A = M 
 M = D 

//referencing this, local, that, or args
@2 
 D = A 
 @THAT 
 D = M + D 
 
//pop stack to address in D
@R13 
 M=D 
 @SP 
 AM = M -1 
 D = M 
 @R13 
 A = M 
 M = D 

//referencing constant
@510 
 D=A 

//push D to stack
@SP 
 A = M 
 M=D 
 @SP 
 M = M + 1 

//referencing temp
@11 
 D = A 

//pop stack to address in D
@R13 
 M=D 
 @SP 
 AM = M -1 
 D = M 
 @R13 
 A = M 
 M = D 

//referencing this, local, that, or args
@0 
 D = A 
 @LCL 
 D = M + D 
 
//push value addressed by D to stack
A=D 
 D=M 
 A = D 
 @SP 
 A = M 
 M=D 
 @SP 
 M = M + 1 

//referencing this, local, that, or args
@5 
 D = A 
 @THAT 
 D = M + D 
 
//push value addressed by D to stack
A=D 
 D=M 
 A = D 
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
 
//referencing this, local, that, or args
@1 
 D = A 
 @ARG 
 D = M + D 
 
//push value addressed by D to stack
A=D 
 D=M 
 A = D 
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
 
//referencing this, local, that, or args
@6 
 D = A 
 @THIS 
 D = M + D 
 
//push value addressed by D to stack
A=D 
 D=M 
 A = D 
 @SP 
 A = M 
 M=D 
 @SP 
 M = M + 1 

//referencing this, local, that, or args
@6 
 D = A 
 @THIS 
 D = M + D 
 
//push value addressed by D to stack
A=D 
 D=M 
 A = D 
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
 
//pop stack to D
@SP 
 AM = M -1 
 D = M 

//using this operator: -
@SP 
 A=M-1 
 M = M-D 
 
//referencing temp
@11 
 D = A 

//push value addressed by D to stack
A=D 
 D=M 
 A = D 
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
 