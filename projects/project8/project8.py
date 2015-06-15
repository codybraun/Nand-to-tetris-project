import sys, re, string, os

i = 0
def push (outFile): #just assume value to push is in D
    outFile.write("\n//push D to stack\n")
    outFile.write("@SP \n A = M \n M=D \n @SP \n M = M + 1 \n")

def pushTo (outFile): #push item addressed by D
    outFile.write("\n//push value addressed by D to stack\n")
    outFile.write("A=D \n D=M \n @SP \n A = M \n M=D \n @SP \n M = M + 1 \n")

def pop (outFile): #just pop to D 
    outFile.write("\n//pop stack to D\n")
    outFile.write("@SP \n AM = M -1 \n D = M \n")
    
def popTo (outFile): #pop to address in D
    outFile.write("\n//pop stack to address in D\n")
    outFile.write("@R13 \n M=D \n @SP \n AM = M -1 \n D = M \n @R13 \n A=M \n M = D \n")

def transform (segment):
    dict = {'argument':'ARG', 'this':'THIS', 'that':'THAT', 'local':'LCL'}
    return dict.get(segment)

def compTransform (comp):
    dict = {'gt':'JGT', 'eq':'JEQ', 'lt':'JLT'}
    return dict.get(comp)

def memoryOut(command, segment, index, outFile, className):
    lineOut = ""
    print ("command is " + command + " segment is " + segment + " index is " + index)   
    if (segment=="constant"): #handle differently for a constant
        outFile.write("\n//referencing constant\n")
        outFile.write("@%s \n D=A \n" %index) #put the constant in D
        push(outFile) #push D
        return
    elif (segment=="static"):   
        if (command=="push"):
            outFile.write("\n //referencing static \n")
            outFile.write("@%s.%s \n D=M \n"%(className, index))
            outFile.write("\n //pushing static \n")
            outFile.write("@SP \n A=M \n M=D \n @SP \n M=M+1 ")
        elif (command=="pop"):
            outFile.write("\n //popping \n")
            outFile.write("@SP \n M=M-1 \n A=M \n D=M \n")
            outFile.write("\n //putting D in static \n")
            outFile.write("@%s.%s \n M=D \n"%(className, index))
        return
    elif (segment =="this" or segment=="that" or segment == "argument" or segment=="local"):
        segment=transform(segment) #fix the formatting
        outFile.write("\n//referencing %s \n" %segment)
        outFile.write("@%s \n D = A \n @%s \n D = M + D \n "% (index, segment)) #go to the right segment and then offset by index and put value in D
        if (command=="push"):
            pushTo(outFile) #push D
        elif (command=="pop"):
            popTo(outFile) #pop to address in D
    elif (segment=="pointer"):
        
        if (command=="push"):
            outFile.write("\n//moving pointer\n")
            outFile.write("\n @THIS \n")
            if (index=="1"):
                outFile.write("A=A+1 \n")
            outFile.write("D=M \n")
            push(outFile)
        else:
            pop(outFile)
            outFile.write("\n//moving pointer\n")
            outFile.write("@THIS \n")
            if (index=="1"):
                outFile.write("A=A+1 \n")
            outFile.write("M=D \n")    
    else:
        outFile.write("\n//referencing temp\n")
        outFile.write("@%s \n D = A \n"% str(5 + int(index))) #offset temp by index and put in D
        if (command=="push"):
            pushTo(outFile) #push D
        elif (command=="pop"):
            popTo(outFile) #pop to address in D
        
def addAndOr(outFile, operator):
    pop(outFile)
    outFile.write("\n//using this operator: %s\n" %operator) #so assume we just popped the other value to D
    outFile.write("@SP \n A=M-1 \n M = M%sD \n "%operator)
    
def negNot(outFile, operator):    
    outFile.write("\n//negate or not \n") #so assume we just popped the other value to D
    outFile.write("@SP \n A=M-1 \n M=%sM \n"%operator)
    
def labelOut(labelName, outFile):
    outFile.write("\n//writing label\n")
    outFile.write("(%s) \n" %(labelName.capitalize()))

def gotoLabel(labelName, outFile):
    outFile.write("\n//unconditional goto label\n")
    outFile.write("@%s \n" %(labelName.capitalize()))
    outFile.write("D;JMP \n")
    
def gotoLabelIf(labelName, outFile):
    outFile.write("\n//conditional goto label\n")
    pop(outFile) #put the top of stack in D
    outFile.write("@%s \n" %(labelName.capitalize()))
    outFile.write("D;JNE \n")
    
def returnFunction(numArgs, funcName, outFile):
    outFile.write("\n//returning from %s\n"%funcName)
    outFile.write("\n//put frame in R13 \n")
    outFile.write("@LCL \n D=M \n @R13 \n M=D \n")
    outFile.write("\n//put return in R14\n")
    outFile.write("@5 \n D=D-A \n A=D \n D=M \n @R14 \n M=D \n")
    
    pop(outFile)
    outFile.write("@ARG \n A=M \n M=D \n")
    outFile.write("@ARG \n D=M+1 \n @SP \n M =D \n")
    
    outFile.write("\n//restore segments\n")
    outFile.write("@R13 \n M=M-1 \n A=M \n D=M \n @THAT \n M=D \n")
    outFile.write("@R13 \n M=M-1 \n A=M \n D=M \n @THIS \n M=D \n")
    outFile.write("@R13 \n M=M-1 \n A=M \n D=M \n @ARG \n M=D \n")
    outFile.write("@R13 \n M=M-1 \n A=M \n D=M \n @LCL \n M=D \n")
    outFile.write("@R14 \n A=M \n")
    
    outFile.write("\n//jump to return address\n")
    outFile.write("0;JMP \n ")
    
