Lazer lazer; // Lazer for shooting out electrons
ArrayList<EnergyLevel> energyLevels; // List to hold the energy levels
ArrayList<Photon> photons; // List to hold the photons
ArrayList<Lazer> lazers; // List to hold the electrons fired by the lazer
ColorSpectrum spectrum;

// The usual setup stuff
void setup() {
   size(800, 800);
   init();
}

// Even more of the usual setup stuff
void init() {
   energyLevels = new ArrayList<EnergyLevel>();
   for(int i = 1; i <= 5; i++){
      energyLevels.add(new EnergyLevel(i));
   }
   photons = new ArrayList<Photon>();
   lazers = new ArrayList<Lazer>();
   
   lazers.add(new Lazer(new PVector(200, 750), getEnergyLevel(1).electrons.get(0)));
   lazers.add(new Lazer(new PVector(450, 750), getEnergyLevel(1).electrons.get(1)));
   lazers.add(new Lazer(new PVector(700, 750), getEnergyLevel(1).electrons.get(2)));

   spectrum = new ColorSpectrum();
}

// The usual drawing stuff
void draw(){
   background(255);

   for (Lazer l : lazers)
      l.render();

   // Render all the photons, removing if off-screen
   for(int i = 0; i < photons.size(); i++) {
      Photon p = photons.get(i);
      if(isOffScreen(p.position)){
         photons.remove(i);
         i--;
      }
      p.render();
   }
   // Render all the energy levels
   for(EnergyLevel level : energyLevels) {
      level.render();
   }

   /*spectrum.render();*/

   stroke(0);
   noFill();
   rectMode(CORNER);
   rect(600, 10, 190, 75);
   textSize(15);
   fill(0);
   text("UV Photon", 610, 35);
   text("Visible Photon", 610, 55);
   text("IR Photon", 610, 75);
   text(frameRate, 0, 15);
}

void addElectronToEnergyLevel(Electron e, int energyLevel) {
   energyLevels.get(energyLevel - 1).electrons.add(e);
}

EnergyLevel getEnergyLevel(int energyLevel) {
   return energyLevels.get(energyLevel - 1);
}

void addPhoton(Photon ph) {
   photons.add(ph);
}

void keyPressed() {
   if (key == '1')
      lazers.get(0).fire();
   if (key == '2')
      lazers.get(1).fire();
   if (key == '3')
      lazers.get(2).fire();
   if (key == 'r')
      init();
}

boolean closeEnoughTo(PVector curr, PVector other, float closeness) {
   return abs(curr.y - other.y) < closeness;
}

float yDist(PVector p1, PVector p2) {
   return sqrt((p2.y - p1.y) * (p2.y - p1.y));
}

// Helper method for checking if a position is off-screen
boolean isOffScreen(PVector position) {
   float x = position.x;
   float y = position.y;
   return x < 0 || y < 0 || x > width || y > height;
}
