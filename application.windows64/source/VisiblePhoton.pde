class VisiblePhoton extends Photon{
   VisiblePhoton(PVector pos) {
      super(pos);
   }  

   VisiblePhoton(PVector pos, PVector vel) {
      super(pos, vel);
   }

   void drawPhoton() {
      fill(#ff9933);
      stroke(#ffff00);
      ellipse(position.x, position.y, RADIUS * 2, RADIUS * 2);
   }
}