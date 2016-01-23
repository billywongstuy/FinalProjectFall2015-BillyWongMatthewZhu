//FIX NOTES: 

//NO PAUSE BETWEEN ATTACK DAMAGE AND STATUS DAMAGE
//MIGHT BE TOO FAST FOR STATUS HP DROP

//code in so that unfreeze doesn't not happen unless certain attacks
//does the prevent op from attacking when switching in turn work?
//send in battle for beginning of battle and when switching out "come back"
//STATUS APPEARS AS SOON AS THE ANIMATION STARTS change it after the attack
//add the text for status happened (after everything) using Poke.addEffects


//there's no pause between a critical hit and fainting
//or no pause btw effectiveness text and fainting if crit

//figure out where multi hits text appears

//order of display text
//all check also check if addeffects[0][0] != ""
//attack (put here if attackEffectiveness == 1 && !attackCrit && attackHits == 1, then "statusText"
//crit (put here if attackEffectiveness == 1 && attackHits == 1, then state is "statusText"
//super effective (put here if attackHits == 1, then state is "statusText"
//hit times
//status

//Need to make the text for sleep/freeze get omitted if target attacks first, add wake up/unthawing text

PFont font;
PImage battle;
PImage blankBox;
PImage options;
PImage yourPoke;
PImage oppPoke;

PImage chooseOppScreen;
PImage chooseOppArrow;
int cOArrowY = 188;
int oppLevel = 1;

PImage challengeScreen;

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
boolean screenShown = false;
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
Attack oppAttack = null;
int oppHealthLost = 0;
int yourHealthLost = 0;

ArrayList<Poke>yourTeam = new ArrayList<Poke>();
Poke yourPokemonOut;
Poke yourPreviousPoke;

ArrayList<Poke>oppTeam = new ArrayList<Poke>();
Poke oppPokemonOut;
AI OppTrainer;

int partySlot = 0;
boolean youSwitchedThisTurn = false;
boolean oppSwitchedThisTurn = false;

void setup() {
  background(255,255,255);
  size(640,576);
  font = loadFont("PokemonGB-32.vlw");
  textFont(font, 32);
  state = "chooseOpp";
  
  setupPokeSet();
  //add 5 (charizard) 25 raichu 102 for exeggcutor 134 for jolteon 128 magikarp
  yourTeam.add(Pokemons.get(102)); 
  yourTeam.add(Pokemons.get(5));
  yourTeam.add(Pokemons.get(2));
  
  //OppTrainer = new AI_Easy(Charizard,Blastoise,Venusaur,"prof.oak"); 
  
  //oppTeam = OppTrainer.AI_Team;
  yourPokemonOut = yourTeam.get(0);
  yourPreviousPoke = yourPokemonOut;
  
  //oppPokemonOut = oppTeam.get(0);
  
  chooseOppScreen = loadImage("choose-level.png");
  chooseOppArrow = loadImage("arrow.png");
  challengeScreen = loadImage("challenge.png");
  
  battle = loadImage("battlers-info-template.png");  
  yourPoke = loadImage("Sprites/Back/" + yourPokemonOut.index+".PNG"); 
  //oppPoke = loadImage("Sprites/Front/" + oppPokemonOut.index+".PNG");
 
  yourPoke.resize(230,230);
  //oppPoke.resize(225,225);
 
  options = loadImage("pkmn-battle-bottom-bar.png");
  choiceArrow = loadImage("arrow.png");
 
  move = loadImage("choose-move-template.png");
  moveArrow = loadImage("arrow.png");
  
  blankBox = loadImage("blank_box_bottom.png");
  
  switchScreen = loadImage("switching.png");
  switchArrow = loadImage("arrow.png");   
  
  hpToShow = yourPokemonOut.hp;
  yourdisplayHP = " " + yourPokemonOut.hp;
  /*oppPokemonOut.a1 = Thunder_Wave;
  oppPokemonOut.a2 = Tackle;
  oppPokemonOut.a3 = Flamethrower;
  oppPokemonOut.a4 = Strength;*/
   
}

