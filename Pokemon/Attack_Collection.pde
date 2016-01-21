Attack None = new Attack("None",0,"Normal","Physical",95,35,"",0,"","",0,"");
Attack Tackle = new Attack("Tackle",35,"Normal","Physical",95,35,"",0,"","",0,"");
Attack Karate_Chop = new Attack("Karate_Chop",50,"Normal","Physical",100,25,"",0,"","",0,"");
Attack Slash = new Attack("Slash",70,"Normal","Physical",100,20,"",0,"","",0,"");
Attack Hyper_Beam = new Attack("Hyper Beam",150,"Normal","Physical",90,5,"",0,"","",0,"");
Attack Fire_Blast = new Attack("Fire Blast",120,"Fire","Special",85,5,"burn",0.3,"o","",0,"");
Attack Thunderbolt = new Attack("Thunderbolt",95,"Electric","Special",100,15,"paralysis",0.1,"o","",0,"");
Attack Thundershock= new Attack("Thundershock",40,"Electric","Special",100,30,"paralysis",0.1,"o","",0,"");

//change back to 120 and 0.1
Attack Thunder = new Attack("Thunder",320,"Electric","Special",70,10,"paralysis",0.1,"o","",0,"");
Attack Vine_Whip = new Attack("Vine Whip",35,"Grass","Special",100,10,"",0,"","",0,"");
Attack Razor_Leaf = new Attack("Razor Leaf",55,"Grass","Special",95,25,"",0,"","",0,"");
Attack Flamethrower = new Attack("Flamethrower",95,"Fire","Special",100,15,"burn",0.1,"o","",0,"");
Attack Ice_Beam = new Attack("Ice Beam",95,"Ice","Special",100,15,"freeze",0.1,"o","",0,"");
Attack Surf = new Attack("Surf",95,"Water","Special",100,15,"",0,"","",0,"");
Attack Crabhammer = new Attack("Crabhammer",90,"Water","Special",85,10,"",0,"","",0,"");
Attack BubbleBeam = new Attack("BubbleBeam",65,"Water","Special",100,20,"lowerStat(3,1)",0.1,"o","",0,"");
Attack Strength = new Attack("Strength",80,"Normal","Physical",100,15,"",0,"","",0,"");
Attack Earthquake = new Attack("Earthquake",100,"Ground","Physical",100,10,"",0,"","",0,"");
Attack Wing_Attack = new Attack("Wing Attack",60,"Flying","Physical",100,35,"",0,"","",0,"");
Attack Sludge = new Attack("Sludge",65,"Poison","Physical",100,20,"poisons",0.3,"o","",0,"");
Attack Thunder_Wave = new Attack("Thunder Wave",0,"Electric","Special",100,20,"paralysis",1,"o","",0,"");
Attack Swords_Dance = new Attack("Swords Dance",0,"Normal","Status",100,30,"raiseStat(0,2)",1,"s","",0,"");
Attack Sleep_Powder = new Attack("Sleep Powder",0,"Grass","Status",75,15,"sleep",1,"o","",0,"");
Attack Explosion = new Attack("Explosion",170,"Normal","Physical",100,5,"faint",1,"s","",0,"");
Attack Self_Destruct = new Attack("Self-Destruct",130,"Normal","Physical",100,5,"faint",1,"s","",0,"");
Attack Psychic = new Attack("Psychic",90,"Psychic","Special",100,10,"lowerStat(3,1)",0.3,"o","",0,"");
Attack Pin_Missile = new Attack("Pin Missile",14,"Bug","Physical",85,20,"multi(2,5)",1,"o","",0,"");

//Attack Thundershock= new Attack("Thundershock",40,"Electric","Special",100,30,"paralysis",0.1,"o","",0,"");

//Attack test = new Attack(120,"Fire",85,5,"multi(2,5)",1,"o","",0,"");

//if Explosion or SelfDestruct def /2 
//guillotine + fissure cannot hit pokemon w/ higher speed
//dragon rage, supe rfang, seismic toss, sonic boom, night shade
//bide, mirror move
//tri attack effects
//psywave
//mimic, minimize, bide
//fly, dig, etc.
//priority quick attack
//rage

//do we implement high critical hit ratio effect?

//statuses: brn, frz, prlz, psn, slp, confuse, leech seed, self drop/boost, opp drop/boost