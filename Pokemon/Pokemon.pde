PFont font;
PImage battle;
PImage blankBox;
PImage options;
PImage yourPoke;
PImage oppPoke;

PImage choiceArrow;
int cArrowX = 288;
int cArrowY = 450;

PImage move;
PImage moveArrow;
int mArrowY = 420;

String state;
int slow = 0;
int attackTransitionTime = 0;
int textShowTime = 0;

String speedWinner;
int hpToShow;
String yourdisplayHP;

Attack yourAttack;
Attack oppAttack;
int oppHealthLost = 0;
int yourHealthLost = 0;

ArrayList<Poke>yourTeam = new ArrayList<Poke>();
Poke yourPokemonOut;

ArrayList<Poke>oppTeam = new ArrayList<Poke>();
Poke oppPokemonOut;
AI OppTrainer;


void setup() {
  background(255,255,255);
  size(640,576);
  font = loadFont("PokemonGB-32.vlw");
  textFont(font, 32);
  state = "chooseOption";
  
  setupPokeSet();
  yourTeam.add(Pokemons.get(24)); 
  oppTeam.add((Poke)(Pokemons.get(18).clone()));
  
  
  battle = loadImage("battlers-info-template.png");  
  yourPoke = loadImage("Sprites/Back/" + yourTeam.get(0).index+".PNG"); 
  oppPoke = loadImage("Sprites/Front/" + oppTeam.get(0).index+".PNG");
 
  yourPoke.resize(230,230);
  oppPoke.resize(225,225);
 
  options = loadImage("pkmn-battle-bottom-bar.png");
  choiceArrow = loadImage("arrow.png");
 
  move = loadImage("choose-move-template.png");
  moveArrow = loadImage("arrow.png");
  
  blankBox = loadImage("blank_box_bottom.png");
  
  
  yourTeam.get(0).a1 = Surf;
  yourTeam.get(0).a2 = Thunder;
  yourTeam.get(0).a3 = Strength;
  yourTeam.get(0).a4 = Thunderbolt;
  
  hpToShow = yourTeam.get(0).hp;
  yourdisplayHP = " " + yourTeam.get(0).hp;
   
}

void draw() {
  frameRate(30);
  displayBattlersInfo();
  if (state.equals("chooseOption")) {
    setupOptionScreen();
  }
  if (state.equals("chooseMove")) {
    setupMoveChoice();
    if (attackTransitionTime >= 25) {
      turnEvents(); 
    }
    else {
      attackTransitionTime++;  
    }
  }
  animateTurn();
  showHPBar();
  if (state.equals("chooseNext-you")) {
      
  }
}


//----------------------------------------------------------
//THIS FUNCTION SCROLLS THE HP AND DISPLAY ALL ATTACK TEXT
//----------------------------------------------------------

void animateTurn() {
  //needs to add text box with attacks and side effects
  
  if (state.equals("turn-p1") || state.equals("turn-p2") || state.equals("crit-1") || state.equals("crit-2") || state.equals("faintShow")) {
    image(blankBox,0,0);  
  }
  
  //ANIMATE YOUR OPPONENT ATTACKING
  if ((state.equals("turn-p1") && speedWinner.equals("opp")) || (state.equals("turn-p2") && speedWinner.equals("you"))) { 
    yourDropHealth();
    if (oppTeam.get(0).turnParalyzed) {
      text("Enemy " + oppTeam.get(0).getName()+"\'s",50,475);
      text("paralyzed!",50,535);
      textShowTime++;
    }
    else {
      text("Enemy " + oppTeam.get(0).getName(),50,475);
      text("used " + oppAttack.toString()+"!",50,535);
    }
  }

  //animate you attacking
  if ((state.equals("turn-p1") && speedWinner.equals("you")) || (state.equals("turn-p2") && speedWinner.equals("opp"))) {
    oppDropHealth();
    if (yourTeam.get(0).turnParalyzed) {
      text(yourTeam.get(0).getName()+"\'s",50,475);
      text("paralyzed!",50,535);
      textShowTime++;
    }
    else {
      text(yourTeam.get(0).getName(),50,475);
      text("used " + yourAttack.toString()+"!",50,535);
    }
  }
  
  //text for crits and transitioning to next phase
  if (state.equals("crit-1") && textShowTime < 45) {
    text("A critical hit!",50,475);  
    textShowTime++;
  }
  if (state.equals("crit-1") && textShowTime >= 45) {
    state = "turn-p2";
    textShowTime = 0;
  }
  if (state.equals("crit-2") && textShowTime < 45) {
    text("A critical hit!",50,475);  
    textShowTime++;
  }
  if (state.equals("crit-2") && textShowTime >= 45) {
    state = "chooseOption";
    textShowTime = 0;
  }
  
  //when your opponent faints
  if (oppTeam.get(0).status.equals("FNT") && oppHealthLost == oppTeam.get(0).health && !state.equals("chooseNext-opp")) {
    if (textShowTime < 60) {
      state = "faintShow";
      text("Enemy " + oppTeam.get(0).getName(),50,475);
      text("fainted!",50,535);
      textShowTime++;
    }
    else {
      textShowTime = 0;  
      state = "chooseNext-opp";
    }
  }
  
  //when you faint
  if (yourTeam.get(0).status.equals("FNT") && yourHealthLost == yourTeam.get(0).health && !state.equals("chooseNext-you")) {
    if (textShowTime < 60) {
      state = "faintShow";
      text(yourTeam.get(0).getName(),50,475);
      text("fainted!",50,535);
      textShowTime++;
    }
    else {
      textShowTime = 0;  
      state = "chooseNext-you";
    }
  }
  
  //chooseNext state is the switch screen. to be implemented
  
}

