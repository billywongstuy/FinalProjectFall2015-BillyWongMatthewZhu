class Attack {
  private String name;
  private int power;
  private String type;
  private int accuracy;
  private int pp;
  private int ppLeft;
  private String effect1;
  private double effect1Chance;
  private String effect1Target;
  private String effect2;
  private double effect2Chance;
  private String effect2Target;
  private String category;
  
  //still need physical/special
  Attack(String nam, int pow, String t, String c, int a, int p, String eff1, double eff1Chance, String eff1t, String eff2, double eff2Chance, String eff2t) {
    name = nam;
    power = pow;
    type = t;
    category = c;
    accuracy = a;
    pp = p;
    ppLeft = pp;
    effect1 = eff1;
    effect1Chance = eff1Chance;
    effect1Target = eff1t;
    effect2 = eff2;
    effect2Chance = eff2Chance;
    effect2Target = eff2t;
  }
    
  
  Attack(Attack a) {
    this(a.name,a.power,a.type,a.category,a.accuracy,a.pp,a.effect1,a.effect1Chance,a.effect1Target,a.effect2,a.effect2Chance,a.effect2Target);  
  }
  
  public Attack copy() {
    Attack copy = new Attack(this);
    return copy;
  }
  
  
    
  String [] generateEffect(String effect, double effectChance, String effectTarget, Poke opp, Poke self, int damage) {
    String [] ary = {"",""};
    
    Poke target = opp;
    if (effectChance == 0 || effect.equals("") || effectTarget.equals("")) {
      return ary;  
    }
    
    if (effectTarget.equals("s")) {
      target = self;  
    }
    if (effect.substring(0,3).equals("mul")) {
      //something with effect.indexOf("(")
      //ignore this part, handled in attack in poke
    }
    if (effect.substring(0,3).equals("hea")) {
      
    }
    //for these use 0 for attack, 1 for def, 2 for special, 3 for speed, 4 for evasion, 5 for accuracy
    if (effect.substring(0,3).equals("low")) {
      int stat = Integer.parseInt(effect.substring(effect.indexOf("(")+1,effect.indexOf(",")));
      int lower = Integer.parseInt(effect.substring(effect.indexOf(",")+1,effect.indexOf(")")));
      if (target.statStatus[stat] + lower >= -6) {
        target.statStatus[stat] -= lower;  
      }
      else if (target.statStatus[stat] == -5) {
        target.statStatus[stat] = -6;    
      }
      ary[0] = target.getName()+"'s";
      ary[1] = getStat(stat) + " fell!";
      if (lower >= 2) {
        ary[1] = getStat(stat) + " sharply fell!";
      }
    }
    if (effect.substring(0,3).equals("rai")) {
      println("Raising");
      int stat = Integer.parseInt(effect.substring(effect.indexOf("(")+1,effect.indexOf(",")));
      int boost = Integer.parseInt(effect.substring(effect.indexOf(",")+1,effect.indexOf(")")));
      if (target.statStatus[stat] + boost <= 6) {
        target.statStatus[stat] += boost;  
      }
      else if (target.statStatus[stat] == 5) {
        target.statStatus[stat] = 6;    
      }
      ary[0] = target.getName()+"'s";
      ary[1] = getStat(stat) + " rose!";
      if (boost >= 2) {
        ary[1] = getStat(stat) + " sharply rose!";
      }
    }
    if (effect.substring(0,3).equals("bur") && Math.random() < effectChance && target.getStatus().equals("") && !target.type1.equals("Fire") && !target.type2.equals("Fire")) {
      target.setStatus("BRN");  
      ary[0] = target.getName();
      ary[1] = "got burned!";
    }
    if (effect.substring(0,3).equals("par") && Math.random() < effectChance && target.getStatus().equals("")) {
      target.setStatus("PRZ"); 
      ary[0] = target.getName();
      ary[1] = "got paralyzed!";
      println(ary[0] + " " + ary[1] + "AAAAAA");
      println("PARALYZED!");
    }
    if (effect.substring(0,3).equals("fre") && Math.random() < effectChance && target.getStatus().equals("")) {
      target.setStatus("FRZ");  
      ary[0] = target.getName();
      ary[1] = "got frozen!";
    }
    if (effect.substring(0,3).equals("poi") && Math.random() < effectChance && target.getStatus().equals("") && !target.type1.equals("Poison") && !target.type2.equals("Poison")) {
      target.setStatus("PSN"); 
      ary[0] = target.getName();
      ary[1] = "got poisoned!";
      println("POISONED " + target.getName());
    }
    if (effect.substring(0,3).equals("sle") && Math.random() < effectChance && target.getStatus().equals("")) {
      target.setStatus("SLP"); 
      /*if (this == Rest) {
        target.sleepTurns = 2;  
      }*/
      target.sleepTurns = (int)(Math.random()*7+1);
      ary[0] = target.getName();
      ary[1] = "fell asleep!";
    }
    if (effect.substring(0,3).equals("bad") && Math.random() < effectChance && target.getStatus().equals("")) {
      target.setStatus("PSN-B");  
    }
    if (effect.substring(0,3).equals("set")) {
      //setdamage
    }
    if (effect.substring(0,3).equals("rec")) {
      //recoil
    }
    if (effect.substring(0,3).equals("fai")) {
      //faint from self destruct, explosion
    }
    println(ary[0]);
    return ary;
  }
  
  String [][] generateFullEffect(Poke opp, Poke self, int damage) {
    String[][]ary = new String[2][];
    ary[0] = generateEffect(effect1, effect1Chance, effect1Target, opp, self, damage);
    ary[1] = generateEffect(effect2, effect2Chance, effect2Target, opp, self, damage);
    return ary;
  }
  
  
  //----------------------------
  //RETURN METHODS
  //----------------------------
    String toString() {
    return name.toUpperCase();  
  }
  
  String getType() {
    return type.toUpperCase();  
  }
  
  int getPower() {
    return power;      
  }
  
  String getCategory() {
    return category;  
  }
  
  
  String getStat(int n) {
    switch(n) {
      case 0:
        return "attack";
      case 1:
        return "defense";
      case 2:
        return "special";
      case 3:
        return "speed";
      case 4:
        return "evasion";
      case 5:
        return "accuracy";
    }
    return "";
  }
  
  
}