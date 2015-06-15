import lxml.etree as ET
import re, sys, os, string
from project11 import *
subSymbols = {}
classSymbols = {}
tableIndex = 0
classes= ["Output","String","Screen","Keyboard","Array","Sys","Memory","Math"]

def fieldCounter():
    count = 0
    for item in classSymbols:
        if len(classSymbols[item]) > 1:
            if classSymbols[item][1]=="field":
                count = count + 1
    return str(count)

def varCounter():
    count = 0
    for item in subSymbols:
        if len(subSymbols[item]) > 1:
            if subSymbols[item][1]=="var":
                count = count + 1
    return str(count)
#return the info about symbols
def symbolLookup(symbolName):
    if symbolName in subSymbols:
        return subSymbols[symbolName]
    elif symbolName in classSymbols:
        return classSymbols[symbolName]
    elif symbolName in classes:
        return (symbolName,"type","kind")
    else:
        return ("sub","type","kind")
    
    
def writeIdTable(root, definition, usage):
    identifierInfo = ET.SubElement(root, usage)
    identifierInfo1 = ET.SubElement(root, definition[0])
    identifierInfo2 = ET.SubElement(root, definition[1])
    identifierInfo3 = ET.SubElement(root, "index")
    identifierInfo3.text = str(definition[2])
    identifierInfo4 = ET.SubElement(root, "fieldCount")
    identifierInfo4.text = fieldCounter()
    
def parseStatements(root, tokenTree, i): 
    child = tokenTree[i]
    statements = ET.SubElement(root, "statements")
    while (child.text!= "}"): #walk down recursively until we hit a closing curly brace
        if (child.text=="let"):
            i = parseLet(statements, tokenTree, i)
        elif (child.text=="do"):
           i = parseDo(statements , tokenTree, i)
        elif (child.text=="if"):
            i= parseIfWhileStatement(statements , tokenTree, i, "if")
        elif (child.text=="while"):
            i= parseIfWhileStatement(statements , tokenTree, i, "while")
        elif (child.text=="return"):
            i=parseReturn(statements , tokenTree, i)
        else:
            i = i + 1
        child = tokenTree[i]
    return i
    
def parseIfWhileStatement (root, tokenTree, i, type): #take the usual root, list of tokens, and position, but additionally a type "if" or "while"
    whileState = ET.SubElement(root, "%sStatement"%type)
    child = tokenTree[i]
    whileState.append(tokenTree[i])
    i = i + 1
    whileState.append(tokenTree[i])
    i = i + 1
    i=parseExpression(whileState, tokenTree, i)
    whileState.append(tokenTree[i])
    i = i + 1
    whileState.append(tokenTree[i])
    i = i + 1
    i = parseStatements(whileState, tokenTree, i)
    whileState.append(tokenTree[i])
    i = i + 1
    return i

def parseDo(root, tokenTree, i): #print evrything up to a list of expressions, indicated by open parens
    child = tokenTree[i]
    do = ET.SubElement(root, "doStatement")
    while (child.text!= "("):
        if (child.tag=="identifier"):
            if len(tokenTree[i-2])>1 and tokenTree[i-2][2].tag=="var" and tokenTree[i-1].text==".":
                writeIdTable(child, ("method","method","method"), "use")
            else:
                writeIdTable(child, symbolLookup(child.text), "use")
        do.append(tokenTree[i])
        i = i + 1
        child = tokenTree[i]
    do.append(tokenTree[i])
    i = i + 1
    i = handleExpressionList(do, tokenTree, i)
    do.append(tokenTree[i])
    i = i + 1
    do.append(tokenTree[i]) #print paraenthesis and semicolon
    i = i + 1
    return i

def parseLet(root, tokenTree, i): #parse let, handle expression if we hit [
    let = ET.SubElement(root, "letStatement")
    child = tokenTree[i]
    let.append(tokenTree[i])
    i = i + 1
    if (tokenTree[i].tag=="identifier"):
        writeIdTable(tokenTree[i], symbolLookup(tokenTree[i].text), "use")
    let.append(tokenTree[i])
    i = i + 1
    if (tokenTree[i].text=="["):
        let.append(tokenTree[i])
        i = i + 1
        i = parseExpression(let, tokenTree, i)
        let.append(tokenTree[i])
        i = i + 1
    let.append(tokenTree[i]) #this should be the = sign either way
    i = i + 1
    i = parseExpression(let, tokenTree, i)
    let.append(tokenTree[i])
    i = i + 1
    return i

