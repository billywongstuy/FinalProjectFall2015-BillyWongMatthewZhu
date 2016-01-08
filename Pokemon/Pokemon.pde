void setup() {
   
}

void draw() {
  println(Bulbasaur.status);
  println("took " + Charmander.attack(Bulbasaur,Fire_Blast)+ " damage");
  //println(checkEffectiveness("Water","Normal"));
  //println(checkEffectiveness(Tackle.type, "Fire"));
  //println(int("Water")+1);
  //println(Mew.attack(Mewtwo,test));
  if (Bulbasaur.hp <= 0) {
     noLoop();
     println("Bulbasaur fainted!");
  }
  println(Bulbasaur.hp + "HP left");
}