private static final float [] multipliers = {0.25, 0.28, 0.33, .40, .50, 0.66, 1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0};

abstract class Poke implements Cloneable{
  private String name;
  private int index;
  private String type1; String type2;
  private int health; /*max*/ private int hp; //current
  private int atk; private int def; private int spec; private int speed;
  private int baseSpeed; 
  private int lv;
  int EV = 65535;
  private String status = "";
  private int [] statStatus = {0, 0, 0, 0, 0, 0};  //atk, def, special, speed, evasion, accuracy
  private String [][] attackEffects = {{"",""},{"",""}};  //used for text to display
  Attack a1;
  Attack a2;
  Attack a3;
  Attack a4;
  private boolean attackCrit;
  private boolean attackMissed = false;
  private float attackEffectiveness = 1;
  private boolean turnParalyzed;
  private boolean frozen;
  private boolean asleep;
  private boolean paralyzed;
  private boolean burned;
  private boolean fainted;
  private boolean flinch = false;
  private boolean confused = false;
  int confuseTurns = 0;
  private boolean hitSelf = false;
  int sleepTurns = 0;
  boolean recharge = false;
  boolean setRecharge = false;
  int attackHits;
  String inflictStatus = "";
  Poke inflictStatusTarget;
  
  Poke(String n, int i, String t, int bh, int ba, int bd, int bsp, int bs, int l) {
    lv = l;
    name = n;
    type1 = t;
    //63 is sqrt(EV)/4 rounded down
    health = (int)(((bh+15)*2+63)*lv/100)+lv+10;
    atk = (int)(((ba+15)*2+63)*lv/100)+5;
    def = (int)(((bd+15)*2+63)*lv/100)+5;
    spec = (int)(((bsp+15)*2+63)*lv/100)+5;
    speed = (int)(((bs+15)*2+63)*lv/100)+5;
    hp = health;
    baseSpeed = bs; 
    type2 = "";
    index = i;
  }
  
  Poke(String n, int i, String t1, String t2, int bh, int ba, int bd, int bsp, int bs, int l) {
    this(n,i,t1,bh,ba,bd,bsp,bs,l);
    type2 = t2;
  }
  
  public Object clone() {
    try{
      return super.clone();  
    }
    catch(CloneNotSupportedException e) {
      return null;  
    }
  }
  
  void setAttacks(Attack a, Attack b, Attack c, Attack d) {
    a1 = (a.copy());
    a2 = (b.copy());
    a3 = (c.copy());
    a4 = (d.copy());
    /*a1 = a;
    a2 = b;
    a3 = c;
    a4 = d;*/
  }
  
  int attack(Poke opp, Attack attack) {
    //println(this + " " + flinch);
    attackEffects[0][0] = "";
    attackEffects[0][1] = "";
    attackEffects[1][0] = "";
    attackEffects[1][1] = "";
    inflictStatus = "";
    inflictStatusTarget = null;
    int rand = (int)(Math.random()*100);
    if (fainted) {
      //println(name + " is fainted!");
      return 0;  
    }
    else if (rand > attack.accuracy) {
      attack.ppLeft--;
      attackMissed = true;  
      return 0;
    }
    else if (attack == None) {
      return 0;  
    }
    else if (paralyzed && (int)(Math.random()*4) == 0) {
      turnParalyzed = true;
      println(name + " is paralyzed! It couldn't attack!");
      return 0;  
    }
    else if (frozen) {
      println(name + " is frozen and can't attack!");
      return 0;
    }
    else if (status.equals("SLP")) {
      println("asleep");
      return 0;
    }
    else if (recharge) {
      return 0;  
    }
    else if (flinch) {
      return 0;  
    }
    else {
      /*if (confused && Math.random()*2 == 1) {
        hitSelf = true;
        return 0;  
      }*/
      //println(this + " normal progression");
      hitSelf = false;
      turnParalyzed = false;
      frozen = false;
      attackMissed = false;
      flinch = false;
      attack.ppLeft--;
      int damage = opp.takeDamage(calculateDamage(opp, attack));
      //println(damage);
      //println(opp.hp);
      if (attack.name.equals("Hyper Beam") && opp.hp > 0) {
        setRecharge = true;    
      }
      if (attack.effect1.length() >= 3 && attack.effect1.substring(0,3).equals("mul")) {
        int min = Integer.parseInt(attack.effect1.substring(attack.effect1.indexOf("(")+1,attack.effect1.indexOf("(")+2));
        int max = Integer.parseInt(attack.effect1.substring(attack.effect1.indexOf(",")+1,attack.effect1.indexOf(",")+2));
        attackHits = (int)(Math.random()*(max-min+1)+min);
        return opp.takeDamage(calculateDamage(opp, attack))*attackHits;
      }      
      attackHits = 1;
      return damage;
    }
  }
  
