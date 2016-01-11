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
  yourPokemonOut = yourTeam.get(0);
  oppPokemonOut = oppTeam.get(0);
  
  battle = loadImage("battlers-info-template.png");  
  yourPoke = loadImage("Sprites/Back/" + yourPokemonOut.index+".PNG"); 
  oppPoke = loadImage("Sprites/Front/" + oppPokemonOut.index+".PNG");
 
  yourPoke.resize(230,230);
  oppPoke.resize(225,225);
 
  options = loadImage("pkmn-battle-bottom-bar.png");
  choiceArrow = loadImage("arrow.png");
 
  move = loadImage("choose-move-template.png");
  moveArrow = loadImage("arrow.png");
  
  blankBox = loadImage("blank_box_bottom.png");
  
  
  yourPokemonOut.a1 = Surf;
  yourPokemonOut.a2 = Thunder;
  yourPokemonOut.a3 = Strength;
  yourPokemonOut.a4 = Thunderbolt;
  
  hpToShow = yourPokemonOut.hp;
  yourdisplayHP = " " + yourPokemonOut.hp;
   
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
  if (state.equals("chooseNext-opp")) {
    
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
    if (oppPokemonOut.turnParalyzed) {
      text("Enemy " + oppPokemonOut.getName()+"\'s",50,475);
      text("paralyzed!",50,535);
      textShowTime++;
    }
    else if (oppPokemonOut.frozen) {
      text("Enemy " + oppPokemonOut.getName()+"\'s",50,475);
      text("frozen!",50,535);
      textShowTime++;    
    }
    else {
      text("Enemy " + oppPokemonOut.getName(),50,475);
      text("used " + oppAttack.toString()+"!",50,535);
    }
  }

  //ANIMATE YOU ATTACKING
  if ((state.equals("turn-p1") && speedWinner.equals("you")) || (state.equals("turn-p2") && speedWinner.equals("opp"))) {
    oppDropHealth();
    if (yourPokemonOut.turnParalyzed) {
      text(yourPokemonOut.getName()+"\'s",50,475);
      text("paralyzed!",50,535);
      textShowTime++;
    }
    else if (yourPokemonOut.frozen) {
      text(yourPokemonOut.getName()+"\'s",50,475);
      text("frozen!",50,535);
      textShowTime++;  
    }
    else {
      text(yourPokemonOut.getName(),50,475);
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
  
  if (state.equals("type-effect-opp") && textShowTime <= 45) {
    if (oppPokemonOut.attackEffectiveness == 0.5) {
        
    }
    if (oppPokemonOut.attackEffectiveness == 2) {
      
    }
    textShowTime++;
  }
  else {
    //state =
    textShowTime = 0;  
  }
  
  if (state.equals("type-effect-you")) {
    
  }
  
  
  //when your opponent faints
  if (oppPokemonOut.status.equals("FNT") && oppHealthLost == oppPokemonOut.health && !state.equals("chooseNext-opp")) {
    if (textShowTime < 60) {
      state = "faintShow";
      text("Enemy " + oppPokemonOut.getName(),50,475);
      text("fainted!",50,535);
      textShowTime++;
    }
    else {
      textShowTime = 0;  
      state = "chooseNext-opp";
    }
  }
  
  //when you faint
  if (yourPokemonOut.status.equals("FNT") && yourHealthLost == yourPokemonOut.health && !state.equals("chooseNext-you")) {
    if (textShowTime < 60) {
      state = "faintShow";
      text(yourPokemonOut.getName(),50,475);
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
  rect(575-(yourHealthLost*190/yourPokemonOut.health),300,(yourHealthLost*190/yourPokemonOut.health),8);
  rect(319-(oppHealthLost*190/oppPokemonOut.health),76,(oppHealthLost*190/oppPokemonOut.health),8);  
}

void turnEvents() {
  if (state.equals("chooseMove") && keyPressed && (key == 'Z' || key == 'z')) {
    state = "turn-p1";
    
    //incorporate speed and turns
    switch(mArrowY) {
       case 420:
         yourAttack = yourPokemonOut.a1;
         break;
       case 452:
         yourAttack = yourPokemonOut.a2;
         break;
       case 485:
         yourAttack = yourPokemonOut.a3;
         break;
       case 516:
         yourAttack = yourPokemonOut.a4;
         break;
    }
    
    int yourSpeed = yourPokemonOut.speed;
    int oppSpeed = oppPokemonOut.speed;
    
    //paralysis hindrance
    if (oppPokemonOut.getStatus().equals("PRZ")) {
      oppSpeed /= 4;
    }
    if (yourPokemonOut.getStatus().equals("PRZ")) {
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
    oppAttack = Tackle;   //should be oppAttack = OppTrainer.chooseMove(yourPokemonOut);
    
    if (speedWinner.equals("you")) {
      yourPokemonOut.attack(oppPokemonOut,yourAttack);
      oppPokemonOut.attack(yourPokemonOut,oppAttack);
    }
    else if (speedWinner.equals("opp")) {
      oppPokemonOut.attack(yourPokemonOut,oppAttack);  
      yourPokemonOut.attack(oppPokemonOut,yourAttack);  
    }
    
    attackTransitionTime = 0;
  }
}


//-------------------------------------
//DROP OPPONENT'S HEALTH BIT BY BIT
//-------------------------------------
void oppDropHealth() {
  
  //add some text display to be placed here: Pokemon used attack!
  
  if (oppPokemonOut.health - oppPokemonOut.hp > oppHealthLost) {
    if (oppHealthLost < oppPokemonOut.health) {
      oppHealthLost++;  
    }
  }
  else if ((yourPokemonOut.turnParalyzed || yourPokemonOut.frozen) && textShowTime < 45) {
    
  }
  else{
    textShowTime = 0;
    if ((yourPokemonOut.attackCrit) && state.equals("turn-p1")) {
      state = "crit-1"; 
    }
    else if ((yourPokemonOut.attackCrit) && state.equals("turn-p2")) {
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
  if (yourPokemonOut.health - yourPokemonOut.hp > yourHealthLost) {
    if (yourHealthLost < yourPokemonOut.health && !oppPokemonOut.turnParalyzed) {
      yourHealthLost++; 
      hpToShow--;
    }
  }
  else if ((oppPokemonOut.turnParalyzed || oppPokemonOut.frozen) && textShowTime < 45) {
    
  }
  else{
    textShowTime = 0;
    if ((oppPokemonOut.attackCrit) && state.equals("turn-p1")) {
      state = "crit-1"; 
    }
    else if ((oppPokemonOut.attackCrit) && state.equals("turn-p2")) {
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
  text(yourPokemonOut.a1.toString(),193,445);
  text(yourPokemonOut.a2.toString(),193,477);
  text(yourPokemonOut.a3.toString(),193,510);
  text(yourPokemonOut.a4.toString(),193,541);
  image(moveArrow,160,mArrowY);
 
  switch(mArrowY) {
    case 420:
      text(yourPokemonOut.a1.getType(),65,349);
      text(yourPokemonOut.a1.ppLeft,160,381);
      text(yourPokemonOut.a1.pp,255,381);
      break;
    case 452:
      text(yourPokemonOut.a2.getType(),65,349);
      text(yourPokemonOut.a2.ppLeft,160,381);
      text(yourPokemonOut.a2.pp,255,381);
      break;
    case 485:
      text(yourPokemonOut.a3.getType(),65,349);
      text(yourPokemonOut.a3.ppLeft,160,381);
      text(yourPokemonOut.a3.pp,255,381);
      break;
    case 516:
      text(yourPokemonOut.a4.getType(),65,349);
      text(yourPokemonOut.a4.ppLeft,160,381);
      text(yourPokemonOut.a4.pp,255,381);
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
  
  text(yourPokemonOut.getName(),319,252);  
  String yourdisplayHealth;
  yourdisplayHealth = " " + yourPokemonOut.health;
  text(yourdisplayHealth.substring(yourdisplayHealth.length()-3),480,348);
  
  yourdisplayHP = " "+hpToShow;
  if (yourdisplayHP.length() <= 2) {
    yourdisplayHP = " " +  yourdisplayHP;
  }
  text(yourdisplayHP.substring(yourdisplayHP.length()-3),350,348);
  
  if (yourPokemonOut.getStatus().equals("none") || (yourPokemonOut.getStatus().equals("FNT") && yourHealthLost < yourPokemonOut.health)) {
    text(yourPokemonOut.lv,480,285);
  }
  else {
    fill(color(255,255,255));
    noStroke();
    rect(445,254,32,32);
    fill(color(0));
    text(yourPokemonOut.getStatus(),430,285);
  }   
    
  text(oppPokemonOut.getName(),35,30);
  if (oppPokemonOut.getStatus().equals("none") || (oppPokemonOut.getStatus().equals("FNT") && oppHealthLost < oppPokemonOut.health)) {
    text(oppPokemonOut.lv,156,60);  
  }
  else {
    fill(color(255,255,255));
    noStroke();
    rect(125,29,32,32);
    fill(color(0));
    text(oppPokemonOut.getStatus(),126,60);
  }
  
  
}