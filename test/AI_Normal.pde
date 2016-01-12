class AI_Normal extends AI{
    public AI_Normal(Poke p1, Poke p2, Poke p3){
                super(p1,p2,p3);
              }
             Attack chooseMove(Poke PlayerPoke){
              ArrayList<Attack>attacks = new ArrayList<Attack>(4);
              attacks.add(oppPokemonOut.geta1());  
              attacks.add(oppPokemonOut.geta2());
              attacks.add(oppPokemonOut.geta3());
              attacks.add(oppPokemonOut.geta4());
              int moveNumber = 0;
              Attack planAttack = attacks.get(moveNumber); 
                for(int i = 0; i < attacks.size(); i ++){
                  if(i < attacks.size()){
                  if(yourPokemonOut.getType2().equals("")){
                    if(checkEffectiveness(attacks.get(i).getType(),yourPokemonOut.getType1()) == 2.0 ){
                   moveNumber = i;
                    }
                    else{
                      if(checkEffectiveness(attacks.get(i).getType(),yourPokemonOut.getType1()) == 2.0 || checkEffectiveness(attacks.get(i).getType(),yourPokemonOut.getType2()) == 2.0  ){
                   moveNumber = i;
                      }
                    }
                  }
                  }
                
                else{
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
                }
              }
            
              return planAttack;
             }
          }
          
   
        