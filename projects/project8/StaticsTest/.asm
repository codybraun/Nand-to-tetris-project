
 //initializing function 
(Class2.set)
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

 //popping 
@SP 
 M=M-1 
 A=M 
 D=M 

 //putting D in static 
@Class2.0 
 M=D 

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

 //popping 
@SP 
 M=M-1 
 A=M 
 D=M 

 //putting D in static 
@Class2.1 
 M=D 

//referencing constant
@0 
 D=A 

//push D to stack
@SP 
 A = M 
 M=D 
 @SP 
 M = M + 1 

//returning from Class2

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
 
 //initializing function 
(Class2.get)
@0 
 D = A 

 //referencing static 
@Class2.0 
 D=M 

 //pushing static 
@SP 
 A=M 
 M=D 
 @SP 
 M=M+1 
 //referencing static 
@Class2.1 
 D=M 

 //pushing static 
@SP 
 A=M 
 M=D 
 @SP 
 M=M+1 
//pop stack to D
@SP 
 AM = M -1 
 D = M 

//using this operator: -
@SP 
 A=M-1 
 M = M-D 
 
//returning from Class2

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
 