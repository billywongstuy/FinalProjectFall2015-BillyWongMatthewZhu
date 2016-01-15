float checkEffectiveness(String attackType, String type) {
  if (type.equals("")) {
    return 1;  
  }
  int at = typeToInt(attackType);
  int t = typeToInt(type);
  float[][]matchups = new float[15][15];
  for (int i = 0; i < matchups.length; i++) {
    for (int j = 0; j < matchups[i].length; j++) {
      matchups[i][j] = 1;  
    }
  }
  //Normal
  matchups[0][7] = 0;  //Ghost
  matchups[0][5] = 0.5;  //Rock
  
  //Fighting
  matchups[1][0] = 2; matchups[1][5] = 2; matchups[1][13] = 2; //Normal, Rock, Ice
  matchups[1][2] = 0.5; matchups[1][3] = 0.5; matchups[1][12] = 0.5; //Flying, Poison, Psychic
  matchups[1][7] = 0; //Ghost
  
  //Flying
  matchups[2][1] = 2; matchups[2][6] = 2; matchups[2][10] = 2; //Fighting, Bug, Grass
  matchups[2][5] = 0.5; matchups[2][11] = 0.5; //Electric, Rock
  
  //Poison
  matchups[3][6] = 2; matchups[3][10] = 2;
  matchups[3][3] = 0.5; matchups[3][4] = 0.5; matchups[3][5] = 0.5; matchups[3][7] = 0.5; //Poison, Ground, Rock, Ghost
  
  //Ground
  matchups[4][3] = 2; matchups[4][5] = 2; matchups[4][11] =  2; //Poison, Rock, Electric
  matchups[4][6] = 0.5; matchups[4][10] = 0.5; //Bug, Grass
  matchups[4][2] = 0; //Flying
  
  //Rock
  matchups[5][2] = 2; matchups[5][6] = 2; matchups[5][8] = 2; matchups[5][13] = 2;  //Flying, Bug, Fire, Ice
  matchups[5][1] = 0.5; matchups[5][4] = 0.5; //Fighting, Ground
  
  //Bug
  matchups[6][3] = 2; matchups[6][10] = 2; matchups[6][12] = 2;  //Poison, Grass, Psychic
  matchups[6][1] = 0.5; matchups[6][2] = 0.5; matchups[6][7] = 0.5; matchups[6][8] = 0.5;  //Fighting, Flying, Ghost, Fire
  
  //Ghost
  matchups[7][7] = 2; //Ghost
  matchups[7][0] = 0; matchups[7][12] = 0; //Normal, Psychic
  
  //Fire
  matchups[8][6] = 2; matchups[8][10] = 2; matchups[8][13] = 2;  //Bug, Grass, Ice
  matchups[8][5] = 0.5; matchups[8][8] = 0.5; matchups[8][9] = 0.5; matchups[8][14] = 0.5;  //Rock, Fire, Water, Dragon
  
  //Water
  matchups[9][4] = 2; matchups[9][5] = 2; matchups[9][8] = 2; //Ground, Rock, Fire
  matchups[9][10] = 0.5; matchups[9][10] = 0.5; matchups[9][14] = 0.5; //Water, Grass, Dragon
  
  //Grass
  matchups[10][4] = 2; matchups[10][5] = 2; matchups[10][9] = 2; //Ground, Rock, Water
  matchups[10][2] = 0.5; matchups[10][3] = 0.5; matchups[10][6] = 0.5; matchups[10][8] = 0.5; matchups[10][10] = 0.5; matchups[10][14] = 0.5; //Flying, Poison, Bug, Fire, Grass, Dragon
  
  //Electric
  matchups[11][2] = 2; matchups[11][9] = 2; //Flying, Water
  matchups[11][10] = 0.5; matchups[11][11] = 0.5; matchups[11][14] = 0.5; //Grass, Electric, Dragon
  matchups[11][4] = 0;  //Ground
  
  //Psychic
  matchups[12][1] = 2; matchups[12][3] = 2; //Fighting, Poison
  matchups[12][12] = 0.5; //Psychic
  
  //Ice
  matchups[13][2] = 2; matchups[13][4] = 2; matchups[13][10] = 2; matchups[13][14] = 2; //Flying, Ground, Grass, Dragon
  matchups[13][9] = 0.5; matchups[13][13] = 0.5; //Water, Ice   //NO FIRE YET!
  
  //Dragon
  matchups[14][14] = 2;  //Dragon
  
  return matchups[at][t];
}

int typeToInt(String type) {
  if (type.equals("Normal")) {
    return 0;
  }
  if (type.equals("Fighting")) {
    return 1;  
  }
  if (type.equals("Flying")) {
    return 2;  
  }
  if (type.equals("Poison")) {
    return 3;  
  }
  if (type.equals("Ground")) {
    return 4;  
  }
  if (type.equals("Rock")) {
    return 5;  
  }
  if (type.equals("Bug")) {
     return 6;    
  }
  if (type.equals("Ghost")) {
    return 7;  
  }
  if (type.equals("Fire")) {
    return 8;  
  }
  if (type.equals("Water")) {
    return 9;  
  }
  if (type.equals("Grass")) {
    return 10;  
  }
  if (type.equals("Electric")) {
    return 11;  
  }
  if (type.equals("Psychic")) {
    return 12;  
  }
  if (type.equals("Ice")) {
    return 13;  
  }
  if (type.equals("Dragon")) {
    return 14;  
  } 
    return 255;
}

float checkFullEffectiveness(String attackType, String type1, String type2) {
  return checkEffectiveness(attackType,type1)*checkEffectiveness(attackType,type2);  
}

float checkBattleEffectiveness(Attack attack, Poke p) {
  return checkFullEffectiveness(attack.getType(),p.type1,p.type2);  
}