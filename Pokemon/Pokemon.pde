//FIX NOTES: 
//STATUS APPEARS AS SOON AS THE ANIMATION STARTS
//NO PAUSE BETWEEN ATTACK DAMAGE AND STATUS DAMAGE
//MIGHT BE TOO FAST FOR STATUS HP DROP

PFont font;
PImage battle;
PImage blankBox;
PImage options;
PImage yourPoke;
PImage oppPoke;

PImage chooseOppScreen;
PImage chooseOppArrow;
int cOArrowY = 300;
int oppLevel = 1;

boolean battleStart = false;
PImage choiceArrow;
int cArrowX = 288;
int cArrowY = 450;

PImage move;
PImage moveArrow;
int mArrowY = 420;

PImage switchScreen;
PImage switchArrow;
int sArrowY = 20;

String state;
boolean stateFlowCheck = true;
int slow = 0;
int attackTransitionTime = 0;
int textShowTime = 0;

//String speedWinner;
Poke speedWinner;     
Poke slowerPoke;
int hpToShow;
String yourdisplayHP;
String yourdisplayHealth;

Attack yourAttack;
Attack oppAttack;
int oppHealthLost = 0;
int yourHealthLost = 0;

ArrayList<Poke>yourTeam = new ArrayList<Poke>();
Poke yourPokemonOut;

ArrayList<Poke>oppTeam = new ArrayList<Poke>();
Poke oppPokemonOut;
AI OppTrainer;

int partySlot = 0;
boolean switchedThisTurn = false;

void setup() {
  background(255,255,255);
  size(640,576);
  font = loadFont("PokemonGB-32.vlw");
  textFont(font, 32);
  state = "chooseOpp";
  
  setupPokeSet();
  yourTeam.add(Pokemons.get(25)); 
  yourTeam.add(Pokemons.get(150));
  yourTeam.add(Pokemons.get(5));
  OppTrainer = new AI_Normal(Venusaur,Charizard,Blastoise);
  oppTeam = OppTrainer.AI_Team;
  yourPokemonOut = yourTeam.get(0);
  oppPokemonOut = oppTeam.get(0);
  
  chooseOppScreen = loadImage("choose-level.png");
  chooseOppArrow = loadImage("arrow.png");
  
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
  
  switchScreen = loadImage("switching.png");
  switchArrow = loadImage("arrow.png");
    
  yourPokemonOut.a1 = Surf;
  yourPokemonOut.a2 = Thunder;
  yourPokemonOut.a3 = Strength;
  yourPokemonOut.a4 = Thunderbolt;
  
  yourTeam.get(1).a1 = Surf;
  yourTeam.get(1).a2 = Thunder;
  yourTeam.get(1).a3 = Strength;
  yourTeam.get(1).a4 = Thunderbolt;
  
  yourTeam.get(2).a1 = Surf;
  yourTeam.get(2).a2 = Thunder;
  yourTeam.get(2).a3 = Strength;
  yourTeam.get(2).a4 = Thunderbolt;
  
  hpToShow = yourPokemonOut.hp;
  yourdisplayHP = " " + yourPokemonOut.hp;
  /*oppPokemonOut.a1 = Thunder_Wave;
  oppPokemonOut.a2 = Tackle;
  oppPokemonOut.a3 = Flamethrower;
  oppPokemonOut.a4 = Strength;*/
   
}

void draw() {
  println(state);
  frameRate(30);
  if (state.equals("chooseOpp")) {
    setupChooseOppScreen();  
  }
  if (battleStart) {
    displayBattlersInfo();
  }
  if (state.equals("chooseOption")) {
    setupOptionScreen();
  }
  if (state.equals("chooseMove")) {
    setupMoveChoice();
    if (attackTransitionTime >= 35) {
      turnEvents(); 
    }
    else {
      attackTransitionTime++;  
    }
  }
  animateTurn();
  showHPBar();
  if (state.equals("turnEndDamage") || state.equals("textEnd1") || state.equals("textEnd2")) {
    handleEndTurn();  
  }
  if (state.equals("choosePokeYou")) {
    switchYou();
  }
  if (state.equals("choosePokeOpp")) {
    switchOpp();
  }
  /*Pinsir.hp = 999;
  println(Pinsir.hp);
  Scyther.attack(Pinsir,Wing_Attack);
  println(Pinsir.hp);
  Scyther.attack(Pinsir,Swords_Dance);
  Scyther.attack(Pinsir,Wing_Attack);
  println(Pinsir.hp);
  noLoop();*/
}

