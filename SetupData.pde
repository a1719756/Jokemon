// Setup Jokemon
void SetupJokemon(){
  Jokemon = new Table();
  Jokemon.addColumn("id");
  Jokemon.addColumn("name");
  Jokemon.addColumn("type1");
  Jokemon.addColumn("type2");
  Jokemon.addColumn("hitpoints");
  Jokemon.addColumn("attack");
  Jokemon.addColumn("defense");
  Jokemon.addColumn("specialattack");
  Jokemon.addColumn("specialdefense");
  Jokemon.addColumn("speed");
    // Mousicate - Normal
    addJokemon("Mousicate","Normal","",55,81,60,50,70,97);
    // Charilard - Fire/Flying
    addJokemon("Charilard","Fire","Flying",78,84,78,109,85,100);
    // Blastoy - Water
    addJokemon("Blastoy","Water","",79,83,100,85,105,78);
    // Raiyou - Electric
    addJokemon("Raiyou","Electric","",60,90,55,90,80,110);
    // Venupores - Grass
    addJokemon("Venupores","Grass","Poison",80,82,83,100,100,80);
    // Dewlong - Ice
    addJokemon("Dewlong","Water","Ice",90,70,80,70,95,70);
    // Maloser - Fighting
    addJokemon("Maloser","Fighting","",90,130,80,65,85,55);
    // Nidoprince - Poison
    addJokemon("Nidoprince","Poison","Ground",81,102,77,85,75,85);
    // Sandthrash - Ground
    addJokemon("Sandthrash","Ground","",75,100,110,45,55,65);
    // Doveot - Flying
    addJokemon("Doveot","Normal","Flying",83,80,75,70,70,101);
    // Alakabam - Psychic
    addJokemon("Alakabam","Psychic","",55,50,45,135,95,120);
    // Beehorn - Bug
    addJokemon("Beehorn","Bug","Poison",65,90,40,45,80,75);
    // Gotem - Rock
    addJokemon("Gotem","Rock","Ground",80,120,130,55,65,45);
    // Genbar - Ghost
    addJokemon("Genbar","Ghost","Poison",60,65,60,130,75,110);
    // Dragonmite - Dragon
    addJokemon("Dragonmite","Dragon","Flying",91,134,95,100,100,80);
  // Save Table
  saveTable(Jokemon, "data/Jokemon.csv");
}

// Setup Move Strengths
void SetupStrengths(){
  MoveStrengths = new Table();
  MoveStrengths.addColumn("id");
  MoveStrengths.addColumn("");
  MoveStrengths.addColumn("Normal");
  MoveStrengths.addColumn("Fire");
  MoveStrengths.addColumn("Water");
  MoveStrengths.addColumn("Electric");
  MoveStrengths.addColumn("Grass");
  MoveStrengths.addColumn("Ice");
  MoveStrengths.addColumn("Fighting");
  MoveStrengths.addColumn("Poison");
  MoveStrengths.addColumn("Ground");
  MoveStrengths.addColumn("Flying");
  MoveStrengths.addColumn("Psychic");
  MoveStrengths.addColumn("Bug");
  MoveStrengths.addColumn("Rock");
  MoveStrengths.addColumn("Ghost");
  MoveStrengths.addColumn("Dragon");
    // Normal
    addMoveStrength("Normal",1,1,1,1,1,1,1,1,1,1,1,1,0.5,0,1);
    // Fire
    addMoveStrength("Fire",1,0.5,0.5,1,2,2,1,1,1,1,1,2,0.5,1,0.5);
    // Water
    addMoveStrength("Water",1,2,0.5,1,0.5,1,1,1,2,1,1,1,2,1,0.5);
    // Electric
    addMoveStrength("Electric",1,1,2,0.5,0.5,1,1,1,0,2,1,1,1,1,0.5);
    // Grass
    addMoveStrength("Grass",1,0.5,2,1,0.5,1,1,0.5,2,0.5,1,0.5,2,1,0.5);
    // Ice
    addMoveStrength("Ice",1,1,0.5,1,2,0.5,1,1,2,2,1,1,1,1,2);
    // Fighting
    addMoveStrength("Fighting",2,1,1,1,1,2,1,0.5,1,0.5,0.5,0.5,2,0,1);
    // Poison
    addMoveStrength("Poison",1,1,1,1,2,1,1,0.5,0.5,1,1,2,0.5,0.5,1);
    // Ground
    addMoveStrength("Ground",1,2,1,2,0.5,1,1,2,1,0,1,0.5,2,1,1);
    // Flying
    addMoveStrength("Flying",1,1,1,0.5,2,1,2,1,1,1,1,2,0.5,1,1);
    // Psychic
    addMoveStrength("Psychic",1,1,1,1,1,1,2,2,1,1,0.5,1,1,1,1);
    // Bug
    addMoveStrength("Bug",1,0.5,1,1,2,1,0.5,2,1,0.5,2,1,1,0.5,1);
    // Rock
    addMoveStrength("Rock",1,2,1,1,1,2,0.5,1,0.5,2,1,2,1,1,1);
    // Ghost
    addMoveStrength("Ghost",0,1,1,1,1,1,1,1,1,1,0,1,1,2,1);
    // Dragon
    addMoveStrength("Dragon",1,1,1,1,1,1,1,1,1,1,1,1,1,1,2);
  // Save Table
  saveTable(MoveStrengths, "data/MoveStrengths.csv");
}

