abstract class Photon {
   PVector position; // position of photon
   PVector velocity; // velocity of photon
   int radius; // radius of photon
   final int SPEED = 5;
   final int RADIUS = 10;

   Photon(PVector pos) {
      position = pos;
      // assign random velocities
      float rand;
      float xVel = (rand = random(0, 1.0)) >= .5 ? rand * SPEED : -rand * SPEED; 
      float yVel = (rand = random(0, 1.0)) >= .5 ? rand * SPEED : -rand * SPEED; 
      velocity = new PVector(xVel, yVel);
      velocity.normalize();
   }

   Photon(PVector pos, PVector vel) {
      position = pos;
      velocity = vel;
   }

   void render(){
      position.add(velocity);
      drawPhoton();
   }

   abstract void drawPhoton();
}
