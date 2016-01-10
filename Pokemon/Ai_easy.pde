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