import sys, re, string, os

i = 0
def push (outFile): #just assume value to push is in D
    outFile.write("\n//push D to stack\n")
    outFile.write("@SP \n A = M \n M=D \n @SP \n M = M + 1 \n")

def pushTo (outFile): #push item addressed by D
    outFile.write("\n//push value addressed by D to stack\n")
    outFile.write("A=D \n D=M \n A = D \n @SP \n A = M \n M=D \n @SP \n M = M + 1 \n")

def pop (outFile): #just pop to D 
    outFile.write("\n//pop stack to D\n")
    outFile.write("@SP \n AM = M -1 \n D = M \n")
    
def popTo (outFile): #pop to address in D
    outFile.write("\n//pop stack to address in D\n")
    outFile.write("@R13 \n M=D \n @SP \n AM = M -1 \n D = M \n @R13 \n A = M \n M = D \n")

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
        outFile.write("\n//referencing this, local, that, or args\n")
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
def interpretFile(fileN):
    #handle filenames    
    inFileName = fileN
    className = inFileName.split(".vm")[0]
    outFileName = (className) + ".asm"
    outFile = open(outFileName, 'w')
    #get to parsing

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
                else:
                    mathOut(command, arg1, arg2, outFile)             
    outFile.close()    
                        
if __name__ == '__main__':
    i= 0 
    if (len(sys.argv) < 2):
        print ("Please pass the name of an .asm file or directory")
    else:
        arg = sys.argv[1]
        if (arg.find(".vm") == -1):
            for file in os.listdir("./"+arg):
                filePath = os.path.join(arg, file)
                if (filePath.find(".vm") != -1):
                    interpretFile(filePath)
        else:
            interpretFile(arg)
