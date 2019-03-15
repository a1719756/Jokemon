// Setup Canvas, Jokemon and Moves
void setup() {
  int tempX = 0;
  int tempY = 0;

  size(600, 600);
  textAlign(CENTER);
  frameRate(60);

  //loading images - check if files exist
  
  // Logo Exists
  File jlogo = new File(sketchPath("sprites/jokemon.png"));
  if (jlogo.exists()) {
    jokemonlogo = loadImage("sprites/jokemon.png");
  } else {
    jokemonlogo = createImage(0, 0, 0);
  }
  
  // Sprites Exist
  for (int i = 0; i<JokeNumber; i++) {
    // Front Sprite Exists
    File jfront = new File(sketchPath("sprites/"+i+".png"));
    if (jfront.exists()) {
      jokemonfront[i] = loadImage("sprites/"+i+".png");
    } else {
      jokemonfront[i] = createImage(0, 0, 0);
    }
    // Back Sprite Exists
    File jback = new File(sketchPath("sprites/"+i+"b.png"));
    if (jback.exists()) {
      jokemonback[i] = loadImage("sprites/"+i+"b.png");
    } else {
      jokemonback[i] = createImage(0, 0, 0);
    }
  }

  // Move Buttons //
  // Set Sizes
  MoveButtonWidth = width/3;
  MoveButtonHeight = height/16;
  // Set Colours
  MoveHighlight = color(150);
  MoveColor = color(255);
  MoveDisabled = color(100);
  MoveTwoTurn = color(232, 222, 23);
  MoveTwoTurnHighlight = color(160, 160, 18);
  MoveTwoTurnDis = color(100, 100, 2);
  // Set Positions
  for (int i = 0; i<MovesNumber; i++) {
    MoveOver[i] = false;
    MoveButtonX[i] = width/12.3 + tempX; 
    MoveButtonY[i] = height - (height/8) - tempY;
    if (i==1) {
      tempX -= width;
      tempY += height/12;
    }
    tempX += width/2;
  }  

  SetupJokemon();
  SetupStrengths();
  SetupMoves();
  SetupMovesets();
  reset();
}

// Move Buttons
void update() {
  for (int i=0; i<MovesNumber; i++) {
    if (overMoveButton(MoveButtonX[i], MoveButtonY[i], MoveButtonWidth, MoveButtonHeight)==true) {
      MoveOver[i] = true;
      JokeMoveSel[Player] = JokeMoves[Player][i];
    } else {
      MoveOver[i] = false;
    }
    if (MoveOver[i]) {
      int MoveDamage = Moves.getInt(JokeMoves[Player][i], "damage");
      int MoveAccuracy = Moves.getInt(JokeMoves[Player][i], "accuracy");
      int MovePP = Moves.getInt(JokeMoves[Player][i], "PP");
      String MoveType = Moves.getString(JokeMoves[Player][i], "type");
      String accuracyString = String.valueOf(MoveAccuracy);
      String damageString = String.valueOf(MoveDamage);
      if (MoveDamage==0) {
        damageString = "-";
      }
      if (MoveAccuracy>100 && Moves.getString(JokeMoves[Player][i], "effect")=="2/Turn") {
        MoveAccuracy=Moves.getInt(JokeMoves[Player][i]+1, "accuracy");
        MoveDamage=Moves.getInt(JokeMoves[Player][i]+1, "damage");
        accuracyString = String.valueOf(MoveAccuracy);
        damageString = String.valueOf(MoveDamage);
      } else if (MoveAccuracy>100) {
        accuracyString = "-";
        MoveAccuracy=100;
      }
      // Move Description Box
      fill(200);
      rect(width-0.3*width, height-height/2, 0.28*width, 0.2*height);
      fill(0);
      textSize(13);
      text("Type: "+MoveType+"\nPP: "+JokeMovesPP[Player][i]+"/"+MovePP+"\nDamage: "+damageString+"\nAccuracy: "+accuracyString, width-0.16*width, height-0.452*height);
    }
  }
}

