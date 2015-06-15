import sys, re, string

def assemble(fileN):
	#handle filenames	
	inFileName = sys.argv[1]
	outFileName = (inFileName.split(".")[0]) + ".hack"
	outFile = open(outFileName, 'w')
	#get to parsing
	with open(inFileName, 'r') as inFile:
		#preset addresses		
		i=0
		symbolTable = {}
		symbolTable['SP']= 0
		symbolTable['LCL']= 1
		symbolTable['ARG']= 2
		symbolTable['THIS']= 3
		symbolTable['THAT']= 4
		symbolTable['SCREEN']= 16384
		symbolTable['KBD']= 2457
		symbolTable['R0']= 0
		symbolTable['R1']= 1
		symbolTable['R2']= 2
		symbolTable['R3']= 3
		symbolTable['R4']= 4
		symbolTable['R5']= 5
		symbolTable['R6']= 6
		symbolTable['R7']= 7
		symbolTable['R8']= 8
		symbolTable['R9']= 9
		symbolTable['R10']= 10
		symbolTable['R11']= 11
		symbolTable['R12']= 12
		symbolTable['R13']= 13
		symbolTable['R14']= 14
		symbolTable['R15']= 15
		#first pass to replace labels
		for line in inFile:
			line = (line.strip()).split("//")[0]
			if (re.match("\(",line)!=None):
				line = (line.replace("(","")).replace(")","")
				if line in symbolTable:
					symbolTable[line]=symbolTable[line]+1				
				else:
					symbolTable[line] = i
			elif line != "":
				i = i +1
				
		inFile.seek(0)
		for line in inFile:
			line = (line.strip()).split("//")[0]
			if (line!=""):
				if re.match("@",line): #A instruction
					line = line.replace("@", "")
					if (line.isdigit()):
						binLine = "{0:015b}".format(int(line))
						outFile.write("0" + binLine + "\n")
					else:
						if line in symbolTable:
							binLine = "{0:015b}".format(int(symbolTable[line]))
							outFile.write("0" + binLine + "\n")
				elif re.match("\(",line): #label, skip it
					line = line
				else: #set up array
					bitArray = [1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0]
					#break up line
					if (len(line.split(";")) > 1):
						jump = (line.split(";")[1]).strip()
					else:
						jump = ""
					if (len(line.split("="))) > 1:
						dest = line.split("=")[0]
					else:
						dest = ""
					if (len(line.split("=")) > 1):
						comp = line.split("=")[1]
					else:
						comp=(line.split(";")[0]).strip()
					
					if (re.search('\+', comp) != None):
						operator = '+'
					elif (re.search('\|', comp) != None):
						operator = '|'
					elif (re.search('-', comp) != None):
						operator = '-'
					elif (re.search('!', comp) != None):
						operator = '!'
					elif (re.search('&', comp) != None):
						operator = '&'
					else:
						operator=""
						
					splitComp = re.split('[=+-]', comp)
					x = splitComp[0].strip()
					if (len(splitComp)>1):
						y = (splitComp[1]).strip()
					else:	
						y = ""
					
					if (x!="M" and y!="M"): #not using M, bit 3 is off
						if (x=="A" or x=="0" or x=="1" or (x=="" and y=="1") or (y=="A" and operator=="!") or (operator=="-" and y=="A")):
							bitArray[4] = 1
							
						if (x=="1" or (y=="1" and x != "D") or (x=="A" and y != "D") or (y=="A" and operator != "+" and operator != "&") or (x=="D" and y=="1" and operator == "+") or (x=="D" and y=="A" and operator != "+" and operator !="&")):
							bitArray[5] = 1
							
						if (x!="A" and y!="A"):
							bitArray[6] = 1
						
						if (((x=="D" or x=="1") and operator=="") or (y=="D" and (operator == "!" or operator=="-")) or (y=="1" and operator=="+") or (operator=="|") or (x=="D" and operator=="-" and y =="1")):
							bitArray[7] =1
							
						if not (operator == "&" or operator=="|" or operator=="!" or ((x=="D" or x=="A") and y == "")):
							bitArray[8] = 1 
							
						if ((x=="1" and operator=="") or (operator=="!") or (operator=="-" and (y=="D" or y=="A")) or (operator=="|") or ((x=="D" or x=="A") and operator=="+" and y=="1")):
							bitArray[9]=1
						else:
							bitArray[9]=0
							
					else: #using M, bit 3 on
						bitArray[3] = 1			
						
						if not (x=="D" or y=="D"):
							bitArray[4] = 1
						
						if not (operator =="&" or (x=="D" and operator=="+" and y=="M") or (x=="M" and operator=="-" and y=="D")):
							bitArray[5]=1
							
						bitArray[6] = 0
						
						if ((x=="M" and operator=="+" and y=="1") or (x=="M" and operator=="-" and y=="D") or operator=="|"):
							bitArray[7] = 1
						else:
							bitArray[7] = 0
							
						if (operator=="+" or operator=="-"):
							bitArray[8] = 1
						else:
							bitArray[8] = 0	
							
						if (operator=="!" or operator=="|" or (operator=="-" and y!="1") or (x=="M" and operator =="+" and y=="1")):
							bitArray[9] = 1		
					
					if (re.search('A',dest)!=None):
						bitArray[10] = 1
					if (re.search('D',dest)!=None):
						bitArray[11] = 1
					if (re.search('M',dest)!=None):
						bitArray[12] = 1	
						
					if (jump=='JGT'):
						bitArray[13]=0
						bitArray[14]=0
						bitArray[15]=1
					elif (jump=='JEQ'):
						bitArray[13]=0
						bitArray[14]=1
						bitArray[15]=0
					elif (jump=='JGE'):
						bitArray[13]=0
						bitArray[14]=1
						bitArray[15]=1
					elif (jump=='JLT'):
						bitArray[13]=1
						bitArray[14]=0
						bitArray[15]=0
					elif (jump=='JNE'):
						bitArray[13]=1
						bitArray[14]=0
						bitArray[15]=1
					elif (jump=='JLE'):
						bitArray[13]=1
						bitArray[14]=1
						bitArray[15]=0
					elif (jump=='JMP'):
						bitArray[13]=1
						bitArray[14]=1
						bitArray[15]=1
					for bit in bitArray:
						outFile.write(str(bit))
					outFile.write("\n")
	outFile.close()	
						
if __name__ == '__main__':
	if (len(sys.argv) < 2):
		print ("Please pass the name of an .asm file")
	else:
		assemble(sys.argv[1])
