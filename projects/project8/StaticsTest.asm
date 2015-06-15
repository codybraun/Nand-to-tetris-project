
//Bootstrap code
@256 
 D=A 
 @SP 
 M=D

 //calling function, store state 
@Sys.init.RETURNADDRESS 
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

 //move LCL to SP 
@SP 
 D=M 
 @LCL 
 M=D

 //transfer control 
@Sys.init 
 0;JMP
(Sys.init.RETURNADDRESS)
(BOOTLOOP) 
 @BOOTLOOP 
 0;JMP 

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
 A=D 
 D=M 
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
 D=M+1 
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
@R14 
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
 A=D 
 D=M 
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
 D=M+1 
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
@R14 
 A=M 

//jump to return address
0;JMP 
 
 //initializing function 
(Class1.set)
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
@Class1.0 
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
@Class1.1 
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

//returning from Class1

//put frame in R13 
@LCL 
 D=M 
 @R13 
 M=D 

//put return in R14
@5 
 D=D-A 
 A=D 
 D=M 
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
 D=M+1 
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
@R14 
 A=M 

//jump to return address
0;JMP 
 
 //initializing function 
(Class1.get)
@0 
 D = A 

 //referencing static 
@Class1.0 
 D=M 

 //pushing static 
@SP 
 A=M 
 M=D 
 @SP 
 M=M+1 
 //referencing static 
@Class1.1 
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
 
//returning from Class1

//put frame in R13 
@LCL 
 D=M 
 @R13 
 M=D 

//put return in R14
@5 
 D=D-A 
 A=D 
 D=M 
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
 D=M+1 
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
@R14 
 A=M 

//jump to return address
0;JMP 
 
 //initializing function 
(Sys.init)
@0 
 D = A 

//referencing constant
@6 
 D=A 

//push D to stack
@SP 
 A = M 
 M=D 
 @SP 
 M = M + 1 

//referencing constant
@8 
 D=A 

//push D to stack
@SP 
 A = M 
 M=D 
 @SP 
 M = M + 1 

 //calling function, store state 
@Class1.set.RETURNADDRESS 
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
 @2 
 D=D-A 
 @ARG 
 M=D 

 //move LCL to SP 
@SP 
 D=M 
 @LCL 
 M=D

 //transfer control 
@Class1.set 
 0;JMP
(Class1.set.RETURNADDRESS)

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
@23 
 D=A 

//push D to stack
@SP 
 A = M 
 M=D 
 @SP 
 M = M + 1 

//referencing constant
@15 
 D=A 

//push D to stack
@SP 
 A = M 
 M=D 
 @SP 
 M = M + 1 

 //calling function, store state 
@Class2.set.RETURNADDRESS 
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
 @2 
 D=D-A 
 @ARG 
 M=D 

 //move LCL to SP 
@SP 
 D=M 
 @LCL 
 M=D

 //transfer control 
@Class2.set 
 0;JMP
(Class2.set.RETURNADDRESS)

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

 //calling function, store state 
@Class1.get.RETURNADDRESS 
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

 //move LCL to SP 
@SP 
 D=M 
 @LCL 
 M=D

 //transfer control 
@Class1.get 
 0;JMP
(Class1.get.RETURNADDRESS)

 //calling function, store state 
@Class2.get.RETURNADDRESS 
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

 //move LCL to SP 
@SP 
 D=M 
 @LCL 
 M=D

 //transfer control 
@Class2.get 
 0;JMP
(Class2.get.RETURNADDRESS)

//writing label
(While) 

//unconditional goto label
@While 
D;JMP 
