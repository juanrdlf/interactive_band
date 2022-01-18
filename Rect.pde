abstract class Rectangle {
  int x, y, w, h, r, sw;
  color c;
  CustomImage buttonImage;
  String imagePath;
  String id;

  Rectangle(int _x, int _y, int _w, int _h, int _r, String _id, int _sw) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    r = _r;
    id = _id;
    sw = _sw;
  }
  void draw() {
    if (canBeDrawed()) {
      strokeWeight(sw);
      fill(50);
      stroke(255);
      rect(x, y, w, h, r);
      if (buttonImage != null) {
        if (imagePath.contains("black")) {
          String newPath = imagePath.substring(0, imagePath.length()-10) + ".png";
          setImage(loadImage(newPath),x,y,w,h, newPath);
        }
        buttonImage.draw();
      }
    }
    else {
      strokeWeight(sw);
      fill(50, 0);
      stroke(0);
      rect(x, y, w, h, r);
      if (buttonImage != null) {
        if (!imagePath.contains("black")) {
          String newPath = imagePath.substring(0, imagePath.length()-4) + "_black.png";
          setImage(loadImage(newPath),x,y,w,h, newPath);
        }
        buttonImage.draw();
      }
    }
  }
  boolean isClicked( float _x, float _y ) {
    return _x > x - w/2 && _y > y - h/2 && _x < x+w/2 && _y < y+h/2;
  }
  void setImage(PImage image, float width, float height, float x, float y, String _imagePath) {
    buttonImage = new CustomImage(image, width, height, x, y);
    imagePath = _imagePath;
  }
  String getId() {
    return id;
  }
  abstract void doAction();
  abstract boolean canBeDrawed();
}

public class SoundRectangle extends Rectangle {
  AudioSample au;

  SoundRectangle(int _x, int _y, int _w, int _h, int _r, String _id, int _sw, AudioSample _au) {
    super(_x, _y, _w, _h, _r, _id, _sw);
    au = _au;
  }

  public void doAction() {
    if (changingAudios) {
      selectInput("Elige un archivo:", "fileSelected", null, this);
    } else {
      au.trigger();
    }
  }

  public void fileSelected(File selection){
    if (selection == null) {
      println("El usuario cerró la ventana o pulsó cancelar");
    }
    else {
      if (selection.getAbsolutePath().toLowerCase().endsWith("wav")) {
        au = minim.loadSample(selection.getAbsolutePath());
      }
      else {
        println("Extensión no válida");
      }
    }
  }

    boolean canBeDrawed() {
    return !isCameraOn;
  }
}

class BaseRectangle extends Rectangle {

  BaseRectangle(int _x, int _y, int _w, int _h, int _r, String _id, int _sw) {
    super(_x, _y, _w, _h, _r, _id, _sw);
  }

  void doAction() {
    if (!isCameraOn) {
      camera.setup();
      Rectangle masBPM = new BPMUpRectangle(width - 170, height - 22, 10, 10, 0, "BPMUp", 1);
      masBPM.setImage(loadImage("images/mas.png"), width - 170, height - 22, 10, 10, "NO");
      cameraRectangles.add(masBPM);
  
      Rectangle menosBPM = new BPMDownRectangle(width - 170, height - 13, 10, 10, 0, "BPMDown", 1);
      menosBPM.setImage(loadImage("images/menos.png"), width - 170, height - 13, 10, 10, "NO");
      cameraRectangles.add(menosBPM);
  
      Rectangle masThreshold = new ThresholdUpRectangle(width - 20, height - 22, 10, 10, 0, "ThresholdUp", 1);
      masThreshold.setImage(loadImage("images/mas.png"), width - 20, height - 22, 10, 10, "NO");
      cameraRectangles.add(masThreshold);
  
      Rectangle menosThreshold = new ThresholdDownRectangle(width - 20, height - 13, 10, 10, 0, "ThresholdDown", 1);
      menosThreshold.setImage(loadImage("images/menos.png"), width - 20, height - 13, 10, 10, "NO");
      cameraRectangles.add(menosThreshold);
    }
    else {
      isCameraOn = false;
      pos[0] = -1;
      pos[1] = -1; 
    }
  }

