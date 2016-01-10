import java.lang.Object;
import java.util.*;
abstract class AI {
  private ArrayList<Poke> PlayerPokeTeam = new ArrayList<Poke>();
  private ArrayList<Poke> AI_Team = new ArrayList<Poke>();
  private Attack[][] PokeAttacks = new Attack[3][4];
  private int counter = 0;

  public AI(Poke p1, Poke p2, Poke p3) {
      AI_Team.add(p1);
      AI_Team.add(p2);
      AI_Team.add(p3);
  }

  
  void addPokeAttacks(Poke pokemon,Attack attack){
    int PokePosition = PlayerPokeTeam.indexOf(pokemon);
    PokeAttacks[PokePosition][counter]= attack;
    counter ++;
  }
  
   abstract Attack chooseMove(Poke PlayersPoke);

}
      
      
      
      
    

    
  
    
  
  

  
  
  
 
  