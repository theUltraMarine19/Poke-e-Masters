import sys
import json
fname = sys.argv[1]

def printx(arg):
	print(arg, end="")

def func(x,ctr):
	y = x["evolves_to"]
	tokens = x["species"]["url"].split("/")
	spacli = ["-"]*ctr
	if (ctr!=0):
		# print(x["evolution_details"][0]["min_level"], x["evolution_details"][0]["trigger"]["name"], "-".join(spacli), x["species"]["name"], tokens[len(tokens)-2])
		print(tokens[len(tokens)-2], x["evolution_details"][0]["trigger"]["name"], "-".join(spacli), x["evolution_details"][0]["min_level"], end="")
		printx(" | ")
	else:
		# print("-".join(spacli), x["species"]["name"], tokens[len(tokens)-2])
		print("-".join(spacli), tokens[len(tokens)-2], end="")
		printx(" | ")
	if (len(y) == 0):
		return
	ctr += 1
	printx("\n")
	for i in range(len(y)):
		func(y[i],ctr)

with open(fname, 'r') as f:
	li = f.read().splitlines()
	if (len(li) != 0):
		unparsed_json = li[0]
		parsed_json = json.loads(unparsed_json)
		pokedex = json.loads(json.dumps(parsed_json))
		z = pokedex["chain"]
		printx("\n")
		printx("=========================================")
		printx("\n")
		func(z,0)
		# x = pokedex["chain"]["species"]["url"]
		# y = pokedex["chain"]["evolves_to"]
		# tokens = x.split("/")
		# print(pokedex["chain"]["species"]["name"], tokens[len(tokens)-2])
		# while (len(y)!=0):
		# 	z2 = y
		# 	for i in range(len(z2)):
		# 		z1 = y[i]
		# 		z = z1["species"]["url"]
		# 		tokens = z.split("/")
		# 		print(z1["species"]["name"], tokens[len(tokens)-2])
		# 		y = z1["evolves_to"]