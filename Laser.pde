class Laser {    
   Electron targetElectron;
   PVector position;
   int startFrame;

   Laser(PVector pos, Electron te) {
      targetElectron = te;   
      position = pos;
      startFrame = 0;
      frameCount = 30;
   }

   void render() {
      fill(0);
      rectMode(CENTER);
      noStroke();
      rect(position.x, 750, 50, 100);
      rectMode(NORMAL);
      if (frameCount > 30 && frameCount - startFrame < 20) {
         fill(#ffff00);
         rectMode(CORNER);
         rect(position.x - 7, 700 - 195, 14, 195);
      }
   }

   // fires an electron from the laser
   void fire() {
      if (!targetElectron.done) {
         startFrame = frameCount;
         targetElectron.animating = true; 
      }
   }
}
