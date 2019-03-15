// Check Speed
boolean CheckSpeed(){
  float playerspeed = JokeStats[Player][Spe] * JokeStatsMod[Player][Spe] * ParaMod[Player];
  float opponentspeed = JokeStats[Opponent][Spe] * JokeStatsMod[Opponent][Spe] * ParaMod[Opponent];
  boolean returnval = true;
  int speedtie = int(random(1,3));
  if(playerspeed > opponentspeed){
    returnval = true;
  } else if(playerspeed < opponentspeed){
    returnval = false;
  } else{
    if(speedtie==1){
      //println("Player hits first");
      returnval = true;
    }else if(speedtie==2){
      //println("Opponent hits first");
      returnval = false;
    }
  }
  return returnval;
}

// Check Accuracy - Dig and Earthquake Interaction not Implemented
boolean CheckAccuracy(int moveid,int attackerid,int defenderid){
  int moveaccuracy = Moves.getInt(moveid,"accuracy");
  int testaccuracy = int(random(0,101));
  if(PlayerAtk){
    testaccuracy += JokeTwoTurnAccMod[Opponent];
  }else{
    testaccuracy += JokeTwoTurnAccMod[Player];
  }
  if(testaccuracy <= moveaccuracy){
    //println("Hits with " + testaccuracy);
    return true;
  } else{
    //println("Doesn't with " + testaccuracy);
    return false;
  }
}

// Deal Damage
int Damage(int moveid, int attackerid, int defenderid){
  String moveattacktype = Moves.getString(moveid,"attacktype");
  String movetype = Moves.getString(moveid,"type");
  String movename = Moves.getString(moveid,"name");
  String attackertype1 = Jokemon.getString(attackerid,"type1");
  String attackertype2 = Jokemon.getString(attackerid,"type2");
  String attackername = Jokemon.getString(attackerid,"name");
  String defendertype1 = Jokemon.getString(defenderid,"type1");
  String defendertype2 = Jokemon.getString(defenderid,"type2");
  String defendername = Jokemon.getString(defenderid,"name");
  String attackerstring = "";
  String defenderstring = "";
  String endstring = "";
  TableRow damagerow = MoveStrengths.findRow(movetype,"");
  int damagedone;
  float damage = Moves.getInt(moveid,"damage");
  float damagemult;
  float attack = 0;
  float defense = 0;
  float statmodattack = 0;
  float statmoddefense = 0;
  // Check for Attacking Move Type
  if(moveattacktype == "Physical"){
    attack = Jokemon.getInt(attackerid,"attack");
    defense = Jokemon.getInt(defenderid,"defense");
    if(PlayerAtk){
      statmodattack = JokeStatsMod[Player][Atk] * BurnMod[Player];
      statmoddefense = JokeStatsMod[Opponent][Def];
    } else{
      statmodattack = JokeStatsMod[Opponent][Atk] * BurnMod[Opponent];
      statmoddefense = JokeStatsMod[Player][Def];
    }
  } else if(moveattacktype == "Special"){
    attack = Jokemon.getInt(attackerid,"specialattack");
    defense = Jokemon.getInt(defenderid,"specialdefense");
    if(PlayerAtk){
      statmodattack = JokeStatsMod[Player][SpA];
      statmoddefense = JokeStatsMod[Opponent][SpD];
    } else{
      statmodattack = JokeStatsMod[Opponent][SpA];
      statmoddefense = JokeStatsMod[Player][SpD];
    }
  }
  // Attacking Jokemon String
  if(attackertype2 != ""){
    attackerstring = attackername; 
  } else {
    attackerstring = attackername;
  }
  // Defending Jokemon String and Damage Mult
  if(defendertype2 != ""){
    defenderstring = defendername; 
    damagemult = damagerow.getFloat(defendertype1) * damagerow.getFloat(defendertype2);
  } else {
    defenderstring = defendername;
    damagemult = damagerow.getFloat(defendertype1);
  }
  // End String
  if(damagemult >= 2){
    endstring = "It's super effective!"+WaitTime;
  } else if(damagemult <= 0.5){
    endstring = "It's not very effective!"+WaitTime;
  }
  // Apply Attack and Defense Bonuses
  damagemult =  damagemult * statmodattack * (1/statmoddefense);
  // Random Damage
  damagemult = damagemult * random(0.85,1.01);
  // Check for STAB
  if(attackertype1 == movetype || attackertype2 == movetype){
    damagemult = damagemult * 1.5;
  }
  // Calculate Damage
  damagedone = int(((((((2*50)/5) + 2) * damage * (attack/defense))/50) + 2) * damagemult);
  // Display Text
  textcounter = 0;
  if(PlayerAtk==true){
    DisplayText += (attackerstring + " used " + movename + " on foe " + defenderstring + "."+WaitTime + endstring);
  }else if(PlayerAtk==false){
    DisplayText += ("Foe " + attackerstring + " used " + movename + " on " + defenderstring + "."+WaitTime + endstring);  
  }
  return damagedone;
}

// Over Move Button
boolean overMoveButton(float x, float y, int width, int height){
  if(mouseX >= x && mouseX <= x+width && mouseY >= y && mouseY <= y+height){
    return true;
  } else {
    return false;
  }
}

