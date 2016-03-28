class Electron {
   PVector position; // Position of electron
   PVector velocity; // Velocity of electron (directional)
   final int SPEED = 5; // Speed of electron (non-directional) 
   final int RADIUS = 10; // Radius of electron
   boolean animating; // Whether or not the elctron is in the rising phase of it's animation
   boolean done;
   int targetLevel;
   boolean arrowsMade;

   Electron(PVector pos, int target) {
      position = pos;
      animating = false;
      done = false;
      targetLevel = target;
      velocity = new PVector(0, -SPEED);
      arrowsMade = false;
   }

   void render() {
      if (!done)
         drawElectron();
      if (animating)
         position.add(velocity);
      float dist = yDist(position, getEnergyLevel(targetLevel).position);
      if (abs(dist) < SPEED / 2) {
         animating = false;
         done = true;
      }
   }

   void drawElectron() {
      // draw base of electron
      fill(#3455F5);
      stroke(#00ccff);
      ellipse(position.x, position.y, RADIUS * 2, RADIUS * 2);
   }
}
