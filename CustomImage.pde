class CustomImage {
  PImage image;
  float width, height, x, y;
  CustomImage(PImage _i, float _width, float _height, float _x, float _y) {
    image = _i;
    width = _width;
    height = _height;
    x = _x;
    y = _y;
  }
  void draw() {
    image(image, width, height, x, y);
  }
}