// Setup Moves
void SetupMoves(){
  Moves = new Table();
  Moves.addColumn("id");
  Moves.addColumn("name");
  Moves.addColumn("type");
  Moves.addColumn("damage");
  Moves.addColumn("accuracy");
  Moves.addColumn("PP");
  Moves.addColumn("statuspercent");
  Moves.addColumn("effect");
  Moves.addColumn("attacktype");
    // Tackle
    addMove("Tackle","Normal",40,100,35,0,"","Physical");
    // Scratch
    addMove("Scratch","Normal",40,100,35,0,"","Physical");
    // Growl
    addMove("Growl","Normal",0,100,35,100,"-1/Atk","Status");
    // Tail Whip
    addMove("Tail Whip","Normal",0,100,30,100,"-1/Def","Status");
    // Solar Beam - Status
    addMove("Solar Beam","Grass",0,999,10,100,"2/Turn","Physical");
    // Solar Beam - Attack
    addMove("Solar Beam","Grass",120,100,10,0,"","Physical");
    // Flamethrower
    addMove("Flamethrower","Fire",95,100,15,10,"1/Burn","Special");
    // Hydro Pump
    addMove("Hydro Pump","Water",120,80,5,0,"","Special");
    // Sky Attack - Status
    addMove("Sky Attack","Flying",0,999,5,100,"2/Turn","Physical");
    // Sky Attack - Attack
    addMove("Sky Attack","Flying",140,90,5,0,"","Physical");
    // Gust
    addMove("Gust","Flying",40,100,35,0,"","Special");
    // Psychic
    addMove("Psychic","Psychic",90,100,10,10,"-1/SpD","Special");
    // Fly - Status
    addMove("Fly","Flying",0,999,15,100,"2/Turn","Physical");
    // Fly - Attack
    addMove("Fly","Flying",70,95,15,0,"","Physical");
    // Dig - Status
    addMove("Dig","Ground",0,999,10,100,"2/Turn","Physical");
    // Dig - Attack
    addMove("Dig","Ground",60,95,10,0,"","Physical");
    // Swords Dance
    addMove("Swords Dance","Normal",0,999,20,100,"+2/Atk/Self","Status");
    // Ice Beam
    addMove("Ice Beam","Ice",90,100,10,10,"1/Freeze","Special");
    // String Shot
    addMove("String Shot","Bug",0,95,40,100,"-1/Speed","Status");
    // Thunderbolt
    addMove("Thunderbolt","Electric",95,100,15,10,"1/Para","Special");
    // Poison Sting
    addMove("Poison Sting","Poison",15,100,35,20,"1/Poison","Physical");
    // Earthquake
    addMove("Earthquake","Ground",100,100,10,0,"","Physical");
    // Hypnosis
    addMove("Hypnosis","Psychic",0,60,20,100,"1/Sleep","Physical");
    // Thunder Wave
    addMove("Thunder Wave","Electric",0,100,20,100,"1/Para","Status");
    // Poison Powder
    addMove("Poison Powder","Poison",0,75,35,100,"1/Poison","Status");
    // Will-O-Wisp
    addMove("Will-O-Wisp","Fire",0,85,15,100,"1/Burn","Status");
    // Dragon Rage
    addMove("Dragon Rage","Dragon",0,100,10,0,"","Special");
    // Shadow Ball
    addMove("Shadow Ball","Ghost",80,100,10,20,"-1/SpD","Special");
    // Seismic Toss
    addMove("Seismic Toss","Fighting",0,100,20,0,"","Physical");
    // Rock Throw
    addMove("Rock Throw","Rock",50,90,15,0,"","Physical");
    // Lick
    addMove("Lick","Ghost",30,100,30,30,"1/Para","Physical");
    // Body Slam
    addMove("Body Slam","Normal",85,100,15,30,"1/Para","Physical");
    // Bubble Beam
    addMove("Bubble Beam","Water",65,100,20,10,"-1/Speed","Special");
  // Save Table
  saveTable(Moves, "data/Moves.csv");
}