//--------------------------------
//SWITCHING
//--------------------------------

void switchYou() {
  frameRate(10);
  if (!yourPokemonOut.getStatus().equals("FNT") && keyPressed && (key == 'x' || key == 'X')) {
    state = "chooseOption";
  }
  image(switchScreen,0,0);
  image(switchArrow,0,sArrowY);
  displayTeamInfo();
  //include the part that puts status instead of level later
  
  if (keyPressed && key == CODED && keyCode == DOWN) {
    switch(sArrowY) {
      case 20:
        sArrowY = 88;
        partySlot++;
        break;
      case 88:
        sArrowY = 151;
        partySlot++;
        break;
    }
  }
  if (keyPressed && key == CODED && keyCode == UP) {
    switch(sArrowY) {
      case 151:
        sArrowY = 88;
        partySlot--;
        break;
      case 88:
        sArrowY = 20;
        partySlot--;
        break;
    }
  }
  
  println(partySlot);
  if (keyPressed && (key == 'z' || key == 'Z')) {
    if (yourTeam.get(partySlot) == yourPokemonOut) {
      println(yourPokemonOut);
      println(yourTeam.get(partySlot));
      if (yourPokemonOut.getStatus().equals("FNT")) {
        println("No energy to battle!");  
      }
      else {
        println("Currently battling!");  
      }
    }
    else {
      println("change");
     
      if (!yourPokemonOut.getStatus().equals("FNT")) {
        switchedThisTurn = true;
      }
      
     
      yourPokemonOut = yourTeam.get(partySlot);
      yourHealthLost = yourPokemonOut.health - yourPokemonOut.hp;
      hpToShow = yourPokemonOut.hp;
      yourPoke = loadImage("Sprites/Back/" + yourPokemonOut.index+".PNG");
      
      //make it so that it skips the ability to attack if not fainted
      state = "chooseOption";
      stateFlowCheck = false;
      
      
      //FATAL FLAW: OPPONENT CHOOSES MOVE AFTER SWITCHING
      if (switchedThisTurn) {
        state = "chooseMove";
        turnEvents();
        println("ghsdjbidcbn");
      }
      
    }
  }
  
}


void switchOpp() {
  //make variable poke to switch into from ai method chooseNext
  //if opponent pokemon fainted set status to chooseOption
  //set oppPokemonOut to that pokemon
  //set oppHealthLost to health - hp
  //change the image
}

String hpString(int hp) {
  String showHealth = ""+hp;
  if (showHealth.length() <= 3) {
    showHealth = "  " + showHealth;
  }
  showHealth = showHealth.substring(showHealth.length()-3);
  return showHealth;
}


void displayTeamInfo() {
  fill(color(0));
  text(yourTeam.get(0).getName(),99,30);
  text(yourTeam.get(1).getName(),99,93);
  text(yourTeam.get(2).getName(),99,156);
  
  text(hpString(yourTeam.get(0).hp),415,60);
  text(hpString(yourTeam.get(0).health),545,60);
  text(yourTeam.get(0).lv,450,29);
  
  text(hpString(yourTeam.get(1).hp),415,123);
  text(hpString(yourTeam.get(1).health),545,123);
  text(yourTeam.get(1).lv,450,92);
  
  text(hpString(yourTeam.get(2).hp),415,186);
  text(hpString(yourTeam.get(2).health),545,186);
  text(yourTeam.get(2).lv,450,155);
  
  fill(color(48,164,71));
  rect(192,44,yourTeam.get(0).hp*192/yourTeam.get(0).health,8);
  rect(192,108,yourTeam.get(1).hp*192/yourTeam.get(1).health,8);
  rect(192,172,yourTeam.get(2).hp*192/yourTeam.get(2).health,8);
}

