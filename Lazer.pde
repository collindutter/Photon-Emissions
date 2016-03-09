class Lazer {    
   Electron targetElectron;
   PVector position;

   Lazer(PVector pos, Electron te) {
      targetElectron = te;   
      position = pos;
   }

   void render() {
      fill(0);
      rectMode(CENTER);
      rect(position.x, 750, 50, 100);
      rectMode(NORMAL);
   }

   // fires an electron from the lazer
   void fire() {
      if (!targetElectron.done)
         targetElectron.animating = true; 
   }
}
