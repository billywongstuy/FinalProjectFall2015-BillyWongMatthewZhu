
//using oppPokemonOut as placeholder for opp pokemon currently out
//using Pikachu as placeholder for your Pokemon out

class AI_Easy extends AI{
  
  public AI_Easy(Poke p1, Poke p2, Poke p3) {
    super(p1,p2,p3);  
  }
  
  public AI_Easy(Poke p1, Poke p2, Poke p3, String n){
    super(p1,p2,p3,n);
  }
  
  
  Poke chooseNextPoke(){
    ArrayList<Poke>canSwitchTo = new ArrayList<Poke>();
    for (int i = 0; i < AI_Team.size(); i++) {
      if (!AI_Team.get(i).getStatus().equals("FNT") && AI_Team.get(i) != oppPokemonOut) {
        canSwitchTo.add(AI_Team.get(i));  
      }
    }
    if (canSwitchTo.size() == 0) {
      return null;  
    }
    Poke chooseThis = canSwitchTo.get((int)(Math.random()*canSwitchTo.size()));
    return chooseThis;
  }
  
  Attack chooseMove(){
    ArrayList<Attack>attacks = new ArrayList<Attack>(4);
    attacks.add(oppPokemonOut.geta1());  
    attacks.add(oppPokemonOut.geta2());
    attacks.add(oppPokemonOut.geta3());
    attacks.add(oppPokemonOut.geta4());
    for (int i = 0; i < attacks.size(); i++) {
      if (attacks.get(i).ppLeft <= 0) {
        attacks.remove(i);
        i--;
      }
    }
    int beginningSize = attacks.size();
    int moveNumber = (int)(Math.random()*attacks.size());
    
    Attack planAttack = attacks.get(moveNumber);
    if(!yourPokemonOut.getStatus().equals("")){
      if(moveNumber == 0){
        if (!attacks.get(0).effect1.equals("") && attacks.get(0).effect1Chance == 1){
          attacks.remove(0);          
        }
      }
      if(moveNumber == 1){
        if (!attacks.get(1).effect1.equals("") && attacks.get(1).effect1Chance == 1){
          attacks.remove(1);          
        }
      }
      if(moveNumber == 2){
        if (!attacks.get(2).effect1.equals("") && attacks.get(2).effect1Chance == 1){
          attacks.remove(2);          
        }
      }
      if(moveNumber == 3){
        if (!attacks.get(3).effect1.equals("") && attacks.get(3).effect1Chance == 1){
          attacks.remove(3);          
        }
      }
           
       
      if (attacks.size() < beginningSize && attacks.size() >= 1) {
       planAttack = attacks.get((int)(Math.random()*attacks.size()));
      }
        
    }
    
    return planAttack;
  }

  int chooseAction(){
    int option = 0;
    return option;
  }
    
    
}