void draw() {
  //println(state);
  frameRate(30);
  if (state.equals("chooseOpp")) {
    setupChooseOppScreen();  
  }
  if (state.equals("challenge")) {
    challengeScreen();  
  }
  if (battleStart) {
    displayBattlersInfo();
  
    if (state.equals("chooseOption")) {
      setupOptionScreen();
    }
    if (state.equals("chooseMove")) {
      setupMoveChoice();
      if (attackTransitionTime >= 35) {
        if (keyPressed && (key == 'Z' || key == 'z')) {
          turnEvents(); 
        }
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
      if (loss()) {
        state = "loss";  
      }
      else {
        switchYou();
      }
    }
    if (state.equals("choosePokeOpp")) {
      switchOpp();
    }
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


//----------------------------
//CHECKS IF YOU LOST
//------------------------------

boolean loss() {
  if (yourTeam.get(0).getStatus().equals("FNT") && yourTeam.get(1).getStatus().equals("FNT") && yourTeam.get(2).getStatus().equals("FNT")) {
    return true;  
  }
  return false;
}

//--------------------------------
//SWITCHING YOU
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
  
  if (keyPressed && (key == 'z' || key == 'Z')) {
    if (yourTeam.get(partySlot) == yourPokemonOut) {
      println(yourPokemonOut);
      println(yourTeam.get(partySlot));
      if (yourPokemonOut.getStatus().equals("FNT")) {
        println("No energy to battle!");  
        state = "noEnergy";
      }
      else {
        state = "battling";
        println("Currently battling!");  
      }
    }
    else {
     
      if (!yourPokemonOut.getStatus().equals("FNT")) {
        youSwitchedThisTurn = true;
        oppAttack = OppTrainer.chooseMove();
      }            
      yourPreviousPoke = yourPokemonOut;
      yourPokemonOut = yourTeam.get(partySlot);
      yourHealthLost = yourPokemonOut.health - yourPokemonOut.hp;
      hpToShow = yourPokemonOut.hp;
      yourPoke = loadImage("Sprites/Back/" + yourPokemonOut.index+".PNG");
      
      state = "youSendOut";  
      
      if (yourAttack.name.equals("Explosion") || yourAttack.name.equals("Self-Destruct")) {
        state = "oppSendOut";  
      }
      if (oppAttack.name.equals("Explosion") || oppAttack.name.equals("Self-Destruct")) {
        state = "oppSendOut";  
      }
      
    }
  }
  
}

//------------------------
//SWITCHING OPP
//------------------------

void switchOpp() {

  Poke switchTo = OppTrainer.chooseNextPoke();
  
  if (switchTo == null) {
    state = "victory";  
  }
  else {
    if (!oppPokemonOut.getStatus().equals("FNT")) {
      oppSwitchedThisTurn = true;
      oppAttack = None;
    }
    
    oppPokemonOut = switchTo;
    oppHealthLost = oppPokemonOut.health - oppPokemonOut.hp;
    oppPoke = loadImage("Sprites/Front/" + oppPokemonOut.index+".PNG");
    oppPoke.resize(225,225);   
    
    state = "oppSendOut";
    
    if (yourPokemonOut.status.equals("FNT")) {
      state = "choosePokeYou";  
    }
    
  }
}


//-------------------------------
//TEXT FOR OPP SWITCH IN
//-------------------------------

void oppSendOut() {
  if (textShowTime < 45) {
    text(OppTrainer + " sent out",50,475);
    text(oppPokemonOut.getName() + "!",50,535);
    textShowTime++;
  }
  else {
    textShowTime = 0;
    state = "chooseOption";
  
    if (oppSwitchedThisTurn) {
      state = "turn-p1";
      if (!oppAttack.name.equals("Explosion") && !oppAttack.name.equals("Self-Destruct")) {
        oppAttack = None;
      }
      //turnEvents();
    }
    else {
      println("ack");
      println(oppAttack);
      //if (!oppAttack.name.equals("Explosion") && !oppAttack.name.equals("Self-Destruct")) {
      //  oppAttack = null;
      //}      
    }
    
    println("too");
    
    if (yourAttack.name.equals("Explosion") || yourAttack.name.equals("Self-Destruct")) {
      state = "youSendOut";  
    }
      
    println(oppAttack);
    println("hegsgsg"); 
    println(oppAttack.name.equals("Explosion") || oppAttack.name.equals("Self-Destruct"));
      
    if (oppAttack.name.equals("Explosion") || oppAttack.name.equals("Self-Destruct")) {
      println("lkji");
      state = "youSendOut";  
      oppAttack = null;
      println("lol null");
    }
    
    println("hesh");
  }
 
}


//------------------------------
//TEXT FOR YOUR SWITCH IN
//--------------------------------

void youSendOut() {
  if (textShowTime < 45) {
    text("Go! " + yourPokemonOut.getName() + "!",50,475);
    textShowTime++;
  }
  else {
    textShowTime = 0;
    state = "chooseOption";
    stateFlowCheck = false;
      

    if (youSwitchedThisTurn) {
      println("here");
      state = "chooseMove";
      turnEvents();
      println(state);
    }
    
    
    if (yourAttack.name.equals("Explosion") || yourAttack.name.equals("Self-Destruct")) {
      oppAttack = null; 
      yourAttack = null;
    }
    
  }
}


//---------------------------------
//CONVERTS HP INTO LENGTH OF 3
//---------------------------------

String hpString(int hp) {
  String showHealth = ""+hp;
  if (showHealth.length() <= 3) {
    showHealth = "  " + showHealth;
  }
  showHealth = showHealth.substring(showHealth.length()-3);
  return showHealth;
}


//-------------------------------
//SHOWS YOUR TEAM WHEN SWITCHING
//--------------------------------

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

//------------------------------
//DECIDE AI DIFFICULTY
//-------------------------------

void chooseOppDiff() {
  //println(oppLevel + "LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL " + oppLevel);
  if (oppLevel == 1) {
    OppTrainer = new AI_Easy(Magikarp,Charizard,Venusaur,"prof.oak"); 
  }
  else if (oppLevel == 2) {
    OppTrainer = new AI_Normal(Blastoise,Charizard,Venusaur,"prof.oak");
    //println("norm");
  }  
  else if(oppLevel == 3){
    OppTrainer = new AI_Hard(Blastoise,Charizard,Venusaur,"prof.oak");
  }
  //println("hey");
  oppTeam = OppTrainer.AI_Team;
  oppPokemonOut = oppTeam.get(0);
  oppPoke = loadImage("Sprites/Front/" + oppPokemonOut.index+".PNG");
  oppPoke.resize(225,225);
}


//--------------------------------------------------
//THIS FUNCTION HANDLES ALL THE END OF TURN THINGS
//--------------------------------------------------

void handleEndTurn() {
  image(blankBox,0,0); 
  fill(color(0));
  
  if (state.equals("turnEndDamage")) {
    //println("entered");
    //incorporate speed later
    if (yourPokemonOut.getStatus().equals("BRN") || yourPokemonOut.getStatus().equals("PSN")) {
      yourPokemonOut.takeDamage((int)(yourPokemonOut.health/16));
      //println("HP:" + yourPokemonOut.hp);
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
    //println("entered-2");
        
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
  
    //println("reset everything");
    cArrowX = 288;
    cArrowY = 450;
    if (!oppAttack.name.equals("Explosion") && !oppAttack.name.equals("Self-Destruct")) {
      oppAttack = null;
      //println("nullify");
    }
    if (!yourAttack.name.equals("Explosion") && !yourAttack.name.equals("Self-Destruct")) {
      yourAttack = null;
    }
    youSwitchedThisTurn = false;
    oppSwitchedThisTurn = false;
    
    
    oppPokemonOut.recharge = false;
    if (oppPokemonOut.setRecharge) {
      oppPokemonOut.setRecharge = false;
      oppPokemonOut.recharge = true;
    }
    yourPokemonOut.recharge = false;
    if (yourPokemonOut.setRecharge) {
      yourPokemonOut.setRecharge = false;
      yourPokemonOut.recharge = true;
    }        
  }  
}


//-------------------------
//RETURNS NEXT STATE
//--------------------------

String nextState(Poke p) {
  Attack a = oppAttack;
  Poke other = yourPokemonOut;
  int otherHealthLost = yourHealthLost;
    
  if (p == yourPokemonOut) {
    a = yourAttack;
    other = oppPokemonOut;
    otherHealthLost = oppHealthLost;
  }
  
  if (state.equals("faintShowYou") && (oppAttack.name.equals("Explosion") || oppAttack.name.equals("Self-Destruct"))) {
    a = oppAttack; 
    p = oppPokemonOut;
    println(oppHealthLost);
  }
  
  //println("change");
  //println(a.name);
  //println(Explosion.name);

  if (state.substring(0,3).equals("tur") && p.attackEffectiveness != 1 && p.attackEffectiveness != 0 && !p.attackCrit && targetHPFinish(p) && a != null && a.getPower() != 0 && !state.substring(0,6).equals("type-e")) {
    if (p == yourPokemonOut) {
      //println("type-type");
      return "type-effect-you";  
    }
    return "type-effect-opp";
  }
  else if (p.attackHits > 1 && !state.substring(0,7).equals("multi-h")) {
    if (p == yourPokemonOut) {
      return "multi-hit-you";
    }
    return "multi-hit-opp";
  }
  else if (!p.attackEffects[0][0].equals("") && !state.substring(4,6).equals("Sta")) {
    if (p == yourPokemonOut) {
      return "yourStatusText"; 
    }
    return "oppStatusText";
  }
  else if (a.name.equals("Explosion") || a.name.equals("Self-Destruct")) {
    //println(p);
    p.hp = 0;
    p.status = "FNT";
    if (p == yourPokemonOut) {
      if (!state.equals("faintShowOpp") && !state.equals("faintShowYou")) {
        return "faintShowOpp";  
      }
      if (!state.equals("faintShowYou")) {
        return "faintShowYou";
      }
      //println(yourPokemonOut.status);
    }
    if (p == oppPokemonOut) {
      println("heroshsh");
      if (!state.equals("faintShowOpp") && !state.equals("faintShowYou")) {
        return "faintShowYou";  
      }
      if (!state.equals("faintShowOpp")) {
        return "faintShowOpp";
      }
      //println(oppPokemonOut.status);
    }     
    return "choosePokeOpp";
  }
  else if (oppPokemonOut.status.equals("FNT") && oppHealthLost == oppPokemonOut.health && !state.equals("faintShowOpp")) {
    return "faintShowOpp";  
  }
  else if (yourPokemonOut.status.equals("FNT") && yourHealthLost == yourPokemonOut.health && !state.equals("faintShowYou")) {
    return "faintShowYou";  
  }
  else if (state.equals("faintShowOpp")) {
    return "choosePokeOpp";    
  }
  else if (state.equals("faintShowYou")) {
    //println("time to switch");
    return "choosePokeYou";    
  }
  
  else {
    //println("next turn!");
    if (speedWinner == p) {
      return "turn-p2";  
    }
    return "turnEndDamage";
  }
}


//----------------------------
//CANNOT SWITCH TEXT
//----------------------------

void cannotSwitchText() {
  if (state.equals("noEnergy")) {
    if (textShowTime < 45) {
      background(color(255));
      image(switchScreen,0,0);
      displayTeamInfo();
      image(blankBox,0,0);
      fill(color(0));
      text("There's no will",50,475);
      text("to fight!",50,535);
      textShowTime++;
    }
    else {
      textShowTime = 0;
      state = "choosePokeYou";
    }    
  }
  
  if (state.equals("battling")) {
    if (textShowTime < 45) {
      background(color(255));
      image(switchScreen,0,0);
      displayTeamInfo();
      image(blankBox,0,0);
      fill(color(0));
      text(yourPokemonOut.getName() + "'s",50,475);
      text("battling!",50,535);
      textShowTime++;
    }
    else {
      textShowTime = 0;
      state = "choosePokeYou";
    }    
  }
}

//----------------------------
//BLANK BOX
//------------------------------

void blankBox() {
  if (state.equals("turn-p1") || state.equals("turn-p2") || state.equals("crit-1") || state.equals("crit-2") || state.equals("type-effect-you") || state.equals("type-effect-opp")) {
    image(blankBox,0,0);  
  }
  
  else if (state.equals("pauseYou") || state.equals("pauseOpp") || state.equals("noPP") || state.equals("oppSendOut") || state.equals("youSendOut")) {
    image(blankBox,0,0);  
  } 
  
  else if (state.equals("victory") || state.equals("loss") || state.equals("faintShowYou") || state.equals("faintShowOpp")) {
    image(blankBox,0,0);  
  }  
  
  else if (state.equals("yourStatusText") || state.equals("oppStatusText")) {
    image(blankBox,0,0);  
  }
  
  else if (state.equals("multi-hit-you") || state.equals("multi-hit-opp")) {
    image(blankBox,0,0);  
  }
}

//----------------------------------------------------------
//THIS FUNCTION SCROLLS THE HP AND DISPLAY ALL ATTACK TEXT
//----------------------------------------------------------

void animateTurn() {
  //println(state);
  
  //needs to add text box with attacks and side effects
  blankBox();
  
  if (state.equals("victory")) {
    blankBox();
    text("Player",50,475);
    text("defeated " + OppTrainer + "!",50,535);
    noLoop();
  }
  
  if (state.equals("loss")) {
    blankBox();
    text("Player",50,475);
    text("lost to " + OppTrainer + "!",50,535);
    noLoop();
  }
  
  cannotSwitchText();
  
  //NO PP
  if (state.equals("noPP")) {
    if (textShowTime < 30) {
      text("No PP!",50,475);
      textShowTime++;
    }
    else {
      textShowTime = 0;
      state = "chooseMove";
    }
  }
  
  if (state.equals("oppSendOut")) {
    oppSendOut();  
  }
  
  if (state.equals("youSendOut")) {
    youSendOut();
  }
  
  
  //ANIMATE YOUR OPPONENT ATTACKING
  if ((state.equals("turn-p1") && speedWinner == oppPokemonOut) || (state.equals("turn-p2") && speedWinner == yourPokemonOut)) {
    oppAttackText();
  }

  //ANIMATE YOU ATTACKING
  else if ((state.equals("turn-p1") && speedWinner == yourPokemonOut) || (state.equals("turn-p2") && speedWinner == oppPokemonOut)) {
    yourAttackText();
  }
  
  
  if (state.equals("multi-hit-you")) {
    multiHitText(yourPokemonOut);  
  }
  
  if (state.equals("multi-hit-opp")) {
    multiHitText(oppPokemonOut);  
  }
  
 
  if (state.equals("crit-1") && textShowTime < 45) {
    text("Critical hit!",50,475);  
    textShowTime++;
    attackTransitionTime++;
  }
  if (state.equals("crit-1") && textShowTime >= 45) {
    state = nextState(speedWinner);
    textShowTime = 0;
    attackTransitionTime = 0;
        
  }
  if (state.equals("crit-2") && textShowTime < 45) {
    text("Critical hit!",50,475);  
    textShowTime++;
    attackTransitionTime++;
  }
  if (state.equals("crit-2") && textShowTime >= 45) {
    state = nextState(slowerPoke);
    textShowTime = 0;
    attackTransitionTime = 0;    
  }
  
  if (state.equals("oppStatusText")) {
    oppStatusText();  
  }
  if (state.equals("yourStatusText")) {
    yourStatusText();  
  }
  
  oppEffectivenessText();
  yourEffectivenessText();
  
  
  //need to make a break over here so other text displays before transitioning
  
  
  //when your opponent faints
  /*if (oppPokemonOut.status.equals("FNT") && oppHealthLost == oppPokemonOut.health && !state.equals("choosePokeOpp") && attackTransitionTime == 0 && !state.equals("victory") && !state.equals("loss")) {
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
  if (yourPokemonOut.status.equals("FNT") && yourHealthLost == yourPokemonOut.health && !state.equals("choosePokeYou") && !state.equals("victory") && !state.equals("loss")) {
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
  }*/
  
  
  if (state.equals("faintShowOpp")) {
    if (textShowTime < 60) {
      text("Enemy " + oppPokemonOut.getName(),50,475);
      text("fainted!",50,535);
      textShowTime++;
    }
    else {
      textShowTime = 0;  
      state = nextState(oppPokemonOut);
    }
  }
  
  
  if (state.equals("faintShowYou")) {
    if (textShowTime < 60) {
      text(yourPokemonOut.getName(),50,475);
      text("fainted!",50,535);
      textShowTime++;
    }
    else {
      textShowTime = 0;  
      state = nextState(yourPokemonOut);
    }
  }
  
}

//-------------------------------
//

void multiHitText(Poke p) {
  if (textShowTime < 45) {
    text("Hit " + p.attackHits + " times!",50,475);
    textShowTime++;  
  }
  else {
    p.attackHits = 1;
    state = nextState(p);
  }
}


//--------------------------------
//EFFECTIVENESS TEXT YOU
//-------------------------------

void yourEffectivenessText() {
  if (state.equals("type-effect-you") && textShowTime <= 45) {
    println("herg");
    if (yourAttack.getPower() == 0 || yourPokemonOut.attackMissed) {
      println("increase");
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
    attackTransitionTime++;
  }
  if (state.equals("type-effect-you") && textShowTime > 45) {
   
    /*if (speedWinner == yourPokemonOut) {
      state = "turn-p2";  
    }
    else {
      state = "turnEndDamage";  
    }*/
    println("lololo");
    state = nextState(yourPokemonOut);
    
    println("heya");
    
    textShowTime = 0;  
    attackTransitionTime = 0;
  }    
}


//----------------------------------
//EFFECTIVENESS TEXT OPP
//----------------------------------

void oppEffectivenessText() {
  if (state.equals("type-effect-opp") && textShowTime <= 45) {
    if (oppAttack.getPower() == 0 || oppPokemonOut.attackMissed) {
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
    attackTransitionTime++;
  }
  if (state.equals("type-effect-opp") && textShowTime > 45) {
    /*if (speedWinner == oppPokemonOut) {
      state = "turn-p2";  
    }
    else {
      state = "turnEndDamage";  
    }*/
    
    state = nextState(oppPokemonOut);
    textShowTime = 0;  
    attackTransitionTime = 0;
  }    
}

//---------------------------------
//DISPLAY OPPONENT ATTACK TEXT
//---------------------------------

void oppAttackText() {
  if (oppAttack == None) {
      if (state.equals("turn-p1")) {
        state = "turn-p2";
      }
      else if (state.equals("turn-p2")) {
        state = "turnEndDamage";  
      }
    }
    
    else if (oppPokemonOut.turnParalyzed) {
      if (textShowTime < 45) {
        text("Enemy " + oppPokemonOut.getName()+"\'s",50,475);
        text("paralyzed!",50,535);
        textShowTime++;
      }
      else {
        textShowTime = 0;
        println("TY");
        println(oppPokemonOut);
        state = nextState(oppPokemonOut);
      }
    }
    else if (oppPokemonOut.frozen) {
      if (textShowTime < 45) {
        text("Enemy " + oppPokemonOut.getName()+"\'s",50,475);
        text("frozen!",50,535);
        textShowTime++;
      }
      else {
        textShowTime = 0;
        state = nextState(oppPokemonOut);
      }
    }
    else if (oppPokemonOut.getStatus().equals("SLP")) {
      if (textShowTime < 45) {
        text("Enemy " + oppPokemonOut.getName()+"\'s",50,475);
        text("asleep!",50,535);
        textShowTime++;      
      }
      else {
        textShowTime = 0;
        state = nextState(oppPokemonOut);
      }
    }
    else if (oppPokemonOut.recharge) {
      if (textShowTime < 45) {
        text("Enemy " + oppPokemonOut.getName()+"\'s",50,475);
        text("recharging!",50,535);
        textShowTime++;   
      }
      else {
        textShowTime = 0;
        state = nextState(oppPokemonOut);
      }
    }
    else if (oppPokemonOut.attackMissed) {
        if (textShowTime < 45) {
          text("Enemy " + oppPokemonOut.getName(),50,475);
          text("used " + oppAttack +"!",50,535);
          textShowTime++;
        }
        else if (textShowTime < 90) {
          text("Enemy " + oppPokemonOut.getName()+"'s",50,475);
          text("attack missed!",50,535); 
          textShowTime++;
        }
        else {
          textShowTime = 0;
          state = nextState(oppPokemonOut);
        }
    }
    else if (oppPokemonOut.attackEffectiveness == 0) {
      if (textShowTime < 45) {
        text("Enemy " + oppPokemonOut.getName(),50,475);
        text("used " + oppAttack.toString()+"!",50,535); 
        textShowTime++;
      }
      else {
        textShowTime = 0;
        state = "type-effect-opp";
      }
    }
    else if (oppAttack.getPower() == 0) {
      if (textShowTime < 45) {
        text("Enemy " + oppPokemonOut.getName(),50,475);
        text("used " + oppAttack.toString()+"!",50,535); 
        textShowTime++;      
      }
      else {
        textShowTime = 0;
        state = nextState(oppPokemonOut); 
      }
    }
    else {
      text("Enemy " + oppPokemonOut.getName(),50,475);
      text("used " + oppAttack.toString()+"!",50,535);
      yourDropHealth();
    }  
}


//------------------------------------
//DISPLAY YOUR ATTACK TEXT
//------------------------------------

void yourAttackText() {
  if (yourAttack == None) {
      if (state.equals("turn-p1")) {
        state = "turn-p2";
      }
      else if (state.equals("turn-p2")) {
        state = "turnEndDamage";  
      }
    }
    
    else if (yourPokemonOut.turnParalyzed) {
      if (textShowTime < 45) {
        text(yourPokemonOut.getName()+"\'s",50,475);
        text("paralyzed!",50,535);
        textShowTime++;
      }
      else {
        textShowTime = 0;
        state = nextState(yourPokemonOut);
      }
    }
    else if (yourPokemonOut.frozen) {
      if (textShowTime < 45) {
        text(yourPokemonOut.getName()+"\'s",50,475);
        text("frozen!",50,535);
        textShowTime++;  
      }
      else {
        textShowTime = 0;
        state = nextState(yourPokemonOut);
      }
    }
    else if (yourPokemonOut.getStatus().equals("SLP")) {
      if (textShowTime < 45) {
        text(yourPokemonOut.getName()+"\'s",50,475);
        text("asleep!",50,535);
        textShowTime++;  
      }
      else {
        textShowTime = 0;
        state = nextState(yourPokemonOut);
      }
    }
    else if (yourPokemonOut.recharge) {
      if (textShowTime < 45) {
        text(yourPokemonOut.getName()+"\'s",50,475);
        text("recharging!",50,535);
        textShowTime++;  
      }
      else {
        textShowTime = 0;
        state = nextState(yourPokemonOut);
      }
    }
    else if (yourPokemonOut.attackMissed) {
        if (textShowTime < 45) {
          text(yourPokemonOut.getName(),50,475);
          text("used " + yourAttack+"!",50,535); 
          textShowTime++;
        }
        else if (textShowTime < 90) {
          text(yourPokemonOut.getName()+"'s",50,475);
          text("attack missed!",50,535); 
          textShowTime++;    
        }
        else {
          textShowTime = 0;
          state = nextState(yourPokemonOut);
        }
    }
    else if (yourPokemonOut.attackEffectiveness == 0) {
        
      if (textShowTime < 45) {
        text(yourPokemonOut.getName(),50,475);
        text("used " + yourAttack.toString()+"!",50,535); 
        textShowTime++;
      }
      else {
        textShowTime = 0;
        state = "type-effect-you";
      }
    }
    else if (yourAttack.getPower() == 0) {
      if (textShowTime < 45) {
        text(yourPokemonOut.getName(),50,475);
        text("used " + yourAttack.toString()+"!",50,535); 
        textShowTime++;  
        println("ARBOKKKK " + textShowTime);
      }
      else {
        textShowTime = 0;
        state = nextState(yourPokemonOut); 
      }
    }
    else {
      text(yourPokemonOut.getName(),50,475);
      text("used " + yourAttack.toString()+"!",50,535); 
      oppDropHealth();
      
    }
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

boolean targetHPFinish(Poke p) {
  if (p == oppPokemonOut) {
    return yourHPFinish();  
  }
  return oppHPFinish();
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


//------------------------
//PROCESS TURN EVENTS
//------------------------

void turnEvents() {
  if (state.equals("chooseMove")) {
    state = "turn-p1";
    
    
    //incorporate pp into here
    //if pp Left for the move is 0, put into "noPP" state
    //put section into animateTurn for "noPP" to display message for 45 frames (using textShowTime)
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

    
    if (yourAttack.ppLeft <= 0) {
      state = "noPP";  
    }
    else {      
      int yourSpeed = (int)(yourPokemonOut.speed * multipliers[yourPokemonOut.statStatus[4]+6]);
      int oppSpeed = (int)(oppPokemonOut.speed * multipliers[oppPokemonOut.statStatus[4]+6]);
      
      //paralysis hindrance
      if (oppPokemonOut.getStatus().equals("PRZ")) {
        oppSpeed /= 4;
      }
      if (yourPokemonOut.getStatus().equals("PRZ")) {
        yourSpeed /= 4;
      }
      
      if (yourPokemonOut.sleepTurns > 0) {
        yourPokemonOut.sleepTurns--;  
      }
      if (oppPokemonOut.sleepTurns > 0) {
        oppPokemonOut.sleepTurns--;  
      }
      if (yourPokemonOut.sleepTurns == 0 && yourPokemonOut.getStatus().equals("SLP")) {
        yourPokemonOut.setStatus("");  
      }
      if (oppPokemonOut.sleepTurns == 0 && oppPokemonOut.getStatus().equals("SLP")) {
        oppPokemonOut.setStatus("");  
      }
      
      println("sleep turns: " + oppPokemonOut.sleepTurns);
      
      //oppPokemonOut.status = "PRZ";
            
      //who goes first
      if (yourSpeed > oppSpeed) {
        speedWinner = yourPokemonOut;
        slowerPoke = oppPokemonOut;
      }
      else if (oppSpeed > yourSpeed) {
        speedWinner = oppPokemonOut; 
        slowerPoke = yourPokemonOut;
        println("you are slower");
      }
      //speedtie
      else if ((int)(Math.random()*2) == 0) {
        speedWinner = yourPokemonOut;  
        slowerPoke = oppPokemonOut;
      }
      else {
        speedWinner = oppPokemonOut;  
        slowerPoke = yourPokemonOut;
        println("you're slower");
      }
      
      
      if (youSwitchedThisTurn) {
        yourAttack = None;  
      }
      else {
        yourPreviousPoke = yourPokemonOut;  
      }
      
      
      if (OppTrainer.chooseAction() == 1){
        switchOpp();
        println(state);
        oppAttack = None;
        speedWinner = yourPokemonOut;
        slowerPoke = oppPokemonOut;
      }
      
      
      println("o-attack: " + oppAttack);
      println("y-attack: " + yourAttack);
      
      
      
      
      if (oppAttack == null) {
        println("here");
        
        oppAttack = OppTrainer.chooseMove();
      }
      
     
      //oppAttack = Explosion;
      
      println(oppPokemonOut.status);
      
      if (speedWinner == yourPokemonOut) {
        yourPokemonOut.attack(oppPokemonOut,yourAttack);
        oppPokemonOut.attack(yourPokemonOut,oppAttack);
      }
      else if (speedWinner == oppPokemonOut) {
        oppPokemonOut.attack(yourPokemonOut,oppAttack);  
        yourPokemonOut.attack(oppPokemonOut,yourAttack);  
      }
      
      attackTransitionTime = 0;
            
    }
  }
}

//-----------------------------------
//YOUR STATUS TEXT
//-------------------------------------

void yourStatusText() {
  if (yourPokemonOut.inflictStatusTarget != null && yourPokemonOut.inflictStatusTarget.status.equals("") && !yourPokemonOut.inflictStatus.equals("")) {
    yourPokemonOut.inflictStatusTarget.setStatus(yourPokemonOut.inflictStatus);
  }
  if (textShowTime < 45) {
    text(yourPokemonOut.attackEffects[0][0],50,475);
    text(yourPokemonOut.attackEffects[0][1],50,535);
    textShowTime++;
  }
  else {
    textShowTime = 0;
    if (speedWinner == yourPokemonOut) {
      state = "turn-p2";  
    }
    else {
      state = "turnEndDamage";  
    }
    //can't use because this happens at end of turn
    //state = nextState(yourPokemonOut);
  }
}

//-----------------------------------
//OPP STATUS TEXT
//-------------------------------------

void oppStatusText() {
  
  if (oppPokemonOut.inflictStatusTarget != null && oppPokemonOut.inflictStatusTarget.status.equals("") && !oppPokemonOut.inflictStatus.equals("")) {
    oppPokemonOut.inflictStatusTarget.setStatus(oppPokemonOut.inflictStatus);
  }
  if (textShowTime < 45) {
    text(oppPokemonOut.attackEffects[0][0],50,475);
    text(oppPokemonOut.attackEffects[0][1],50,535);
    textShowTime++;
  }
  else {
    textShowTime = 0;
    if (speedWinner == oppPokemonOut) {
      state = "turn-p2";  
    }
    else {
      state = "turnEndDamage";  
    }
    //state = nextState(oppPokemonOut);
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
  //else if ((yourPokemonOut.turnParalyzed || yourPokemonOut.frozen) && textShowTime < 45) {
  //  
  //}
  else{
    if (oppPokemonOut.hp == 0) {
      oppPokemonOut.setStatus("FNT");  
    }
    textShowTime = 0;
    if (yourPokemonOut.attackCrit && state.equals("turn-p1") && yourPokemonOut.attackEffectiveness != 0) {
      state = "crit-1"; 
    }
    else if (yourPokemonOut.attackCrit && state.equals("turn-p2") && yourPokemonOut.attackEffectiveness != 0) {
      state = "crit-2";  
    }
   // else if (!yourPokemonOut.attackCrit && yourPokemonOut.attackEffectiveness == 1 && yourPokemonOut.attackHits == 1 && !yourPokemonOut.attackEffects[0][0].equals("")) {
   //   state = "yourStatusText";    
   // }
    else if (state.equals("turn-p1")) {      
      //state = "turn-p2";
      state = nextState(yourPokemonOut);
    }
    else if (state.equals("turn-p2") && !(yourPokemonOut.attackEffectiveness == 0 || yourAttack.getPower() == 0)) {
      //state = "turnEndDamage";
      state = nextState(yourPokemonOut);
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
  //else if ((oppPokemonOut.turnParalyzed || oppPokemonOut.frozen) && textShowTime < 45) {
  //  
  //}
  else{
    if (yourPokemonOut.hp == 0) {
      yourPokemonOut.setStatus("FNT");  
    }
    textShowTime = 0;
    if (oppPokemonOut.attackCrit && state.equals("turn-p1") && oppPokemonOut.attackEffectiveness != 0) {
      state = "crit-1"; 
    }
    else if (oppPokemonOut.attackCrit && state.equals("turn-p2") && oppPokemonOut.attackEffectiveness != 0) {
      state = "crit-2";  
    }
   // else if (!yourPokemonOut.attackCrit && yourPokemonOut.attackEffectiveness == 1 && yourPokemonOut.attackHits == 1 && !yourPokemonOut.attackEffects[0][0].equals("")) {
   //   state = "oppStatusText";    
    //}
    else if (state.equals("turn-p1")) {
      //state = "turn-p2"; 
      state = nextState(oppPokemonOut);
      println("ho");
    }
    else if (state.equals("turn-p2") && !(oppPokemonOut.attackEffectiveness == 0 || oppAttack.getPower() == 0)){
      //state = "turnEndDamage";
      state = nextState(oppPokemonOut);
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
 
  Attack attackToShow = yourPokemonOut.a1;
 
  switch(mArrowY) {
    case 420:
      attackToShow = yourPokemonOut.a1;
      break;
    case 452:
      attackToShow = yourPokemonOut.a2;
      break;
    case 485:
      attackToShow = yourPokemonOut.a3;
      break;
    case 516:
      attackToShow = yourPokemonOut.a4;
      break;
   }
   
   String ppLeftString = "" + attackToShow.ppLeft;
   if (ppLeftString.length() < 2) {
     ppLeftString = " " + ppLeftString;  
   }
   
   String ppString = "" + attackToShow.pp;
   if (ppString.length() < 2) {
     ppString = "" + ppLeftString;  
   }
   
   text(attackToShow.getType(),65,349);
   text(ppLeftString,160,381);
   text(ppString,255,381);  
   
 
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
      println(textShowTime + "LLLOO");
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
  
  if (yourPokemonOut.getStatus().equals("") || (yourPokemonOut.getStatus().equals("FNT") && yourHealthLost < yourPokemonOut.health)) {
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
  if (oppPokemonOut.getStatus().equals("") || (oppPokemonOut.getStatus().equals("FNT") && oppHealthLost < oppPokemonOut.health)) {
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
  image(chooseOppArrow,375,cOArrowY);
  frameRate(10);
  
  if (keyPressed && key == CODED && keyCode == DOWN) {
    //255
    switch(cOArrowY) {
      case 188:
        cOArrowY = 255;
        oppLevel++;
        break;
      case 255:
        cOArrowY = 315;
        oppLevel++;
        break;
    }
  }
  
  if (keyPressed && key == CODED && keyCode == UP) {
    //255
    switch(cOArrowY) {
      case 255:
        cOArrowY = 188;
        oppLevel--;
        break;
      case 315:
        cOArrowY = 255;
        oppLevel--;
        break;
    }
  }
  
  
  if (keyPressed && (key == 'z' || key == 'Z')) {
    //currently directs to this because no catalog yet
    state = "challenge";  
    chooseOppDiff();
  }
  
  
}

//-------------------
//CHALLENGE SCREEN
//--------------------

void challengeScreen() {
    frameRate(30);
    if (textShowTime < 60) {
      image(challengeScreen,0,0);
      fill(color(0));
      text(OppTrainer.name + " wants",50,475);
      text("to battle!",50,535); 
      textShowTime++;
    }
    else {
      textShowTime = 0;
      state = "chooseOption";
      battleStart = true;
    }
}