class EnergyLevel {
   int number;
   PVector position;
   ArrayList<Electron> electrons; // List to hold the electrons fired by the lazer

   int locs[][] = {{4, 1}, {3, 2}, {2, 3}}; // {quantity, target}

   EnergyLevel(int num) {
      number = num;
      position = new PVector(0, 50 / (num * .1));
      electrons = new ArrayList<Electron>();
      if (num == 1) {
         electrons.add(new Electron(new PVector(200, position.y), 5));
         electrons.add(new Electron(new PVector(450, position.y), 5));
         electrons.add(new Electron(new PVector(700, position.y), 5));
      }
   }

   void render() {
      drawEnergyLevel();
      drawElectrons();
   }

   void drawElectrons() {
      // Render all the electrons, removing if off-screen
      for (int j = 0; j < electrons.size(); j++) {
         Electron e = electrons.get(j);
         e.render();
         if (e.done && !e.arrowsMade) {
            int[] info = locs[j];

            for (int i = 0; i < info[0]; i++) {
               Electron base = electrons.get(j);
               PVector pos = new PVector();
               pos.x = base.position.x + 25 * (i + 1);
               pos.y = getEnergyLevel(base.targetLevel - i).position.y;
               ArrowElectron ae = new ArrowElectron(pos, info[1]);
               addElectronToEnergyLevel(ae, base.targetLevel);
               e.arrowsMade = true; 
            }
         }
      }
   }

   void drawEnergyLevel() {
      stroke(color(0, 0, 255));
      strokeWeight(3);
      line(100, position.y, 800, position.y);
      fill(0);
      textSize(25);
      text("n = " + number, 10, position.y);
      stroke(0);
   }
}
