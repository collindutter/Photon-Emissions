class ColorSpectrum {
   PImage img;
   PVector pos;
   final int WIDTH = 700;
   final int HEIGHT = 150;
   boolean visRevealed, irRevealed, uvRevealed;
   int visOpactiy, irOpacity, uvOpacity;

   ColorSpectrum() {
      img = loadImage("spectrum.jpg"); 
      pos = new PVector(100, 525);

      visRevealed = false;
      irRevealed = false;
      uvRevealed = false;

      visOpactiy = 255;
      irOpacity = 255;
      uvOpacity = 255;
   }

   void render() {
      drawSpectrum();
   }

   void drawSpectrum() {
      noStroke();
      rectMode(CORNER);
      image(img, pos.x, pos.y, WIDTH - 1, HEIGHT);
      if (uvRevealed)
         if (frameCount % 2 == 0)
            uvOpacity -= 5;
         fill(255, uvOpacity);
         rect(pos.x, pos.y, WIDTH / 3, HEIGHT);
      if (visRevealed)
         if (frameCount % 2 == 0)
            visOpactiy -= 5;
      fill(255, visOpactiy);
      rect(pos.x + WIDTH / 3, pos.y, WIDTH / 3, HEIGHT);
      if (irRevealed)
         if (frameCount % 2 == 0)
            irOpacity -= 5;
      fill(255, irOpacity);
      rect(pos.x + WIDTH * 2 / 3, pos.y, WIDTH / 3, HEIGHT);
   }
}