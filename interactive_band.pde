boolean isShowScreen;
int widthButton;
int heightButton;
int spaceForButtons;
int strokeWidth;
int optionButtonSize;
PImage[] imagesGrabacion;
void setup() {
  isShowScreen = false;
  size(750, 500);
  chargeimagesGrabacion();
  spaceForButtons = 70;
  optionButtonSize = spaceForButtons - 20;
  strokeWidth = 10;
  widthButton  = width/3;
  heightButton = height/2 - spaceForButtons/2;
  background(50);
  showWelcome();
}

void draw() {
}

//Carga las imágenes de los botones en un array
void chargeimagesGrabacion() {
  imagesGrabacion = new PImage[2];
  imagesGrabacion[0] = loadImage("images/reproducir.png");
  imagesGrabacion[1] = loadImage("images/grabar.png");
}


//Método que enseña la pantala de inicio. Las fuentes cargadas se encuentran en la carpeta
//del proyecto
void showWelcome() {
  isShowScreen = true;
  PFont neon_club_music, neon_club_music_big, wc_musica_bta;

  neon_club_music_big=createFont("neon_club_music.otf", 60);
  neon_club_music=createFont("neon_club_music.otf", 20);
  wc_musica_bta=createFont("wc_musica_bta.ttf", 20);

  fill(255);
  textFont(neon_club_music_big);
  text("Interactive Band", 35, 130);

  textFont(wc_musica_bta);
  text("abcdefghijkl", 220, 170);

  textFont(neon_club_music);
  text("Welcome to Interactive Band, here you will ", 80, 250);
  text("be able to play some preloaded sounds or", 80, 270);
  text("load your own. This sounds can be played", 80, 290);
  text("both with mouse an keyboard or with a cam", 80, 310);

  text("Click if you are prepared to rock", 140, 370);
}

//Metodo para cuando pulsamos el raton
void mousePressed() {
  if (isShowScreen) {
    showBoard();
    isShowScreen = false;
  } else {
    //Condiciones de los botones
    //Primera fila
    //Primer boton
    if (mouseX > 0 && mouseX < widthButton && mouseY > 0 && mouseY < heightButton) {
      println("Pulsado el primer boton");
    }
    //Segundo
    if (mouseX > widthButton && mouseX < widthButton*2 && mouseY > 0 && mouseY < heightButton) {
      println("Pulsado el segundo boton");
    }
    //Tercero
    if (mouseX > widthButton*2 && mouseX < width && mouseY > 0 && mouseY < heightButton) {
      println("Pulsado el tercer boton");
    }

    //Segunda fila
    //Cuarto boton
    if (mouseX > 0 && mouseX < widthButton && mouseY > heightButton && mouseY < height - spaceForButtons) {
      println("Pulsado el cuarto boton");
    }
    //Quinto
    if (mouseX > widthButton && mouseX < widthButton*2 && mouseY > heightButton && mouseY < height - spaceForButtons) {
      println("Pulsado el quinto boton");
    }
    //Sexto
    if (mouseX > widthButton*2 && mouseX < width && mouseY > heightButton && mouseY < height - spaceForButtons) {
      println("Pulsado el sexto boton");
    }
    
    //Botones de grabacion
    for(int i = 0; i < imagesGrabacion.length; i++) {
      //TODO
    }
  }
}

void showBoard() {
  background(50);
  stroke(230);
  strokeWeight(strokeWidth);
  fill(50);
  rectMode(CORNER);
  //Botones de la primera fila
  rect(0, 0, widthButton, heightButton, 28);
  rect(0+widthButton, 0, widthButton, heightButton, 28);
  rect(widthButton * 2, 0, widthButton, heightButton, 28);
  //Botones de la segunda fila
  rect(0, heightButton, widthButton, heightButton, 28);
  rect(0+widthButton, heightButton, widthButton, heightButton, 28);
  rect(widthButton * 2, heightButton, widthButton, heightButton, 28);
  
  //Botones de grabacion
  strokeWeight(1);
  rectMode(CENTER);
  imageMode(CENTER);
  int heightProv, widthProv; //Solo para reutilizarlas en los botones e imágenes
  heightProv =  height - spaceForButtons/2;
  for(int i = 0; i < imagesGrabacion.length; i++) {
    widthProv = 10 + optionButtonSize/2 + i*(optionButtonSize+10);
    rect(widthProv, heightProv, optionButtonSize, optionButtonSize, 0);
    image(imagesGrabacion[i], widthProv, heightProv, optionButtonSize - 10, optionButtonSize - 10);
  }
  
}
