PGraphics texture;
int tailleCube = 25;
int nbCubes = 85;//511
PShape[] cubess = new PShape[nbCubes+1];
ArrayList<PShape> cubes;
int a = 0;
int b = 1;
int c = 0;
int aR = 0;
int bR = 1;
int cR = 0;
PShader shader1;
float idselect, idselect2;
ArrayList<Boolean> isSelect = new ArrayList() ;
PGraphics g1, g2;

void setup() {
  frameRate(500);
  size(800, 600, P3D);
  pixelDensity(displayDensity());
  shader1 = loadShader("shader1Frag.glsl", "shader1Vert.glsl");
  texture = createGraphics(tailleCube, tailleCube, P3D);
  for (int i = 0; i  < nbCubes; i++) {
    this.cubess[i] = Cube(tailleCube, i+1);
  }
  shader(shader1);
  for(int i = 0; i < this.nbCubes; i++){
    this.isSelect.add(false);
  }
}

void draw() {
  lights();
  if (keyPressed) {
    this.cubess = new PShape[nbCubes+1];
    for (int i = 0; i  < nbCubes; i++) {
      this.cubess[i] = Cube(tailleCube, i+1);
    }
  }
  background(216, 216, 216);
  polynomeR();
  pushMatrix();
  translate(width/4, height/2);
  rotateY(-frameCount/70.0);
  pyramid(a, b, c);
  popMatrix();
  polynomeL();
  pushMatrix();
  translate(3*width/4, height/2);
  rotateY(frameCount/70.0);
  pyramid(aR, bR, cR);
  popMatrix();
  resetShader();
}
color colors(int i){
  if(type(i) == 0){
    return color(255, 0, 0);
  }
  if (type(i) == 1) { //le chiffre 1
    return color(95, 95, 95);
  }
  if (type(i) == 2) { //nombre pas premier parfait
    return color(151, 151, 255);
  }
  if (type(i) == 3) { //nombre pas premier abondant
    return color(255, 255, 2);
  }
  if (type(i) == 4) { //nombre premier deficient
    return color(0, 255, 10);
  }
  if (type(i) == 5) { //nombre premier parfait
    return color(255, 0, 54);
  }
  if (type(i) == 6) { //nombre premier abondant
    return color(0, 91, 255);
  }
  return 0;
}


PShape Cube(int taille, int numero) {
  PShape result = createShape();
  result.attrib("idnum", (float)numero);
  result.setName("" + numero);
  result.beginShape(QUADS);
  if (type(numero) == 0) { //nombre pas premier deficient
    pushMatrix();
    result.fill(255, 0, 0);
    popMatrix();
  }
  if (type(numero) == 1) { //le chiffre 1
    pushMatrix();
    result.fill(95, 95, 95);
    popMatrix();
  }
  if (type(numero) == 2) { //nombre pas premier parfait
    pushMatrix();
    result.fill(151, 151, 255);
    popMatrix();
  }
  if (type(numero) == 3) { //nombre pas premier abondant
    pushMatrix();
    result.fill(255, 255, 2);
    popMatrix();
  }
  if (type(numero) == 4) { //nombre premier deficient
    pushMatrix();
    result.fill(0, 255, 10);
    popMatrix();
  }
  if (type(numero) == 5) { //nombre premier parfait
    pushMatrix();
    result.fill(255, 0, 54);
    popMatrix();
  }
  if (type(numero) == 6) { //nombre premier abondant
    pushMatrix();
    result.fill(0, 91, 255);
    popMatrix();
  }
 
  result.vertex(-taille/2, -taille/2, taille/2);
  result.vertex(-taille/2, -taille/2, -taille/2);
  result.vertex(taille/2, -taille/2, -taille/2);
  result.vertex(taille/2, -taille/2, taille/2);

  result.vertex(taille/2, -taille/2, taille/2);
  result.vertex(taille/2, taille/2, taille/2);
  result.vertex(-taille/2, taille/2, taille/2);
  result.vertex(-taille/2, -taille/2, taille/2);

  result.vertex(-taille/2, -taille/2, taille/2);
  result.vertex(-taille/2, taille/2, taille/2);
  result.vertex(-taille/2, taille/2, -taille/2);
  result.vertex(-taille/2, -taille/2, -taille/2);

  result.vertex(-taille/2, -taille/2, -taille/2);
  result.vertex(-taille/2, taille/2, -taille/2);
  result.vertex(taille/2, taille/2, -taille/2);
  result.vertex(taille/2, -taille/2, -taille/2);

  result.vertex(taille/2, -taille/2, -taille/2);
  result.vertex(taille/2, taille/2, -taille/2);
  result.vertex(taille/2, taille/2, taille/2);
  result.vertex(taille/2, -taille/2, taille/2);

  result.vertex(taille/2, taille/2, taille/2);
  result.vertex(-taille/2, taille/2, taille/2);
  result.vertex(-taille/2, taille/2, -taille/2);
  result.vertex(taille/2, taille/2, -taille/2);
  result.endShape();
  return result;
}

