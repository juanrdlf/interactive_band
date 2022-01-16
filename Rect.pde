abstract class Rectangle {
  int x,y,w,h,r,sw;
  color c;
  CustomImage buttonImage;
  String id;
  
  Rectangle(int _x, int _y, int _w, int _h, int _r, String _id, int _sw){
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    r = _r;
    id = _id;
    sw = _sw;
  }
  void draw(){
    if (canBeDrawed()) {
      strokeWeight(sw);
      rect(x,y,w,h,r);
      if (buttonImage != null) {
        buttonImage.draw();
      }
    }
  }
  boolean isClicked( float _x, float _y ){
    return _x > x - w/2 && _y > y - h/2 && _x < x+w/2 && _y < y+h/2;
      
  }
  void setImage(PImage image, float width, float height, float x, float y) {
    buttonImage = new CustomImage(image, width, height, x, y);
  }
  String getId() {
    return id;
  }
  abstract void doAction();
  abstract boolean canBeDrawed();
}

class SoundRectangle extends Rectangle {
  AudioSample au;
  
  SoundRectangle(int _x, int _y, int _w, int _h, int _r, String _id, int _sw, AudioSample _au){
    super(_x, _y, _w, _h, _r, _id, _sw);
    au = _au;
  }
  
  void doAction() {
    au.trigger();
  }
  
  boolean canBeDrawed() {
    return !isCameraOn;
  }
}

class BaseRectangle extends Rectangle {
 
  BaseRectangle(int _x, int _y, int _w, int _h, int _r, String _id, int _sw){
    super(_x, _y, _w, _h, _r, _id, _sw);
  }
  
  void doAction() {
    camera.setup();
    Rectangle masBPM = new BPMUpRectangle(width - 170, height - 22, 10, 10, 0, "BPMUp",1);
    masBPM.setImage(loadImage("images/mas.png"), width - 170, height - 22, 10, 10);
    cameraRectangles.add(masBPM);
    
    Rectangle menosBPM = new BPMDownRectangle(width - 170, height - 13, 10, 10, 0, "BPMDown",1);
    menosBPM.setImage(loadImage("images/menos.png"), width - 170, height - 13, 10, 10);
    cameraRectangles.add(menosBPM);
    
    Rectangle masThreshold = new ThresholdUpRectangle(width - 20, height - 22, 10, 10, 0, "ThresholdUp",1);
    masThreshold.setImage(loadImage("images/mas.png"), width - 20, height - 22, 10, 10);
    cameraRectangles.add(masThreshold);
    
    Rectangle menosThreshold = new ThresholdDownRectangle(width - 20, height - 13, 10, 10, 0, "ThresholdDown",1);
    menosThreshold.setImage(loadImage("images/menos.png"), width - 20, height - 13, 10, 10);
    cameraRectangles.add(menosThreshold);
  }
  
  boolean canBeDrawed() {
    return true;
  }
}

class BPMUpRectangle extends Rectangle {
  
  BPMUpRectangle(int _x, int _y, int _w, int _h, int _r, String _id, int _sw){
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
  
  BPMDownRectangle(int _x, int _y, int _w, int _h, int _r, String _id, int _sw){
    super(_x, _y, _w, _h, _r, _id, _sw);
  }
  
  void doAction() {
    if (bpm > 0){
      bpm--;
    }
  }
  
  boolean canBeDrawed() {
    return isCameraOn;
  }
  
}

class ThresholdUpRectangle extends Rectangle {
  
  Camera cam;
  
  ThresholdUpRectangle(int _x, int _y, int _w, int _h, int _r, String _id, int _sw){
    super(_x, _y, _w, _h, _r, _id, _sw);
    this.cam = getCamera();
  }
  
  void doAction() {
    if (cam.getThreshold() > 0){
      cam.increaseThreshold();
    }
  }
  
  boolean canBeDrawed() {
    return isCameraOn;
  }
  
}

class ThresholdDownRectangle extends Rectangle {
  
  Camera cam;
  
  ThresholdDownRectangle(int _x, int _y, int _w, int _h, int _r, String _id, int _sw){
    super(_x, _y, _w, _h, _r, _id, _sw);
    this.cam = getCamera();
  }
  
  void doAction() {
    if (cam.getThreshold() > 0){
      cam.decreaseThreshold();
    }
  }
  
  boolean canBeDrawed() {
    return isCameraOn;
  }
  
}
