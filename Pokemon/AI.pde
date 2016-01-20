//AI_Team is equivalent to oppTeam //they both never change after the battle starts

import java.lang.Object;
import java.util.*;
abstract class AI {
  Poke[]PlayerTeam = new Poke[3];
  Attack [][] PlayerAttacks = new Attack[3][4];
  public ArrayList<Poke> AI_Team = new ArrayList<Poke>(3);
  String name;
  int pokemonStored = 0;
  int[]attacksStored = {0,0,0};

  public AI(Poke p1, Poke p2, Poke p3) {
      AI_Team.add(p1);
      AI_Team.add(p2);
      AI_Team.add(p3);
      name = "TRAINER";
  }
  
  public AI(Poke p1, Poke p2, Poke p3, String n) {
      AI_Team.add(p1);
      AI_Team.add(p2);
      AI_Team.add(p3);
      name = n.toUpperCase();
  }
  
  

  
  void storeAttack(){
    for (int i = 0; i < PlayerTeam.length; i++) {
      //if attack is none or null then immediately stop
      //check if the pokemon matches the current pokemon out
      //if PlayerAttacks[i][3] != null stop
      //if so check to see if yourAttack is in the PlayerAttacks[i][0-attacksStored]
      //if not PlayerAttacks[i][attacksStored] = yourAttack
      //attacksStored ++
      
    }
  }
  
  void storePokemon() {
    //if PlayerTeam[2] != null, then stop
    
    PlayerTeam[pokemonStored] = yourPokemonOut;
    for (int i = 0; i < pokemonStored; i++) {
      if (PlayerTeam[i].getClass().equals(yourPokemonOut.getClass())) {
        PlayerTeam[pokemonStored-1] = null;  
      }
    }
  }
    
   abstract Poke chooseNextPoke();
   abstract Attack chooseMove();  
   abstract int chooseAction();
   
   String toString() {
     return name;  
   }

}
      
      
      
      
    

    
  
    
  
  

  
  
  
 
  