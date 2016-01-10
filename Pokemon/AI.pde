import java.lang.Object;
import java.util.*;
abstract class AI {
  private ArrayList<Poke> PlayerPokeTeam = new ArrayList<Poke>();
  private ArrayList<Poke> AIPokeTeam = new ArrayList<Poke>();
  private Attack[][] PokeAttacks = new Attack[3][4];
  private int counter = 0;

  void AddAI(){
  AIPokeTeam.add(Bulbasaur);
  AIPokeTeam.add(Ivysaur);
  AIPokeTeam.add(Venusaur);
  }
  void addPokeTeam(Poke pokemon){
    PlayerPokeTeam.add(pokemon);
  }
  void addPokeAttacks(Poke pokemon ,Attack attack){
    int PokePosition = PlayerPokeTeam.indexOf(pokemon);
    PokeAttacks[PokePosition][counter]= attack;
    counter ++;
  }
  
   abstract Attack chooseMove(Poke PlayersPoke);
 //  AddAI();
   // boolean check = PlayerPokeTeam.size() >= 1;
    //if(check){
    //  Random rng = new Random();
    //  if(rng.nextInt(3) == 0){
     // }
     // if(rng.nextInt(3) ==1){
     // }
     // if(rng.nextInt(3) == 2){
     // }
  //  }
 // }
}
      
      
      
      
    

    
  
    
  
  

  
  
  
 
  