// Attack Chosen
void ChooseAttack(int move){
  boolean[] firstmessage = new boolean[2];
  boolean spe = true;
  boolean acc = true;
  boolean MoveSelected = false;
  boolean TypeImmune = false;
  boolean MultiStatus = false;
  boolean[] fasterstatus = new boolean[StatusNumber];
  boolean[] slowerstatus = new boolean[StatusNumber];
  int faster = 0;
  int slower = 1;
  int fasterjoke = JokeID[Player];
  int slowerjoke = JokeID[Opponent];
  int fasterhp = JokeHP[Player];
  int fastermaxhp = JokeMaxHP[Player];
  int slowermaxhp = JokeMaxHP[Opponent];
  int slowerhp = JokeHP[Opponent];
  int fastermove = 0;
  int slowermove = 0;
  int damage = 0;
  int plamoveindex = 0;
  int oppmoveindex = 0;
  int oppmoveindexi = 0;
  int[] tempturnsleep = new int[Players];
  String fastertype1 = "";
  String fastertype2 = "";
  String slowertype1 = "";
  String slowertype2 = "";
  String movetype;
  String usertype1 = Jokemon.getString(JokeID[Player],"type1");
  String usertype2 = Jokemon.getString(JokeID[Player],"type2");
  String poketype1 = Jokemon.getString(JokeID[Opponent],"type1");
  String poketype2 = Jokemon.getString(JokeID[Opponent],"type2");
  String fasterstring = Jokemon.getString(JokeID[Player],"name");
  String slowerstring = "Foe "+Jokemon.getString(JokeID[Opponent],"name");
  TableRow damagerow;
  
  DisplayText += " \n";
  
  for(int i = 0; i<MovesNumber; i++){
    MoveOverDis[i]=true;
  }
  
  // Choose Opponent Move - If Second Part of Two Turn Move Choose It
  for(int i = 0; i<MovesNumber; i++){
    if(JokeMoves[Opponent][i] == 5 || JokeMoves[Opponent][i] == 9 || JokeMoves[Opponent][i] == 13 || JokeMoves[Opponent][i] == 15){
      JokeMoveSel[Opponent] = JokeMoves[Opponent][i];
      MoveSelected=true;
    }
  }
  
  // Choose Opponent Move - By Supereffective or Random
  for(int i = 0; i<MovesNumber; i++){
    oppmoveindex = JokeMoves[Opponent][i];
    movetype = Moves.getString(oppmoveindex,"type");
    damagerow = MoveStrengths.findRow(movetype,"");
    if(!MoveSelected && (Moves.getString(oppmoveindex,"effect")=="1/Sleep"||Moves.getString(oppmoveindex,"effect")=="1/Para"||Moves.getString(oppmoveindex,"effect")=="1/Freeze"||Moves.getString(oppmoveindex,"effect")=="1/Poison"||Moves.getString(oppmoveindex,"effect")=="1/Burn") && (!JokeStatus[Player][0]&&!JokeStatus[Player][1]&&!JokeStatus[Player][2]&&!JokeStatus[Player][3]&&!JokeStatus[Player][4]) && Moves.getInt(oppmoveindex,"damage")==0){
      JokeMoveSel[Opponent] = JokeMoves[Opponent][i];
      if((movetype=="Ground" && (usertype1 == "Flying" || usertype2 == "Flying")) || (movetype=="Poison" && (usertype1 == "Poison" || usertype2 == "Poison")) || (movetype=="Electric" && (usertype1 == "Ground" || usertype2 == "Ground")) || (movetype=="Ghost" && (usertype1 == "Normal" || usertype2 == "Normal")) || (movetype=="Normal" && (usertype1 == "Ghost" || usertype2 == "Ghost")) || (movetype=="Ghost" && (usertype1 == "Psychic" || usertype2 == "Psychic"))){
        MoveSelected = false;
      }else{
        //println("Chose 1");
        //println(JokeStatus[Player]);
        oppmoveindexi = i;
        MoveSelected = true;
      }
    }else if(!MoveSelected && ((damagerow.getFloat(usertype1) >= 2) || (usertype2 != "" && damagerow.getFloat(usertype2) >= 2)) && Moves.getInt(oppmoveindex,"damage")!=0){
      JokeMoveSel[Opponent] = JokeMoves[Opponent][i];
      if((movetype=="Ground" && (usertype1 == "Flying" || usertype2 == "Flying")) || (movetype=="Poison" && (usertype1 == "Poison" || usertype2 == "Poison")) || (movetype=="Electric" && (usertype1 == "Ground" || usertype2 == "Ground")) || (movetype=="Ghost" && (usertype1 == "Normal" || usertype2 == "Normal")) || (movetype=="Normal" && (usertype1 == "Ghost" || usertype2 == "Ghost")) || (movetype=="Ghost" && (usertype1 == "Psychic" || usertype2 == "Psychic"))){
        MoveSelected = false;
      }else{
        //println("Chose 2");
        oppmoveindexi = i;
        MoveSelected = true;
      }
    } else if(!MoveSelected){
      JokeMoveSel[Opponent] = JokeMoves[Opponent][int(random(MovesNumber))];
      while((Moves.getString(oppmoveindex,"effect")=="1/Sleep"||Moves.getString(oppmoveindex,"effect")=="1/Para"||Moves.getString(oppmoveindex,"effect")=="1/Freeze"||Moves.getString(oppmoveindex,"effect")=="1/Poison"||Moves.getString(oppmoveindex,"effect")=="1/Burn")  && (movetype=="Ground" && (usertype1 == "Flying" || usertype2 == "Flying")) || (movetype=="Poison" && (usertype1 == "Poison" || usertype2 == "Poison")) || (movetype=="Electric" && (usertype1 == "Ground" || usertype2 == "Ground"))){
        JokeMoveSel[Opponent] = JokeMoves[Opponent][int(random(MovesNumber))];
      }
      oppmoveindexi = i;
      //println("Chose 3");
    }
  }
  
  // Check Who Should Go First
  spe = CheckSpeed();
  
  // Reset Player if Two Turn Move
  if(move == 5 || move == 9 || move == 13 || move == 15){
    JokeTwoTurn[Player] = false;
    for(int i = 0; i<MovesNumber; i++){
      MoveOverDis[i]=false;
      JokeTwoTurnMove[Player][i]=false;
      if(JokeMoves[Player][i] == 5){
        JokeMoves[Player][i] = 4;
      }else if(JokeMoves[Player][i] == 9){
        JokeMoves[Player][i] = 8;
      }else if(JokeMoves[Player][i] == 13){
        JokeMoves[Player][i] = 12;
      }else if(JokeMoves[Player][i] == 15){
        JokeMoves[Player][i] = 14;
      }
    }
  }
  
  // Reset Opponent if Two Turn Move
  if(JokeMoveSel[Opponent] == 5 || JokeMoveSel[Opponent] == 9 || JokeMoveSel[Opponent] == 13 || JokeMoveSel[Opponent] == 15){
    JokeTwoTurn[Opponent] = false;
    for(int i = 0; i<MovesNumber; i++){
      JokeTwoTurnMove[Opponent][i]=false;
      if(JokeMoves[Opponent][i]==5){
        JokeMoves[Opponent][i] = 4;
      }else if(JokeMoves[Opponent][i]==9){
        JokeMoves[Opponent][i] = 8;
      }else if(JokeMoves[Opponent][i]==13){
        JokeMoves[Opponent][i] = 12;
      }else if(JokeMoves[Opponent][i]==15){
        JokeMoves[Opponent][i] = 14;
      }
    }
  }
  
  // Set Variables Depending On Speed
  
  // Player Faster
  if(spe){
    PlayerAtk = true;
    fastermove = move;
    slowermove = JokeMoveSel[Opponent];
    fasterjoke = JokeID[Player];
    fasterhp = JokeHP[Player];
    fastermaxhp = JokeMaxHP[Player];
    slowerjoke = JokeID[Opponent];
    slowerhp = JokeHP[Opponent];
    slowermaxhp = JokeMaxHP[Opponent];
    fastertype1 = usertype1;
    fastertype2 = usertype2;
    slowertype1 = poketype1;
    slowertype2 = poketype2;
    fasterstring = Jokemon.getString(JokeID[Player],"name");
    slowerstring = "Foe "+Jokemon.getString(JokeID[Opponent],"name");
    tempturnsleep[faster] = TurnSleep[Player];
    tempturnsleep[slower] = TurnSleep[Opponent];
    for(int i = 0; i<StatusNumber; i++){
      fasterstatus[i] = JokeStatus[Player][i];
      slowerstatus[i] = JokeStatus[Opponent][i];
    }
    for(int i = 0; i<MovesNumber; i++){
      if(JokeMoves[Player][i]==fastermove){
        plamoveindex=i;
      }
    }
    
  // Opponent Faster
  } else if(!spe){
    PlayerAtk = false;
    fastermove = JokeMoveSel[Opponent];
    slowermove = move;
    fasterjoke = JokeID[Opponent];
    fasterhp = JokeHP[Opponent];
    fastermaxhp = JokeMaxHP[Opponent];
    slowerjoke = JokeID[Player];
    slowerhp = JokeHP[Player];
    slowermaxhp = JokeMaxHP[Player];
    fastertype1 = poketype1;
    fastertype2 = poketype2;
    slowertype1 = usertype1;
    slowertype2 = usertype2;
    fasterstring = "Foe "+Jokemon.getString(JokeID[Opponent],"name");
    slowerstring = Jokemon.getString(JokeID[Player],"name");
    tempturnsleep[faster] = TurnSleep[Opponent];
    tempturnsleep[slower] = TurnSleep[Player];
    for(int i = 0; i<StatusNumber; i++){
      fasterstatus[i] = JokeStatus[Opponent][i];
      slowerstatus[i] = JokeStatus[Player][i];
    }
    for(int i = 0; i<MovesNumber; i++){
      if(JokeMoves[Player][i]==slowermove){
        plamoveindex=i;
      }
    }
    
  }
  
  // Reset Opponent Accuracy for Two Turn Moves for Faster Jokemon
  if(PlayerAtk){
    JokeTwoTurnAccMod[Player] = 0;
  } else {
    JokeTwoTurnAccMod[Opponent] = 0;
  }
  
  // Faster Jokemon's Turn - Check for Statuses and If None or Ran Out Do Turn
  if(fasterstatus[Freeze] && (int(random(0,101))>10) && Moves.getString(fastermove,"type")!="Fire" && Moves.getString(slowermove,"type")!="Fire"){
    if(spe){
      JokeMovesPP[Player][plamoveindex] += 1;
    }else{
      JokeMovesPP[Opponent][oppmoveindexi] += 1;
    }
    DisplayText += (fasterstring+" is frozen solid!"+WaitTime);
  }else if(fasterstatus[Sleep] && tempturnsleep[faster]>0){
    tempturnsleep[faster]-=1;
    if(spe){
        TurnSleep[Player] = tempturnsleep[faster];
        JokeMovesPP[Player][plamoveindex] += 1;
      }else{
        TurnSleep[Opponent] = tempturnsleep[faster];
        JokeMovesPP[Opponent][oppmoveindexi] += 1;
      }
    DisplayText += (fasterstring+" is fast asleep!"+WaitTime);
  } else if(fasterstatus[Paralyse] && (int(random(0,101))>33)){
    if(spe){
      JokeMovesPP[Player][plamoveindex] += 1;
    }else{
      JokeMovesPP[Opponent][oppmoveindexi] += 1;
    }
    DisplayText += (fasterstring+" is paralysed, it cannot move!"+WaitTime);
  } else {
    if(fasterstatus[Freeze]){
      fasterstatus[Freeze] = false;
      DisplayText += (fasterstring+" thawed out!"+WaitTime);
    } else if(fasterstatus[Sleep]){
      fasterstatus[Sleep] = false;
      DisplayText += (fasterstring+" woke up!"+WaitTime);
    }
    acc = CheckAccuracy(fastermove,fasterjoke,slowerjoke);
    if(Moves.getString(fastermove,"type")=="Ground" && (slowertype1=="Flying" || slowertype2=="Flying") && Moves.getInt(fastermove,"id")!=14){
      if(Moves.getString(fastermove,"effect").indexOf("Self")!=-1){
        TypeImmune=false;
      } else{
        acc=false;
        TypeImmune=true;
      }
    }else if(Moves.getString(fastermove,"type")=="Electric" && (slowertype1=="Ground" || slowertype2=="Ground")){
      if(Moves.getString(fastermove,"effect").indexOf("Self")!=-1){
        TypeImmune=false;
      } else{
        acc=false;
        TypeImmune=true;
      }
    }else if(Moves.getString(fastermove,"type")=="Poison" && (slowertype1=="Poison" || slowertype2=="Poison")){
      if(Moves.getString(fastermove,"effect").indexOf("Self")!=-1){
        TypeImmune=false;
      } else{
        acc=false;
        TypeImmune=true;
      }
    }else if(Moves.getString(fastermove,"type")=="Ghost" && (slowertype1=="Normal" || slowertype2=="Normal")){
      if(Moves.getString(fastermove,"effect").indexOf("Self")!=-1){
        TypeImmune=false;
      } else{
        acc=false;
        TypeImmune=true;
      }
    }else if(Moves.getString(fastermove,"type")=="Normal" && (slowertype1=="Ghost" || slowertype2=="Ghost")){
      if(Moves.getString(fastermove,"effect").indexOf("Self")!=-1){
        TypeImmune=false;
      } else{
        acc=false;
        TypeImmune=true;
      }
    }else if(Moves.getString(fastermove,"type")=="Ghost" && (slowertype1=="Psychic" || slowertype2=="Psychic")){
      if(Moves.getString(fastermove,"effect").indexOf("Self")!=-1){
        TypeImmune=false;
      } else{
        acc=false;
        TypeImmune=true;
      }
    }else if((Moves.getString(fastermove,"effect").indexOf("Freeze")!=-1 || Moves.getString(fastermove,"effect").indexOf("Burn")!=-1 || Moves.getString(fastermove,"effect").indexOf("Sleep")!=-1 || Moves.getString(fastermove,"effect").indexOf("Para")!=-1 || Moves.getString(fastermove,"effect").indexOf("Poison")!=-1) && (slowerstatus[Freeze] || slowerstatus[Burn] || slowerstatus[Sleep] || slowerstatus[Paralyse] || slowerstatus[Poison]) && Moves.getInt(fastermove,"damage")==0){
      acc=false;
      MultiStatus=true;
    }
    if(fasterhp>0){
      if(acc){
        // Damage
        if(Moves.getInt(fastermove,"damage")>0 && Moves.getString(fastermove,"effect")!="2/Turn"){
          damage = Damage(fastermove,fasterjoke,slowerjoke);
          slowerhp -= damage;
        }
        // Status
        if(Moves.getString(fastermove,"effect")!=""){
          getStatus(fastermove,PlayerAtk);
        }
        // Dragon Rage
        if(Moves.getString(fastermove,"name")=="Dragon Rage"){
          damage = Damage(fastermove,fasterjoke,slowerjoke);
          damage = 40;
          slowerhp -= damage;
        }
        // Seismic Toss
        if(Moves.getString(fastermove,"name")=="Seismic Toss"){
          damage = Damage(fastermove,fasterjoke,slowerjoke);
          damage = 50;
          slowerhp -= damage;
        }
      } else if(!acc){
        if(PlayerAtk){
          DisplayText += (fasterstring+" used " + Moves.getString(fastermove,"name") + " on foe " + Jokemon.getString(slowerjoke,"name") + "."+WaitTime);
          if(TypeImmune){
            DisplayText += ("It doesn't affect foe " + Jokemon.getString(slowerjoke,"name")+"."+WaitTime);
          } else if(MultiStatus){
            DisplayText += "But it failed!"+WaitTime;
          } else{
            DisplayText += (slowerstring + " avoided the attack!"+WaitTime);
          }
        } else {
          DisplayText += (fasterstring+" used " + Moves.getString(fastermove,"name") + " on " + Jokemon.getString(slowerjoke,"name") + "."+WaitTime);
          if(TypeImmune){
            DisplayText += ("It doesn't affect " + Jokemon.getString(slowerjoke,"name")+"."+WaitTime);
          } else{
            DisplayText += (slowerstring + " avoided the attack!"+WaitTime);
          }
        }
      }
    }
  }
  
  // Change Turns
  if(!PlayerAtk){
    PlayerAtk = true;
  }else if(PlayerAtk){
    PlayerAtk = false;
  }
  TypeImmune=false;
  MultiStatus=false;
  
  // Reset Opponent Accuracy for Two Turn Moves for Slower Jokemon
  if(PlayerAtk){
    JokeTwoTurnAccMod[Player] = 0;
  } else {
    JokeTwoTurnAccMod[Opponent] = 0;
  }
  
  // Check for Status
  for(int i = 0; i<StatusNumber; i++){
    if(spe){
      slowerstatus[i] = JokeStatus[Opponent][i];
      JokeStatus[Player][i] = fasterstatus[i];
      tempturnsleep[slower] = TurnSleep[Opponent];
    }else{
      slowerstatus[i] = JokeStatus[Player][i];
      JokeStatus[Opponent][i] = fasterstatus[i];
      tempturnsleep[slower] = TurnSleep[Player];
    }
  }
  
  // Slower Jokemon's Turn
  if(slowerhp>0){
    if(slowerstatus[Freeze] && (int(random(0,101))>10) && Moves.getString(slowermove,"type")!="Fire" && Moves.getString(fastermove,"type")!="Fire"){
      if(spe){
        JokeMovesPP[Opponent][oppmoveindexi] += 1;
      }else{
        JokeMovesPP[Player][plamoveindex] += 1;
      }
      DisplayText += (slowerstring+" is frozen solid!"+WaitTime);
    }else if(slowerstatus[Sleep] && tempturnsleep[slower]>0){
      tempturnsleep[slower]-=1;
      if(spe){
        TurnSleep[Opponent] = tempturnsleep[slower];
//        JokeMovesPP[Opponent][JokeMoveSel[Opponent]] += 1;
      }else{
        TurnSleep[Player] = tempturnsleep[slower];
        JokeMovesPP[Player][plamoveindex] += 1;
      }
      DisplayText += (slowerstring+" is fast asleep!"+WaitTime);
    } else if(slowerstatus[Paralyse] && (int(random(0,101))>33)){
      if(spe){
        JokeMovesPP[Opponent][oppmoveindexi] += 1;
      }else{
        JokeMovesPP[Player][plamoveindex] += 1;
      }
      DisplayText += (slowerstring+" is paralysed, it cannot move!"+WaitTime);
    } else {
      if(slowerstatus[Freeze]){
        slowerstatus[Freeze] = false;
        DisplayText += (slowerstring+" thawed out!"+WaitTime);
      } else if(slowerstatus[Sleep]){
        slowerstatus[Sleep] = false;
        DisplayText += (slowerstring+" woke up!"+WaitTime);
      }
      acc = CheckAccuracy(slowermove,slowerjoke,fasterjoke);
      if(Moves.getString(slowermove,"type")=="Ground" && (fastertype1=="Flying" || fastertype2=="Flying")){
        if(Moves.getString(slowermove,"effect").indexOf("Self")!=-1){
          TypeImmune=false;
        } else{
          acc=false;
          TypeImmune=true;
        }
      }else if(Moves.getString(slowermove,"type")=="Electric" && (fastertype1=="Ground" || fastertype2=="Ground")){
        if(Moves.getString(slowermove,"effect").indexOf("Self")!=-1){
          TypeImmune=false;
        } else{
          acc=false;
          TypeImmune=true;
        }
      }else if(Moves.getString(slowermove,"type")=="Poison" && (fastertype1=="Poison" || fastertype2=="Poison")){
        if(Moves.getString(slowermove,"effect").indexOf("Self")!=-1){
          TypeImmune=false;
        } else{
          acc=false;
          TypeImmune=true;
        }
      }else if(Moves.getString(slowermove,"type")=="Ghost" && (fastertype1=="Normal" || fastertype2=="Normal")){
        if(Moves.getString(slowermove,"effect").indexOf("Self")!=-1){
          TypeImmune=false;
        } else{
          acc=false;
          TypeImmune=true;
        }
      }else if(Moves.getString(slowermove,"type")=="Normal" && (fastertype1=="Ghost" || fastertype2=="Ghost")){
        if(Moves.getString(slowermove,"effect").indexOf("Self")!=-1){
          TypeImmune=false;
        } else{
          acc=false;
          TypeImmune=true;
        }
      }else if(Moves.getString(slowermove,"type")=="Ghost" && (fastertype1=="Psychic" || fastertype2=="Psychic")){
        if(Moves.getString(slowermove,"effect").indexOf("Self")!=-1){
          TypeImmune=false;
        } else{
          acc=false;
          TypeImmune=true;
        }
      }else if((Moves.getString(slowermove,"effect").indexOf("Freeze")!=-1 || Moves.getString(slowermove,"effect").indexOf("Burn")!=-1 || Moves.getString(slowermove,"effect").indexOf("Sleep")!=-1 || Moves.getString(slowermove,"effect").indexOf("Para")!=-1 || Moves.getString(slowermove,"effect").indexOf("Poison")!=-1) && (fasterstatus[Freeze] || fasterstatus[Burn] || fasterstatus[Sleep] || fasterstatus[Paralyse] || fasterstatus[Poison]) && Moves.getInt(slowermove,"damage")==0){
        acc=false;
        MultiStatus=true;
      }
      if(acc){
        // Damage
        if(Moves.getInt(slowermove,"damage")>0){
          damage = Damage(slowermove,slowerjoke,fasterjoke);
          fasterhp -= damage;
        }
        // Status
        if(Moves.getString(slowermove,"effect")!=""){
          getStatus(slowermove,PlayerAtk);
        }
        // Dragon Rage
        if(Moves.getString(slowermove,"name")=="Dragon Rage"){
          damage = Damage(slowermove,slowerjoke,fasterjoke);
          damage = 40;
          fasterhp -= damage;
        }
        // Seismic Toss
        if(Moves.getString(slowermove,"name")=="Seismic Toss"){
          damage = Damage(slowermove,slowerjoke,fasterjoke);
          damage = 50;
          fasterhp -= damage;
        }
      }else if(!acc){
        if(PlayerAtk){
          DisplayText += (Jokemon.getString(slowerjoke,"name")+" used " + Moves.getString(slowermove,"name") + " on foe " + Jokemon.getString(fasterjoke,"name") + "."+WaitTime);
          if(TypeImmune){
            DisplayText += ("It doesn't affect foe " + Jokemon.getString(fasterjoke,"name")+"."+WaitTime);
          } else{
            DisplayText += (fasterstring + " avoided the attack!"+WaitTime);
          }
        } else {
          DisplayText += "Foe "+(Jokemon.getString(slowerjoke,"name")+" used " + Moves.getString(slowermove,"name") + " on " + Jokemon.getString(fasterjoke,"name") + "."+WaitTime);
          if(TypeImmune){
            DisplayText += ("It doesn't affect " + Jokemon.getString(fasterjoke,"name")+"."+WaitTime);
          } else if(MultiStatus){
            DisplayText += "But it failed!"+WaitTime;
          } else{
            DisplayText += (fasterstring + " avoided the attack!"+WaitTime);
          }
        }
      }
  }
  
  // Slower Jokemon Initial Faint Check
  } else {
    slowerhp = 0;
    DisplayText += (slowerstring + " fainted!"+WaitTime);
    firstmessage[slower] = true;
  }
  
  // Check for Status
  for(int i = 0; i<StatusNumber; i++){
    if(spe){
      fasterstatus[i] = JokeStatus[Player][i];
      JokeStatus[Opponent][i] = slowerstatus[i];
    }else{
      fasterstatus[i] = JokeStatus[Opponent][i];
      JokeStatus[Player][i] = slowerstatus[i];
    }
  }
  
  // Faster Jokemon Initial Faint Check
  if(fasterhp<=0){
    fasterhp = 0;
    DisplayText += (fasterstring + " fainted!"+WaitTime);
    firstmessage[faster] = true;
  }
  
  // Burn and Poison Damage for Faster
  if(fasterstatus[Burn] && fasterhp>0){
    DisplayText += fasterstring + " is damaged by it's burn!"+WaitTime;
    fasterhp -= (0.08*fastermaxhp);
  } else if(fasterstatus[Poison]){
    DisplayText += fasterstring + " is damaged due to poison!"+WaitTime;
    fasterhp -= (0.12*fastermaxhp);
  }
  
  // Burn and Poison Damage for Slower
  if(slowerstatus[Burn] && slowerhp>0){
    DisplayText += slowerstring + " is damaged by it's burn!"+WaitTime;
    slowerhp -= (0.08*slowermaxhp);
  } else if(slowerstatus[Poison]){
    DisplayText += slowerstring + " is damaged due to poison!"+WaitTime;
    slowerhp -= (0.12*slowermaxhp);
  }
  
  // Faster Jokemon Initial Faint Check
  if(fasterhp<=0 && !firstmessage[faster]){
    fasterhp = 0;
    DisplayText += (fasterstring + " fainted!"+WaitTime);
  }
  
  // Slower Jokemon Faint Check After Status
  if(slowerhp<=0 && !firstmessage[slower]){
    slowerhp = 0;
    DisplayText += (slowerstring + " fainted!"+WaitTime);
  }
  
  // Set HP and Status
  if(spe){
    JokeHP[Player] = fasterhp;
    JokeHP[Opponent] = slowerhp;
    for(int i = 0; i<StatusNumber; i++){
      JokeStatus[Player][i] = fasterstatus[i];
      JokeStatus[Opponent][i] = slowerstatus[i];
    }
  } else{
    JokeHP[Player] = slowerhp;
    JokeHP[Opponent] = fasterhp;
    for(int i = 0; i<StatusNumber; i++){
      JokeStatus[Player][i] = slowerstatus[i];
      JokeStatus[Opponent][i] = fasterstatus[i];
    }
  }
  
  // Check if Player Wins
  if(JokeHP[Opponent]<=0){
    PlayerWin=true;
  }else if(JokeHP[Player]<=0){
    PlayerWin=false;
  }
  
  if(!BattleEnd){
    DisplayText += "\n";
  }
}

