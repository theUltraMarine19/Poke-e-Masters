if __name__ == '__main__':
	with open('otp2','r') as f:
		for line in f:
			line = line[1:len(line)-2]
			line = line.split(", ")
			if line[1] != "\'null\'" and len(line)==4 and line[3] != "\'use-item\')" and line[3] != "\'trade\')":
				level = line[2][1:len(line[2])-1]
				if level == "None":
					level = 20
				print("update pokemon set evolveintoid="+line[1][1:]+",minevolvelevel="+str(level)+" where pid="+line[0]+";")