class Photon {
   PVector position; // position of photon
   PVector velocity; // velocity of photon
   int radius; // radius of photon
   final int SPEED = 5;
   final int RADIUS = 7;

   Photon(PVector pos) {
      position = pos;
      // assign random velocities
      float rand;
      float xVel = (rand = random(0, 1.0)) >= .5 ? rand * SPEED : -rand * SPEED; 
      float yVel = (rand = random(0, 1.0)) >= .5 ? rand * SPEED : -rand * SPEED; 
      velocity = new PVector(xVel, yVel);
      velocity.normalize();
   }

   void render(){
      position.add(velocity);
      drawPhoton();
   }

   void drawPhoton() {
   }
}