//--------------------------------------------------
//THIS FUNCTION HANDLES ALL THE END OF TURN THINGS
//--------------------------------------------------

void handleEndTurn() {
  image(blankBox,0,0); 
  fill(color(0));
  
  if (state.equals("turnEndDamage")) {
    println("entered");
    //incorporate speed later
    if (yourPokemonOut.getStatus().equals("BRN") || yourPokemonOut.getStatus().equals("PSN")) {
      yourPokemonOut.takeDamage((int)(yourPokemonOut.health/16));
      println("HP:" + yourPokemonOut.hp);
    }
    if (oppPokemonOut.getStatus().equals("BRN") || oppPokemonOut.getStatus().equals("PSN")) {
      oppPokemonOut.takeDamage((int)(oppPokemonOut.health/16));
    }
    state = "textEnd1";
  }
  if (state.equals("textEnd1")) {
    
    if (speedWinner.getStatus().equals("BRN")) {
      if (speedWinner == yourPokemonOut) {
        text(speedWinner.getName() + "'s",50,475);
      }
      else {
        text("Enemy " + speedWinner.getName() + "'s",50,475);
      }
      text("hurt by the burn!",50,535);
    }
    else if (speedWinner.getStatus().equals("PSN")) {
      if (speedWinner == yourPokemonOut) {
        text(speedWinner.getName() + "'s",50,475);
      }
      else {
        text("Enemy " + speedWinner.getName() + "'s",50,475);
      }
      text("hurt by poison!",50,535);      
    }
    
    if (speedWinner == yourPokemonOut) {yourDropHealth();}
    else {oppDropHealth();}

  }
  if (state.equals("textEnd2")) {
    println("entered-2");
        
    if (slowerPoke.getStatus().equals("BRN")) {
      if (slowerPoke == yourPokemonOut) {
        text(slowerPoke.getName() + "'s",50,475);
      }
      else {
        text("Enemy " + slowerPoke.getName() + "'s",50,475);
      }
      text("hurt by the burn!",50,535);
    }
    else if (slowerPoke.getStatus().equals("PSN")) {
      if (slowerPoke == yourPokemonOut) {
        text(slowerPoke.getName() + "'s",50,475);
      }
      else {
        text("Enemy " + slowerPoke.getName() + "'s",50,475);
      }
      text("hurt by poison!",50,535);    
    }
    
    if (slowerPoke == yourPokemonOut) {yourDropHealth();}
    else {oppDropHealth();}
  
    cArrowX = 288;
    cArrowY = 450;
  }  
}


//----------------------------------------------------------
//THIS FUNCTION SCROLLS THE HP AND DISPLAY ALL ATTACK TEXT
//----------------------------------------------------------