// Get Status
void getStatus(int moveid, boolean attack){
  boolean twoturn = false;
  boolean[] statustype = new boolean[StatusNumber];
  boolean selfmove = false;
  TableRow statusrow = Moves.findRow(Integer.toString(moveid),"id");
  String movename = statusrow.getString("name");
  String effect = statusrow.getString("effect");
  int stageend = effect.indexOf("/");
  int stages = Integer.parseInt(effect.substring(0,stageend));
  int stat = 0;
  String stataffect = effect.substring(stageend+1,effect.length());
  String statstring = "";
  String endstring = "";
  //println(JokeCurrentStage[Player][Atk]);
  if(stataffect.indexOf("Atk")!=-1){
    stat = 0;
    statstring = "attack";
  } else if(stataffect.indexOf("Def")!=-1){
    stat = 1;
    statstring = "defense";
  } else if(stataffect.indexOf("SpA")!=-1){
    stat = 2;
    statstring = "special attack";
  } else if(stataffect.indexOf("SpD")!=-1){
    stat = 3;
    statstring = "special defense";
  } else if(stataffect.indexOf("Spe")!=-1){
    stat = 4;
    statstring = "speed";
  } else if(stataffect.indexOf("Turn")!=-1){
    twoturn = true;
  } else if(stataffect.indexOf("Freeze")!=-1){
    statustype[Freeze] = true;
  } else if(stataffect.indexOf("Burn")!=-1){
    statustype[Burn] = true;
  } else if(stataffect.indexOf("Sleep")!=-1){
    statustype[Sleep] = true;
  } else if(stataffect.indexOf("Para")!=-1){
    statustype[Paralyse] = true;
  } else if(stataffect.indexOf("Poison")!=-1){
    statustype[Poison] = true;
  }
  
  // Check if a Self Move
  if(stataffect.indexOf("Self")!=-1){
    selfmove = true;
  }
  
  // Check if a Two Turn Move
  if(!twoturn){    
    // Status Move
    if(stages==1){
      endstring = "rose!";
    }else if(stages==2){
      endstring = "rose sharply!";
    }else if(stages==3){
      endstring = "rose drastically!";
    }else if(stages==4){
      endstring = "went way up!";
    }else if(stages==-1){
      endstring = "fell!";
    }else if(stages==-2){
      endstring = "fell harshly!";
    }else if(stages==-3){
      endstring = "fell drastically!";
    }else if(stages==-4){
      endstring = "fell way down!";
    }
  
    if(statuscheck(moveid)){
      if(Moves.getInt(moveid,"damage")==0){
        if(attack){
          if(selfmove){
            DisplayText += (Jokemon.getString(JokeID[Player],"name")+" used " + movename + "."+WaitTime);
          } else{
            DisplayText += (Jokemon.getString(JokeID[Player],"name")+" used " + movename + " on " + Jokemon.getString(JokeID[Opponent],"name") + "."+WaitTime);
          }
        }else if(!attack){
          if(selfmove){
            DisplayText += ("Foe "+Jokemon.getString(JokeID[Opponent],"name")+" used " + movename + "."+WaitTime);
          } else{
            DisplayText += ("Foe "+Jokemon.getString(JokeID[Opponent],"name")+" used " + movename + " on " + Jokemon.getString(JokeID[Player],"name") + "."+WaitTime);
          }  
        }
      }
      
      if(!statustype[Freeze]&&!statustype[Burn]&&!statustype[Sleep]&&!statustype[Paralyse]&&!statustype[Poison]){
        // Opponent Self Move or Player Move
        if((!attack && selfmove) || (attack && !selfmove)){
          JokeCurrentStage[Opponent][stat] += stages;
          if(JokeCurrentStage[Opponent][stat]<0){
            JokeCurrentStage[Opponent][stat]=0;
            endstring = "won't go any lower!";
          } else if(JokeCurrentStage[Opponent][stat]>=12){
            JokeCurrentStage[Opponent][stat]=12;
            endstring = "won't go any higher!";
          }
          JokeStatsMod[Opponent][stat] = StatStageVal[JokeCurrentStage[Opponent][stat]];
          DisplayText += ("Foe "+Jokemon.getString(JokeID[Opponent],"name")+"'s "+statstring+" "+endstring)+WaitTime;
        // Player Self Move or Opponent Move
        }else if((selfmove && attack) || (!attack && !selfmove)){
          JokeCurrentStage[Player][stat] += stages;
          if(JokeCurrentStage[Player][stat]<0){
            JokeCurrentStage[Player][stat]=0;
            endstring = "won't go any lower!";
          } else if(JokeCurrentStage[Player][stat]>12){
            JokeCurrentStage[Player][stat]=12;
            endstring = "won't go any higher!";
          }
          JokeStatsMod[Player][stat] = StatStageVal[JokeCurrentStage[Player][stat]];
          DisplayText += (Jokemon.getString(JokeID[Player],"name")+"'s "+statstring+" "+endstring)+WaitTime;
        }
      }else if(statustype[Freeze]){
        if(attack){
          if(!JokeStatus[Opponent][Freeze] && !JokeStatus[Opponent][Burn] && !JokeStatus[Opponent][Sleep] && !JokeStatus[Opponent][Paralyse] && !JokeStatus[Opponent][Poison] && (Jokemon.getString(JokeID[Opponent],"type1")!="Ice" && Jokemon.getString(JokeID[Opponent],"type2")!="Ice")){
            JokeStatus[Opponent][Freeze] = true;
            DisplayText += "Foe "+(Jokemon.getString(JokeID[Opponent],"name")+" has been frozen!"+WaitTime);
          }
        }else{
          if(!JokeStatus[Player][Freeze] && !JokeStatus[Player][Burn] && !JokeStatus[Player][Sleep] && !JokeStatus[Player][Paralyse] && !JokeStatus[Player][Poison] && (Jokemon.getString(JokeID[Player],"type1")!="Ice" && Jokemon.getString(JokeID[Player],"type2")!="Ice")){
            JokeStatus[Player][Freeze] = true;
            DisplayText += (Jokemon.getString(JokeID[Player],"name")+" has been frozen!"+WaitTime);
          }
        }
      }else if(statustype[Burn]){
        if(attack){
          if(!JokeStatus[Opponent][Freeze] && !JokeStatus[Opponent][Burn] && !JokeStatus[Opponent][Sleep] && !JokeStatus[Opponent][Paralyse] && !JokeStatus[Opponent][Poison] && (Jokemon.getString(JokeID[Opponent],"type1")!="Fire" && Jokemon.getString(JokeID[Opponent],"type2")!="Fire")){
            JokeStatus[Opponent][Burn] = true;
            BurnMod[Opponent] = 0.5;
            DisplayText += "Foe "+(Jokemon.getString(JokeID[Opponent],"name")+" has been burned!"+WaitTime);
          }
        }else{
          if(!JokeStatus[Player][Freeze] && !JokeStatus[Player][Burn] && !JokeStatus[Player][Sleep] && !JokeStatus[Player][Paralyse] && !JokeStatus[Player][Poison] && (Jokemon.getString(JokeID[Player],"type1")!="Fire" && Jokemon.getString(JokeID[Player],"type2")!="Fire")){
            JokeStatus[Player][Burn] = true;
            BurnMod[Player] = 0.5;
            DisplayText += (Jokemon.getString(JokeID[Player],"name")+" has been burned!"+WaitTime);
          }
        }
      }else if(statustype[Sleep]){
        if(attack){
          if(!JokeStatus[Opponent][Freeze] && !JokeStatus[Opponent][Burn] && !JokeStatus[Opponent][Sleep] && !JokeStatus[Opponent][Paralyse] && !JokeStatus[Opponent][Poison]){
            JokeStatus[Opponent][Sleep] = true;
            TurnSleep[Opponent] = int(random(1,4));
            //println("Sleep: "+TurnSleep[Opponent]);
            DisplayText += "Foe "+(Jokemon.getString(JokeID[Opponent],"name")+" fell asleep!"+WaitTime);
          }
        }else{
          if(!JokeStatus[Player][Freeze] && !JokeStatus[Player][Burn] && !JokeStatus[Player][Sleep] && !JokeStatus[Player][Paralyse] && !JokeStatus[Player][Poison]){
            JokeStatus[Player][Sleep] = true;
            TurnSleep[Player] = int(random(1,4));
            DisplayText += (Jokemon.getString(JokeID[Player],"name")+" fell asleep!"+WaitTime);
          }
        }
      }else if(statustype[Paralyse]){
        if(attack){
          if(!JokeStatus[Opponent][Freeze] && !JokeStatus[Opponent][Burn] && !JokeStatus[Opponent][Sleep] && !JokeStatus[Opponent][Paralyse] && !JokeStatus[Opponent][Poison]){
            JokeStatus[Opponent][Paralyse] = true;
            ParaMod[Opponent] = 0.25;
            DisplayText += "Foe "+(Jokemon.getString(JokeID[Opponent],"name")+" is paralysed, it may not be able to move!"+WaitTime);
          }
        }else{
          if(!JokeStatus[Player][Freeze] && !JokeStatus[Player][Burn] && !JokeStatus[Player][Sleep] && !JokeStatus[Player][Paralyse] && !JokeStatus[Player][Poison]){
            JokeStatus[Player][Paralyse] = true;
            ParaMod[Player] = 0.25;
            DisplayText += (Jokemon.getString(JokeID[Player],"name")+" is paralysed, it may not be able to move!"+WaitTime);
          }
        }
      }else if(statustype[Poison]){
        if(attack){
          if(!JokeStatus[Opponent][Freeze] && !JokeStatus[Opponent][Burn] && !JokeStatus[Opponent][Sleep] && !JokeStatus[Opponent][Paralyse] && !JokeStatus[Opponent][Poison] && (Jokemon.getString(JokeID[Opponent],"type1")!="Poison" && Jokemon.getString(JokeID[Opponent],"type2")!="Poison")){
            JokeStatus[Opponent][Poison] = true;
            DisplayText += "Foe "+(Jokemon.getString(JokeID[Opponent],"name")+" has been poisoned!"+WaitTime);
          }
        }else{
          if(!JokeStatus[Player][Freeze] && !JokeStatus[Player][Burn] && !JokeStatus[Player][Sleep] && !JokeStatus[Player][Paralyse] && !JokeStatus[Player][Poison] && (Jokemon.getString(JokeID[Player],"type1")!="Poison" && Jokemon.getString(JokeID[Player],"type2")!="Poison")){
            JokeStatus[Player][Poison] = true;
            DisplayText += (Jokemon.getString(JokeID[Player],"name")+" has been poisoned!"+WaitTime);
          }
        }
      }
    }
  // Two Turn Move
  }else{
    String startstring = "";
    if(attack){
      startstring = Jokemon.getString(JokeID[Player],"name");
      JokeTwoTurn[Player] = true;
    }else{
      startstring = "Foe " + Jokemon.getString(JokeID[Opponent],"name");
      JokeTwoTurn[Opponent] = true;
    }
    if(movename=="Solar Beam"){
      DisplayText += startstring+" is asborbing energy!"+WaitTime;
      if(attack){
        for(int i = 0; i<MovesNumber; i++){
          JokeTwoTurnMove[Player][i] = false;
          if(JokeMoves[Player][i] == 4){
            JokeMoves[Player][i] = 5;
          }
        }
        JokeTwoTurnMove[Player][SolarBeam] = true;
      } else{
        for(int i = 0; i<MovesNumber; i++){
          JokeTwoTurnMove[Opponent][i] = false;
          if(JokeMoves[Opponent][i] == 4){
            JokeMoves[Opponent][i] = 5;
          }
        }
        JokeTwoTurnMove[Opponent][SolarBeam] = true;
      }
    } else if(movename=="Sky Attack"){
      DisplayText += startstring+" became cloaked in a harsh light!"+WaitTime;
      if(attack){
        for(int i = 0; i<MovesNumber; i++){
          JokeTwoTurnMove[Player][i] = false;
          if(JokeMoves[Player][i] == 8){
            JokeMoves[Player][i] = 9;
          }
        }
        JokeTwoTurnMove[Player][SkyAttack] = true;
      } else{
        for(int i = 0; i<MovesNumber; i++){
          JokeTwoTurnMove[Opponent][i] = false;
          if(JokeMoves[Opponent][i] == 8){
            JokeMoves[Opponent][i] = 9;
          }
        }
        JokeTwoTurnMove[Opponent][SkyAttack] = true;
      }
    } else if(movename=="Fly"){
      JokeTwoTurnAccMod[Player] = 100;
      DisplayText += startstring+" flew up!"+WaitTime;
      if(attack){
        for(int i = 0; i<MovesNumber; i++){
          JokeTwoTurnMove[Player][i] = false;
          if(JokeMoves[Player][i] == 12){
            JokeMoves[Player][i] = 13;
          }
        }
        JokeTwoTurnMove[Player][Fly] = true;
      } else{
        JokeTwoTurnAccMod[Opponent] = 100;
        for(int i = 0; i<MovesNumber; i++){
          JokeTwoTurnMove[Opponent][i] = false;
          if(JokeMoves[Opponent][i] == 12){
            JokeMoves[Opponent][i] = 13;
          }
        }
        JokeTwoTurnMove[Opponent][Fly] = true;
      }
    } else if(movename=="Dig"){
      DisplayText += startstring+" dug underground!"+WaitTime;
      if(attack){
        JokeTwoTurnAccMod[Player] = 100;
        for(int i = 0; i<MovesNumber; i++){
          JokeTwoTurnMove[Player][i] = false;
          if(JokeMoves[Player][i] == 14){
            JokeMoves[Player][i] = 15;
          }
        }
        JokeTwoTurnMove[Player][Dig] = true;
      } else{
        JokeTwoTurnAccMod[Opponent] = 100;
        for(int i = 0; i<MovesNumber; i++){
          JokeTwoTurnMove[Opponent][i] = false;
          if(JokeMoves[Opponent][i] == 14){
            JokeMoves[Opponent][i] = 15;
          }
        }
        JokeTwoTurnMove[Opponent][Dig] = true;
      }
    }
  }
}

