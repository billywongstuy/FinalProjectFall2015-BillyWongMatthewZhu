PImage options;
PImage arrow;
int arrowX = 288;
int arrowY = 448;

void setup() {
  background(255,255,255);
  size(640,576);
  options = loadImage("pkmn-battle-bottom-bar.png");
  arrow = loadImage("arrow.png");
}

void draw() {
  image(options,0,386);
  image(arrow,arrowX,arrowY);
  if (keyPressed && key == CODED) {
    if (keyCode == UP && arrowY >= 510) {
      image(arrow,arrowX,448);
      arrowY = 448;
    }
    if (keyCode == DOWN && arrowY <= 448) {
      image(arrow,arrowX,510);
      arrowY = 510;
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
  //image(arrow,288,510);
  //image(arrow,482,448);
  //image(arrow,482,510);
  /*triangle(292,448,292,479,314,465);
  triangle(485,448,485,479,507,465);
  triangle(292,508,292,539,314,525);
  triangle(485,508,485,539,507,525);*/
  
  
  //println(Charmander.attack(Bulbasaur,Fire_Blast));

  if (Bulbasaur.hp <= 0) {
     noLoop();
     println("Bulbasaur fainted!");
  }
}