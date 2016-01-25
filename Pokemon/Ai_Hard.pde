class AI_Hard extends AI{
    ArrayList<Integer> EffectiveMove = new ArrayList<Integer>();
    public AI_Hard(Poke p1, Poke p2, Poke p3){
    super(p1,p2,p3);
    }
              
  public AI_Hard(Poke p1, Poke p2, Poke p3, String n){
    super(p1,p2,p3,n);
  }
              
  int chooseAction(){
    //should type advantage based switches happen?
    if(checkTypeEffectiveness(yourPreviousPoke.getType1(),oppPokemonOut) >= 2|| checkTypeEffectiveness(yourPreviousPoke.getType2(),oppPokemonOut) >= 2){
      return 1;
    }
    else if(oppPokemonOut.speed > yourPokemonOut.speed){
      if (willKill(oppPokemonOut.a1) || willKill(oppPokemonOut.a2) || willKill(oppPokemonOut.a3) || willKill(oppPokemonOut.a4)){
        return 0;
      }
      else if (willAnyYourMovesCauseFaint()) {
        return 1;  
      }
      return 0;
    }   
    else if(oppPokemonOut.speed < yourPokemonOut.speed && willAnyYourMovesCauseFaint() && !allLow() ) {
      return 1;
    }
    else if(oppPokemonOut.speed > yourPokemonOut.speed && willDie(yourAttack) && 
    else{
      return 0;
    }
  }
   
          
  void collectInfo() {
    storePokemon();
    storeAttack();      
  }
        
  //nextStep: make it so that it choose a Poke less likely to die or more likely to kill    
  Poke chooseNextPoke(){
    
    //add parts to check for weakness not to switch in
    ArrayList<Poke>canSwitchTo = new ArrayList<Poke>();
    String currentAttackType = yourAttack.type;
    for (int i = 0; i < AI_Team.size(); i++) {
      if (AI_Team.get(i) != oppPokemonOut && !AI_Team.get(i).getStatus().equals("FNT")) {
        canSwitchTo.add(AI_Team.get(i));  
      }
    }
    if (canSwitchTo.size() == 0) {
      return null;  
    }
    Poke chooseThis = canSwitchTo.get((int)(Math.random()*canSwitchTo.size()));
    for(int a = 0; a < canSwitchTo.size(); a ++){
      if (checkFullEffectiveness(currentAttackType,chooseThis.type1,chooseThis.type2) >= 2) {
        chooseThis = canSwitchTo.get(a);        
      }              
    }
    return chooseThis;     
  }
       

              
  Attack chooseMove(){
    ArrayList<Attack>attacks = new ArrayList<Attack>();
    ArrayList<Attack>status = new ArrayList<Attack>();
    
    attacks.add(oppPokemonOut.a1);
    attacks.add(oppPokemonOut.a2);
    attacks.add(oppPokemonOut.a3);
    attacks.add(oppPokemonOut.a4);
    
    for (int y = 0; y < attacks.size(); y++) {
      if (attacks.get(y).ppLeft <= 0) {
        attacks.remove(y);
        y--;
      }
    }
    
    for (int i = 0; i < attacks.size(); i++) {
      if (attacks.get(i).category.equals("Status")) {
        status.add(attacks.get(i));  
      }
    }
    
    for (int k = 0; k < status.size(); k++) {     
      if (!yourPokemonOut.getStatus().equals("") && status.get(k).effect1Target.equals("o") && !status.get(k).effect1.substring(0,3).equals("rai") && !status.get(k).effect1.substring(0,3).equals("low")) {
        status.remove(k);
        k--;
      }
      if (status.get(k).effect1.substring(0,3).equals("hea") && oppPokemonOut.hp * 2 > oppPokemonOut.health) {
        status.remove(k);  
      }
      if (status.get(k).effect1.substring(0,3).equals("rai") && oppPokemonOut.statStatus[Integer.parseInt(attacks.get(k).effect1.substring(attacks.get(k).effect1.indexOf("(")+1,attacks.get(k).effect1.indexOf(",")))] == 6) {
        status.remove(k);  
      }
      if (status.get(k).effect1.substring(0,3).equals("low") && yourPokemonOut.statStatus[Integer.parseInt(attacks.get(k).effect1.substring(attacks.get(k).effect1.indexOf("(")+1,attacks.get(k).effect1.indexOf(",")))] == -6) {
        status.remove(k);  
      }
    }
    
    int moveNumber = (int)(Math.random()*attacks.size());
    Attack planAttack = attacks.get(moveNumber);
    
    if (attacks.size() > 0) {
      Attack greatestDamage = attacks.get(0);
      for(int j = 1; j < attacks.size(); j++){
        if (calculateDamage(yourPokemonOut,attacks.get(j)) > calculateDamage(yourPokemonOut,greatestDamage)) {
          greatestDamage = attacks.get(j);  
          println("strongest changed");
        }
      }
      planAttack = greatestDamage;
      //println(planAttack);
    }
    
    //println(planAttack);
    
    int random = (int)(Math.random()*2);
    println(random);
    println(random == 0);
    if (status.size() > 0 && !willKill(planAttack) &&  random == 0) {
      planAttack = status.get((int)(Math.random()*status.size()));    
    }
   
   //use strongest damage here
   //currently ok for need to heal, but what if you're below 50% and the attack does over 50% anyways (second part of if)
    if (status.size() > 0 && willAnyYourMovesCauseFaint() && oppPokemonOut.hp < (int)(oppPokemonOut.health/2)) {
      for (int i = 0; i < status.size(); i++) {
        if (status.get(i).effect1.substring(0,3).equals("hea")) {
          return status.get(i);  
        }
      }
    }
   
    
    return planAttack;         
  }

          
  int calculateDamage(Poke opp, Attack attack) {
    double baseDmg;
    if (attack.getCategory().equals("Physical")) {
      baseDmg = Math.floor(yourPokemonOut.checkSTAB(attack)*(Math.floor(Math.floor((2*yourPokemonOut.lv+10)*yourPokemonOut.atk*yourPokemonOut.burned()*multipliers[yourPokemonOut.statStatus[0]+6]*attack.getPower()/250)/(opp.getDef()*multipliers[opp.statStatus[1]+6]))+2.0));
    }
    else if (attack.getCategory().equals("Special")) {
      baseDmg = Math.floor(yourPokemonOut.checkSTAB(attack)*(Math.floor(Math.floor((2*yourPokemonOut.lv+10)*yourPokemonOut.spec*multipliers[yourPokemonOut.statStatus[2]+6]*attack.getPower()/250)/(opp.getSpec()*multipliers[opp.statStatus[2]+6]))+2.0));
    }
    else {
      baseDmg = 0;  
    }
    double random = (int)(Math.random()*16+85);
    double modifier = (random/100.0)*yourPokemonOut.effective(attack,opp.getType1(),opp.getType2()); //includes STAB(above), random, effectiveness, and random (included above)
    int damage = (int)(Math.floor(baseDmg*modifier));
    if (opp.hp < damage) {
      return opp.hp;  
    }
    return damage;
  }
      
  int yourStrongestDamage() {
    int strongestDamage = 0;
    int pokeOutIndex = 0;
    for (int i = 0; i < pokemonStored; i++) {
      if (PlayerTeam[i].getClass() == yourPokemonOut.getClass()) {
        pokeOutIndex = i;    
      }
    }
    for (int j = 0; j < attacksStored[pokeOutIndex]; j++) {
      if (calculateDamage(oppPokemonOut,PlayerAttacks[pokeOutIndex][j]) > strongestDamage) {
        strongestDamage = calculateDamage(oppPokemonOut,PlayerAttacks[pokeOutIndex][j]);
      }
    }  
    return strongestDamage;
  }
  
  boolean willDie(Attack a) {
    if (calculateDamage(oppPokemonOut,a) >= oppPokemonOut.hp) {
      return true;    
    }
    return false;
  }
  
  boolean willAnyYourMovesCauseFaint() {
    int pokeOutIndex = 0;
    for (int i = 0; i < pokemonStored; i++) {
      if (PlayerTeam[i].getClass() == yourPokemonOut.getClass()) {
        pokeOutIndex = i;    
      }
    }
    for (int j = 0; j < attacksStored[pokeOutIndex]; j++) {
      if (willDie(PlayerAttacks[pokeOutIndex][j])) {
        return true;  
      }
    }
    return false;
  }
      
  boolean willKill(Attack a){
    if (calculateDamage(yourPokemonOut,a) >= yourPokemonOut.hp) {
      return true;  
    }
    return false;
  }
 boolean allLow(){
   boolean low = true;
   for(int a =0; a < AI_Team.size(); a ++){
     if(AI_Team.get(a).hp > AI_Team.get(a).health * (3/10)){
       low = false;
     }
   }
   return low;
 }
 boolean hasHeal(){
   boolean hasheal;
   for(int z = 0; z < 4; z++){
     if(
        
}