// Mouse Press
void mousePressed() {
  // Jokemon Selector - Checks Button Coordinates
  if (select==1) {
    //first row
    if (mouseX>20 && mouseX<0.24*width && mouseY<80 && mouseY>40) {
      booleanreseter();
      jokeselector[0]=true;
      JokeID[Player] = 0;
    }else if (mouseX>0.24*width+20 && mouseX<0.24*width*2 && mouseY<80 && mouseY>40) {
      booleanreseter();
      jokeselector[1]=true;
      JokeID[Player] = 1;
    } else if (mouseX>0.24*width*2+20 && mouseX<0.24*width*3 && mouseY<80 && mouseY>40) {
      booleanreseter();
      jokeselector[2]=true;
      JokeID[Player] = 2;
    } else if (mouseX>0.24*width*3+20 && mouseX<0.24*width*4 && mouseY<80 && mouseY>40) {
      booleanreseter();
      jokeselector[3]=true;
      JokeID[Player] = 3;
    }
    //second row
    else if (mouseX>20 && mouseX<0.24*width && mouseY<80+0.16*height && mouseY>0.16*height+40) {
      booleanreseter();
      jokeselector[4]=true;
      JokeID[Player] = 4;
    } else if (mouseX>0.24*width+20 && mouseX<0.24*width*2 && mouseY<80+0.16*height && mouseY>0.16*height+40) {
      booleanreseter();
      jokeselector[5]=true;
      JokeID[Player] = 5;
    } else if (mouseX>0.24*width*2+20 && mouseX<0.24*width*3 && mouseY<80+0.16*height && mouseY>0.16*height+40) {
      booleanreseter();
      jokeselector[6]=true;
      JokeID[Player] = 6;
    } else if (mouseX>0.24*width*3+20 && mouseX<0.24*width*4 && mouseY<80+0.16*height && mouseY>0.16*height+40) {
      booleanreseter();
      jokeselector[7]=true;
      JokeID[Player] = 7;
    }
    //third row
    else if (mouseX>20 && mouseX<0.24*width && mouseY<80+0.16*height*2 && mouseY>0.16*height*2+40) {
      booleanreseter();
      jokeselector[8]=true;
      JokeID[Player] = 8;
    } else if (mouseX>0.24*width+20 && mouseX<0.24*width*2 && mouseY<80+0.16*height*2 && mouseY>0.16*height*2+40) {
      booleanreseter();
      jokeselector[9]=true;
      JokeID[Player] = 9;
    } else if (mouseX>0.24*width*2+20 && mouseX<0.24*width*3 && mouseY<80+0.16*height*2 && mouseY>0.16*height*2+40) {
      booleanreseter();
      jokeselector[10]=true;
      JokeID[Player] = 10;
    } else if (mouseX>0.24*width*3+20 && mouseX<0.24*width*4 && mouseY<80+0.16*height*2 && mouseY>0.16*height*2+40) {
      booleanreseter();
      jokeselector[11]=true;
      JokeID[Player] = 11;
    }
    //fourth row
    else if (mouseX>20 && mouseX<0.34*width &&mouseY<80+0.16*height*3 && mouseY>0.16*height*3+40) {
      booleanreseter();
      jokeselector[12]=true;
      JokeID[Player] = 12;
    } else if (mouseX>0.38*width && mouseX<width*0.58 &&mouseY<80+0.16*height*3 && mouseY>0.16*height*3+40) {
      booleanreseter();
      jokeselector[13]=true;
      JokeID[Player] = 13;
    } else if (mouseX>0.62*width && mouseX<0.82*width &&mouseY<80+0.16*height*3 && mouseY>0.16*height*3+40) {
      booleanreseter();
      jokeselector[14]=true;
      JokeID[Player] = 14;
    } else if (mouseX>0.006*width && mouseX<0.994*width && mouseY>0.806*height && mouseY<0.994*height) {
      booleanreseter();
      JokeSprite[Player] = jokemonback[JokeID[Player]];
      jokeselector[15]=true;
      // Set Iniitial Stats
      for (int i = 0; i<StatsNumber-1; i++) {
        JokeStatsMod[Player][i] = 1.0;
        JokeStatsMod[Opponent][i] = 1.0;
      }
      for (int i = 0; i<StatusNumber; i++) {
        JokeStatus[Player][i] = false;
        JokeStatus[Opponent][i] = false;
      }
      StatsSet=true;
      SetStats();
    }
  }
  // Battle
  if (select==2) {
    for (int i=0; i<MovesNumber; i++) {
      if (MoveOver[i] && !MoveOverDis[i]) {
        if (JokeMovesPP[Player][i]>0) {
          DisplayText = "\n";
          ChooseAttack(JokeMoveSel[Player]);
          if (!JokeTwoTurn[Player]) {
            JokeMovesPP[Player][i]-=1;
          }
        } else {
          DisplayText += "This move has no PP left!"+WaitTime;
        }
      }
    }
  }
}

