import ddf.minim.*;

boolean isShowScreen;
boolean isCameraOn;
int widthButton;
int heightButton;
int spaceForButtons;
int strokeWidth;
int optionButtonSize;
PImage[] imagesGrabacion;
ArrayList<Rectangle> rectangles, cameraRectangles;
ArrayList<AudioSample> as;
Minim minim;
Camera camera;
float[] pos;
long start;
boolean timer;
int bpm;

void setup() {
  bpm = 120;
  isShowScreen = false;
  isCameraOn = false;
  rectangles = new ArrayList<Rectangle>();
  cameraRectangles = new ArrayList<Rectangle>();
  as = new ArrayList<AudioSample>();
  pos = new float[2];
  timer = true;
  minim = new Minim(this);
  camera = new Camera(this, width, height, 30);
  loadAudioSamples();
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
  if(isCameraOn) {
    pos = camera.draw();
    drawParams();
    for (Rectangle r : cameraRectangles) {
    r.draw();
  }
  }
  else if (!isShowScreen){
    background(50);
  }
  for (Rectangle r : rectangles) {
    r.draw();
  }
  if(pos[0] != -1 && pos[1] != -1 && timer) {
    checkButtons(pos[0],pos[1]);
    timer = false;
    start = System.currentTimeMillis();
  }
  if (!timer && System.currentTimeMillis() - start > 1000/(bpm/60.0)) {
    timer = true;
  }
}

void drawParams() {
  PFont mono = createFont("data/helvetica.ttf", 128);
  textFont(mono);
  fill(255);
  rect(width - 140, height - 18, 260, 20);
  fill(0);
  textSize(20);
  text("BPM: " + bpm, width - 265, height - 10);
  text("Threshold: " + camera.getThreshold() / 1, width - 160, height - 10);
}

//Carga las imágenes de los botones en un array
void chargeimagesGrabacion() {
  imagesGrabacion = new PImage[3];
  imagesGrabacion[0] = loadImage("images/reproducir.png");
  imagesGrabacion[1] = loadImage("images/grabar.png");
  imagesGrabacion[2] = loadImage("images/camara.png");
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

  text("Click if you are ready to rock", 140, 370);
}

//Metodo para cuando pulsamos el raton
void mousePressed() {
  if (isShowScreen && !isCameraOn) {
    showBoard();
    isShowScreen = false;
  } else if (!isCameraOn) {
    //Comprobación si se hace click sobre un botón
    checkButtons(mouseX, mouseY);
  } else if (isCameraOn) {
    checkCameraButtons(mouseX, mouseY);
  }
}

void checkButtons(float x, float y) {
  for(Rectangle rect : rectangles) {
      if (rect.isClicked(x, y)) {
        rect.doAction();
        println("Clicked button " + rect.getId());
      }
    }
}

void checkCameraButtons(float x, float y) {
  for(Rectangle rect : cameraRectangles) {
      if (rect.isClicked(x, y)) {
        rect.doAction();
        println("Clicked button " + rect.getId());
      }
    }
}

void showBoard() {
  background(50);
  stroke(230);
  fill(50);
  rectMode(CENTER);
  imageMode(CENTER);
  
  //Botones de la primera fila
  Rectangle rect1 = new SoundRectangle(widthButton/2,heightButton/2, widthButton, heightButton, 28, "MusicButton#1", strokeWidth, as.get(0));
  rect1.setImage(loadImage("images/1.png"), widthButton/2,heightButton/2, widthButton, heightButton);
  Rectangle rect2 = new SoundRectangle(widthButton+(widthButton/2),heightButton/2, widthButton, heightButton, 28, "MusicButton#2", strokeWidth, as.get(1));
  rect2.setImage(loadImage("images/2.png"), widthButton+(widthButton/2),heightButton/2, widthButton, heightButton);
  Rectangle rect3 = new SoundRectangle(widthButton * 2+(widthButton/2), heightButton/2, widthButton, heightButton, 28, "MusicButton#3", strokeWidth, as.get(2));
  rect3.setImage(loadImage("images/3.png"), widthButton * 2+(widthButton/2), heightButton/2, widthButton, heightButton);
  rectangles.add(rect1);
  rectangles.add(rect2);
  rectangles.add(rect3);
  //Botones de la segunda fila
  Rectangle rect4 = new SoundRectangle(widthButton/2, heightButton + (heightButton/2), widthButton, heightButton, 28, "MusicButton#4", strokeWidth, as.get(3));
  rect4.setImage(loadImage("images/4.png"), widthButton/2, heightButton + (heightButton/2), widthButton, heightButton);
  Rectangle rect5 = new SoundRectangle(widthButton+(widthButton/2), heightButton + (heightButton/2), widthButton, heightButton, 28, "MusicButton#5", strokeWidth, as.get(4));
  rect5.setImage(loadImage("images/5.png"), widthButton+(widthButton/2), heightButton + (heightButton/2), widthButton, heightButton);
  Rectangle rect6 = new SoundRectangle(widthButton * 2+(widthButton/2), heightButton + (heightButton/2), widthButton, heightButton, 28, "MusicButton#6", strokeWidth, as.get(5));
  rect6.setImage(loadImage("images/6.png"), widthButton * 2+(widthButton/2), heightButton + (heightButton/2), widthButton, heightButton);
  rectangles.add(rect4);
  rectangles.add(rect5);
  rectangles.add(rect6);
  
  //Botones de grabacion
  int heightProv, widthProv; //Solo para reutilizarlas en los botones e imágenes
  heightProv =  height - spaceForButtons/2;
  for(int i = 0; i < imagesGrabacion.length; i++) {
    widthProv = 10 + optionButtonSize/2 + i*(optionButtonSize+10);
    Rectangle rect = new BaseRectangle(widthProv, heightProv, optionButtonSize, optionButtonSize, 0, "OptionButton#"+(i+1), 1);
    rect.setImage(imagesGrabacion[i], widthProv, heightProv, optionButtonSize - 10, optionButtonSize - 10);
    rectangles.add(rect);
  }
  
}

void loadAudioSamples() {
  for (int i = 0; i < 6; i++) {
    as.add(minim.loadSample("samples/"+i+".wav"));
  }
}

void captureEvent(Capture video) {
  if (isCameraOn) {
    camera.captureEvent(video);
  }
}

void keyTyped() {
  if (key=='q' && isCameraOn) {
    camera.stop();
    isCameraOn = false;
  }
  if (key=='+' && isCameraOn) {
    bpm++; 
    camera.increaseThreshold();
  }
  if (key=='-' && isCameraOn && bpm > 0) {
    bpm--; 
    camera.decreaseThreshold();
  }
}

Camera getCamera() {
  return camera;
}
