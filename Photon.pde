class Photon {
   PVector position; // position of photon
   PVector velocity; // velocity of photon
   int radius; // radius of photon
   final int SPEED = 5;

   Photon(PVector pos) {
      position = pos;
      // assign random velocities
      int xVel = random(0, 1) >= .5 ? SPEED : -SPEED; 
      int yVel = random(0, 1) >= .5 ? SPEED : -SPEED;
      velocity = new PVector(xVel, yVel);
      radius = 5;
   }

   void render(){
      position.add(velocity);
      drawPhoton();
   }

   void drawPhoton() {
      // draw base of photon
      fill(#ff9933);
      ellipse(position.x, position.y, radius*2, radius*2);
      // draw stroke of photon
      noFill();
      strokeWeight(3);
      stroke(#ffff00);
      ellipse(position.x, position.y, radius*2, radius*2);
      strokeWeight(1);
      stroke(0);
   }
}