// Status Chance Check
boolean statuscheck(int moveid){
  int statusaccuracy = Moves.getInt(moveid,"statuspercent");
  int testaccuracy = int(random(0,101));
  if(testaccuracy <= statusaccuracy){
    //println("Status hits with " + testaccuracy);
    return true;
  } else{
    //println("Status misses with " + testaccuracy);
    return false;
  }
}

// Text Show
void ShowText(){
  int lineend = DisplayText.indexOf("\n");
  // Text Box
  fill(255);
  strokeWeight(2);
  rect(0.014*width,height-0.3*height,0.97*width,30);
  if((millis()%100>=10&&millis()%100<=200) && (textcounter < lineend)){
    textcounter++;
    moveprogress=false;
    for(int i = 0; i<MovesNumber; i++){
      MoveOverDis[i] = true;
    }
  }else if(textcounter == lineend){
    if(textcounter==0){
      moveprogress=true;
    }
    for(int i = 0; i<MovesNumber; i++){
      MoveOverDis[i] = false;
    }
  }
  if(textcounter==lineend && DisplayText.length()>lineend+1){
    DisplayText = DisplayText.substring(lineend+1,DisplayText.length());
    textcounter = 0;
  }
  // Actual Text;
  ShowText = DisplayText.substring(0,textcounter);
  if(ShowText.contains("fainted!")){
    BattleEnd = true;
    //resetTransition();
    transition2=true;
  }
  fill(0);
  textAlign(LEFT);
  textSize(15);
  text(ShowText,0.05*width,height-0.26*height);
}