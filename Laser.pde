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
      if (frameCount > 30 && frameCount - startFrame < 30) {
         fill(#ffff00);
         rectMode(CORNER);
         rect(position.x - 7, 700 - 200, 14, 200);
      }
   }

   // fires an electron from the laser
   void fire() {
      startFrame = frameCount;
      if (!targetElectron.done)
         targetElectron.animating = true; 
   }
}
