import csv

'''a = open("all_Pokemon_stats_gen1.csv","r")
b = csv.reader(a)

pokes = []
pokemons = []
pokemon = []
pokemonList = ""

for row in b:
    pokes.append(row)
    pokemons.append([row[2],row[3],row[4],row[5],row[7],row[6]])
    pokemon.append("Poke " + row[2] + " = new Poke(" + "\"" + row[2] + "\"," + "insert type1,insert type2,"+row[3]+","+row[4]+","+row[5]+","+row[7]+","+row[6]+",insert level);")
    pokemonList += "Poke " + row[2] + " = new Poke(" + "\"" + row[2] + "\"," + "insert type1,insert type2,"+row[3]+","+row[4]+","+row[5]+","+row[7]+","+row[6]+",insert level);\n"
    print "Pokemons.add(new " + row[2] + "());"
a.close()'''

#Poke Charmander = new Poke("Charmander","Fire",39,52,43,50,65,5);

#print pokes
#print pokemon
#print pokemonList

    
n = open("all_Moves_uptogen1.csv", "r")
o = csv.reader(n)

listy = []

print o
for row in o:
    listy.append(row)
    power = 0
    if row[6] != "*":
        power = row[6]
    accuracy = 1
    if row[15] != "*":
        accuracy = row[15]
    Acc = str(accuracy)
    Pow = str(power)
    twochance = row[13]
    if twochance == "":
        twochance = 0
    if row[0] != "":
        print "Attack " + row[1]+ " = new Attack(" + "\"" + row[1] + "\"," + Pow + ",\"" + row[2] + "\",\"" + row[3] + "\"," + Acc + "," + row[5] + ",\"" + row[9] + "\"," + row[10] + ",\"" + row[11] + "\",\"" + row[12] + "\"," + str(twochance) + ",\"" + row[14] + "\");"

#print listy
n.close()