void animateTurn() {
  //needs to add text box with attacks and side effects
  
  if (state.equals("turn-p1") || state.equals("turn-p2") || state.equals("crit-1") || state.equals("crit-2") || state.equals("faintShow") || state.equals("type-effect-you") || state.equals("type-effect-opp")) {
    image(blankBox,0,0);  
  }
  
  if (state.equals("pauseYou") || state.equals("pauseOpp")) {
    image(blankBox,0,0);  
  }  
  
  //ANIMATE YOUR OPPONENT ATTACKING
  if ((state.equals("turn-p1") && speedWinner == oppPokemonOut) || (state.equals("turn-p2") && speedWinner == yourPokemonOut)) {
    
    println("opp attack");
    
    if (oppAttack == None) {
      if (state.equals("turn-p1")) {
        state = "turn-p2";
      }
      else if (state.equals("turn-p2")) {
        state = "turnEndDamage";  
      }
    }
    
    else if (oppPokemonOut.attackEffectiveness == 0 || oppAttack.getPower() == 0) {
        if (textShowTime < 45) {
          text("Enemy " + oppPokemonOut.getName(),50,475);
          text("used " + oppAttack.toString()+"!",50,535); 
          textShowTime++;
        }
        else {
          textShowTime = 0;
          state = "type-effect-opp";
          println("x");
        }
    }
    else if (oppPokemonOut.turnParalyzed) {
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
      yourDropHealth();
    }
  }

  //ANIMATE YOU ATTACKING
  else if ((state.equals("turn-p1") && speedWinner == yourPokemonOut) || (state.equals("turn-p2") && speedWinner == oppPokemonOut)) {
    
    if (yourAttack == None) {
      if (state.equals("turn-p1")) {
        state = "turn-p2";
      }
      else if (state.equals("turn-p2")) {
        state = "turnEndDamage";  
      }
    }
    
    else if (yourPokemonOut.attackEffectiveness == 0 || yourAttack.getPower() == 0) {
        
        if (textShowTime < 45) {
          text(yourPokemonOut.getName(),50,475);
          text("used " + yourAttack.toString()+"!",50,535); 
          textShowTime++;
        }
        else {
          textShowTime = 0;
          state = "type-effect-you";
          println("y");
        }
    }  
    else if (yourPokemonOut.turnParalyzed) {
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
      oppDropHealth();
    }
  }
  
  if (oppPokemonOut.attackEffectiveness != 1 && oppPokemonOut.attackEffectiveness != 0 && !oppPokemonOut.attackCrit && yourHPFinish()) {
    if ((speedWinner == oppPokemonOut && state.equals("turn-p1")) || (speedWinner == yourPokemonOut && state.equals("turn-p2"))) {  
      state = "type-effect-opp";  
      println("change");
    }
  }
  
  if (yourPokemonOut.attackEffectiveness != 1 && yourPokemonOut.attackEffectiveness != 0 && !yourPokemonOut.attackCrit && oppHPFinish()) {
    if ((speedWinner == yourPokemonOut && state.equals("turn-p1")) || (speedWinner == oppPokemonOut && state.equals("turn-p2"))) { 
      state = "type-effect-you";  
    }
  }
    
  //text for crits and transitioning to next phase
  if (state.equals("crit-1") && textShowTime < 45) {
    text("Critical hit!",50,475);  
    textShowTime++;
  }
  if (state.equals("crit-1") && textShowTime >= 45) {
    state = "turn-p2";
    textShowTime = 0;
    
    if (yourPokemonOut.attackEffectiveness != 1 && !state.equals("type-effect-opp") && speedWinner == yourPokemonOut) {
      state = "type-effect-you";  
    }
    else if (oppPokemonOut.attackEffectiveness != 1 && !state.equals("type-effect-you") && speedWinner == oppPokemonOut) {
      state = "type-effect-opp";  
    } 
    
  }
  if (state.equals("crit-2") && textShowTime < 45) {
    text("Critical hit!",50,475);  
    textShowTime++;
  }
  if (state.equals("crit-2") && textShowTime >= 45) {
    state = "turnEndDamage";
    textShowTime = 0;
    
    if (yourPokemonOut.attackEffectiveness != 1 && !state.equals("type-effect-opp") && speedWinner == oppPokemonOut) {
      state = "type-effect-you";  
    }
    else if (oppPokemonOut.attackEffectiveness != 1 && !state.equals("type-effect-you") && speedWinner == yourPokemonOut) {
      state = "type-effect-opp";  
      println("a");
    }
    
  }
  
  if (state.equals("type-effect-opp") && textShowTime <= 45) {
    if (oppAttack.getPower() == 0) {
        textShowTime = 45;
    }
    else if (oppPokemonOut.attackEffectiveness == 0.5 || oppPokemonOut.attackEffectiveness == 0.25) {
      text("It's not very",50,475);
      text("effective...",50,535);
    }
    else if (oppPokemonOut.attackEffectiveness == 2 || oppPokemonOut.attackEffectiveness == 4) {
      text("It's super",50,475);
      text("effective!",50,535);
    }
    else if (oppPokemonOut.attackEffectiveness == 0) {
      text("No effect!",50,475);
    }
    textShowTime++;
  }
  if (state.equals("type-effect-opp") && textShowTime > 45) {
    if (speedWinner == oppPokemonOut) {
      state = "turn-p2";  
    }
    else {
      state = "turnEndDamage";  
    }
    textShowTime = 0;  
  }

  
  if (state.equals("type-effect-you") && textShowTime <= 45) {
    if (yourAttack.getPower() == 0) {
      textShowTime = 45;
    }
    else if (yourPokemonOut.attackEffectiveness == 0.5 || yourPokemonOut.attackEffectiveness == 0.25) {
      text("It's not very",50,475);
      text("effective...",50,535);
    }
    else if (yourPokemonOut.attackEffectiveness == 2 || yourPokemonOut.attackEffectiveness == 4) {
      text("It's super",50,475);
      text("effective!",50,535); 
    }
    else if (yourPokemonOut.attackEffectiveness == 0) {
      text("No effect!",50,475);
    }
    textShowTime++;
  }
  if (state.equals("type-effect-you") && textShowTime > 45) {
    if (speedWinner == yourPokemonOut) {
      state = "turn-p2";  
    }
    else {
      state = "turnEndDamage";  
    }
    textShowTime = 0;  
  }
  
  
  
  //when your opponent faints
  if (oppPokemonOut.status.equals("FNT") && oppHealthLost == oppPokemonOut.health && !state.equals("choosePokeOpp")) {
    if (textShowTime < 60) {
      state = "faintShow";
      text("Enemy " + oppPokemonOut.getName(),50,475);
      text("fainted!",50,535);
      textShowTime++;
    }
    else {
      textShowTime = 0;  
      state = "choosePokeOpp";
    }
  }
  
  //when you faint
  if (yourPokemonOut.status.equals("FNT") && yourHealthLost == yourPokemonOut.health && !state.equals("choosePokeYou")) {
    if (textShowTime < 60) {
      state = "faintShow";
      text(yourPokemonOut.getName(),50,475);
      text("fainted!",50,535);
      textShowTime++;
    }
    else {
      textShowTime = 0;  
      state = "choosePokeYou";
    }
  }
  
  //choosePoke state is the switch screen. to be implemented
  
}