def parseTerm(root, tokenTree, i): #this is sort of a mess, there's probably an easier way to handle terms. I ran out of time
    term = ET.SubElement(root, "term")
    child = tokenTree[i]
    if (child.text=="~"):
        term.append(tokenTree[i])
        i = i + 1
        i = parseTerm(term, tokenTree, i)
    elif (child.text in ["[","("]):
            term.append(tokenTree[i])
            i = i + 1
            child = tokenTree[i]
            i = parseExpression(term, tokenTree, i)
            term.append(tokenTree[i])
            i = i + 1
    else:
        if child.tag == "identifier":
            print child.text
            if child.text in subSymbols:
                writeIdTable(child, subSymbols[child.text], "use") #check if in local scope first
            elif child.text in classSymbols:
                writeIdTable(child, classSymbols[child.text], "use")
            else:
                ET.SubElement(child, "sub")
                ET.SubElement(child, child.text)
                ET.SubElement(child, "sub3")

        term.append(tokenTree[i])
        i = i + 1
        child = tokenTree[i]
        if (child.text in ["[","("]):
            term.append(tokenTree[i])
            i = i + 1
            child = tokenTree[i]
            i = parseExpression(term, tokenTree, i)
            term.append(tokenTree[i])
            i = i + 1
        elif (child.text=="."):
            term.append(tokenTree[i])
            i = i + 1
            term.append(tokenTree[i])
            i = i + 1
            term.append(tokenTree[i])
            i = i + 1
            child = tokenTree[i]
            i = handleExpressionList(term, tokenTree, i)
            term.append(tokenTree[i])
            i = i + 1  
    return i

def parseExpression(root, tokenTree, i): 
    child = tokenTree[i]
    expression = ET.SubElement(root, "expression")
    operators = ["+", "-", "*", "/", "<", ">", "&","="]
    while ((child.text!=")") and (child.text!=";") and (child.text!=",") and (child.text!="]") and (child.text!="[")):
        if (child.text in operators):
            expression.append(tokenTree[i])
            i = i + 1
            child = tokenTree[i]
        else:
            i = parseTerm(expression, tokenTree, i)
            child = tokenTree[i]
    root.append(tokenTree[i])
    return i

def parseReturn(root, tokenTree, i): 
    ret = ET.SubElement(root, "returnStatement")
    ret.append(tokenTree[i])
    i = i + 1
    child = tokenTree[i]
    if child.text!=";":
        i = parseExpression(ret, tokenTree, i)
        i = i + 1
    ret.append(tokenTree[i])
    return i

def handleClass(tokenTree, i): #classes should just be made up of fields, methods, and constructors. this handles those
    global classes
    global classSymbols
    classSymbols = {}
    root = ET.Element("class")
    root.append(tokenTree[i])
    i = i + 1
    classes.append(tokenTree[i].text)
    root.append(tokenTree[i]) #add symbol and class name
    i = i + 1
    root.append(tokenTree[i])
    i = i + 1
    child = tokenTree[i]  

    while (child.text!= "}"): #walk down recursively until we hit a closing curly brace
        if (child.text=="field" or child.text=="static"):
            i = handleClassVarDec(root, tokenTree, i)
        elif (child.text=="method" or child.text=="constructor" or child.text=="function"):
            i = handleSubroutine(root, tokenTree, i)
        else:
            i=i+1
        child = tokenTree[i]
    root.append(tokenTree[i])
    return root
     

def handleClassVarDec(root, tokenTree, i):
    global tableIndex
    varDec = ET.SubElement(root, "classVarDec")
    child = tokenTree[i]
    while (child.text== "field" or child.text=="static"):
        staticOrField = child.text
        type = tokenTree[i+1].text
        varDec.append(tokenTree[i])
        i = i + 1
        varDec.append(tokenTree[i])
        i = i + 1
        child = tokenTree[i]
        print "loop1"
        while (child.text != ";"):
            if (child.text!=","):
                classSymbols[tokenTree[i].text] = (type, "field", tableIndex)
                writeIdTable(child, classSymbols[child.text], "def")
                tableIndex = tableIndex + 1 
                varDec.append(tokenTree[i])
                i = i + 1
                child = tokenTree[i]
            else:
                varDec.append(tokenTree[i])
                i = i + 1
                child = tokenTree[i]
            print "loop2"
        varDec.append(tokenTree[i])
        i=i+1
    return i

def handleVarDec(root, tokenTree, i):
    global tableIndex
    varDec = ET.SubElement(root, "varDec")
    child = tokenTree[i]
    kind = "kind"
    while (child.text!= ";"):
        if (child.tag=="identifier" and child.text in classes):
            kind = child.text
        if (child.tag=="identifier" and child.text not in classes):
            subSymbols[tokenTree[i].text] = (kind, "var", tableIndex)
            writeIdTable(tokenTree[i], subSymbols[tokenTree[i].text], "def")
            tableIndex = tableIndex + 1 
        varDec.append(tokenTree[i])
        i = i + 1
        child = tokenTree[i]
    varDec.append(tokenTree[i])
    i=i+1
    return i
     
