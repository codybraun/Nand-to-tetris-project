
//referencing constant
@111 
 D=A 

//push D to stack
@SP 
 A = M 
 M=D 
 @SP 
 M = M + 1 

//referencing constant
@333 
 D=A 

//push D to stack
@SP 
 A = M 
 M=D 
 @SP 
 M = M + 1 

//referencing constant
@888 
 D=A 

//push D to stack
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
@./StaticTest.8 
 M=D 

 //popping 
@SP 
 M=M-1 
 A=M 
 D=M 

 //putting D in static 
@./StaticTest.3 
 M=D 

 //popping 
@SP 
 M=M-1 
 A=M 
 D=M 

 //putting D in static 
@./StaticTest.1 
 M=D 

 //referencing static 
@./StaticTest.3 
 D=M 

 //pushing static 
@SP 
 A=M 
 M=D 
 @SP 
 M=M+1 
 //referencing static 
@./StaticTest.1 
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
 
 //referencing static 
@./StaticTest.8 
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

//using this operator: +
@SP 
 A=M-1 
 M = M+D 
 