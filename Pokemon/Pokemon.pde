PImage battle;
PImage options;
PImage yourPoke;
PImage oppPoke;

PImage choiceArrow;
int cArrowX = 288;
int cArrowY = 450;

PImage move;
PImage moveArrow;
int mArrowY = 420;

PFont font;
String yourdisplayHealth;
String yourdisplayHP;
String state;
int slow = 0;
//ArrayList<Poke>Pokemons = new ArrayList<Poke>(151);
//ArrayList<Poke>yourTeam = new ArrayList<Poke>(3);

void setup() {
  background(255,255,255);
  size(640,576);
  font = loadFont("PokemonGB-32.vlw");
  textFont(font, 32);
  state = "chooseOption";
  
  battle = loadImage("battlers-info-template.png");  
  yourPoke = loadImage("Sprites/Back/" + Pikachu.index+".PNG"); 
  oppPoke = loadImage("Sprites/Front/" + Raichu.index+".PNG");
 
  yourPoke.resize(230,230);
  oppPoke.resize(225,225);
 
  options = loadImage("pkmn-battle-bottom-bar.png");
  choiceArrow = loadImage("arrow.png");
 
  move = loadImage("choose-move-template.png");
  moveArrow = loadImage("arrow.png");
  
  
  //Pokemons.add(new Bulbasaur());
  //yourTeam.add(Pokemons.get(0));
  Pikachu.a1 = Surf;
  Pikachu.a2 = Thunder;
  Pikachu.a3 = Strength;
  Pikachu.a4 = Thunderbolt;
}

void draw() {
  //println(team);
  frameRate(30);
  displayBattlersInfo();
  if (state.equals("chooseOption")) {
    setupOptionScreen();
  }
  if (state.equals("chooseMove")) {
    setupMoveChoice();
  }
}

void setupMoveChoice() {
  image(move,0,0);
  text(Pikachu.a1.toString(),193,445);
  text(Pikachu.a2.toString(),193,477);
  text(Pikachu.a3.toString(),193,510);
  text(Pikachu.a4.toString(),193,541);
  image(moveArrow,160,mArrowY);
 
 switch(mArrowY) {
   case 420:
     text(Pikachu.a1.getType(),65,349);
     text(Pikachu.a1.ppLeft,160,381);
     text(Pikachu.a1.pp,255,381);
     break;
   case 452:
     text(Pikachu.a2.getType(),65,349);
     text(Pikachu.a2.ppLeft,160,381);
     text(Pikachu.a2.pp,255,381);
     break;
   case 485:
     text(Pikachu.a3.getType(),65,349);
     text(Pikachu.a3.ppLeft,160,381);
     text(Pikachu.a3.pp,255,381);
     break;
   case 516:
     text(Pikachu.a4.getType(),65,349);
     text(Pikachu.a4.ppLeft,160,381);
     text(Pikachu.a4.pp,255,381);
     break;
 }
 
 if (slow == 0) {
   slow = 1;  
 }
 else {
   slow = 0;
 }
 
  if (keyPressed && key == CODED && slow == 0) {
    frameRate(10);
    if (keyCode == UP) {
      if (mArrowY == 452) {
        mArrowY = 420; 
      }
      else if (mArrowY == 485) {
        mArrowY = 452;
      }
      else if (mArrowY == 516) {
        mArrowY = 485;
      }
    }
    if (keyCode == DOWN) {
      if (mArrowY == 485) {
        mArrowY = 516;
      }
      else if (mArrowY == 452) {
        mArrowY = 485;
      }
      else if (mArrowY == 420) {
        mArrowY = 452;
      }
    }
  }
  
  if (keyPressed && (key == 'x' || key == 'X')) {
    state = "chooseOption";    
  }
  
}

void setupOptionScreen() {
  image(choiceArrow,cArrowX,cArrowY);
  if (keyPressed && key == CODED) {
    if (keyCode == UP && cArrowY >= 512) {
      cArrowY = 450;
    }
    if (keyCode == DOWN && cArrowY <= 450) {
      cArrowY = 512;
    }
    if (keyCode == LEFT && cArrowX >= 482) {
      cArrowX = 288;
    }
    if (keyCode == RIGHT && cArrowX >= 288) {
      cArrowX = 482;
    }
  }
  if (keyPressed && cArrowX == 288 && cArrowY == 450 && (key == 'z' || key == 'Z')) {
    state = "chooseMove";    
  }
  
}

void displayBattlersInfo() {
  image(battle,0,0);
  
  image(yourPoke,33,155);
  image(oppPoke,380,0);
  image(options,0,388);
 
  fill(color(0));
  
  text(Pikachu.getName().toUpperCase(),319,252);  
  yourdisplayHealth = " " + Pikachu.health;
  text(yourdisplayHealth.substring(yourdisplayHealth.length()-3),350,348);
  yourdisplayHP = " " + Pikachu.hp;
  text(yourdisplayHP.substring(yourdisplayHP.length()-3),480,348);
  
  if (Pikachu.getStatus().equals("none")) {
    text(Pikachu.lv,480,285);
  }
  else {
    fill(color(255,255,255));
    noStroke();
    rect(445,254,32,32);
    fill(color(0));
    text(Pikachu.getStatus(),430,285);
  }   
    
  text(Raichu.getName().toUpperCase(),35,30);
  if (Raichu.getStatus().equals("none")) {
    text(Raichu.lv,156,60);  
  }
  else {
    fill(color(255,255,255));
    noStroke();
    rect(125,29,32,32);
    fill(color(0));
    text(Raichu.getStatus(),126,60);
  }
}