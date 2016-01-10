//using Raichu as placeholder for opp pokemon currently out
//using Pikachu as placeholder for your Pokemon out

class Ai_easy extends AI{
  
  Attack chooseMove(Poke PlayerPoke){
    ArrayList<Attack>attacks = new ArrayList<Attack>(4);
    attacks.add(Raichu.geta1());  
    attacks.add(Raichu.geta2());
    attacks.add(Raichu.geta3());
    attacks.add(Raichu.geta4());
    
    int moveNumber = (int)(Math.random()*4);
    Attack planAttack = attacks.get(moveNumber);
    if(!Pikachu.getStatus().equals("none")){
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
           
       
      if (attacks.size() < 4 && attacks.size() >= 1) {
       planAttack = attacks.get((int)(Math.random()*attacks.size()));
      }
        
    }
    
    return planAttack;
  }
}