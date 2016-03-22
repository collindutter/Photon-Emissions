class IRPhoton extends Photon {
   IRPhoton(PVector pos) {
      super(pos);
   }

   void drawPhoton() {
      // draw base of photon
      fill(#ff9933);
      ellipse(position.x, position.y, RADIUS*2, RADIUS*2);
      // draw stroke of photon
      noFill();
      strokeWeight(3);
      stroke(#ffff00);
      ellipse(position.x, position.y, RADIUS*2, RADIUS*2);
      strokeWeight(1);
      stroke(0);
   }

}
