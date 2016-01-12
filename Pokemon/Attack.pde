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
    
  String generateEffect(String effect, double effectChance, String effectTarget, Poke opp, Poke self, int damage) {
    Poke target = opp;
    if (effectChance == 0 || effect.equals("")) {
      return "";  
    }
    else if (effectTarget.equals("s")) {
      target = self;  
    }
    if (effect.substring(0,3).equals("mul")) {
      //something with effect.indexOf("(")
      int min = Integer.parseInt(effect.substring(effect.indexOf("(")+1,effect.indexOf("(")+2));
      int max = Integer.parseInt(effect.substring(effect.indexOf(",")+1,effect.indexOf(",")+2));
      int hits = (int)(Math.random()*(max-min+1)+min);
      
    }
    if (effect.substring(0,3).equals("low")) {
       //something with indexOf "(" and indexOf of ","
    }
    if (effect.substring(0,3).equals("rai")) {
      println(effect.substring(effect.indexOf("(")+1,effect.indexOf(".")));
      println(effect.substring(effect.indexOf(".")+1,effect.indexOf(",")));
      println(effect.substring(effect.indexOf(",")+1,effect.indexOf(")")));
    }
    if (effect.substring(0,3).equals("bur") && Math.random() < effectChance) {
        target.setStatus("BRN");  
        println(target.getName() + " got burned.");
        return (target.getName() + " got burned.");
    }
    if (effect.substring(0,3).equals("par") && Math.random() < effectChance) {
      target.setStatus("PRZ"); 
      println(target.getName() + " got paralyzed.");
        return (target.getName() + " got paralyzed.");
    }
    if (effect.substring(0,3).equals("fre") && Math.random() < effectChance) {
      target.setStatus("FRZ");  
    }
    if (effect.substring(0,3).equals("poi") && Math.random() < effectChance) {
      target.setStatus("PSN");  
    }
    if (effect.substring(0,3).equals("sle") && Math.random() < effectChance) {
      target.setStatus("SLP");  
    }
    if (effect.substring(0,3).equals("bad") && Math.random() < effectChance) {
      target.setStatus("PSN-B");  
    }
    if (effect.substring(0,3).equals("set")) {
      //setdamage
    }
    if (effect.substring(0,3).equals("rec")) {
      //recoil
    }
    if (effect.substring(0,3).equals("fai")) {
      //faint from self destruct, explosion, memento (if exist in this gen)
    }
    return "";
  }
  
  String generateFullEffect(Poke opp, Poke self, int damage) {
    return generateEffect(effect1, effect1Chance, effect1Target, opp, self, damage) + "\n" + generateEffect(effect2, effect2Chance, effect2Target, opp, self, damage);
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
  
  double getPower() {
    return power;      
  }
  
  String getCategory() {
    return category;  
  }
  
  
}