// Initialise Stats
void SetStats() {
  // Set Jokemon Stats //
  // EV Stats
  for (int i = 0; i<Players; i++) {
    JokeEVs[i][Hit] = MoveSet.getInt(JokeID[i], "hitpointsEVs");
    JokeEVs[i][Atk] = MoveSet.getInt(JokeID[i], "attackEVs");
    JokeEVs[i][Def] = MoveSet.getInt(JokeID[i], "defenseEVs");
    JokeEVs[i][SpA] = MoveSet.getInt(JokeID[i], "specialAttackEVs");
    JokeEVs[i][SpD] = MoveSet.getInt(JokeID[i], "specialDefenseEVs");
    JokeEVs[i][Spe] = MoveSet.getInt(JokeID[i], "speedEVs");
  }
  // Base Stats
  JokeMaxHP[Player] = JokeHP[Player] = Jokemon.getInt(JokeID[Player], "hitpoints") + (JokeEVs[Player][Hit]/8);
  JokeStats[Player][Atk] = Jokemon.getInt(JokeID[Player], "attack") + (JokeEVs[Player][Atk]/8);
  JokeStats[Player][Def] = Jokemon.getInt(JokeID[Player], "defense") + (JokeEVs[Player][Def]/8);
  JokeStats[Player][SpA] = Jokemon.getInt(JokeID[Player], "specialattack") + (JokeEVs[Player][SpA]/8);
  JokeStats[Player][SpD] = Jokemon.getInt(JokeID[Player], "specialdefense") + (JokeEVs[Player][SpD]/8);
  JokeStats[Player][Spe] = Jokemon.getInt(JokeID[Player], "speed") + (JokeEVs[Player][Spe]/8);
  JokeMaxHP[Opponent] = JokeHP[Opponent] = Jokemon.getInt(JokeID[Opponent], "hitpoints") + (JokeEVs[Opponent][Hit]/8);
  JokeStats[Opponent][Atk] = Jokemon.getInt(JokeID[Opponent], "attack") + (JokeEVs[Opponent][Atk]/8);
  JokeStats[Opponent][Def] = Jokemon.getInt(JokeID[Opponent], "defense") + (JokeEVs[Opponent][Def]/8);
  JokeStats[Opponent][SpA] = Jokemon.getInt(JokeID[Opponent], "specialattack") + (JokeEVs[Opponent][SpA]/8);
  JokeStats[Opponent][SpD] = Jokemon.getInt(JokeID[Opponent], "specialdefense") + (JokeEVs[Opponent][SpD]/8);
  JokeStats[Opponent][Spe] = Jokemon.getInt(JokeID[Opponent], "speed") + (JokeEVs[Opponent][Spe]/8);
  // Moveset - Set the Moves
  for (int i = 0; i<MovesNumber; i++) {
    JokeMoves[Player][i] = MoveSet.getInt(JokeID[Player], "move"+(i+1));
    JokeMoves[Opponent][i] = MoveSet.getInt(JokeID[Opponent], "move"+(i+1));
  }
  // Set Modifiers
  BurnMod[Player] = 1.0;
  BurnMod[Opponent] = 1.0;
  ParaMod[Player] = 1.0;
  ParaMod[Opponent] = 1.0;
  TurnSleep[Player] = 0;
  TurnSleep[Opponent] = 0;
  // Set Current Move PP
  for (int i = 0; i<MovesNumber; i++) {
    JokeMovesPP[Player][i] = Moves.getInt(JokeMoves[Player][i], "PP");
    JokeMovesPP[Opponent][i] = Moves.getInt(JokeMoves[Opponent][i], "PP");
  }
  // Set Current Stat Stages
  for (int i = 0; i<StatStages; i++) {
    JokeCurrentStage[Player][i] = 6;
    JokeCurrentStage[Opponent][i] = 6;
  }
}