  int calculateDamage(Poke opp, Attack attack) {
    double baseDmg;
    if (attack.getCategory().equals("Physical")) {
      baseDmg = Math.floor(checkSTAB(attack)*(Math.floor(Math.floor((2*lv*critical(attack)+10)*atk*burned()*multipliers[statStatus[0]+6]*attack.getPower()/250)/(boom(attack)*opp.getDef()*multipliers[opp.statStatus[1]+6]))+2.0));
    }
    else if (attack.getCategory().equals("Special")) {
      baseDmg = Math.floor(checkSTAB(attack)*(Math.floor(Math.floor((2*lv*critical(attack)+10)*spec*multipliers[statStatus[2]+6]*attack.getPower()/250)/(opp.getSpec()*multipliers[opp.statStatus[2]+6]))+2.0));
    }
    else {
      baseDmg = 0;  
    }
    double random = (int)(Math.random()*16+85);
    //println("Random:" + random);
    double modifier = (random/100.0)*effective(attack,opp.getType1(),opp.getType2()); //includes STAB(above), random, effectiveness, and random (included above)
    
    int damage = (int)(Math.floor(baseDmg*modifier));
    
    if (attackEffectiveness != 0) {
      attackEffects = attack.generateFullEffect(opp,this,damage);
    }
    if (opp.hp < damage) {
      return opp.hp;  
    }
    
    if (attack.power == 0) {
      return 0;  
    }
    return damage;
  }
  
  float boom(Attack a) {
    if (a.name.equals(Explosion.name) || a.name.equals(Self_Destruct.name)) {
      return 0.5;  
    }
    return 1.0;
  }
  
  double critical(Attack a) {
    float chance = baseSpeed*100.0/512.0;  //chance is baseSpeed*100/512 but divide by 100 for calculating
    if (a.name.equals("Razor Leaf") || a.name.equals("Karate_Chop") || a.name.equals("Slash") || a.name.equals("Crabhammer")  /*Sky Attack, Razor Wind*/) {
      chance = baseSpeed*100/64;  
    }
    //println("chance: " + chance);
    double random = (Math.random()*100.0);
    //println(random);
    if (random < chance) {
      println("A critical hit!");
      attackCrit = true;
      double increase = (2.0*this.lv+5)/(this.lv+5.0);
      return increase;  
    }
    else {
      attackCrit = false;
      return 1.0; 
    }
  }
  
  double checkSTAB(Attack attack) {
    if (type1.equals(attack.type) || type2.equals(attack.type)) {
      //return Math.floor(baseDamage/2);
      return 1.5;
    }
    else {
      //return 0;  
      return 1;
    }
  }
  
  float effective(Attack attack, String t1, String t2) { 
    float result = checkEffectiveness(attack.type, t1) * checkEffectiveness(attack.type,t2);
    attackEffectiveness = result;
    if (result == 0.5) {
      println("It's not very effective.");  
    }
    if (result == 0) {
      println("It had no effect.");  
    }
    if (result == 2) {
      println("It's super effective.");  
    }
    return result;
  }
  
  int takeDamage(int damage) {
    if (damage >= hp) {
      hp = 0;
      fainted = true;
      //setStatus("FNT");
    }
    else {
      println(name + " took " + damage);
      hp -= damage;
    }
    return damage; 
  }  
  
  void setStatus(String s) {
    status = s;  
  }
  
  double burned() {
    if (burned) {
      return 0.5;  
    }
    return 1;
  }
  
  //----------------------------
  //RETURN METHODS
  //----------------------------
  Attack geta1(){
    return a1;
  }
  Attack geta2(){
    return a2;
  }
  Attack geta3(){
    return a3;
  }
  Attack geta4(){
    return a4;
  }
  int getDef() {
    return def;  
  }
  
  int getSpec() {
    return spec;  
  }
  
  String getType1() {
    return type1;
  }
  
  String getType2() {
    return type2;  
  }
  
  String getName() {
    return name.toUpperCase();  
  }
  
  String getStatus() {
    return status;  
  }
  
}