//some pokemon with body slam should have double-edge
//pokemon with low kick should have submission (and some with mega punch/kick)

class Bulbasaur extends Poke {
  Bulbasaur() {
    super("Bulbasaur",1,"Grass","Poison",45,49,49,65,45,100);
  }
}
class Ivysaur extends Poke {
  Ivysaur() {
    super("Ivysaur",2,"Grass","Poison",60,62,63,80,60,100);
  }
}
class Venusaur extends Poke {
  Venusaur() {
    super("Venusaur",3,"Grass","Poison",80,82,83,100,80,100);
    setAttacks(Swords_Dance,Razor_Leaf,Sleep_Powder,Body_Slam);
  }
}
class Charmander extends Poke {
  Charmander() {
    super("Charmander",4,"Fire",39,52,43,50,65,100);
  }
}
class Charmeleon extends Poke {
  Charmeleon() {
    super("Charmeleon",5,"Fire",58,64,58,65,80,100);
  }
}
class Charizard extends Poke {
  Charizard() {
    super("Charizard",6,"Fire","Flying",78,84,78,85,100,100);
    setAttacks(Fire_Blast,Body_Slam,Earthquake,Swords_Dance);
  }
}
class Squirtle extends Poke {
  Squirtle() {
    super("Squirtle",7,"Water",44,48,65,50,43,100);
  }
}
class Wartortle extends Poke {
  Wartortle() {
    super("Wartortle",8,"Water",59,63,80,65,58,100);
  }
}
class Blastoise extends Poke {
  Blastoise() {
    super("Blastoise",9,"Water",79,83,100,85,78,100);
    setAttacks(Surf,Blizzard,Earthquake,Ice_Beam);
  }
}
class Caterpie extends Poke {
  Caterpie() {
    super("Caterpie",10,"Bug",45,30,35,20,45,100);
  }
}
class Metapod extends Poke {
  Metapod() {
    super("Metapod",11,"Bug",50,20,55,25,30,100);
  }
}
class Butterfree extends Poke {
  Butterfree() {
    super("Butterfree",12,"Bug","Flying",60,45,50,80,70,100);
    setAttacks(Psychic,Mega_Drain,Sleep_Powder,Stun_Spore);
  }
}
class Weedle extends Poke {
  Weedle() {
    super("Weedle",13,"Bug","Poison",40,35,30,20,50,100);
  }
}
class Kakuna extends Poke {
  Kakuna() {
    super("Kakuna",14,"Bug","Poison",45,25,50,25,35,100);
  }
}
class Beedrill extends Poke {
  Beedrill() {
    super("Beedrill",15,"Bug","Poison",65,80,40,45,75,100);
    setAttacks(Twineedle,Hyper_Beam,Swords_Dance,Agility);
  }
}
class Pidgey extends Poke {
  Pidgey() {
    super("Pidgey",16,"Normal","Flying",40,45,40,35,56,100);
  }
}
class Pidgeotto extends Poke {
  Pidgeotto() {
    super("Pidgeotto",17,"Normal","Flying",63,60,55,50,71,100);
  }
}
class Pidgeot extends Poke {
  Pidgeot() {
    super("Pidgeot",18,"Normal","Flying",83,80,75,70,91,100);
    setAttacks(Body_Slam,Hyper_Beam,Agility,Wing_Attack);
  }
}
class Rattata extends Poke {
  Rattata() {
    super("Rattata",19,"Normal",30,56,35,25,72,100);
  }
}
class Raticate extends Poke {
  Raticate() {
    super("Raticate",20,"Normal",55,81,60,50,97,100);
    setAttacks(Body_Slam,Hyper_Beam,BubbleBeam,Hyper_Fang);
  }
}
class Spearow extends Poke {
  Spearow() {
    super("Spearow",21,"Normal","Flying",40,60,30,31,70,100);
  }
}
class Fearow extends Poke {
  Fearow() {
    super("Fearow",22,"Normal","Flying",65,90,65,61,100,100);
    setAttacks(Drill_Peck,Body_Slam,Hyper_Beam,Fury_Attack);
  }
}
class Ekans extends Poke {
  Ekans() {
    super("Ekans",23,"Poison",35,60,44,40,55,100);
  }
}
class Arbok extends Poke {
  Arbok() {
    super("Arbok",24,"Poison",60,85,69,65,80,100);
    setAttacks(Earthquake,Glare,Hyper_Beam,Rock_Slide);
  }
}
class Pikachu extends Poke {
  Pikachu() {
    super("Pikachu",25,"Electric",35,55,30,50,90,100);
  }
}
class Raichu extends Poke {
  Raichu() {
    super("Raichu",26,"Electric",60,90,55,90,100,100);
    setAttacks(Surf,Thunder_Wave,Body_Slam,Thunderbolt);
  }
}
class Sandshrew extends Poke {
  Sandshrew() {
    super("Sandshrew",27,"Ground",50,75,85,30,40,100);
  }
}
class Sandslash extends Poke {
  Sandslash() {
    super("Sandslash",28,"Ground",75,100,110,55,65,100);
    setAttacks(Earthquake,Swords_Dance,Hyper_Beam,Rock_Slide);
  }
}
class NidoranF extends Poke {
  NidoranF() {
    super("NidoranF",29,"Poison",55,47,52,40,41,100);
  }
}
class Nidorina extends Poke {
  Nidorina() {
    super("Nidorina",30,"Poison",70,62,67,55,56,100);
  }
}
class Nidoqueen extends Poke {
  Nidoqueen() {
    super("Nidoqueen",31,"Poison","Ground",90,82,87,75,76,100);
    setAttacks(Earthquake,Blizzard,Thunder,Body_Slam);
  }
}
class NidoranM extends Poke {
  NidoranM() {
    super("NidoranM",32,"Poison",46,57,40,40,50,100);
  }
}
class Nidorino extends Poke {
  Nidorino() {
    super("Nidorino",33,"Poison",61,72,57,55,65,100);
  }
}
class Nidoking extends Poke {
  Nidoking() {
    super("Nidoking",34,"Posion","Ground",81,92,77,75,85,100);
    setAttacks(Earthquake,Blizzard,Thunder,Body_Slam);
  }
}
class Clefairy extends Poke {
  Clefairy() {
    super("Clefairy",35,"Normal",70,45,48,60,35,100);
  }
}
class Clefable extends Poke {
  Clefable() {
    super("Clefable",36,"Normal",95,70,73,85,60,100);
    setAttacks(Blizzard,Thunder_Wave,Thunderbolt,Sing);
  }
}
class Vulpix extends Poke {
  Vulpix() {
    super("Vulpix",37,"Fire",38,41,40,65,65,100);
  }
}
class Ninetales extends Poke {
  Ninetales() {
    super("Ninetales",38,"Fire",73,76,75,100,100,100);
    setAttacks(Fire_Blast,Body_Slam,Hyper_Beam,Flamethrower);
    //confuse ray, fire spin for last 2
  }
}
class Jigglypuff extends Poke {
  Jigglypuff() {
    super("Jigglypuff",39,"Normal",115,45,20,25,20,100);
  }
}
class Wigglytuff extends Poke {
  Wigglytuff() {
    super("Wigglytuff",40,"Normal",140,70,45,50,45,100);
    setAttacks(Thunder,Body_Slam,Hyper_Beam,Blizzard);
  }
}
class Zubat extends Poke {
  Zubat() {
    super("Zubat",41,"Poison","Flying",40,45,35,40,55,100);
  }
}
class Golbat extends Poke {
  Golbat() {
    super("Golbat",42,"Poison","Flying",75,80,70,75,90,100);
    setAttacks(Screech,Hyper_Beam,Mega_Drain,Bite);
  }
}
class Oddish extends Poke {
  Oddish() {
    super("Oddish",43,"Poison","Flying",45,50,55,75,30,100);
  }
}
class Gloom extends Poke {
  Gloom() {
    super("Gloom",44,"Grass","Poison",60,65,70,85,40,100);
  }
}
class Vileplume extends Poke {
  Vileplume() {
    super("Vileplume",45,"Grass","Poison",75,80,85,100,50,100);
    setAttacks(Sleep_Powder,Swords_Dance,Body_Slam,Mega_Drain);
  }
}
class Paras extends Poke {
  Paras() {
    super("Paras",46,"Bug","Grass",35,70,55,55,25,100);
  }
}
class Parasect extends Poke {
  Parasect() {
    super("Parasect",47,"Bug","Grass",60,95,80,80,30,100);
    setAttacks(Spore,Body_Slam,Mega_Drain,Swords_Dance);
  }
}
class Venonat extends Poke {
  Venonat() {
    super("Venonat",48,"Bug","Poison",60,55,50,40,45,100);
  }
}
class Venomoth extends Poke {
  Venomoth() {
    super("Venomoth",49,"Bug","Poison",70,65,60,90,90,100);
    setAttacks(Psychic,Mega_Drain,Sleep_Powder,Stun_Spore);
  }
}
class Diglett extends Poke {
  Diglett() {
    super("Diglett",50,"Ground",10,55,25,45,95,100);
  }
}
class Dugtrio extends Poke {
  Dugtrio() {
    super("Dugtrio",51,"Ground",35,80,50,70,120,100);
    setAttacks(Earthquake,Slash,Sand_Attack,Rock_Slide);
  }
}
class Meowth extends Poke {
  Meowth() {
    super("Meowth",52,"Normal",40,45,35,40,90,100);
  }
}
class Persian extends Poke {
  Persian() {
    super("Persian",53,"Normal",65,70,60,65,115,100);
    setAttacks(Slash,BubbleBeam,Hyper_Beam,Thunderbolt);
  }
}
class Psyduck extends Poke {
  Psyduck() {
    super("Psyduck",54,"Water",50,52,48,50,55,100);
  }
}
class Golduck extends Poke {
  Golduck() {
    super("Golduck",55,"Water",80,82,78,80,85,100);
    setAttacks(Amnesia,Blizzard,Surf,Body_Slam);
  }
}
class Mankey extends Poke {
  Mankey() {
    super("Mankey",56,"Fighting",40,80,35,35,70,100);
  }
}
class Primeape extends Poke {
  Primeape() {
    super("Primeape",57,"Fighting",65,105,60,60,95,100);
    setAttacks(Rock_Slide,Body_Slam,Hyper_Beam,Low_Kick);
  }
}
class Growlithe extends Poke {
  Growlithe() {
    super("Growlithe",58,"Fire",55,70,45,50,60,100);
  }
}
class Arcanine extends Poke {
  Arcanine() {
    super("Arcanine",59,"Fire",90,110,80,80,95,100);
    setAttacks(Fire_Blast,Body_Slam,Hyper_Beam,Flamethrower);
  }
}
class Poliwag extends Poke {
  Poliwag() {
    super("Poliwag",60,"Water",40,50,40,40,90,100);
  }
}
class Poliwhirl extends Poke {
  Poliwhirl() {
    super("Poliwhirl",61,"Water",65,65,65,50,90,100);
  }
}
class Poliwrath extends Poke {
  Poliwrath() {
    super("Poliwrath",62,"Water","Fighting",90,85,95,70,70,100);
    setAttacks(Amnesia,Hypnosis,Surf,Mega_Kick);
  }
}
class Abra extends Poke {
  Abra() {
    super("Abra",63,"Psychic",25,20,15,105,90,100);
  }
}
class Kadabra extends Poke {
  Kadabra() {
    super("Kadabra",64,"Psychic",40,35,30,120,105,100);
  }
}
class Alakazam extends Poke {
  Alakazam() {
    super("Alakazam",65,"Psychic",55,50,45,135,120,100);
    setAttacks(Psychic,Recover,Thunder_Wave,ThunderPunch);
  }
}
class Machop extends Poke {
  Machop() {
    super("Machop",66,"Fighting",70,80,50,35,35,100);
  }
}
class Machoke extends Poke {
  Machoke() {
    super("Machoke",67,"Fighting",80,100,70,50,45,100);
  }
}
class Machamp extends Poke {
  Machamp() {
    super("Machamp",68,"Fighting",90,130,80,65,55,100);
    setAttacks(Body_Slam,Earthquake,Hyper_Beam,Low_Kick);
  }
}
class Bellsprout extends Poke {
  Bellsprout() {
    super("Bellsprout",69,"Grass","Poison",50,75,35,70,40,100);
  }
}
class Weepinbell extends Poke {
  Weepinbell() {
    super("Weepinbell",70,"Grass","Poison",65,90,50,85,55,100);
  }
}
class Victreebel extends Poke {
  Victreebel() {
    super("Victreebel",71,"Grass","Poison",80,105,65,100,70,100);
    setAttacks(Razor_Leaf,Swords_Dance,Sleep_Powder,Hyper_Beam);
  }
}
class Tentacool extends Poke {
  Tentacool() {
    super("Tentacool",72,"Water","Poison",40,40,35,100,70,100);
  }
}
class Tentacruel extends Poke {
  Tentacruel() {
    super("Tentacruel",73,"Water","Poison",80,70,65,120,100,100);
    setAttacks(Mega_Drain,Blizzard,Surf,Hyper_Beam);
  }
}
class Geodude extends Poke {
  Geodude() {
    super("Geodude",74,"Rock","Ground",40,80,100,30,20,100);
  }
}
class Graveler extends Poke {
  Graveler() {
    super("Graveler",75,"Rock","Ground",55,95,115,45,35,100);
  }
}
class Golem extends Poke {
  Golem() {
    super("Golem",76,"Rock","Ground",80,110,130,55,45,100);
    setAttacks(Earthquake,Body_Slam,Explosion,Rock_Slide);
  }
}
class Ponyta extends Poke {
  Ponyta() {
    super("Ponyta",77,"Fire",50,85,55,65,90,100);
  }
}
class Rapidash extends Poke {
  Rapidash() {
    super("Rapidash",78,"Fire",65,100,70,80,105,100);
    setAttacks(Fire_Blast,Agility,Body_Slam,Hyper_Beam);
  }
}
class Slowpoke extends Poke {
  Slowpoke() {
    super("Slowpoke",79,"Water","Psychic",90,65,65,40,15,100);
  }
}
class Slowbro extends Poke {
  Slowbro() {
    super("Slowbro",80,"Water","Psychic",95,75,110,80,30,100);
    setAttacks(Amnesia,Surf,Thunder_Wave,Recover);
    //NOTES: HEE HEE SHOULD BE REST INSTEAD OF RECOVER
  }
}
class Magnemite extends Poke {
  Magnemite() {
    super("Magnemite",81,"Electric",25,35,70,95,45,100);
  }
}
class Magneton extends Poke {
  Magneton() {
    super("Magneton",82,"Electric",50,60,95,120,70,100);
    setAttacks(Thunderbolt,Thunder_Wave,Hyper_Beam,Thunder);
  }
}
class Farfetchd extends Poke {
  Farfetchd() {
    super("Farfetch'd",83,"Normal","Flying",52,65,55,58,60,100);
    setAttacks(Sand_Attack,Slash,Swords_Dance,Body_Slam);
  }
}
class Doduo extends Poke {
  Doduo() {
    super("Doduo",84,"Normal","Flying",35,85,45,35,75,100);
  }
}
class Dodrio extends Poke {
  Dodrio() {
    super("Dodrio",85,"Normal","Flying",60,110,70,60,100,100);
    setAttacks(Drill_Peck,Body_Slam,Hyper_Beam,Tri_Attack);
  }
}
class Seel extends Poke {
  Seel() {
    super("Seel",86,"Water",65,45,55,70,45,100);
  }
}
class Dewgong extends Poke {
  Dewgong() {
    super("Dewgong",87,"Water","Ice",90,70,80,95,70,100);
    setAttacks(Surf,Blizzard,Body_Slam,Ice_Beam);
  }
}
class Grimer extends Poke {
  Grimer() {
    super("Grimer",88,"Poison",80,80,50,40,25,100);
  }
}
class Muk extends Poke {
  Muk() {
    super("Muk",89,"Poison",105,105,75,65,50,100);
    setAttacks(Sludge,Body_Slam,Explosion,Screech);
  }
}
class Shellder extends Poke {
  Shellder() {
    super("Shellder",90,"Water",30,65,100,45,40,100);
  }
}
class Cloyster extends Poke {
  Cloyster() {
    super("Cloyster",91,"Water","Ice",50,95,180,85,70,100);
    setAttacks(Surf,Blizzard,Hyper_Beam,Explosion);
  }
}
class Gastly extends Poke {
  Gastly() {
    super("Gastly",92,"Ghost","Poison",30,35,30,100,80,100);
  }
}
class Haunter extends Poke {
  Haunter() {
    super("Haunter",93,"Ghost","Poison",45,50,45,115,95,100);
  }
}
class Gengar extends Poke {
  Gengar() {
    super("Gengar",94,"Ghost","Poison",60,65,60,130,110,100);
    setAttacks(Hypnosis,Thunderbolt,Explosion,Mega_Drain);
  }
}
class Onix extends Poke {
  Onix() {
    super("Onix",95,"Rock","Ground",35,45,160,30,70,100);
    setAttacks(Earthquake,Explosion,Rock_Slide,Body_Slam);
  }
}
class Drowzee extends Poke {
  Drowzee() {
    super("Drowzee",96,"Psychic",60,48,45,90,42,100);
  }
}
class Hypno extends Poke {
  Hypno() {
    super("Hypno",97,"Psychic",85,73,70,115,67,100);
    setAttacks(Psychic,Amnesia,Hypnosis,Thunderbolt);
  }
}
class Krabby extends Poke {
  Krabby() {
    super("Krabby",98,"Water",30,105,90,25,50,100);
  }
}
class Kingler extends Poke {
  Kingler() {
    super("Kingler",99,"Water",55,130,115,50,75,100);
    setAttacks(Body_Slam,Hyper_Beam,Crabhammer,Swords_Dance);
  }
}
class Voltorb extends Poke {
  Voltorb() {
    super("Voltorb",100,"Electric",40,30,50,55,100,100);
  }
}
class Electrode extends Poke {
  Electrode() {
    super("Electrode",101,"Electric",60,50,70,80,140,100);
    setAttacks(Thunderbolt,Thunder_Wave,Explosion,Screech);
  }
}
class Exeggcute extends Poke {
  Exeggcute() {
    super("Exeggcute",102,"Grass","Psychic",60,40,80,60,40,100);
  }
}
class Exeggutor extends Poke {
  Exeggutor() {
    super("Exeggutor",103,"Grass","Psychic",95,95,85,125,55,100);
    setAttacks(Sleep_Powder,Psychic,Explosion,Giga_Drain);
  }
}
class Cubone extends Poke {
  Cubone() {
    super("Cubone",104,"Ground",50,50,95,40,35,100);
  }
}
class Marowak extends Poke {
  Marowak() {
    super("Marowak",105,"Ground",60,80,110,50,45,100);
    setAttacks(Swords_Dance,Body_Slam,Earthquake,Blizzard);
  }
}
class Hitmonlee extends Poke {
  Hitmonlee() {
    super("Hitmonlee",106,"Fighting",50,120,53,35,87,100);
    setAttacks(Body_Slam,High_Jump_Kick,Meditate,Rolling_Kick);
  }
}
class Hitmonchan extends Poke {
  Hitmonchan() {
    super("Hitmonchan",107,"Fighting",50,105,79,35,76,100);
    setAttacks(Body_Slam,Low_Kick,Mega_Kick,Agility);
  }
}
class Lickitung extends Poke {
  Lickitung() {
    super("Lickitung",108,"Normal",90,55,75,60,30,100);
    setAttacks(Swords_Dance,Earthquake,Hyper_Beam,Body_Slam);
  }
}
class Koffing extends Poke {
  Koffing() {
    super("Koffing",109,"Poison",40,65,95,60,35,100);
  }
}
class Weezing extends Poke {
  Weezing() {
    super("Weezing",110,"Poison",65,90,120,85,60,100);
    setAttacks(Sludge,Explosion,Thunderbolt,Fire_Blast);
  }
}
class Rhyhorn extends Poke {
  Rhyhorn() {
    super("Rhyhorn",111,"Rock","Ground",80,85,95,30,25,100);
  }
}
class Rhydon extends Poke {
  Rhydon() {
    super("Rhydon",112,"Rock","Ground",105,130,120,45,40,100);
    setAttacks(Earthquake,Rock_Slide,Body_Slam,Mega_Kick);
  }
}
class Chansey extends Poke {
  Chansey() {
    super("Chansey",113,"Normal",250,5,5,105,50,100);
    setAttacks(Ice_Beam,Soft_Boiled,Thunder_Wave,Thunderbolt);
  }
}
class Tangela extends Poke {
  Tangela() {
    super("Tangela",114,"Grass",65,55,115,100,60,100);
    setAttacks(Sleep_Powder,Amnesia,Mega_Drain,Stun_Spore);
  }
}
class Kangaskhan extends Poke {
  Kangaskhan() {
    super("Kangaskhan",115,"Normal",105,95,80,40,90,100);
    setAttacks(Body_Slam,Hyper_Beam,Earthquake,Surf);
  }
}
class Horsea extends Poke {
  Horsea() {
    super("Horsea",116,"Water",30,40,70,70,60,100);
  }
}
class Seadra extends Poke {
  Seadra() {
    super("Seadra",117,"Water",55,65,95,95,85,100);
    setAttacks(Hydro_Pump,Blizzard,Smokescreen,Ice_Beam);
  }
}
class Goldeen extends Poke {
  Goldeen() {
    super("Goldeen",118,"Water",45,67,60,50,63,100);
  }
}
class Seaking extends Poke {
  Seaking() {
    super("Seaking",119,"Water",80,92,65,80,68,100);
    setAttacks(Surf,Blizzard,Hyper_Beam,Body_Slam);
  }
}
class Staryu extends Poke {
  Staryu() {
    super("Staryu",120,"Water",30,45,55,70,85,100);
  }
}
class Starmie extends Poke {
  Starmie() {
    super("Starmie",121,"Water","Psychic",60,75,85,100,115,100);
    setAttacks(Blizzard,Recover,Thunderbolt,Surf);
  }
}
class MrMime extends Poke {
  MrMime() {
    super("Mr. Mime",122,"Psychic",40,45,65,100,90,100);
    setAttacks(Psychic,Thunder_Wave,Thunderbolt,Barrier);
  }
}
class Scyther extends Poke {
  Scyther() {
    super("Scyther",123,"Bug","Flying",70,110,80,55,105,100);
    setAttacks(Slash,Agility,Swords_Dance,Hyper_Beam);
  }
}
class Jynx extends Poke {
  Jynx() {
    super("Jynx",124,"Ice","Psychic",65,50,35,95,95,100);
    setAttacks(Lovely_Kiss,Blizzard,Psychic,BubbleBeam);
  }
}
class Electabuzz extends Poke {
  Electabuzz() {
    super("Electabuzz",125,"Electric",65,83,57,85,105,100);
    setAttacks(Thunderbolt,Thunder_Wave,Psychic,Body_Slam);
  }
}
class Magmar extends Poke {
  Magmar() {
    super("Magmar",126,"Fire",65,95,57,85,93,100);
    setAttacks(Fire_Blast,Body_Slam,Psychic,Flamethrower);
  }
}
class Pinsir extends Poke {
  Pinsir() {
    super("Pinsir",127,"Bug",65,125,100,55,85,100);
    setAttacks(Swords_Dance,Hyper_Beam,Body_Slam,Low_Kick);
  }
}
class Tauros extends Poke {
  Tauros() {
    super("Tauros",128,"Normal",75,100,95,70,110,100);
    setAttacks(Body_Slam,Hyper_Beam,Earthquake,Blizzard);
  }
}
class Magikarp extends Poke {
  Magikarp() {
    super("Magikarp",129,"Water",20,10,55,20,80,100);
    setAttacks(Tackle,Tackle,Tackle,Tackle);
  }
}
class Gyarados extends Poke {
  Gyarados() {
    super("Gyarados",130,"Water","Flying",95,125,79,100,81,100);
    setAttacks(Thunderbolt,Surf,Body_Slam,Hyper_Beam);
  }
}
class Lapras extends Poke {
  Lapras() {
    super("Lapras",131,"Water","Flying",130,85,80,95,60,100);
    setAttacks(Ice_Beam,Thunderbolt,Body_Slam,Psychic);
  }
}
class Ditto extends Poke {
  Ditto() {
    super("Ditto",132,"Normal",48,48,48,48,48,100);
  }
}
class Eevee extends Poke {
  Eevee() {
    super("Eevee",133,"Normal",55,55,50,65,55,100);
  }
}
class Vaporeon extends Poke {
  Vaporeon() {
    super("Vaporeon",134,"Water",130,65,60,110,65,100);
    setAttacks(Surf,Blizzard,Body_Slam,Acid_Armor);
  }
}
class Jolteon extends Poke {
  Jolteon() {
    super("Jolteon",135,"Electric",65,65,60,110,130,100);
    setAttacks(Pin_Missile,Thunderbolt,Thunder_Wave,Body_Slam);
  }
}
class Flareon extends Poke {
  Flareon() {
    super("Flareon",136,"Fire",65,130,60,110,65,100);
    setAttacks(Fire_Blast,Body_Slam,Hyper_Beam,Flamethrower);
  }
}
class Porygon extends Poke {
  Porygon() {
    super("Porygon",137,"Normal",65,60,70,75,40,100);
    setAttacks(Sharpen,Hyper_Beam,Recover,Ice_Beam);
  }
}
class Omanyte extends Poke {
  Omanyte() {
    super("Omanyte",138,"Rock","Water",35,40,100,90,35,100);
  }
}
class Omastar extends Poke {
  Omastar() {
    super("Omastar",139,"Rock","Water",70,60,125,115,55,100);
    setAttacks(Hydro_Pump,Blizzard,Surf,Body_Slam);
  }
}
class Kabuto extends Poke {
  Kabuto() {
    super("Kabuto",140,"Rock","Water",30,80,90,45,55,100);
  }
}
class Kabutops extends Poke {
  Kabutops() {
    super("Kabutops",141,"Rock","Water",60,115,105,70,80,100);
    setAttacks(Swords_Dance,Body_Slam,Surf,Hyper_Beam);
  }
}
class Aerodactyl extends Poke {
  Aerodactyl() {
    super("Aerodactyl",142,"Rock","Flying",80,105,65,60,130,100);
    setAttacks(Body_Slam,Hyper_Beam,Fire_Blast,Double_Team);
    //sky attack
  }
}
class Snorlax extends Poke {
  Snorlax() {
    super("Snorlax",143,"Normal",160,110,65,65,30,100);
    setAttacks(Body_Slam,Hyper_Beam,Earthquake,Self_Destruct);
  }
}
class Articuno extends Poke {
  Articuno() {
    super("Articuno",144,"Ice","Flying",90,85,100,125,85,100);
    setAttacks(Blizzard,Agility,Ice_Beam,Hyper_Beam);
  }
}
class Zapdos extends Poke {
  Zapdos() {
    super("Zapdos",145,"Electric","Flying",90,90,85,125,100,100);
    setAttacks(Thunderbolt,Drill_Peck,Thunder_Wave,Agility);
  }
}
class Moltres extends Poke {
  Moltres() {
    super("Moltres",146,"Fire","Flying",90,100,90,125,90,100);
    setAttacks(Agility,Fire_Blast,Hyper_Beam,Body_Slam);
  }
}
class Dratini extends Poke {
  Dratini() {
    super("Dratini",147,"Dragon",41,64,45,50,50,100);
  }
}
class Dragonair extends Poke {
  Dragonair() {
    super("Dragonair",148,"Dragon",61,84,65,70,70,100);
  }
}
class Dragonite extends Poke {
  Dragonite() {
    super("Dragonite",149,"Dragon","Flying",91,134,95,100,80,100);
    setAttacks(Agility,Hyper_Beam,Body_Slam,Surf);
  }
}
class Mewtwo extends Poke {
  Mewtwo() {
    super("Mewtwo",150,"Psychic",106,110,90,154,130,100);
    setAttacks(Amnesia,Psychic,Ice_Beam,Recover);
  }
}
class Mew extends Poke {
  Mew() {
    super("Mew",151,"Psychic",100,100,100,100,100,100);
    setAttacks(Soft_Boiled,Psychic,Earthquake,Thunderbolt);
  }
}