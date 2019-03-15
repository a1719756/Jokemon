void draw() {
  // Menu
  if (select == 0) {
    intro();
    flasher();
  }
  // Choosing
  if (select == 1) {
    choose();
    nametext();
  }
  // Battle
  if (select == 2) {
    battle();
  }
  // Transitions
  if (transition1) {
    transition();
  } else if (transition2) {
    otherTransition();
  }
} 

void intro() {
  background(#0C8304);
  image(jokemonlogo, 0.12*width, 0.03*height, width/1.3, height/4);

  if (mouseX>(width-300)/2 && mouseX<((width-300)/2)+300 && mouseY<((height-100)/2)+100 && mouseY>(height-100)/2) {
    fill(0);
  } else   fill(255);
  stroke(0);
  strokeCap(ROUND);
  rect((width-300)/2, (height-100)/2, 300, 100, 10);
  if (mouseX>(width-300)/2 && mouseX<((width-300)/2)+300 && mouseY<((height-100)/2)+100 && mouseY>(height-100)/2) {
    fill(255);
  } else   fill(0);
  textSize(20);
  text("Click to Play", width/2, height/2);
  if (mousePressed && mouseX>(width-300)/2 && mouseX<((width-300)/2)+300 && mouseY<((height-100)/2)+100 && mouseY>(height-100)/2) {
    select=1;
  }
}

void choose() {
  int q=0;
  noStroke();
  fill(#0C8304);
  rect(0, 0, width, height);
  fill(0);
  rect(0, 0.8*height, width, 0.2*height);
  if (mouseX>0.006*width && mouseX<0.994*width && mouseY>0.806*height && mouseY<0.994*height) {
    fill(180);
  } else {
    fill(255);
  }
  rect(0.006*width, 0.806*height, 0.988*width, 0.188*height, 5);
  stroke(0);
  strokeWeight(0.002*width);

  //makes rectangles and fills
  for (int x=0; x<4; x++) {
    for (int y=0; y<4; y++, q++) {
      if (q<typecols.length) {
        fill(typecols[q]);
        if (y==3) {
          rect(0.14*width+0.24*width*x, 0.08*height+0.16*height*y, 0.2*width, 0.08*height, 5);
        } else
          rect(0.04*width+0.24*width*x, 0.08*height+.16*height*y, 0.2*width, 0.08*height, 5);
      } else break;
    }
    fill(0);
  }
  textSize(13);
  text("Click box below to confirm!", width/2-0.18*width, 0.74*height);
  //display stats and picture
  textAlign(LEFT);
  textSize(11);
  for (int i = 0; i<JokeNumber; i++) {
    if (jokeselector[i]) {
      String typestring = Jokemon.getString(i, "type1");
      if (Jokemon.getString(i, "type2")!="") {
        typestring = Jokemon.getString(i, "type1")+"/"+Jokemon.getString(i, "type2");
      }
      image(jokemonfront[i], 0.8*width, 0.82*height, 0.16*width, 0.16*height);
      text(Jokemon.getString(i, "name")+"     Type: "+typestring, 0.02*width, 0.84*height);
      text("Stats:"+"    HP: "+Jokemon.getInt(i, "hitpoints")+"                    Attack: "+Jokemon.getInt(i, "attack"), 0.02*width, 0.88*height);
      text("       Defense: "+Jokemon.getInt(i, "defense")+"     "+"       Special Attack: "+Jokemon.getInt(i, "specialattack"), 0.06*width, 0.92*height);
      text("       Speed: "+Jokemon.getInt(i, "speed")+     "               Special Defense: "+Jokemon.getInt(i, "specialdefense"), 0.06*width, 0.96*height);
    }
  }
  if (jokeselector[15]) {
    resetTransition();
    transition1 = true;
    select = 2;
  }
  //first row
  if (mouseX>20 && mouseX<0.24*width && mouseY<80 && mouseY>40) {
    typecols[0]=color(211, 193, 164, 150);
  } else typecols[0] = color(211, 193, 164);
  if (mouseX>0.24*width+20 && mouseX<0.24*width*2 && mouseY<80 && mouseY>40) {
    typecols[4]=color(255, 100, 0, 150);
  } else typecols[4] = color(255, 100, 0);
  if (mouseX>0.24*width*2+20 && mouseX<0.24*width*3 && mouseY<80 && mouseY>40) {
    typecols[8]=color(70, 133, 255, 150);
  } else typecols[8] = color(70, 133, 255);
  if (mouseX>0.24*width*3+20 && mouseX<0.24*width*4 && mouseY<80 && mouseY>40) {
    typecols[12]=color(255, 225, 49, 150);
  } else typecols[12] = color(255, 225, 49);

  //second row
  if (mouseX>20 && mouseX<0.24*width && mouseY<80+0.16*height && mouseY>0.16*height+40) {
    typecols[1]=color(0, 198, 48, 150);
  } else typecols[1] = color(0, 198, 48);
  if (mouseX>0.24*width+20 && mouseX<0.24*width*2 && mouseY<80+0.16*height && mouseY>0.16*height+40) {
    typecols[5]=color(157, 255, 246, 150);
  } else typecols[5] = color(157, 255, 246);
  if (mouseX>0.24*width*2+20 && mouseX<0.24*width*3 && mouseY<80+0.16*height && mouseY>0.16*height+40) {
    typecols[9]=color(191, 45, 23, 150);
  } else typecols[9] = color(191, 45, 23);
  if (mouseX>0.24*width*3+20 && mouseX<0.24*width*4 && mouseY<80+0.16*height && mouseY>0.16*height+40) {
    typecols[13]=color(137, 29, 160, 150);
  } else typecols[13] = color(137, 29, 160);

  //third row
  if (mouseX>20 && mouseX<0.24*width && mouseY<80+0.16*height*2 && mouseY>0.16*height*2+40) {
    typecols[2]=color(214, 165, 30, 150);
  } else typecols[2] = color(214, 165, 30);
  if (mouseX>0.24*width+20 && mouseX<0.24*width*2 && mouseY<80+0.16*height*2 && mouseY>0.16*height*2+40) {
    typecols[6]=color(191, 190, 227, 150);
  } else typecols[6] = color(191, 190, 227);
  if (mouseX>0.24*width*2+20 && mouseX<0.24*width*3 && mouseY<80+0.16*height*2 && mouseY>0.16*height*2+40) {
    typecols[10]=color(247, 35, 117, 150);
  } else typecols[10] = color(247, 35, 117);
  if (mouseX>0.24*width*3+20 && mouseX<0.24*width*4 && mouseY<80+0.16*height*2 && mouseY>0.16*height*2+40) {
    typecols[14]=color(103, 124, 60, 150);
  } else typecols[14] = color(103, 124, 60);

  //fourth row
  if (mouseX>20 && mouseX<0.34*width &&mouseY<80+0.16*height*3 && mouseY>0.16*height*3+40) {
    typecols[3]=color(142, 104, 69, 150);
  } else typecols[3] = color(142, 104, 69);
  if (mouseX>0.38*width && mouseX<width*0.58 &&mouseY<80+0.16*height*3 && mouseY>0.16*height*3+40) {
    typecols[7]=color(111, 89, 116, 150);
  } else typecols[7] = color(111, 89, 116);
  if (mouseX>0.62*width && mouseX<0.82*width &&mouseY<80+0.16*height*3 && mouseY>0.16*height*3+40) {
    typecols[11]=color(98, 2, 196, 150);
  } else typecols[11] = color(98, 2, 196);
}

void nametext() {
  int q = 0;
  for (int x=0; x<4; x++) {
    for (int y=0; y<4; y++, q++) {
      if (q<typecols.length) {
        fill(0);
        if (x==3) {
          text(types[q], 0.14*width+0.24*width*y+((100-textWidth(types[q]))/2), 0.13*height+0.16*height*x);
        } else {
          text(types[q], 0.04*width+0.24*width*y+((100-textWidth(types[q]))/2), 0.13*height+0.16*height*x);
        }
      }
    }
  }
}

void booleanreseter() {
  for (int i=0; i<jokeselector.length; i++) {
    jokeselector[i]=false;
  }
}

int assdf;
boolean truer = false;
void flasher() {
  if (assdf>0.68*width) {
    truer = true;
  }
  if (assdf<0) {
    truer = false;
  }
  if (truer) {
    assdf=int(assdf-0.006*width);
  }
  if (truer==false)
  {
    assdf=int(assdf+0.006*width);
  }
  image(jokemonfront[TitleJokemon], assdf, 0.65*height, 0.34*width, 0.304*height);
}