def callFunction(funcName, numArgs, outFile):
    outFile.write("\n //calling function, store state \n")
    outFile.write("@%s.RETURNADDRESS \n"%funcName.capitalize())
    outFile.write("D=A \n")
    push(outFile)
    outFile.write("\n //put LCL on stack \n")
    outFile.write("@LCL \n D=M \n")
    push(outFile)
    outFile.write("\n //put ARG on stack \n")
    outFile.write("@ARG \n D=M \n")
    push(outFile)
    outFile.write("\n //put THIS on stack \n")
    outFile.write("@THIS \n D=M \n")
    push(outFile)
    outFile.write("\n //put THAT on stack \n")
    outFile.write("@THAT \n D=M \n")
    push(outFile)
    outFile.write("\n //move ARG to first argument \n")
    outFile.write("@SP\n D=M \n @5 \n D=D-A \n @%s \n D=D-A \n @ARG \n M=D \n"%numArgs)
    outFile.write("\n //move LCL to SP \n")
    outFile.write("@SP \n D=M \n @LCL \n M=D\n")
    outFile.write("\n //transfer control \n")    
    outFile.write("@%s \n 0;JMP\n"%funcName.capitalize())
    outFile.write("(%s.RETURNADDRESS)\n"%funcName.capitalize())
    
def function (funcName, numLocal, className, outFile):
    outFile.write("\n //initializing function \n")
    outFile.write("(%s)\n"%(funcName.capitalize()))
    numLocal=int(numLocal)
    outFile.write("@0 \n D = A \n")
    while (numLocal>0):
        outFile.write("\n //adding a zero \n")
        push(outFile)
        numLocal = numLocal-1
            
def mathOut(command, arg1, arg2, outFile):
    global i
    if (command=="add"):  
       addAndOr(outFile, "+")
    elif (command=="and"):  
       addAndOr(outFile, "&")
    elif (command=="or"):  
       addAndOr(outFile, "|")
    elif (command=="sub"):
        addAndOr(outFile,"-")
    elif (command=="neg"):
        negNot(outFile, "-")
    elif (command=="not"):
        negNot(outFile, "!") 
    elif (command=="lt" or command=="eq" or command=="gt"):
        comp = compTransform(command) #pick a compare function
        pop(outFile)
        outFile.write("\n //comparing \n")
        #subtract them. now can compare. need to include some other identifier here because otherwise all the true labels look the same
        outFile.write("@R13 \n M=-1 \n @SP \n AM=M-1 \n D=M-D \n @TRUE%d \n D;%s \n @R13 \n M=M+1 \n (TRUE%d)\n @R13 \n D=M \n"%(i, comp,i))
        push(outFile)
        i = i + 1
        
def interpretFile(outFile, inFileName):
    #get to parsing
    className = inFileName.split(".")[0]
    if className.find("/")!=-1:
        className = className.split("/")[-1]
    with open(inFileName, 'r') as inFile:
        for line in inFile:
            line = (line.strip()).split("//")[0] #cleanup line
            if (line!=""):
                splitLine= line.split()
                command = splitLine[0]
                if (len(splitLine)>1):
                    arg1 = line.split()[1]
                else:
                    arg1 = ""
                if (len(splitLine)>2):
                    arg2 = line.split()[2]  
                else:
                    arg2 = ""
                if (command.strip()=="push" or command.strip()=="pop"):
                    memoryOut(command, arg1, arg2, outFile, className)
                elif (command=="label"):
                    labelOut(arg1, outFile)
                elif (command=="call"):
                    callFunction(arg1, arg2, outFile)
                elif (command=="function"):
                    function(arg1, arg2, className, outFile)
                elif (command=="goto"):
                    gotoLabel(arg1, outFile)
                elif (command=="if-goto"):
                    gotoLabelIf(arg1, outFile)
                elif (command=="return"):
                    returnFunction(arg1, className, outFile)
                else:
                    mathOut(command, arg1, arg2, outFile)             
       

def bootStrap(outFile):
    #check if needed and then bootstrap
    
    outFile.write("\n//Bootstrap code\n")
    outFile.write("@256 \n D=A \n @SP \n M=D\n")
    callFunction("Sys.init", "0", outFile)
    outFile.write("(BOOTLOOP) \n @BOOTLOOP \n 0;JMP \n")
    
                        
if __name__ == '__main__':
    i= 0 
    if (len(sys.argv) < 2):
        print ("Please pass the name of a .vm file or directory")
    else:
        arg = sys.argv[1]
        #handle filenames
        if (arg.find(".vm") == -1):
            outFileName = arg + ".asm"
            outFile = open(outFileName, 'w')
            with open("./"+arg+"/Sys.vm", 'r') as inFile:
                for line in inFile:
                    if "Sys.init" in line:
                        bootStrap(outFile)
            for file in os.listdir("./"+arg):
                filePath = os.path.join(arg, file)
                if (filePath.find(".vm") != -1):
                    interpretFile(outFile, filePath)
        else:
            outFileName= arg.split(".")[0] + ".asm"
            outFile = open(outFileName, 'w')
            with open(arg, 'r') as inFile:
                for line in inFile:
                    if "Sys.init" in line:
                        bootStrap(outFile)
            interpretFile(outFile, arg)
