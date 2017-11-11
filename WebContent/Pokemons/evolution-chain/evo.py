import json

for i in range(208,209):
	with open (str(i+1), 'r') as f:
		data = f.readlines();
		unparsed_json = data[0]
		parsed_json = json.loads(unparsed_json)
		pokedex = json.loads(json.dumps(parsed_json))
		x = pokedex["chain"]["species"]["url"]
		print(i)