int sd(int x) {
  int sommeDiviseur = 0;
  for (int i = 1; i <= x; i++) {
    if (x % i == 0) {
      sommeDiviseur = sommeDiviseur + i;
    }
  }
  return sommeDiviseur;
}

int type(int x) {
  int sdX = sd(x);
  if (sdX-1 == x) { //nombre premier
    if (sdX < 2*x && sdX > 1) {
      return 4; //deficient
    } else if (sdX == 2*x) {
      return 5; //parfait
    } else {
      return 6; //abondant
    }
  } else { //nombre pas premier
    if (sdX < 2*x && sdX > 1) {
      return 0; //deficient
    } else if (sdX < 2*x && sdX == 1) {
      return 1; //unique
    } else if (sdX == 2*x) {
      return 2; //parfait
    } else {
      return 3; //abondant
    }
  }
}

PGraphics textures(int i) {
  texture.beginDraw();
  texture.background(0, 0.0);
  texture.noStroke();
  texture.translate(texture.width/2, texture.height/2);
  texture.lights();
  texture.fill(0);
  texture.rotateZ(PI);
  texture.textSize(10);
  texture.text(i, -tailleCube/4, tailleCube/4, 0);
  texture.endDraw();
  return texture;
}

void pyramid(int aa, int bb, int cc) {
  float dirX = -0.5;
  float dirY = 0.5;
  int compt = 0;
  int nbDepAut = 1;
  int dep = 1;
  int acc = 1;
  int comptZ = 0;
  //translate(width/2, height/2, -100);
  rotateX(PI/2);
 
  //rotateZ(mouseX/100);
  cubes = tableauDeRetour(this.cubess, aa, bb, cc);
  for (int i = 0; i < cubes.size(); i++) {
    if(idselect == stringToInt(cubes.get(i).getName())){
      if(this.isSelect.get(stringToInt(cubes.get(i).getName())-1)){
        cubes.get(i).setFill(color(255,0,255));
        shape(cubes.get(i));
      }else{
        cubes.get(i).setFill(colors(stringToInt(cubes.get(i).getName())));
        shape(cubes.get(i));
      }
    }else{
      shape(cubes.get(i));
    }
    rajouteTexture(textures(stringToInt(cubes.get(i).getName())), tailleCube);
    dep++;
    comptZ++;
    if (comptZ > acc && acc >= 4) {
      acc = acc + 4;
      comptZ = 1;
      translate(dirX * 28, dirY * 28, -25);
    } else if (comptZ >= acc && acc < 4) {
      acc = acc + 3;
      comptZ = 1;
      translate(dirX * 28, dirY * 28, -25);
    } else {
      if (dirX == -0.5 && dirY == 0.5) {
        dirX = 0;
        dirY = 1;
      }
      translate(dirX * 28, dirY * 28);
    }
    if (dep > nbDepAut) {
      dep = 1;
      compt++;
      if (compt > 3) {
        compt = 0;
        nbDepAut++;
      }
      if (dirX == 1 && dirY == 0) {
        dirX = 0;
        dirY = -1;
      } else if (dirX == 0 && dirY == -1) {
        dirX = -1;
        dirY = 0;
      } else if (dirX == -1 && dirY == 0) {
        dirX = -0.5;
        dirY = 0.5;
      } else {
        dirX = 1;
        dirY = 0;
      }
    }
  }
}
void rajouteTexture(PGraphics pg, int taille) {
  pushMatrix();// de devant
  translate(0, 0, (taille/2)+1);
  image(pg, -taille/2, -taille/2);
  popMatrix();

  pushMatrix();// de derrière
  translate(0, 0, (-taille/2)-1);
  image(pg, -taille/2, -taille/2);
  popMatrix();

  pushMatrix();// de gauche
  translate((-taille/2)-1, 0, 0);
  rotateY(PI/2);
  rotateZ(PI/2);
  rotateY(PI);
  image(pg, -taille/2, -taille/2);
  popMatrix();

  pushMatrix();// de droite
  translate((taille/2)+1, 0, 0);
  rotateY(PI/2);
  rotateZ(PI/2);
  image(pg, -taille/2, -taille/2);
  popMatrix();

  pushMatrix();// de haut
  translate(0, (taille/2)+1, 0);
  rotateX(PI/2);
  rotateY(PI);
  image(pg, -taille/2, -taille/2);
  popMatrix();

  pushMatrix();// de bas
  translate(0, (-taille/2)-1, 0);
  rotateX(PI/2);    
  image(pg, -taille/2, -taille/2);
  popMatrix();
}

