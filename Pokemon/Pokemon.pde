PImage options;
PImage arrow;
PImage yourPoke;
PImage oppPoke;
PImage battle;
PFont font;
int arrowX = 288;
int arrowY = 450;
String displayHealth;
String displayHP;

void setup() {
  battle = loadImage("battlers-info-template.png");
  
  background(255,255,255);
  size(640,576);
  options = loadImage("pkmn-battle-bottom-bar.png");
  arrow = loadImage("arrow.png");
  yourPoke = loadImage("Sprites/Back/" + Pikachu.index+".PNG");
  
  //manually resize these to 245 px (in case need to resize) for better res
  oppPoke = loadImage("Sprites/Front/" + Raichu.index+".PNG");
  
  yourPoke.resize(230,230);
  oppPoke.resize(225,225);
  font = loadFont("PokemonGB-32.vlw");
}

void draw() {
  setupScreen();
  
  //println(Charmander.attack(Bulbasaur,Fire_Blast));

  if (Bulbasaur.hp <= 0) {
     noLoop();
     println("Bulbasaur fainted!");
  }
}

void setupScreen() {
  image(battle,0,0);
  
  image(yourPoke,33,155);
  image(oppPoke,380,0);
  image(options,0,388);
  image(arrow,arrowX,arrowY);
  if (keyPressed && key == CODED) {
    if (keyCode == UP && arrowY >= 512) {
      image(arrow,arrowX,450);
      arrowY = 450;
    }
    if (keyCode == DOWN && arrowY <= 450) {
      image(arrow,arrowX,512);
      arrowY = 512;
    }
    if (keyCode == LEFT && arrowX >= 482) {
      image(arrow,288,arrowY);
      arrowX = 288;
    }
    if (keyCode == RIGHT && arrowX >= 288) {
      image(arrow,482,arrowY);
      arrowX = 482;
    }
  }
  textFont(font, 32);
  fill(color(0));
  text("PIKACHU",319,252);  
  displayHealth = " " + Pikachu.health;
  text(displayHealth.substring(displayHealth.length()-3),350,348);
  displayHP = " " + Pikachu.hp;
  text(displayHP.substring(displayHP.length()-3),480,348);
  
  //Pikachu.setStatus("BRN");
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