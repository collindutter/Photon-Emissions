public Lazer lazer;
public ArrayList<EnergyLevel> energyLevels;
public ArrayList<Photon> photons;
public ArrayList<Electron> electrons;

void setup(){
    size(800, 800);
    init();
}

void init(){
    lazer = new Lazer();
    energyLevels = new ArrayList<EnergyLevel>();
    for(int i = 0; i <= 4; i++){
        energyLevels.add(new EnergyLevel(i));
    }
    photons = new ArrayList<Photon>();
    electrons = new ArrayList<Electron>();
}

void draw(){
    background(255);
    for(EnergyLevel level : energyLevels){
        level.render();
    }
    for(int i = 0; i < electrons.size(); i++){
        Electron e = electrons.get(i);
        if(isOffScreen(e.position)){
            electrons.remove(i);
            i--;
        }
        e.render();
    }
    for(int i = 0; i < photons.size(); i++){
        Photon p = photons.get(i);
        if(isOffScreen(p.position)){
            photons.remove(i);
            i--;
        }
        p.render();
    }
    lazer.render();
    textSize(15);
    text(frameRate, 0, 15);
}

void mousePressed(){
    lazer.fire();
}

boolean isOffScreen(PVector position){
    float x = position.x;
    float y = position.y;
    return x < 0 || y < 0 || x > width || y > height;
}
