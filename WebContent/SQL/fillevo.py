f2 = open('otp1', 'r')
lic = f2.readlines()
newlic = []
for i in range(len(lic)):
	line = lic[i]
	if (line.find("==") > -1):
		continue
	line = line.strip()
	
	numpoke = line.split("|")
	newline = [[] for iter in range(len(numpoke)-1)]
	for k in range(len(numpoke)-1):
		tokens = numpoke[k].strip().split(" ")
		newline[k].append(tokens[0])
	# nextline = lic[i+1].strip()
		if (i == len(lic) - 1 or lic[i+1].strip().split(" ")[0] == "" or lic[i+1].find("==") > -1):
			newline[k].append("null")
		else:
			numevo = lic[i+1].strip().split("|")
			for j in range(len(numevo)-1):
				newtokens = numevo[j].strip().split(" ")
				tup = (newtokens[0], newtokens[3], newtokens[1])
				newline[k].append(tup)

		newlic.append(newline[k])

f2.close()

f1 = open('pokemon.sql', 'r')
li = f1.readlines()
newli = []
for j in range(len(li)):
	line = li[j].strip().split(" ")
	index = line[5]
	# print(index)
	for item in newlic:
		# print(item[0])
		if (index.find(str(item[0])) > -1):
			newline = " ".join(line[:-1])
			# print(len(item[1]))
			if (len(item[1]) == 4):
				newline += " , "
				newline += "0"
				newline += " , '"
				newline += "null"
				newline += "' , '"
				newline += "null"
				newline += "' );\n" 
			else:
				newline += " , "
				newline += item[1][1]
				newline += " , '"
				newline += item[1][0]
				newline += "' , '"
				newline += item[1][2]
				newline += "' );\n"

	newli.append(newline)
f1.close()
f3 = open("pokemon_with_evolve.sql", "w")
for item in newli:
	# print(item)
	f3.write(item)

f3.close()




