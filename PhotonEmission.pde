public Lazer lazer; // Lazer for shooting out electrons
public ArrayList<EnergyLevel> energyLevels; // List to hold the energy levels
public ArrayList<Photon> photons; // List to hold the photons
public ArrayList<Electron> electrons; // List to hold the electrons fired by the lazer

// The usual setup stuff
void setup(){
    size(800, 800);
    init();
}

// Even more of the usual setup stuff
void init(){
    lazer = new Lazer();
    energyLevels = new ArrayList<EnergyLevel>();
    for(int i = 0; i <= 4; i++){
        energyLevels.add(new EnergyLevel(i));
    }
    photons = new ArrayList<Photon>();
    electrons = new ArrayList<Electron>();
}

// The usual drawing stuff
void draw(){
    background(255);
    // Render all the energy levels
    for(EnergyLevel level : energyLevels){
        level.render();
    }

    // Render all the electrons, removing if off-screen
    for(int i = 0; i < electrons.size(); i++){
        Electron e = electrons.get(i);
        if(isOffScreen(e.position)){
            electrons.remove(i);
            i--;
        }
        e.render();
    }

    // Render all the photons, removing if off-screen
    for(int i = 0; i < photons.size(); i++){
        Photon p = photons.get(i);
        if(isOffScreen(p.position)){
            photons.remove(i);
            i--;
        }
        p.render();
    }
    
    // Render the lazer
    lazer.render();
    textSize(15);
    text(frameRate, 0, 15);
}

void mousePressed(){
    lazer.fire();
}

// Helper method for checking if a position is off-screen
boolean isOffScreen(PVector position){
    float x = position.x;
    float y = position.y;
    return x < 0 || y < 0 || x > width || y > height;
}
