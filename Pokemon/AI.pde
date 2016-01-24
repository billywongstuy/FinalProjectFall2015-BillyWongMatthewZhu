//AI_Team is equivalent to oppTeam //they both never change after the battle starts

import java.lang.Object;
import java.util.*;
abstract class AI {
  Poke[]PlayerTeam = new Poke[3];
  Attack [][] PlayerAttacks = new Attack[3][4];
  public ArrayList<Poke> AI_Team = new ArrayList<Poke>(3);
  String name;
  int pokemonStored = 0;
  int[]attacksStored = {0,0,0,0};

  public AI(Poke p1, Poke p2, Poke p3) {
      AI_Team.add(p1);
      AI_Team.add(p2);
      AI_Team.add(p3);
      name = "PROF OAK";
  }
  
  public AI(Poke p1, Poke p2, Poke p3, String n) {
      AI_Team.add(p1);
      AI_Team.add(p2);
      AI_Team.add(p3);
      name = n.toUpperCase();
  }
  
 
  
  void storeAttack(){
    //if attack is none or null then immediately stop
      //check if the pokemon matches the current pokemon out
      //if PlayerAttacks[i][3] != null stop
      //if so check to see if yourAttack is in the PlayerAttacks[i][0-attacksStored[i]]
      //if not PlayerAttacks[i][attacksStored[i]] = yourAttack
      //attacksStored[i] ++
      
    
    if(yourAttack != null && yourAttack != None){
      for (int i = 0; i < pokemonStored; i++) {
        if(PlayerTeam[i].getClass()== yourPokemonOut.getClass()){
          boolean hasMove = false;
          if (PlayerAttacks[i][3] == null) {
            for(int a = 0; a < attacksStored[i]; a ++){
              if (PlayerAttacks[i][a] == yourAttack) {
                hasMove = true;
              }
            }
            if (!hasMove) {
              PlayerAttacks[i][attacksStored[i]] = yourAttack;
              attacksStored[i]++;
            }
          }
        }
      }
    }
  }
  
  void storePokemon() {
    if (PlayerTeam[2] == null) {
      boolean alreadyStored = false;
      for (int i = 0; i < pokemonStored; i++) {
        if (PlayerTeam[i].getClass().equals(yourPokemonOut.getClass())) {
          alreadyStored = true;
        }
      }
      if (!alreadyStored) {
        PlayerTeam[pokemonStored] = yourPokemonOut;
        pokemonStored++;
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
      
      
      
      
    

    
  
    
  
  

  
  
  
 
  