
//referencing constant
@17 
 D=A 

//push D to stack
@SP 
 A = M 
 M=D 
 @SP 
 M = M + 1 

//referencing constant
@17 
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
 D;JEQ 
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

//referencing constant
@17 
 D=A 

//push D to stack
@SP 
 A = M 
 M=D 
 @SP 
 M = M + 1 

//referencing constant
@16 
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
 @TRUE1 
 D;JEQ 
 @R13 
 M=M+1 
 (TRUE1)
 @R13 
 D=M 

//push D to stack
@SP 
 A = M 
 M=D 
 @SP 
 M = M + 1 

//referencing constant
@16 
 D=A 

//push D to stack
@SP 
 A = M 
 M=D 
 @SP 
 M = M + 1 

//referencing constant
@17 
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
 @TRUE2 
 D;JEQ 
 @R13 
 M=M+1 
 (TRUE2)
 @R13 
 D=M 

//push D to stack
@SP 
 A = M 
 M=D 
 @SP 
 M = M + 1 

//referencing constant
@892 
 D=A 

//push D to stack
@SP 
 A = M 
 M=D 
 @SP 
 M = M + 1 

//referencing constant
@891 
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
 @TRUE3 
 D;JLT 
 @R13 
 M=M+1 
 (TRUE3)
 @R13 
 D=M 

//push D to stack
@SP 
 A = M 
 M=D 
 @SP 
 M = M + 1 

//referencing constant
@891 
 D=A 

//push D to stack
@SP 
 A = M 
 M=D 
 @SP 
 M = M + 1 

//referencing constant
@892 
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
 @TRUE4 
 D;JLT 
 @R13 
 M=M+1 
 (TRUE4)
 @R13 
 D=M 

//push D to stack
@SP 
 A = M 
 M=D 
 @SP 
 M = M + 1 

//referencing constant
@891 
 D=A 

//push D to stack
@SP 
 A = M 
 M=D 
 @SP 
 M = M + 1 

//referencing constant
@891 
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
 @TRUE5 
 D;JLT 
 @R13 
 M=M+1 
 (TRUE5)
 @R13 
 D=M 

//push D to stack
@SP 
 A = M 
 M=D 
 @SP 
 M = M + 1 

//referencing constant
@32767 
 D=A 

//push D to stack
@SP 
 A = M 
 M=D 
 @SP 
 M = M + 1 

//referencing constant
@32766 
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
 @TRUE6 
 D;JGT 
 @R13 
 M=M+1 
 (TRUE6)
 @R13 
 D=M 

//push D to stack
@SP 
 A = M 
 M=D 
 @SP 
 M = M + 1 

//referencing constant
@32766 
 D=A 

//push D to stack
@SP 
 A = M 
 M=D 
 @SP 
 M = M + 1 

//referencing constant
@32767 
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
 @TRUE7 
 D;JGT 
 @R13 
 M=M+1 
 (TRUE7)
 @R13 
 D=M 

//push D to stack
@SP 
 A = M 
 M=D 
 @SP 
 M = M + 1 

//referencing constant
@32766 
 D=A 

//push D to stack
@SP 
 A = M 
 M=D 
 @SP 
 M = M + 1 

//referencing constant
@32766 
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
 @TRUE8 
 D;JGT 
 @R13 
 M=M+1 
 (TRUE8)
 @R13 
 D=M 

//push D to stack
@SP 
 A = M 
 M=D 
 @SP 
 M = M + 1 

//referencing constant
@57 
 D=A 

//push D to stack
@SP 
 A = M 
 M=D 
 @SP 
 M = M + 1 

//referencing constant
@31 
 D=A 

//push D to stack
@SP 
 A = M 
 M=D 
 @SP 
 M = M + 1 

//referencing constant
@53 
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
 
//referencing constant
@112 
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
 
//negate or not 
@SP 
 A=M-1 
 M=-M 

//pop stack to D
@SP 
 AM = M -1 
 D = M 

//using this operator: &
@SP 
 A=M-1 
 M = M&D 
 
//referencing constant
@82 
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

//using this operator: |
@SP 
 A=M-1 
 M = M|D 
 
//negate or not 
@SP 
 A=M-1 
 M=!M 
