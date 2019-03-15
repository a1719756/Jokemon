int tcount = 0;
// Easy Reference Variables //
int Freeze = 0;
int Burn = 1;
int Sleep = 2;
int Paralyse = 3;
int Poison = 4;
int Players = 2;
int Player = 0;
int Opponent = 1;
int Atk = 0;
int Def = 1;
int SpA = 2;
int SpD = 3;
int Spe = 4;
int Hit = 5;
int SolarBeam = 0;
int SkyAttack = 1;
int Fly = 2;
int Dig = 3;
int JokeNumber = 15;
int MovesNumber = 4;
int StatusNumber = 5;
int StatsNumber = 6;
int StatStages = 13;
float[] StatStageVal = {1.0/4.0,2.0/7.0,1.0/3.0,2.0/5.0,1.0/2.0,2.0/3.0,1.0,3.0/2.0,2.0,5.0/2.0,3.0,7.0/2.0,4.0};
// Jokemon Names
int Mousicate = 0;
int Charilard = 1;
int Blastoy = 2;
int Raiyou = 3;
int Venupores = 4;
int Dewlong = 5;
int Maloser = 6;
int Nidoprince = 7;
int Sandthrash = 8;
int Doveot = 9;
int Alakabam = 10;
int Beehorn = 11;
int Gotem = 12;
int Genbar = 13;
// Global Variables //
Table Jokemon;
Table Moves;
Table MoveStrengths;
Table MoveSet;
boolean moveprogress = false;
boolean backgroundchange = false;
boolean StatsSet = false;
boolean BattleEnd = false;
boolean PlayerWin = false;
boolean PlayerAtk = false;
boolean[] MoveBool = new boolean[MovesNumber];
int select = 0;
int textcounter;
float backgroundgreen = 201;
String DisplayText = "\n";
String ShowText = "";
String WaitTime = "                                   \n";                     
// Status
color[] StatusConditions = {color(178,255,249),color(255,80,10),color(162,162,162),color(247,239,80),color(183,0,171)};
float[] BurnMod = new float[2];
int[] TurnSleep = new int[2];
float[] ParaMod = new float[2];
// Joke Related
color[] typecols = {color(211, 193, 164), color(255, 100, 0), color(70, 133, 255), color(255, 225, 49), color(0, 198, 48), color(157, 255, 246), color(191, 45, 23), color(137, 29, 160), color(214, 165, 30), color(191, 190, 227), color(247, 35, 117), color(103, 124, 60), color(142, 104, 69), color(111, 89, 116), color(98, 2, 196)};
boolean[] jokeselector = {false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,false};
String[] types = {"Normal", "Fire", "Water", "Electric", "Grass", "Ice", "Fighting", "Poison", "Ground", "Flying", "Psychic", "Bug", "Rock", "Ghost", "Dragon"};
PImage[] JokeSprite = new PImage[Players]; 
int[][] JokeEVs = new int[Players][StatsNumber];
int[][] JokeMoves = new int[Players][MovesNumber];
int[][] JokeMovesPP = new int[Players][MovesNumber];
int[] JokeMoveSel = new int[Players];
int[] JokeHP = new int[Players];
int[] JokeMaxHP = new int[Players];
int[][] JokeCurrentStage = new int[Players][StatStages];
float[][] JokeStats = new float[Players][StatsNumber-1];
float[][] JokeStatsMod = new float[Players][StatsNumber-1];
boolean[][] JokeStatus = new boolean[Players][StatusNumber];
boolean[] JokeTwoTurn = new boolean[Players];
boolean[][] JokeTwoTurnMove = new boolean[Players][4];
int[] JokeTwoTurnAccMod = new int[Players];;
int[] JokeID = new int[Players];
// Button Variables //
color MoveHighlight;
color MoveColor;
color MoveDisabled;
color MoveTwoTurn;
color MoveTwoTurnHighlight;
color MoveTwoTurnDis;
boolean[] MoveOver = new boolean[MovesNumber];
boolean[] MoveOverDis = new boolean[MovesNumber];
float[] MoveButtonX = new float[MovesNumber];
float[] MoveButtonY = new float[MovesNumber];
int MoveButtonWidth;
int MoveButtonHeight;
// Pictures
int TitleJokemon = int(random(JokeNumber));
PImage jokemonlogo;
PImage[] jokemonfront = new PImage[15];
PImage[] jokemonback = new PImage[15];
// Transition
int transx;
int transradius = 0;
int transalpha = 255;
boolean transition1 = false;
boolean transition2 = false;
boolean transitionpart1done = false;