//-----------------------
//HP BAR DISPLAY
//-----------------------
void showHPBar() {
  noStroke();
  fill(color(255));
  rect(575-(yourHealthLost*190/yourTeam.get(0).health),300,(yourHealthLost*190/yourTeam.get(0).health),8);
  rect(319-(oppHealthLost*190/oppTeam.get(0).health),76,(oppHealthLost*190/oppTeam.get(0).health),8);  
}

void turnEvents() {
  if (state.equals("chooseMove") && keyPressed && (key == 'Z' || key == 'z')) {
    state = "turn-p1";
    
    //incorporate speed and turns
    switch(mArrowY) {
       case 420:
         yourAttack = yourTeam.get(0).a1;
         break;
       case 452:
         yourAttack = yourTeam.get(0).a2;
         break;
       case 485:
         yourAttack = yourTeam.get(0).a3;
         break;
       case 516:
         yourAttack = yourTeam.get(0).a4;
         break;
    }
    
    int yourSpeed = yourTeam.get(0).speed;
    int oppSpeed = oppTeam.get(0).speed;
    
    //paralysis hindrance
    if (oppTeam.get(0).getStatus().equals("PRZ")) {
      oppSpeed /= 4;
    }
    if (yourTeam.get(0).getStatus().equals("PRZ")) {
      yourSpeed /= 4;
    }
    
    //who goes first
    if (yourSpeed > oppSpeed) {
      speedWinner = "you";  
    }
    else if (oppSpeed > yourSpeed) {
      speedWinner = "opp";  
    }
    //speedtie
    else if ((int)(Math.random()*2) == 0) {
      speedWinner = "you";  
    }
    else {
      speedWinner = "opp";  
    }
    
    //opponent chooses move
    oppAttack = Tackle;   //should be oppAttack = OppTrainer.chooseMove(yourTeam.get(0));
    
    if (speedWinner.equals("you")) {
      yourTeam.get(0).attack(oppTeam.get(0),yourAttack);
      oppTeam.get(0).attack(yourTeam.get(0),oppAttack);
    }
    else if (speedWinner.equals("opp")) {
      oppTeam.get(0).attack(yourTeam.get(0),oppAttack);  
      yourTeam.get(0).attack(oppTeam.get(0),yourAttack);  
    }
    
    attackTransitionTime = 0;
  }
}


//-------------------------------------
//DROP OPPONENT'S HEALTH BIT BY BIT
//-------------------------------------
void oppDropHealth() {
  
  //add some text display to be placed here: Pokemon used attack!
  
  if (oppTeam.get(0).health - oppTeam.get(0).hp > oppHealthLost) {
    if (oppHealthLost < oppTeam.get(0).health) {
      oppHealthLost++;  
    }
  }
  else if (yourTeam.get(0).turnParalyzed && textShowTime < 45) {
    
  }
  else{
    textShowTime = 0;
    if ((yourTeam.get(0).attackCrit) && state.equals("turn-p1")) {
      state = "crit-1"; 
    }
    else if ((yourTeam.get(0).attackCrit) && state.equals("turn-p2")) {
      state = "crit-2";  
    }
    
    else if (state.equals("turn-p1")) {      
      state = "turn-p2"; 
    }
    else {
      state = "chooseOption";
    }    
  }  
}