int stringToInt(String s) {
  return Integer.parseInt(s);
}
void polynomeL() {
  fill(20);
  textSize(20);
  if (b >= 0) {
    if (c >= 0) {
      text(a+"x² + "+ b+"x + "+ c, 20, 39);
    } else {
      text(a+"x² + "+ b+"x "+ c, 20, 39);
    }
  } else {
    if (c >= 0) {
      text(a+"x² "+ b+"x + "+ c, 20, 39);
    } else {
      text(a+"x² "+ b+"x "+ c, 20, 39);
    }
  }
  fill(255);
  rect(35, 45, 10, 10);
  rect(35, 10, 10, 10);
  rect(80, 45, 10, 10);
  rect(80, 10, 10, 10);
  rect(130, 45, 10, 10);
  rect(130, 10, 10, 10);
}
void polynomeR() {
  fill(20);
  textSize(20);
  if (bR >= 0) {
    if (cR >= 0) {
      text(aR+"x² + "+ bR+"x + "+ cR, width-150, 39);
    } else {
      text(aR+"x² + "+ bR+"x "+ cR, width-150, 39);
    }
  } else {
    if (cR >= 0) {
      text(aR+"x² "+ bR+"x + "+ cR, width-150, 39);
    } else {
      text(aR+"x² "+ bR+"x "+ cR, width-150, 39);
    }
  }
  fill(255);
  rect(width-35, 45, 10, 10);
  rect(width-35, 10, 10, 10);
  rect(width-80, 45, 10, 10);
  rect(width-80, 10, 10, 10);
  rect(width-130, 45, 10, 10);
  rect(width-130, 10, 10, 10);
}
void mouseClicked() {
  if (mouseX > 35 && mouseX < 45 && mouseY > 10 && mouseY < 20) {
    a++;
  } else if (mouseX > 35 && mouseX < 45 && mouseY > 45 && mouseY < 55) {
    a--;
  } else if (mouseX > 80 && mouseX < 90 && mouseY > 10 && mouseY < 20) {
    b++;
  } else if (mouseX > 80 && mouseX < 90 && mouseY > 45 && mouseY < 55) {// && this.b > 1){
    b--;
  } else if (mouseX > 130 && mouseX < 140 && mouseY > 10 && mouseY < 20) {
    c++;
  } else if (mouseX > 130 && mouseX < 140 && mouseY > 45 && mouseY < 55) {
    c--;
  } else if (mouseX > width-35 && mouseX < width-25 && mouseY > 10 && mouseY < 20) {
    //println("hahahaha");
    cR++;
  } else if (mouseX > width-35 && mouseX < width-25 && mouseY > 45 && mouseY < 55) {
    cR--;
  } else if (mouseX > width-80 && mouseX < width-70 && mouseY > 10 && mouseY < 20) {
    bR++;
  } else if (mouseX > width-80 && mouseX < width-70 && mouseY > 45 && mouseY < 55) {// && this.b > 1){
    bR--;
  } else if (mouseX > width-130 && mouseX < width-120 && mouseY > 10 && mouseY < 20) {
    aR++;
  } else if (mouseX > width-130 && mouseX < width-120 && mouseY > 45 && mouseY < 55) {
    aR--;
  }
 
}

