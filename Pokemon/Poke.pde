private static final float [] multipliers = {0.25, 0.28, 0.33, .40, .50, 0.66, 1.0, 2.0, 2.5, 3.0, 3.5, 4.0};

abstract class Poke implements Cloneable{
  private String name;
  private int index;
  private String type1; String type2;
  private int health; /*max*/ private int hp; //current
  private int atk; private int def; private int spec; private int speed;
  private int baseSpeed; 
  private int lv;
  int EV = 65535;
  private String status = "none";
  private boolean flinch = false;
  private int [] statStatus = {0, 0, 0, 0, 0, 0};  //atk, def, special, speed, evasion, accuracy
  private boolean critOrNot;  //used for ignoring stat drops/boosts?
  private String addEffects;  //used for text to display
  private Attack a1;
  private Attack a2;
  private Attack a3;
  private Attack a4;
  private boolean attackCrit;
  private float attackEffectiveness = 1;
  private boolean turnParalyzed;
  private boolean frozen;
  
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
  
  int attack(Poke opp, Attack attack) {
    //println(name + ": " + status);
    if (status.equals("FNT")) {
      //println(name + " is fainted!");
      return 0;  
    }
    else if (status.equals("PRZ") && (int)(Math.random()*4) == 0) {
      turnParalyzed = true;
      println(name + " is paralyzed! It couldn't attack!");
      return 0;  
    }
    else if (status.equals("FRZ")) {
      frozen = true;
      println(name + " is frozen and can't attack!");
      return 0;
    }
    else {
      println("t");
      turnParalyzed =false;
      frozen = false;
      attack.ppLeft--;
      return opp.takeDamage(calculateDamage(opp, attack));
    }
  }
  
  int calculateDamage(Poke opp, Attack attack) {
    double baseDmg;
    if (attack.getCategory().equals("Physical")) {
      baseDmg = Math.floor(checkSTAB(attack)*(Math.floor(Math.floor((2*lv*critical()+10)*atk*burned()*multipliers[statStatus[0]+6]*attack.getPower()/250)/opp.getDef())+2.0));
    }
    else if (attack.getCategory().equals("Special")) {
      baseDmg = Math.floor(checkSTAB(attack)*(Math.floor(Math.floor((2*lv*critical()+10)*spec*multipliers[statStatus[2]+6]*attack.getPower()/250)/opp.getSpec())+2.0));
    }
    else {
      baseDmg = 0;  
    }
    double random = (int)(Math.random()*16+85);
    //println("Random:" + random);
    double modifier = (random/100.0)*effective(attack,opp.getType1(),opp.getType2()); //includes STAB(above), random, effectiveness, and random (included above)
    
    int damage = (int)(Math.floor(baseDmg*modifier));
    
    addEffects = attack.generateFullEffect(opp,this,damage);
    if (opp.hp < damage) {
      return opp.hp;  
    }
    return damage;
  }
  
  double critical() {
    double chance = baseSpeed*100.0/512.0;  //chance is baseSpeed*100/512 but divide by 100 for calculating
    //println("chance: " + chance);
    double random = (Math.random()*100.0);
    //println(random);
    if (random < chance) {
      println("A critical hit!");
      attackCrit = true;
      return 2.0;  
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
      setStatus("FNT");
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
    if (status.equals("BRN")) {
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