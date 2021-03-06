class UVPhoton extends Photon {
   UVPhoton(PVector pos) {
      super(pos);
   }

   UVPhoton(PVector pos, PVector vel) {
      super(pos);
   }

   void drawPhoton() {
      fill(0);
      stroke(0);
      ellipse(position.x, position.y, RADIUS * 2, RADIUS * 2);
      textSize(12);
      textAlign(CENTER);
      fill(#cc33ff);
      text("UV", position.x + 1, position.y + 6);
   }
}
