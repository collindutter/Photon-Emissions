class UVPhoton extends Photon {
   UVPhoton(PVector pos) {
      super(pos);
   }

   void drawPhoton() {
      // draw base of photon
      fill(#af9933);
      ellipse(position.x, position.y, RADIUS*2, RADIUS*2);
      // draw stroke of photon
      noFill();
      strokeWeight(3);
      stroke(#afff00);
      ellipse(position.x, position.y, RADIUS*2, RADIUS*2);
      strokeWeight(1);
      stroke(0);
   }
}