def handleSubroutine(root, tokenTree, i):
    global subSymbols, tableIndex
    subSymbols = {}
    tableIndex = 0
    subDec = ET.SubElement(root, "subroutineDec")
    
    classSymbols[(tokenTree[i+2].text)] = (tokenTree[i].text, tokenTree[i].text, tokenTree[i].text)
    writeIdTable(tokenTree[i+2], classSymbols[tokenTree[i+2].text], "def")
    subDec.append(tokenTree[i])
    i = i + 1
    subDec.append(tokenTree[i])
    i = i + 1
    subDec.append(tokenTree[i])
    i = i + 1
    subDec.append(tokenTree[i])
    i = i + 1
    i = handleParameterList(subDec, tokenTree, i)
    subDec.append(tokenTree[i]) #print closing paranthesis
    i = i + 1
    
    subBody = ET.SubElement(subDec, "subroutineBody")
    subBody.append(tokenTree[i]) #opening curly bracket
    i = i + 1
    child = tokenTree[i]
    while (child.text=="var"):
        i = handleVarDec(subBody, tokenTree, i)
        child = tokenTree[i]
    i = parseStatements(subBody, tokenTree, i)
    varCount = ET.SubElement(subBody, "VARCOUNT")
    varCount.text= varCounter()
    subBody.append(tokenTree[i]) #print closing bracket
    i = i + 1
    return i

def handleParameterList(root, tokenTree, i):
    global tableIndex
    paramList = ET.SubElement(root, "parameterList")
    child = tokenTree[i]
    if (child.text== ")"):
        paramList.text="\n"
    while (child.text!= ")"): #add stuff until we hit a closing parenthesis
        if tokenTree[i+2].text=="," or tokenTree[i+2].text==")":
            subSymbols[tokenTree[i+1].text] = ((tokenTree[i].text), "argument", tableIndex)
            tableIndex = tableIndex + 1 
        paramList.append(tokenTree[i])
        i = i + 1
        child = tokenTree[i]
    return i

def handleExpressionList(root, tokenTree, i):
    expList = ET.SubElement(root, "expressionList")
    child = tokenTree[i]
    if (child.text== ")"):
        expList.text="\n"
    while (child.text!= ")"): #add stuff until we hit a closing parenthesis
        if (child.text==","):
            expList.append(tokenTree[i])
            i = i + 1
            child = tokenTree[i]
        else:
            i=parseExpression(expList, tokenTree, i)
            child = tokenTree[i]
    return i

def parseFile (tokenTree, inFileName):
    i = 0
    tokenTree = tokenTree.getroot()
    tokenTree= list(tokenTree)
    if (tokenTree[i].text=="class"):
        parsedTree = handleClass(tokenTree, i)
    else:
        print ("Need a class")
        return
    parsedTree = ET.ElementTree(parsedTree)
    return parsedTree
    

def tokenFile (inFileName):
    
    tokens = ET.Element("tokens")
    itemList = []
    symbols = (";", "{", "}","&","~","-", "=",".","+", ",", ">", "<","(", ")", "*", "/","\"","[","]")
    keyword = ("class","constructor","function","method","field","static","var","int","char","boolean","void","true","false","null","this","let","do","if","else","while","return")
    splitters = '(' + '\/\*|\*\/|' + " " +'|\s|'+ '|\\'.join(symbols) + ')'
    splitters = re.compile(splitters)
    with open(inFileName, 'r') as inFile:
        for line in inFile:
            line = line.split("//")[0] #ignore everything to the right of the single line comment signs
            #print ('line' + line)
            for word in re.split(splitters, line):
                word = word.strip()
                if ((word)!=""):
                    itemList.append(word)
        i = 0
        while (i < len(itemList)):
            if itemList[i] == "\"":  # string constant, need to find the end and append everything in the middle
                stringConstant = ""
                i = i + 1
                while (itemList[i] != "\""):
                    stringConstant = stringConstant + " " + itemList[i] # this actually won't work for special characters
                    i = i + 1
                ET.SubElement(tokens, "stringConstant").text = stringConstant
            elif (itemList[i]=="/*"):  # multiline comment, need to find the end
                while (itemList[i] != "*/"):
                    i = i + 1          
            elif itemList[i] in symbols:
                ET.SubElement(tokens, "symbol").text = itemList[i]
            elif itemList[i] in keyword:
                ET.SubElement(tokens, "keyword").text = itemList[i]
            elif itemList[i].isdigit():  # int constant
                ET.SubElement(tokens, "integerConstant").text = itemList[i]
            else:  # rule everything else out, must be an identifier
                ET.SubElement(tokens, "identifier").text = itemList[i]                    
            i = i + 1
    xmlTree = ET.ElementTree(tokens)
    return xmlTree
                       