// Setup Movesets
void SetupMovesets(){
  MoveSet = new Table();
  MoveSet.addColumn("id");
  MoveSet.addColumn("move1");
  MoveSet.addColumn("move2");
  MoveSet.addColumn("move3");
  MoveSet.addColumn("move4");
  MoveSet.addColumn("hitpointsEVs");
  MoveSet.addColumn("attackEVs");
  MoveSet.addColumn("defenseEVs");
  MoveSet.addColumn("specialAttackEVs");
  MoveSet.addColumn("specialDefenseEVs");
  MoveSet.addColumn("speedEVs");
  // Mousicate - Swords Dance, Tail Whip, Growl, Dig - 252 HP, 252 Attack, 4 Speed
    addMoveSet(16,3,1,14,252,252,0,0,0,4);
  // Charilard - Flamethrower, Gust, Growl, Will-O-Wisp - 4 HP, 252 Special Attack, 252 Speed
    addMoveSet(6,10,2,25,4,0,0,252,0,252);
  // Blastoy - Hydro Pump, Tackle, Tail Whip, Ice Beam - 252 HP, 252 Special Attack, 4 Speed
    addMoveSet(7,0,3,17,252,0,0,252,0,4);
  // Raiyou - Thunderbolt, Thunder Wave, Tail Whip, Tackle - 4 Attack, 252 Special Attack, 252 Speed 
    addMoveSet(19,23,3,0,0,4,0,252,0,252);
  // Venupores - Growl, Solar Beam, Poison Powder, Tackle - 252 HP, 252 Attack, 4 Special Defense
    addMoveSet(2,4,24,0,252,252,0,0,4,0);
  // Dewlong - Ice Beam, Growl, Bubble Beam, Hydro Pump - 252 HP, 252 Defense, 4 Special Defense 
    addMoveSet(17,2,32,7,252,0,252,0,4,0);
  // Maloser - Seismic Toss, Swords Dance, Tackle, Growl - 252 HP, 252 Attack, 4 Defense 
    addMoveSet(28,16,0,2,252,252,4,0,0,0);
  // Nidoprince - Earthquake, Body Slam, Poison Sting, Swords Dance - 252 HP, 252 Attack, 4 Special Defense 
    addMoveSet(21,31,20,16,252,252,0,0,4,0);
  // Sandthrash - Earthquake, Dig, Scratch, Swords Dance - 4 HP, 252 Attack, 252 Speed 
    addMoveSet(21,14,1,16,4,252,0,0,0,252);
  // Doveot - Fly, Sky Attack, Tackle, Gust - 252 Attack, 4 Defense, 252 Speed
  addMoveSet(12,8,0,10,0,252,4,0,0,252);
  // Alakabam - Psychic, Hypnosis, Shadow Ball, Will-O-Wisp - 4 HP, 252 Special Attack, 252 Speed
  addMoveSet(11,22,27,25,4,0,0,252,0,252);
  // Beehorn - Fly, String Shot, Poison Sting, Tackle - 4 HP, 252 Attack, 252 Speed 
  addMoveSet(12,18,20,0,4,252,0,0,0,252);
  // Gotem - Rock Tomb, Earthquake, Tackle, Dig - 252 HP, 252 Attack, 4 Defense
  addMoveSet(29,21,0,14,252,252,4,0,0,0);
  // Genbar - Poison Sting, Shadow Ball, Hypnosis, Lick - 4 Attack, 252 Special Attack, 252 Speed
  addMoveSet(20,27,22,30,0,4,0,252,0,252);
  // Dragonmite - Dragon Rage, Fly, Thunderbolt, Flamethrower - 252 HP, 252 Special Attack, 4 Speed
  addMoveSet(26,12,19,6,252,0,0,252,0,4);
}