void mousePressed(){
  float dirX = 0;
  float dirY = 0;
  int compt = 0;
  int nbDepAut = 0;
  int dep = 0;
  int acc = 0;
  int comptZ = 0;
  pushMatrix();
  g1 = createGraphics(width/2, height, P3D);
  g1.loadPixels();
  g1.beginDraw();
  g1.background(255);
  g1.lights();
  g1.translate(g1.width/2, g1.height/2);
  g1.shader(shader1);
  //g1.rotateY(frameCount/50.0);
  dirX = -0.5;
  dirY = 0.5;
  compt = 0;
  nbDepAut = 1;
  dep = 1;
  acc = 1;
  comptZ = 0;
  g1.rotateX(PI/2);
  g1.rotateZ(frameCount/70.0);
  cubes = tableauDeRetour(this.cubess, a, b, c);
  for (int i = 0; i < cubes.size(); i++) {
    g1.shape(cubes.get(i));
    dep++;
    comptZ++;
    if (comptZ > acc && acc >= 4) {
      acc = acc + 4;
      comptZ = 1;
      g1.translate(dirX * 28, dirY * 28, -25);
    } else if (comptZ >= acc && acc < 4) {
      acc = acc + 3;
      comptZ = 1;
      g1.translate(dirX * 28, dirY * 28, -25);
    } else {
      if (dirX == -0.5 && dirY == 0.5) {
        dirX = 0;
        dirY = 1;
      }
      g1.translate(dirX * 28, dirY * 28);
    }
    if (dep > nbDepAut) {
      dep = 1;
      compt++;
      if (compt > 3) {
        compt = 0;
        nbDepAut++;
      }
      if (dirX == 1 && dirY == 0) {
        dirX = 0;
        dirY = -1;
      } else if (dirX == 0 && dirY == -1) {
        dirX = -1;
        dirY = 0;
      } else if (dirX == -1 && dirY == 0) {
        dirX = -0.5;
        dirY = 0.5;
      } else {
        dirX = 1;
        dirY = 0;
      }
    }
  }
  g1.resetShader();
  g1.endDraw(); 
  popMatrix();
  
  pushMatrix();
  g2 = createGraphics(width, height, P3D);
  g2.loadPixels();
  g2.beginDraw();
  g2.background(255);
  g2.lights();
  g2.translate(6*g1.width/4, g1.height/2);
  g2.shader(shader1);
  //g1.rotateY(frameCount/50.0);
  dirX = -0.5;
  dirY = 0.5;
  compt = 0;
  nbDepAut = 1;
  dep = 1;
  acc = 1;
  comptZ = 0;
  g2.rotateX(PI/2);
  g2.rotateZ(-frameCount/70.0);
  cubes = tableauDeRetour(this.cubess, aR, bR, cR);
  for (int i = 0; i < cubes.size(); i++) {
    g2.shape(cubes.get(i));
    dep++;
    comptZ++;
    if (comptZ > acc && acc >= 4) {
      acc = acc + 4;
      comptZ = 1;
      g2.translate(dirX * 28, dirY * 28, -25);
    } else if (comptZ >= acc && acc < 4) {
      acc = acc + 3;
      comptZ = 1;
      g2.translate(dirX * 28, dirY * 28, -25);
    } else {
      if (dirX == -0.5 && dirY == 0.5) {
        dirX = 0;
        dirY = 1;
      }
      g2.translate(dirX * 28, dirY * 28);
    }
    if (dep > nbDepAut) {
      dep = 1;
      compt++;
      if (compt > 3) {
        compt = 0;
        nbDepAut++;
      }
      if (dirX == 1 && dirY == 0) {
        dirX = 0;
        dirY = -1;
      } else if (dirX == 0 && dirY == -1) {
        dirX = -1;
        dirY = 0;
      } else if (dirX == -1 && dirY == 0) {
        dirX = -0.5;
        dirY = 0.5;
      } else {
        dirX = 1;
        dirY = 0;
      }
    }
  }
  g2.resetShader();
  g2.endDraw(); 
  popMatrix();
  //rotateX(PI/2);
  int p = g1.get(mouseX * displayDensity(), mouseY * displayDensity());
  int p2 = g2.get(mouseX * displayDensity(), mouseY * displayDensity());
  if(mouseX < width/2){
    idselect = int(blue(p) + green(p)*256 + red(p)*256*256);
    if(idselect > 15){
      idselect++;
    }
  }else{
    idselect = int(blue(p2) + green(p2)*256 + red(p2)*256*256);
  }
  if(idselect-1 >= 0 && idselect-1 < this.nbCubes){
    if(this.isSelect.get(int(idselect-1)) == true){
      this.isSelect.set(int(idselect-1), false);
    }else{
      this.isSelect.set(int(idselect-1), true);
    }
  }
} 