//-------------------------------------
//DROP YOUR HEALTH BIT BY BIT
//-------------------------------------
void yourDropHealth() {
  if (yourTeam.get(0).health - yourTeam.get(0).hp > yourHealthLost) {
    if (yourHealthLost < yourTeam.get(0).health && !oppTeam.get(0).turnParalyzed) {
      yourHealthLost++; 
      hpToShow--;
    }
  }
  else if (oppTeam.get(0).turnParalyzed && textShowTime < 45) {
    
  }
  else{
    textShowTime = 0;
    if ((oppTeam.get(0).attackCrit) && state.equals("turn-p1")) {
      state = "crit-1"; 
    }
    else if ((oppTeam.get(0).attackCrit) && state.equals("turn-p2")) {
      state = "crit-2";  
    }
    
    else if (state.equals("turn-p1")) {
      state = "turn-p2"; 
    }
    else {
      state = "chooseOption";
    }    
  }    
}

//----------------------------------------
//SETUP SCREEN WHERE YOU CHOOSE ATTACK
//-----------------------------------------
void setupMoveChoice() {
  image(move,0,0);
  text(yourTeam.get(0).a1.toString(),193,445);
  text(yourTeam.get(0).a2.toString(),193,477);
  text(yourTeam.get(0).a3.toString(),193,510);
  text(yourTeam.get(0).a4.toString(),193,541);
  image(moveArrow,160,mArrowY);
 
  switch(mArrowY) {
    case 420:
      text(yourTeam.get(0).a1.getType(),65,349);
      text(yourTeam.get(0).a1.ppLeft,160,381);
      text(yourTeam.get(0).a1.pp,255,381);
      break;
    case 452:
      text(yourTeam.get(0).a2.getType(),65,349);
      text(yourTeam.get(0).a2.ppLeft,160,381);
      text(yourTeam.get(0).a2.pp,255,381);
      break;
    case 485:
      text(yourTeam.get(0).a3.getType(),65,349);
      text(yourTeam.get(0).a3.ppLeft,160,381);
      text(yourTeam.get(0).a3.pp,255,381);
      break;
    case 516:
      text(yourTeam.get(0).a4.getType(),65,349);
      text(yourTeam.get(0).a4.ppLeft,160,381);
      text(yourTeam.get(0).a4.pp,255,381);
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


//-----------------------------------------------------------
//SETUP SCREEN WHERE YOU CHOOSE TO FIGHT, SWITCH, OR RUN
//-----------------------------------------------------------
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

//------------------------------------------------------
//SETUP IMAGES FOR BATTLING POKEMON AND FULL HP BARS
//------------------------------------------------------
void displayBattlersInfo() {
  image(battle,0,0);
  
  image(yourPoke,33,155);
  image(oppPoke,380,0);
  image(options,0,388);
 
  fill(color(0));
  
  text(yourTeam.get(0).getName(),319,252);  
  String yourdisplayHealth;
  yourdisplayHealth = " " + yourTeam.get(0).health;
  text(yourdisplayHealth.substring(yourdisplayHealth.length()-3),480,348);
  
  yourdisplayHP = " "+hpToShow;
  if (yourdisplayHP.length() <= 2) {
    yourdisplayHP = " " +  yourdisplayHP;
  }
  text(yourdisplayHP.substring(yourdisplayHP.length()-3),350,348);
  
  if (yourTeam.get(0).getStatus().equals("none") || (yourTeam.get(0).getStatus().equals("FNT") && yourHealthLost < yourTeam.get(0).health)) {
    text(yourTeam.get(0).lv,480,285);
  }
  else {
    fill(color(255,255,255));
    noStroke();
    rect(445,254,32,32);
    fill(color(0));
    text(yourTeam.get(0).getStatus(),430,285);
  }   
    
  text(oppTeam.get(0).getName(),35,30);
  if (oppTeam.get(0).getStatus().equals("none") || (oppTeam.get(0).getStatus().equals("FNT") && oppHealthLost < oppTeam.get(0).health)) {
    text(oppTeam.get(0).lv,156,60);  
  }
  else {
    fill(color(255,255,255));
    noStroke();
    rect(125,29,32,32);
    fill(color(0));
    text(oppTeam.get(0).getStatus(),126,60);
  }
  
  
}