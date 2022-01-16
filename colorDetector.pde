class ColorDetector {

  int threshold = 2;
  
  // Array con las cordenadas x e y respectivamente
  int[] trackColor(Capture video) {

    int[] salida = new int[2];
    salida[0] = -1;

    float worldRecord = 500;


    // XY coordinate of closest color
    int closestX = 0;
    int closestY = 0;

    // Begin loop to walk through every pixel
    for (int x = 0; x < video.width; x++) {
      for (int y = 0; y < video.height; y++) {
        int loc = x + y * video.width;
        // What is current color
        color currentColor = video.pixels[loc];
        float r1 = red(currentColor);
        float g1 = green(currentColor);
        float b1 = blue(currentColor);
        float r2 = red(0);
        float g2 = green(0);
        float b2 = blue(0);

        // Using euclidean distance to compare colors
        float d = dist(r1, g1, b1, r2, g2, b2); // We are using the dist( ) function to compare the current color with the color we are tracking.

        // If current color is more similar to tracked color than
        // closest color, save current location and current difference
        if (d < worldRecord) {
          worldRecord = d;
          closestX = x;
          closestY = y;
        }
      }
    }

    // We only consider the color found if its color distance is less than 10. 
    // This threshold of 10 is arbitrary and you can adjust this number depending on how accurate you require the tracking to be.
    if (worldRecord < threshold) {
      // Draw a circle at the tracked pixel
      fill(0);
      strokeWeight(4.0);
      stroke(0);
      ellipse(closestX, closestY, 16, 16);
      salida[0] = closestX;
      salida[1] = closestY;
    }

    return salida;
  }
}