ArrayList<PShape> tableauDeRetour(PShape[] cub, int aa, int bb, int cc) {
  ArrayList<PShape> cubesR = new ArrayList();
  for (int i = 0; i < cub.length; i++) {
    if (aa == 0) { //si a == 0
      if (bb == 0) { //si b == 0
        if (cc != 0 && abs(cc) < cub.length) { //si c != 0
          cubesR.add(cub[abs(cc)-1]); //abs(c) pour afficher aussi les cubes negatif
        }
      } else { //si b != 0
        if (bb > 0) { // si b > 0
          if ((i+1) % bb == 0) {
            if ((cc + i+1 < cub.length) && (i+1 + cc > 0)) {
              cubesR.add(cub[i+cc]);
            }
          }
        } else { //si b < 0
          if ((i+1) % bb == 0) {
            if ((i+1 - cc < cub.length) && (i+1 - cc > 0)) {
              cubesR.add(cub[abs(i)-cc]);
            }
          }
        }
      }
    } else { //si a != 0
      if (aa > 0) {//si a > 0
        if (bb == 0) {//si b == 0
          if (i*i*aa+cc < cub.length && i*i*aa+cc > cc && i*i*aa+cc > 0) {
            cubesR.add(cub[(aa*i*i)-1+cc]);
          }
        } else {//si b != 0
          if (bb > 0) {//si b > 0
            if (cc < 0) {
              if (i*i*aa+i*bb+cc < cub.length && i*i*aa+i*bb+cc > 0) {
                cubesR.add(cub[i*i*aa+i*bb+cc-1]);
              }
            } else {//si c > 0
              if (i*i*aa-i*bb+cc < cub.length && i*i*aa-i*bb+cc > cc) {
                cubesR.add(cub[i*i*aa-i*bb+cc-1]);
              }
            }
          } else { //si b < 0
            if (i*i*aa+i*bb+cc < cub.length && i*i*aa+i*bb+cc > 0) {
              cubesR.add(cub[i*i*aa+i*bb+cc-1]);
            }
          }
        }
      } else {//si a < 0
        if (bb == 0) {//si b == 0
          if (cc < 0) {
            if (i*i*abs(aa)-cc < cub.length && i*i*abs(aa)-cc > -cc) {
              cubesR.add(cub[(abs(aa)*i*i)-1-cc]);
            }
          } else {
            if (i*i*abs(aa)-cc < cub.length && i*i*abs(aa)-cc > 0) {
              cubesR.add(cub[(abs(aa)*i*i)-1-cc]);
            }
          }
        } else {//si b != 0
          if (bb > 0) {
            if (cc < 0) {
              if (i*i*abs(aa)+i*bb-cc < cub.length && i*i*abs(aa)+i*bb-cc > 0 ) {//-this.c ){
                cubesR.add(cub[i*i*abs(aa)+i*bb-cc-1]);
              }
            } else {
              if (i*i*abs(aa)+i*bb-cc < cub.length && i*i*abs(aa)+i*bb-cc > 0) {
                cubesR.add(cub[i*i*abs(aa)+i*bb-cc-1]);
              }
            }
          } else {
            if (this.c < 0) {
              if (i*i*abs(aa)-i*bb-cc < cub.length && i*i*abs(aa)-i*bb-cc > -cc ) {
                cubesR.add(cub[i*i*abs(aa)-i*bb-cc-1]);
              }
            } else {
              if (i*i*abs(aa)-i*bb-cc < cub.length && i*i*abs(aa)-i*bb-cc > 0) {
                cubesR.add(cub[i*i*abs(aa)-i*bb-cc-1]);
              }
            }
          }
        }
      }
    }
  }
  return cubesR;
}

void keyPressed() {
  if (keyCode == UP) {
    this.nbCubes++;
  }
  if (keyCode == DOWN) {
    this.nbCubes--;
  }
  if (keyCode == LEFT) {
    this.nbCubes = this.nbCubes - 5;
  }
  if (keyCode == RIGHT) {
    this.nbCubes = this.nbCubes + 5;
  }
}
