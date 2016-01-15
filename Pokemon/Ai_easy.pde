
//using oppPokemonOut as placeholder for opp pokemon currently out
//using Pikachu as placeholder for your Pokemon out

class Ai_Easy extends AI{
  
  public Ai_Easy(Poke p1, Poke p2, Poke p3) {
    super(p1,p2,p3);  
  }
  
  
      Poke chooseNextPoke(){
         Poke chooseThis = AI_Team.get(0);
         for(int a = 0; a < AI_Team.size(); a ++){
               if(checkEffectiveness(AI_Team.get(a).geta1().getType(), yourPokemonOut.getType1()) > 1||
               checkEffectiveness(AI_Team.get(a).geta1().getType(), yourPokemonOut.getType2()) > 1 ||
               checkEffectiveness(AI_Team.get(a).geta2().getType(), yourPokemonOut.getType1()) > 1 ||
               checkEffectiveness(AI_Team.get(a).geta2().getType(), yourPokemonOut.getType2()) > 1 ||
               checkEffectiveness(AI_Team.get(a).geta3().getType(), yourPokemonOut.getType1()) > 1 ||
               checkEffectiveness(AI_Team.get(a).geta3().getType(), yourPokemonOut.getType2()) > 1 ||
               checkEffectiveness(AI_Team.get(a).geta4().getType(), yourPokemonOut.getType1()) > 1 ||
               checkEffectiveness(AI_Team.get(a).geta4().getType(), yourPokemonOut.getType2()) > 1 ){
                 chooseThis = AI_Team.get(a);

               }
               else{
                   for(int z = 0; z < AI_Team.size(); z ++){
                     if(AI_Team.get(z).hp > 0){
                       chooseThis = AI_Team.get(z);

                     }
                   }
               }
         }
         return chooseThis;
       }
  
  Attack chooseMove(){
    ArrayList<Attack>attacks = new ArrayList<Attack>(4);
    attacks.add(oppPokemonOut.geta1());  
    attacks.add(oppPokemonOut.geta2());
    attacks.add(oppPokemonOut.geta3());
    attacks.add(oppPokemonOut.geta4());
    int moveNumber = (int)(Math.random()*4);
    Attack planAttack = attacks.get(moveNumber);
    if(!yourPokemonOut.getStatus().equals("none")){
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

         int chooseAction(){
         int option = 0;
         /*boolean AllDead = true;
           for(int b = 0; b < AI_Team.size(); b ++){
                if(AI_Team.get(b).hp > 0){
                  AllDead = false;
                }
              }
                
              if((!AllDead) && (checkEffectiveness(oppPokemonOut.geta1().getType(), yourPokemonOut.getType1()) < 1 ||
           checkEffectiveness(oppPokemonOut.geta1().getType(), yourPokemonOut.getType2()) < 1||
           checkEffectiveness(oppPokemonOut.geta2().getType(), yourPokemonOut.getType1()) < 1||
           checkEffectiveness(oppPokemonOut.geta2().getType(), yourPokemonOut.getType2()) < 1||
           checkEffectiveness(oppPokemonOut.geta3().getType(), yourPokemonOut.getType1()) < 1||
           checkEffectiveness(oppPokemonOut.geta3().getType(), yourPokemonOut.getType2()) < 1||
           checkEffectiveness(oppPokemonOut.geta4().getType(), yourPokemonOut.getType1()) < 1||
           checkEffectiveness(oppPokemonOut.geta4().getType(), yourPokemonOut.getType2()) < 1)){
             option = 1;
           }
          else{
            option = 0;
          }*/
       return option;
       }
    
    
}