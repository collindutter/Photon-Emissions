class IRPhoton extends Photon {
   IRPhoton(PVector pos) {
      super(pos);
   }

   IRPhoton(PVector pos, PVector vel) {
      super(pos, vel);
   }

   void drawPhoton() {
      noFill();
      strokeWeight(3);
      stroke(0);
      ellipse(position.x, position.y, RADIUS * 2, RADIUS * 2);
      textSize(12);
      textAlign(CENTER);
      fill(#ff3300);
      text("IR", position.x, position.y + 6);
   }

}
