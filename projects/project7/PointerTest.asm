
//referencing constant
@3030 
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

//moving pointer
@THIS 
M=D 

//referencing constant
@3040 
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

//moving pointer
@THIS 
A=A+1 
M=D 

//referencing constant
@32 
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
@46 
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

//moving pointer

 @THIS 
D=M 

//push D to stack
@SP 
 A = M 
 M=D 
 @SP 
 M = M + 1 

//moving pointer

 @THIS 
A=A+1 
D=M 

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
 
//referencing this, local, that, or args
@2 
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

//using this operator: -
@SP 
 A=M-1 
 M = M-D 
 
//referencing this, local, that, or args
@6 
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
 