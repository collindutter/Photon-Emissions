class VisiblePhoton extends Photon{
   VisiblePhoton(PVector pos) {
      super(pos);
   }  

   VisiblePhoton(PVector pos, PVector vel) {
      super(pos, vel);
   }

   void drawPhoton() {
      fill(#ff9933);
      ellipse(position.x, position.y, RADIUS * 2, RADIUS * 2);
      noFill();
      strokeWeight(3);
      stroke(#ffff00);
      ellipse(position.x, position.y, RADIUS * 2, RADIUS * 2);
   }
}
