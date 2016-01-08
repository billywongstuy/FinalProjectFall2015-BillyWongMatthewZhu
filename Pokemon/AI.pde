import java.lang.Object;
abstract class AI {
  private ArrayList<Poke> PlayerPokeTeam = new ArrayList<Poke>();
  private Attack[][] PokeAttacks = new Attack[3][4];
  private int counter = 0;
  
  void addPokeTeam(Poke pokemon){
    PlayerPokeTeam.add(pokemon);
  }
  void addPokeAttacks(Poke pokemon ,Attack attack){
    int PokePosition = PlayerPokeTeam.indexOf(pokemon);
    PokeAttacks[PokePosition][counter]= attack;
    counter ++;
  }
  }
  void start(){
    new boolean check = PlayerPokeTeam.size() >= 1;
    if(check){
      
      
    

    
  
    
  
  
}
  
  
  
 
  