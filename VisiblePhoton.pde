class VisiblePhoton extends Photon{
   VisiblePhoton(PVector pos) {
      super(pos);
   }  

   void drawPhoton() {
      // draw base of photon
      fill(#2f9933);
      ellipse(position.x, position.y, RADIUS*2, RADIUS*2);
      // draw stroke of photon
      noFill();
      strokeWeight(3);
      stroke(#2fff00);
      ellipse(position.x, position.y, RADIUS*2, RADIUS*2);
      strokeWeight(1);
      stroke(0);
   }
}
