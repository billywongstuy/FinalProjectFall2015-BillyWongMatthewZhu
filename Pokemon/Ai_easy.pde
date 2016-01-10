      class Ai_easy extends AI{
        Attack chooseMove(Poke PlayerPoke){
          int moveNumber = (int)Math.random()*4;
          Attack planAttack = AIPokeTeam[0].geta1();
          if(PlayerPoke.getStatus()=="none"){
            if(moveNumber == 0){
              planAttack = AIPokeTeam.geta1();
            }
             if(moveNumber == 1){
              planAttack = AIPokeTeam.geta2();
            }
             if(moveNumber == 2){
              planAttack = AIPokeTeam.geta3();
            }
             if(moveNumber == 3){
              planAttack = AIPokeTeam.geta4();
            }
          }
            else{
              if(moveNumber == 0){
              if (!AIPokeTeam.geta1().effect1.equals("") && AIPokeTeam.geta1().effect1Chance == 1){
                planAttack = AIPokeTeam.geta1();
              }
              }
              if(moveNumber == 1){
              if (!AIPokeTeam.geta2().effect1.equals("") && AIPokeTeam.geta2().effect1Chance == 1){
                planAttack = AIPokeTeam.geta2();
              }
            }
              if(moveNumber == 2){
              if (!AIPokeTeam.geta3().effect1.equals("") && AIPokeTeam.geta3().effect1Chance == 1){
                planAttack = AIPokeTeam.geta3();
              }
            }
              if(moveNumber == 3){
              if (!AIPokeTeam.geta4().effect1.equals("") && AIPokeTeam.geta4().effect1Chance == 1){
                planAttack = AIPokeTeam.geta4();
              }
            }
              
   
        
    }