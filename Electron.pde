public class Electron{
    public PVector position; // Position of electron
    public PVector velocity; // Velocity of electron (directional)
    public int speed; // Speed of electron (non-directional) 
    public int radius; // Radius of electron
    public boolean rising; // Whether or not the elctron is in the rising phase of it's animation
    public int targetEnergyLevel; // Which energy level the electron is being fired at
    public float angle; // Angle at which electrons bounces down at
    public float t; // Time used for sin motion animation
    public PVector center; // Where the electron changes it's animation state
    public EnergyLevel target; // Position of target energy level

    public Electron(PVector pos, int targetLevel){
        radius = 20;
        position = pos;
        rising = true;
        speed = 10;
        velocity = new PVector(0, -speed);
        targetEnergyLevel = targetLevel;
        angle = random(PI/2 - PI/6, PI/2 + PI/6);
        t = 0;
        target = energyLevels.get(targetEnergyLevel);
        center = new PVector(target.position.x, target.position.y);
    }

    public void render(){
        // if in rising phase of animation
        if(rising){
            // move in simple motion
            position.add(velocity);
            // draw base of electron
            fill(#3455F5);
            ellipse(position.x, position.y, radius*2, radius*2);
            // draw stroke of electron
            stroke(#00ccff);
            strokeWeight(3);
            noFill();
            ellipse(position.x, position.y, radius*2, radius*2);
        }
        // if in falling phase of animation
        else{
            // move in fancy motion and do some fancy vector mumbo jumbo 
            position.x += velocity.x*cos(angle);
            position.y += velocity.y*sin(angle);
            PVector a = perpendicular(PVector.sub(position, center, null));
            a.normalize();
            a.mult(sin(t) * 15);
            // draw base of electron
            fill(#3455F5);
            ellipse(position.x + a.x, position.y + a.y, radius*2, radius*2);
            // draw stroke of electron
            stroke(#00ccff);
            strokeWeight(3);
            noFill();
            ellipse(position.x + a.x, position.y + a.y, radius*2, radius*2);
            t += PI / 12;
        }
        strokeWeight(1);
        stroke(0); 
        // check if electron has hit it's first target energy level
        if(rising && position.y <= target.position.y - 50){
            // if so, flip it around and assign it a new target level to bounce back down to
            rising = false;
            targetEnergyLevel -= (int)random(1,  5);
            if(targetEnergyLevel >= 0){
                target = energyLevels.get(targetEnergyLevel);
            }
        }
        // check if electron has hit a target energy level anything past the first
        else if(!rising && targetEnergyLevel >= 0 && position.y >= target.position.y - 50){
            // if so, create a photon and then assign the electron a new target energy level
            photons.add(new Photon(new PVector(position.x, position.y)));
            targetEnergyLevel -= (int)random(1, 5 - targetEnergyLevel);
            if(angle < PI/2)
                angle += PI/3;
            else
                angle -= PI/3;
            if(targetEnergyLevel >= 0){
                target = energyLevels.get(targetEnergyLevel);
            }
        }

        // if rising, quickly but only along the y axis
        if(rising){
            velocity.set(0, -speed*2);
        }
        // otherwise move along any axis you want! But more slow! 
        else if(!rising){
            velocity.set(speed, speed);
        }
    }

    PVector perpendicular(PVector v)
    {
        return new PVector(-v.y, v.x);
    }
}
