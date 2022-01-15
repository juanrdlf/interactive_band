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
    strokeWeight(sw);
    rect(x,y,w,h,r);
    if (buttonImage != null) {
      buttonImage.draw();
    }
  }
  boolean isClicked( int _x, int _y ){
    return _x > x - w/2 && _y > y - h/2 && _x < x+w/2 && _y < y+h/2;
      
  }
  void setImage(PImage image, float width, float height, float x, float y) {
    buttonImage = new CustomImage(image, width, height, x, y);
  }
  String getId() {
    return id;
  }
  abstract void playAudio();
}

class SoundRectangle extends Rectangle {
  AudioSample au;
  
  SoundRectangle(int _x, int _y, int _w, int _h, int _r, String _id, int _sw, AudioSample _au){
    super(_x, _y, _w, _h, _r, _id, _sw);
    au = _au;
  }
  
  void playAudio() {
    au.trigger();
  }
}

class BaseRectangle extends Rectangle {
 
  BaseRectangle(int _x, int _y, int _w, int _h, int _r, String _id, int _sw){
    super(_x, _y, _w, _h, _r, _id, _sw);
  }
  
  void playAudio() {
  }
}
