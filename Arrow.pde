class Arrow {
   PVector tailPos, headPos;
   PVector velocity;
   boolean animating;
   int targetLevel;
   boolean photonFired;
   PVector halfway;
   final int SPEED = 10;

   Arrow(PVector pos, int target) {
      tailPos = new PVector(pos.x, pos.y);
      headPos = new PVector(pos.x, pos.y);
      EnergyLevel tarLevel = getEnergyLevel(target);
      float half = headPos.y + (tarLevel.position.y - headPos.y) / 2.0;
      halfway = new PVector(0, half);
      velocity = new PVector(0, SPEED);
      targetLevel = target;
      animating = true;
      photonFired = false;
   }

   void render() {
      drawArrow();
      if (animating)
         headPos.add(velocity);
      if (abs(yDist(headPos, halfway)) < SPEED && !photonFired) {
         addPhoton(new Photon(new PVector(headPos.x, headPos.y)));
         photonFired = true;
      }
      float dist = yDist(headPos, getEnergyLevel(targetLevel).position);
      if (animating && abs(dist) < SPEED) {
         animating = false;
      }
   }

   void drawArrow() {
      stroke(0);
      line(tailPos.x, tailPos.y, headPos.x, headPos.y);
      line(headPos.x, headPos.y, headPos.x + 10, headPos.y - 10);
      line(headPos.x, headPos.y, headPos.x - 10, headPos.y - 10);
   }

}