//-----------------------------------
//CHECK WHEN HP DROP IS DONE
//-----------------------------------

boolean yourHPFinish() {
  if (yourHealthLost >= yourPokemonOut.health - yourPokemonOut.hp) {
    return true;  
  }
  return false;
}

boolean oppHPFinish() {
  if (oppHealthLost >= oppPokemonOut.health - oppPokemonOut.hp) {
    return true;  
  }
  return false;
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
    
    int yourSpeed = (int)(yourPokemonOut.speed * multipliers[yourPokemonOut.statStatus[4]+6]);
    int oppSpeed = (int)(oppPokemonOut.speed * multipliers[oppPokemonOut.statStatus[4]+6]);
    
    //paralysis hindrance
    if (oppPokemonOut.getStatus().equals("PRZ")) {
      oppSpeed /= 4;
    }
    if (yourPokemonOut.getStatus().equals("PRZ")) {
      yourSpeed /= 4;
    }
    
    //who goes first
    if (yourSpeed > oppSpeed) {
      speedWinner = yourPokemonOut;
      slowerPoke = oppPokemonOut;
    }
    else if (oppSpeed > yourSpeed) {
      speedWinner = oppPokemonOut; 
      slowerPoke = yourPokemonOut;
    }
    //speedtie
    else if ((int)(Math.random()*2) == 0) {
      speedWinner = yourPokemonOut;  
      slowerPoke = oppPokemonOut;
    }
    else {
      speedWinner = oppPokemonOut;  
      slowerPoke = yourPokemonOut;
    }
    
    //opponent chooses move
    //oppAttack = Tackle;   //should be 
    println("OK");
    oppAttack = OppTrainer.chooseMove();
    println(oppAttack);
    
    //action = chooseAction from ai
    //if action = 1
    //call oppswitchfunction
    //oppAttack = None
    
    
    if (switchedThisTurn) {
      yourAttack = None;  
    }
    
    if (speedWinner == yourPokemonOut) {
      yourPokemonOut.attack(oppPokemonOut,yourAttack);
      oppPokemonOut.attack(yourPokemonOut,oppAttack);
    }
    else if (speedWinner == oppPokemonOut) {
      oppPokemonOut.attack(yourPokemonOut,oppAttack);  
      yourPokemonOut.attack(oppPokemonOut,yourAttack);  
    }
    
    attackTransitionTime = 0;
    
    switchedThisTurn = false;
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
    if (yourPokemonOut.attackCrit && state.equals("turn-p1") && yourPokemonOut.attackEffectiveness != 0) {
      state = "crit-1"; 
    }
    else if (yourPokemonOut.attackCrit && state.equals("turn-p2") && yourPokemonOut.attackEffectiveness != 0) {
      state = "crit-2";  
    }
    
    else if (state.equals("turn-p1")) {      
      state = "turn-p2"; 
    }
    else if (state.equals("turn-p2") && !(yourPokemonOut.attackEffectiveness == 0 || yourAttack.getPower() == 0)) {
      state = "turnEndDamage";
    }
    else if (state.equals("textEnd1")) {
      state = "textEnd2"; 
    }
    else if (state.equals("textEnd2")) {
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
    if (oppPokemonOut.attackCrit && state.equals("turn-p1") && oppPokemonOut.attackEffectiveness != 0) {
      state = "crit-1"; 
    }
    else if (oppPokemonOut.attackCrit && state.equals("turn-p2") && oppPokemonOut.attackEffectiveness != 0) {
      state = "crit-2";  
    }
    
    else if (state.equals("turn-p1")) {
      state = "turn-p2"; 
      println("ho");
    }
    else if (state.equals("turn-p2") && !(oppPokemonOut.attackEffectiveness == 0 || oppAttack.getPower() == 0)){
      state = "turnEndDamage";
    }   
    else if (state.equals("textEnd1")) {
      state = "textEnd2";  
    }
    else if (state.equals("textEnd2")) {
      state = "chooseOption";
      println("bhu");
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
  
  if (cArrowX != 482 || cArrowY != 450) {
    stateFlowCheck = true;  
  }
  if (keyPressed && cArrowX == 482 && cArrowY == 450 && (key == 'z' || key == 'Z')) {
    println("go");
    if (textShowTime > 15) {
      stateFlowCheck = true;
      textShowTime = 0;
    }
    if (stateFlowCheck) {
      state = "choosePokeYou";  
    }
    else {
      //perfect time for Go pokemon name
      println(textShowTime);
      textShowTime++;    
    }
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
  yourdisplayHealth = " " + yourPokemonOut.health;
  text(yourdisplayHealth.substring(yourdisplayHealth.length()-3),480,348);
  
  yourdisplayHP = " "+hpToShow;
  if (yourdisplayHP.length() <= 2) {
    yourdisplayHP = " " +  yourdisplayHP;
  }
  //text(yourdisplayHP.substring(yourdisplayHP.length()-3),350,348);
  text(hpString(hpToShow),350,348);
  
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
  fill(color(0));
  
}

//--------------------------------------------------
//SETUP CHOOSE OPPONENT SCREEN
//-------------------------------------------------

void setupChooseOppScreen() {
  image(chooseOppScreen,0,0);
  image(chooseOppArrow,400,cOArrowY);
  
  if (keyPressed && (key == 'z' || key == 'Z')) {
    //currently directs to this because no catalog yet
    state = "chooseOption";  
    battleStart = true;
    frameRate(2);
  }
  
  
}