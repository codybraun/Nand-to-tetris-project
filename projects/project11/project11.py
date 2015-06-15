from project10 import *
import math
vmOutfile = None
curClass = None

def writeReturn(token):
    global curLabel
    #if (token.getparent().getparent().getparent()[0].text=="constructor"):
     #   vmOutFile.write("push pointer 0\n") #return resulting object i constructor
    if len(token.findall("expression"))!=0:
        writeExpression(token.find("expression"))
    else: # this is void, just throw some junk on the stack to get popped off later
        vmOutFile.write("push constant 1 \n")
    vmOutFile.write("return \n\n")

def writeWhile(token, curLabel):
    writeExpression(token.find("expression"))
    vmOutFile.write("label GOWHILE%d \n" %curLabel)
    vmOutFile.write("if-goto GOIFTRUE%d \n" %curLabel)
    vmOutFile.write("goto GOIFFALSE%d \n" %curLabel)
    vmOutFile.write("label GOIFTRUE%d \n" %curLabel)
    parseStatements(token.find("statements"), curLabel)
    vmOutFile.write("goto GOWHILE%d \n" %curLabel)
    vmOutFile.write("label GOIFFALSE%d \n" %curLabel)
    curLabel = curLabel + 1

def writeIf(token, curLabel):
    writeExpression(token.find("expression"))
    vmOutFile.write("if-goto GOIFTRUE%d \n" %curLabel)
    vmOutFile.write("goto GOIFFALSE%d \n" %curLabel)
    vmOutFile.write("label GOIFTRUE%d \n" %curLabel)
    parseStatements(token.find("statements"), curLabel)
    vmOutFile.write("label GOIFFALSE%d \n" %curLabel)
    curLabel = curLabel + 1
    
def writeFunc(token, type):
    if type=="method":
        vmOutFile.write("function %s.%s %s \n"%(curClass, token[2].text, token.find("subroutineBody").find("VARCOUNT").text))
        vmOutFile.write("push argument 0 \npop pointer 0 \n")
    else:
        vmOutFile.write("function %s.%s %s \n"%(curClass, token[2].text, token.find("subroutineBody").find("VARCOUNT").text))
    parseBody(token.find("subroutineBody"))
    
def writeConstructor(token):
    curLabel=0
    vmOutFile.write("function %s.%s %d \n"%(curClass, token[2].text, math.ceil(len(token.find("parameterList")))%3))
    vmOutFile.write("push constant %s \n" % token[2][4].text)
    vmOutFile.write("call Memory.alloc 1 \n")
    vmOutFile.write("pop pointer 0\n")
    for subToken in token.find("subroutineBody"):
        parseStatements(subToken, curLabel)
    
def writeInt(token):
    vmOutFile.write("push constant %s \n" %token.text)
    
def writeDo(token):
    for exp in token.find("expressionList"):
        writeExpression(exp)
    if len(token.findall("identifier"))==1:
        vmOutFile.write("push pointer 0\n") #need to keep track of object
        vmOutFile.write("call %s.%s %s \n" %(curClass, token.find("identifier").text, len(token.find("expressionList").findall("expression"))+1))
    else:  
        vmOutFile.write("call %s.%s %s \n" %(token.findall("identifier")[0][1].tag, token.findall("identifier")[1].text, len((token.find("expressionList").findall("expression")))))
    
def writeLet(token):
    writeExpression(token.find("expression"))
    writePopTo(token[1])
    
def writeTerm(term):
    for token in term:
        if (token.tag=="identifier"):
            print "ID"
            ET.dump(token)
            if len(token) == 0:
                writeDo(term)
            else:
                writePushTo(token)
        elif (token.tag=="expression"):
            writeExpression(token)
        elif (token.tag=="integerConstant"):
            writeInt(token)
        elif (token.text=="this"):
            vmOutFile.write("push pointer 0 \n")
        elif (token.text=="true"):
            vmOutFile.write("push constant 0 \nnot \n")
        elif (token.text=="false"):
            vmOutFile.write("push constant 0\n")
def parseSubtoken(subToken):
    if (subToken.tag == "subroutineBody"):
        parseBody(subToken)
        
def parseBody(subToken):
    
    for token in subToken:
        if token.tag == "statements":
            curLabel=0
            parseStatements(token, curLabel)
            