// Draw the Background
void drawBackground() {
  stroke(0, 0, 0, 0);
  fill(2, backgroundgreen, 60);
  rect(0, 0, width, height);
  if (backgroundgreen>=200 && !backgroundchange) {
    backgroundchange = true;
  } else if (backgroundgreen<=170 && backgroundchange) {
    backgroundchange = false;
  }
  if (backgroundchange) {
    backgroundgreen-=0.25;
  } else if (!backgroundchange) {
    backgroundgreen+=0.25;
  }
  stroke(50);
}

// Battle
void battle() {
  background(#057C1F);
  drawBackground();
  // Player and Opponent Sprites
  fill(#5BC961);
  strokeWeight(2);
  ellipse(0.26*width, 0.8*height, 0.4*width, 0.34*height);
  ellipse(0.63*width, 0.38*height, 0.3*width, 0.24*height);
  image(JokeSprite[Player], 0.08*width, 0.45*height, 0.34*width, 0.304*height);
  image(JokeSprite[Opponent], width/2, 0.14*height, 0.323*width, 0.2888*height);
  // Other
  update();
  ShowText();
  textSize(13);
  strokeWeight(3);
  // Player and Opponent HP
  String PlayerJokeName = Jokemon.getString(JokeID[Player], "name");
  String OpponentJokeName = Jokemon.getString(JokeID[Opponent], "name");
  String PlayerJokeType1 = Jokemon.getString(JokeID[Player], "type1");
  String PlayerJokeType2 = Jokemon.getString(JokeID[Player], "type2");
  String OpponentJokeType1 = Jokemon.getString(JokeID[Opponent], "type1");
  String OpponentJokeType2 = Jokemon.getString(JokeID[Opponent], "type2");
  // Player and Opponent HP Background
  fill(255);
  rect(0.04*width, height-0.6*height, width/2, 0.05*height);
  rect(width-0.58*width, height-0.9*height, width/2, 0.05*height);
  fill(0);
  text(JokeHP[Player]+"/"+JokeMaxHP[Player]+" "+PlayerJokeName/*+" - "+PlayerJokeType1+" "+PlayerJokeType2*/, 0.06*width, height-0.566*height);
  text(JokeHP[Opponent]+"/"+JokeMaxHP[Opponent]+" "+OpponentJokeName/*+" - "+OpponentJokeType1+" "+OpponentJokeType2*/, width-0.56*width, height-0.866*height);
  // Player Status Conditions
  if (JokeStatus[Player][Freeze]) {
    fill(StatusConditions[Freeze]);
    rect(width/2, height-0.6*height, 0.08*width, 0.05*height);
    textSize(15);
    fill(0);
    text("FZN", 0.516*width, height-0.564*height);
  } else if (JokeStatus[Player][Burn]) {
    fill(StatusConditions[Burn]);
    rect(width/2, height-0.6*height, 0.08*width, 0.05*height);
    textSize(15);
    fill(0);
    text("BRN", 0.516*width, height-0.564*height);
  } else if (JokeStatus[Player][Sleep]) {
    fill(StatusConditions[Sleep]);
    rect(width/2, height-0.6*height, 0.08*width, 0.05*height);
    textSize(15);
    fill(0);
    text("SLP", 0.516*width, height-0.564*height);
  } else if (JokeStatus[Player][Paralyse]) {
    fill(StatusConditions[Paralyse]);
    rect(width/2, height-0.6*height, 0.08*width, 0.05*height);
    textSize(15);
    fill(0);
    text("PAR", 0.516*width, height-0.564*height);
  } else if (JokeStatus[Player][Poison]) {
    fill(StatusConditions[Poison]);
    rect(width/2, height-0.6*height, 0.08*width, 0.05*height);
    textSize(15);
    fill(0);
    text("PSN", 0.516*width, height-0.564*height);
  }
  // Opponent Status Conditions
  if (JokeStatus[Opponent][Freeze]) {
    fill(StatusConditions[Freeze]);
    rect(width-0.12*width, height-0.9*height, 0.08*width, 0.05*height);
    textSize(15);
    fill(0);
    text("FZN", width-0.106*width, height-0.864*height);
  } else if (JokeStatus[Opponent][Burn]) {
    fill(StatusConditions[Burn]);
    rect(width-0.12*width, height-0.9*height, 0.08*width, 0.05*height);
    textSize(15);
    fill(0);
    text("BRN", width-0.106*width, height-0.864*height);
  } else if (JokeStatus[Opponent][Sleep]) {
    fill(StatusConditions[Sleep]);
    rect(width-0.12*width, height-0.9*height, 0.08*width, 0.05*height);
    textSize(15);
    fill(0);
    text("SLP", width-0.106*width, height-0.864*height);
  } else if (JokeStatus[Opponent][Paralyse]) {
    fill(StatusConditions[Paralyse]);
    rect(width-0.12*width, height-0.9*height, 0.08*width, 0.05*height);
    textSize(15);
    fill(0);
    text("PAR", width-0.106*width, height-0.864*height);
  } else if (JokeStatus[Opponent][Poison]) {
    fill(StatusConditions[Poison]);
    rect(width-0.12*width, height-0.9*height, 0.08*width, 0.05*height);
    textSize(15);
    fill(0);
    text("PSN", width-0.106*width, height-0.864*height);
  }
  // Move Select Background
  strokeWeight(0.02*width);
  fill(200);
  rect(0.02*width, 0.77*height, width-0.04*width, height/5);
  // Move Select Boxes
  for (int i = 0; i<MovesNumber; i++) {
    String movename = Moves.getString(JokeMoves[Player][i], "name");
    strokeWeight(0.006*width);
    if (JokeTwoTurn[Player] || !moveprogress) {
      fill(MoveDisabled);
      MoveOverDis[i]=true;
    } else if (MoveOver[i]) {
      fill(MoveHighlight);
    } else {
      fill(MoveColor);
    }
    // Check for Two Turn moves
    if (movename=="Solar Beam" && JokeTwoTurnMove[Player][SolarBeam]) {
      if (MoveOver[i]) {
        fill(MoveTwoTurnHighlight);
      } else {
        fill(MoveTwoTurn);
      }
      if (moveprogress) {
        MoveOverDis[i]=false;
      } else {
        fill(MoveTwoTurnDis);
      }
    } else if (movename=="Sky Attack" && JokeTwoTurnMove[Player][SkyAttack]) {
      if (MoveOver[i]) {
        fill(MoveTwoTurnHighlight);
      } else {
        fill(MoveTwoTurn);
      }
      if (moveprogress) {
        MoveOverDis[i]=false;
      } else {
        fill(MoveTwoTurnDis);
      }
    } else if (movename=="Fly" && JokeTwoTurnMove[Player][Fly]) {
      if (MoveOver[i]) {
        fill(MoveTwoTurnHighlight);
      } else {
        fill(MoveTwoTurn);
      }
      if (moveprogress) {
        MoveOverDis[i]=false;
      } else {
        fill(MoveTwoTurnDis);
      }
    } else if (movename=="Dig" && JokeTwoTurnMove[Player][Dig]) {
      if (MoveOver[i]) {
        fill(MoveTwoTurnHighlight);
      } else {
        fill(MoveTwoTurn);
      }
      if (moveprogress) {
        MoveOverDis[i]=false;
      } else {
        fill(MoveTwoTurnDis);
      }
    }
    rect(MoveButtonX[i], MoveButtonY[i], MoveButtonWidth, MoveButtonHeight);
    fill(0, 0, 0);
    textAlign(CENTER);
    textSize(13);
    text(movename, MoveButtonX[i]+(0.5*MoveButtonWidth), MoveButtonY[i]+(0.65*MoveButtonHeight));
  }
  // Victory Screen
  if (moveprogress && BattleEnd) {
    textAlign(CENTER);
    background(#0C8304);
    fill(255, 100, 255);    
    image(jokemonlogo, 0.12*width, 0.03*height, width/1.3, height/4);
    fill(0);
    textSize(50);
    if (PlayerWin) {
      text("You Win!", width/2, height/2);
      textSize(20);
      text("Press anywhere to play again!", width/2, height/2+40);
      if (mousePressed) {
        reset();
        select=1;
      }
    } else {
      text("You Lose!", width/2, height/2);
      textSize(20);
      text("Press anywhere to play again!", width/2, height/2+40);
      if (mousePressed) {
        reset();
        select=1;
      }
    }
  }
}

void reset() {
  // Reset Variables
  for (int i = 0; i<JokeNumber+1; i++) {
    jokeselector[i] = false;
  }
  StatsSet=false;
  BattleEnd=false;
  PlayerWin=false;
  DisplayText = "\n";
  ShowText = "";
  // Set to Random
  JokeID[Player] = int(random(JokeNumber));
  jokeselector[JokeID[Player]]=true;
  JokeSprite[Player] = jokemonback[JokeID[Player]];
  JokeID[Opponent] = int(random(JokeNumber));
  JokeSprite[Opponent] = jokemonfront[JokeID[Opponent]];
}

void transition() {
  noStroke();
  fill(0, 0, 0, transalpha);
  rect(0, 0, width, height);
  stroke(1);
  // Make two semicircles of different colours
  fill(255);
  arc(transx, height/2, 2*transradius, 2*transradius, 0, PI);
  fill(100, 100, 255);
  arc(transx, height/2, 2*transradius, 2*transradius, PI, 2*PI);
  strokeWeight(10);
  fill(255);
  ellipse(transx, height/2, 0.4*transradius, 0.4*transradius);
  // First part of transition
  if (2*transradius>=width+width/2) {
    transitionpart1done=true;
  } else {
    transradius+=0.016*width;
  }
  // Second part of transition
  if (transitionpart1done && transx<2*width) {
    transx+=0.016*width;
    if (transalpha>0) {
      transalpha-=3;
    } else if (transalpha<0) {
      transalpha=0;
    }
  } else if (transitionpart1done && transx>=2*width) {
    transitionpart1done = false;
    transition1=false;
  }
}

void otherTransition() {
  noStroke();
  if (PlayerWin) {
    fill(50, 50, 200, transalpha);
  } else {
    fill(200, 50, 50, transalpha);
  }
  rect(0, 0, width, height);
  stroke(1);
  // Make two semicircles of different colours
  fill(255);
  arc(transx, height/2, 2*transradius, 2*transradius, 0, PI);
  fill(100, 100, 255);
  arc(transx, height/2, 2*transradius, 2*transradius, PI, 2*PI);
  strokeWeight(10);
  fill(255);
  ellipse(transx, height/2, 0.4*transradius, 0.4*transradius);
  // First part of transition
  if (transx>width/2) {
    transx-=0.016*width;
    if (transalpha<255) {
      transalpha+=10;
    } else if (transalpha>255) {
      transalpha=255;
    }
  } else {
    transitionpart1done=true;
  }
  // Second part of transition
  if (transitionpart1done && 2*transradius>0) {
    transradius-=0.012*width;
    if (transalpha>0) {
      transalpha-=10;
    } else if (transalpha<0) {
      transalpha=0;
    }
  } else if (2*transradius<=0) {
    transition2=false;
  }
}

void resetTransition() {
  transx = width/2;
  transradius = 0;
  transalpha = 255;
  transition1 = false;
  transition2 = false;
  transitionpart1done = false;
}