class ArrowElectron extends Electron {
   Arrow arrow;

   ArrowElectron(PVector pos, int target) {
      super(pos, target);
      PVector arrowPos = new PVector(pos.x, pos.y);
      arrow = new Arrow(arrowPos, target);
   }

   void render() {
      drawElectron();
      position.y = arrow.headPos.y;
      arrow.render();
   }
}