def parseStatements(token, curLabel):
    for subToken in token:
        if subToken.tag == "ifStatement":
            writeIf(subToken, curLabel)
        elif subToken.tag == "doStatement":    
            writeDo(subToken)
            vmOutFile.write("pop temp 1\n") #put the extra argument aside
        elif subToken.tag == "whileStatement":    
            writeWhile(subToken, curLabel)
        elif subToken.tag == "returnStatement":  
            writeReturn(subToken)
        elif subToken.tag == "letStatement":  
            writeLet(subToken)
            
def writeExpression(token):
    if token != None:
        for term in token.findall("term"):
            writeTerm(term)
        if len(token.findall("term"))==1:
            for symbol in token.findall("symbol"):
                writeUnary(symbol)    
        else:
            for symbol in token.findall("symbol"):
                writeArithmetic(symbol)
            
def writePopTo(var):

    if ( var[2].tag=="field"):
        vmOutFile.write("pop this %s \n" %var[3].text)
    elif (var[2].tag=="static"):
        vmOutFile.write("pop static %s \n" %var[3].text)
    elif (var[2].tag=="argument"):
        vmOutFile.write("pop argument %s \n" %var[3].text)
    elif (var[2].tag=="var"):
        vmOutFile.write("pop local %s \n" %var[3].text)
    
def writePushTo(var):
    if (var[2].tag=="field"):
        vmOutFile.write("push this %s \n" %var[3].text)
    elif (var[2].tag=="static"):
        vmOutFile.write("push static %s \n" %var[3].text)
    elif (var[2].tag=="argument"):
        vmOutFile.write("push argument %s \n" %var[3].text)
    elif (var[2].tag=="var"):
        vmOutFile.write("push local %s \n" %var[3].text)
    
def writePop(seg, index):
    vmOutFile.write("pop %s %d \n" %(seg, index))
    
def writePush(seg, index):
    vmOutFile.write("push %s %d \n" %(seg, index))
    
def writeArithmetic (oper):
    if oper.text=="+":
        vmOutFile.write("add \n")
    if oper.text=="*":
        vmOutFile.write("call Math.multiply 2 \n")
    elif oper.text=="-":
        vmOutFile.write("sub \n")
    elif oper.text=="<":
        vmOutFile.write("lt \n")
    elif oper.text==">":
        vmOutFile.write("gt \n")    
    elif oper.text=="&":
        vmOutFile.write("and \n")  
    elif oper.text=="=":
        vmOutFile.write("eq \n")  
        
def writeUnary(oper):
    if oper.text=="~":
        vmOutFile.write("not \n")
    elif oper.text=="-":
        vmOutFile.write("neg \n")        
        
def compile (parsedTree):
    parsedTree = parsedTree.getroot()
    i=0
    for token in parsedTree:
        if (token.tag=="subroutineDec"):
            if (token[0].text=="constructor"):
                writeConstructor(token)
            else:
                writeFunc(token, token[0].text)
    vmOutFile.close()
    #ET.dump(parsedTree)
    
if __name__ == '__main__':
    global vmOutFile
    if (len(sys.argv) < 2):
        print ("Please pass the name of a .jack file or directory")
    else:
        arg = sys.argv[1]
        #handle filenames
        if (arg.find(".jack") == -1):
            for file in os.listdir("./"+arg):
                filePath = os.path.join(arg, file)
                print "FP " + filePath
                if (filePath.find(".jack") != -1):
                    curClass = file.split(".")[0]
                    outFileName =  filePath.split(".")[0] + ".vm"
                    vmOutFile = open(outFileName, 'w')
                    tree = tokenFile(filePath)
                    parsedTree = parseFile(tree, filePath)
                    compile(parsedTree)
                    parsedTree = parsedTree.getroot()
                    ET.dump(parsedTree)
        else:
           
            curClass = arg.split(".")[0]
            outFileName =  curClass + ".vm"
            vmOutFile = open(outFileName, 'w')
            tree = tokenFile(arg)
            parsedTree = parseFile(tree, arg)
            compile(parsedTree)
            parsedTree = parsedTree.getroot()
            ET.dump(parsedTree)
            
            
    print subSymbols
    print classSymbols
    print classes