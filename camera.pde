import processing.video.*;

class Camera {
  Capture video;
  float threshold = 200;

  Camera(PApplet _this, int _width, int _height, int _fps) {
    try{
      this.video = new Capture(_this, _width, _height, _fps);
    }
    catch(IllegalStateException e) {
      println("No se encontró ninguna cámara web");
    }
  }

  void setup() {
    isCameraOn = true;
    video.start();
  }
  
  void captureEvent(Capture video) {
    video.read();
  }

  float[] draw() {
    
    float avgX = 0, avgY = 0;
    int count = 0;
    float[] position = new float[2];
    position[0] = -1;
    position[1] = -1;
    
    loadPixels();
    video.loadPixels();

    // Begin loop to walk through every pixel
    for (int x = 0; x < video.width; x ++ ) {
      for (int y = 0; y < video.height; y ++ ) {

        int loc = x + y*video.width;            // Step 1, what is the 1D pixel location
        color current = video.pixels[loc];      // Step 2, what is the current color

        // Step 4, compare colors (previous vs. current)
        float r1 = red(current); 
        float g1 = green(current); 
        float b1 = blue(current);
        float diff = dist(r1, g1, b1, 0, 0, 0); //difference of the color compared to white

        if (diff < threshold) { 
          avgX += x;
          avgY += y;
          count++;
          pixels[loc] = color(0);
        } else {
          pixels[loc] = color(255);
        }
      }
    }
    updatePixels();
    if (count > 1000) {
      avgX = avgX / count;
      avgY = avgY / count;
      position[0] = avgX;
      position[1] = avgY;
      ellipse(avgX,avgY,10,10);
    }
    return position;
  }

  void stop() {
    video.stop();
  }
  
  void increaseThreshold() {
    threshold++;
  }
  
  void decreaseThreshold() {
    if (threshold > 0){
      threshold--;
    }
  }
  
  float getThreshold(){
    return threshold;
  }
}
