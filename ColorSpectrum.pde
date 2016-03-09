class ColorSpectrum {
   PImage img;
   PVector pos;
   final float WIDTH = 100;
   final float HEIGHT = WIDTH / 1.5;
   int stage;

   ColorSpectrum() {
      img = loadImage("spectrum.jpg"); 
      pos = new PVector(200, 200);
      stage = 3;
   }

   void render() {
      drawSpectrum();
   }

   void drawSpectrum() {
      fill(255);
      noStroke();
      rectMode(CORNER);
      image(img, pos.x, pos.y, WIDTH, HEIGHT);
      rect(pos.x, pos.y, stage * (WIDTH / 3), HEIGHT);
   }
}