// Add Jokemon
void addJokemon(String name,String type1,String type2,int hp, int atk, int def, int spatk, int spdef, int spd){
  TableRow thisJoke = Jokemon.addRow();
  thisJoke.setInt("id", Jokemon.lastRowIndex());
  thisJoke.setString("name", name);
  thisJoke.setString("type1", type1);
  thisJoke.setString("type2", type2);
  thisJoke.setInt("hitpoints", hp);
  thisJoke.setInt("attack", atk);
  thisJoke.setInt("defense", def);
  thisJoke.setInt("specialattack", spatk);
  thisJoke.setInt("specialdefense", spdef);
  thisJoke.setInt("speed", spd);
}

// Add Move Strength
void addMoveStrength(String type, float nor, float fir, float wat, float ele, float gra, float ice, float fig, float poi, float gro, float fly, float psy, float bug, float roc, float gho, float dra){
  TableRow thisMoveStr = MoveStrengths.addRow();
  thisMoveStr.setInt("id", MoveStrengths.lastRowIndex());
  thisMoveStr.setString("", type);
  thisMoveStr.setFloat("Normal", nor);
  thisMoveStr.setFloat("Fire", fir);
  thisMoveStr.setFloat("Water", wat);
  thisMoveStr.setFloat("Electric", ele);
  thisMoveStr.setFloat("Grass", gra);
  thisMoveStr.setFloat("Ice", ice);
  thisMoveStr.setFloat("Fighting", fig);
  thisMoveStr.setFloat("Poison", poi);
  thisMoveStr.setFloat("Ground", gro);
  thisMoveStr.setFloat("Flying", fly);
  thisMoveStr.setFloat("Psychic", psy);
  thisMoveStr.setFloat("Bug", bug);
  thisMoveStr.setFloat("Rock", roc);
  thisMoveStr.setFloat("Ghost", gho);
  thisMoveStr.setFloat("Dragon", dra);
}

// Add Move
void addMove(String name,String type,int damage,int accuracy, int pp, int statuspercent,String effect,String attacktype){
  TableRow thisMove = Moves.addRow();
  thisMove.setInt("id", Moves.lastRowIndex());
  thisMove.setString("name", name);
  thisMove.setString("type", type);
  thisMove.setInt("damage", damage);
  thisMove.setInt("accuracy", accuracy);
  thisMove.setInt("PP", pp);
  thisMove.setInt("statuspercent", statuspercent);
  thisMove.setString("effect", effect);
  thisMove.setString("attacktype", attacktype);
}

// Add Moveset
void addMoveSet(int move1, int move2, int move3, int move4, int hpev, int atkev, int defev, int spattev, int spdefev, int speedev){
  TableRow thisMove = MoveSet.addRow();
  thisMove.setInt("id", Jokemon.lastRowIndex());
  thisMove.setInt("move1", move1);
  thisMove.setInt("move2", move2);
  thisMove.setInt("move3", move3);
  thisMove.setInt("move4", move4);
  thisMove.setInt("hitpointsEVs", hpev);
  thisMove.setInt("attackEVs", atkev);
  thisMove.setInt("defenseEVs", defev);
  thisMove.setInt("specialAttackEVs", spattev);
  thisMove.setInt("specialDefenseEVs", spdefev);
  thisMove.setInt("speedEVs", speedev);
}