  boolean canBeDrawed() {
    return true;
  }
}

class BPMUpRectangle extends Rectangle {

  BPMUpRectangle(int _x, int _y, int _w, int _h, int _r, String _id, int _sw) {
    super(_x, _y, _w, _h, _r, _id, _sw);
  }

  void doAction() {
    bpm++;
  }

  boolean canBeDrawed() {
    return isCameraOn;
  }
}

class BPMDownRectangle extends Rectangle {

  BPMDownRectangle(int _x, int _y, int _w, int _h, int _r, String _id, int _sw) {
    super(_x, _y, _w, _h, _r, _id, _sw);
  }

  void doAction() {
    if (bpm > 0) {
      bpm--;
    }
  }

  boolean canBeDrawed() {
    return isCameraOn;
  }
}

class ThresholdUpRectangle extends Rectangle {

  Camera cam;

  ThresholdUpRectangle(int _x, int _y, int _w, int _h, int _r, String _id, int _sw) {
    super(_x, _y, _w, _h, _r, _id, _sw);
    this.cam = getCamera();
  }

  void doAction() {
    if (cam.getThreshold() > 0) {
      cam.increaseThreshold();
    }
  }

  boolean canBeDrawed() {
    return isCameraOn;
  }
}

class ThresholdDownRectangle extends Rectangle {

  Camera cam;

  ThresholdDownRectangle(int _x, int _y, int _w, int _h, int _r, String _id, int _sw) {
    super(_x, _y, _w, _h, _r, _id, _sw);
    this.cam = getCamera();
  }

  void doAction() {
    if (cam.getThreshold() > 0) {
      cam.decreaseThreshold();
    }
  }

  boolean canBeDrawed() {
    return isCameraOn;
  }
}

class LoadSampleRectangle extends Rectangle {

  LoadSampleRectangle(int _x, int _y, int _w, int _h, int _r, String _id, int _sw) {
    super(_x, _y, _w, _h, _r, _id, _sw);
  }

  void doAction() {
    if (isCameraOn) {
      changingAudios = false;
    }
    else {
      changingAudios = !changingAudios;
    }
  }

  boolean canBeDrawed() {
    return true;
  }
}

public class PlayRectangle extends Rectangle {
  
  boolean playing;
  AudioPlayer audio;
  int volume;
  
  PlayRectangle(int _x, int _y, int _w, int _h, int _r, String _id, int _sw) {
    super(_x, _y, _w, _h, _r, _id, _sw);
    playing = false;
    volume = 100;
  }
  
  void doAction() {
    if (playing) {
      audio.pause();
      playing = false;
      setImage(imagesGrabacion[1],x, y, optionButtonSize - 10, optionButtonSize - 10, "NO");
    }
    else {
      selectInput("Elige un archivo para reproducir:", "fileSelected", null, this);
    }
  }
  
  boolean canBeDrawed() {
     return true; 
  }
  
  public void fileSelected(File selection){
    if (selection == null) {
      println("El usuario cerró la ventana o pulsó cancelar");
    }
    else {
      if (selection.getAbsolutePath().toLowerCase().endsWith("wav") || selection.getAbsolutePath().toLowerCase().endsWith("mp3")) {
        audio = minim.loadFile(selection.getAbsolutePath());
        audio.setGain(volume);
        audio.play();
        playing = true;
        setImage(loadImage("images/pause.png"),x, y, optionButtonSize - 10, optionButtonSize - 10, "NO");
      }
      else {
        println("Extensión no válida");
      }
    }
  }
  
  void volumeUp() {
     if (audio != null) {
       volume = volume + 5;
       audio.setGain(volume); 
     }
  }
  
  void volumeDown() {
     if (audio != null) {
       volume = volume - 5;
       audio.setGain(volume); 
     }
  }
  
}
