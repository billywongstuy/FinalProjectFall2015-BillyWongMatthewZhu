class Ai_Hard extends AI{
    ArrayList<Integer> EffectiveMove = new ArrayList<Integer>();
    public Ai_Hard(Poke p1, Poke p2, Poke p3){
                super(p1,p2,p3);
              }
              
              Attack chooseMove(Poke PlayerPoke){
              ArrayList<Attack>attacks = new ArrayList<Attack>();
              ArrayList<Attack>EffectiveMove = new ArrayList<Attack>();
              int strongestEffectiveness = 2;
              int moveNumber = 0;
              int powerCompare = 0;
              Attack planAttack = attacks.get(moveNumber);
             /* if(checkEffectiveness(PlayerPoke.geta1().getType(), oppPokemonOut.getType1()) > 1||
              checkEffectiveness(PlayerPoke.geta1().getType(), oppPokemonOut.getType2()) > 1||
              checkEffectiveness(PlayerPoke.geta2().getType(), oppPokemonOut.getType1())> 1||
              checkEffectiveness(PlayerPoke.geta2().getType(), oppPokemonOut.getType2()) > 1||
              checkEffectiveness(PlayerPoke.geta3().getType(), oppPokemonOut.getType1()) > 1||
              checkEffectiveness(PlayerPoke.geta3().getType(), oppPokemonOut.getType2()) > 1||
              checkEffectiveness(PlayerPoke.geta4().getType(), oppPokemonOut.getType1()) > 1||
              checkEffectiveness(PlayerPoke.geta4().getType(), oppPokemonOut.getType1()) > 1){
                //Swap pokemon out for advatangeous type
              }
              */
              
              //check if the typeffectiveness of each attack >= strongestEffectiveness if so, add it to arraylist then set strongest
              //at end remove any elements with effectiveness < strongest
                for(int i = 0; i < attacks.size(); i ++){
                  if(i < attacks.size()){
                    if(checkEffectiveness(attacks.get(i).getType(),PlayerPoke.getType1()) > 2
                    || checkEffectiveness(attacks.get(i).getType(),PlayerPoke.getType2())>2){
                   EffectiveMove.add(attacks.get(i));
                    }
                  }
                }
              if(EffectiveMove.size() == 0){
 
                   moveNumber = (int)(Math.random()*4);
                   planAttack = attacks.get(moveNumber); 
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
             else{
               Attack HiDamage = EffectiveMove.get(0);
               for(int j = 0; j < EffectiveMove.size(); j ++){
                 if(EffectiveMove.get(j).getPower() > HiDamage.getPower()){
                   HiDamage = EffectiveMove.get(j);
                 }
               }
               planAttack = HiDamage;
               return planAttack;
             }
                   
                 
          }
}