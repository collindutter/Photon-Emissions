public class Electron{
    public PVector position;
    public PVector velocity;
    public int speed;
    public int radius;
    public boolean rising;
    public int targetEnergyLevel;
    public float angle;
    public float t;
    public PVector center;
    public EnergyLevel target; 
    
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
        
        if(rising){
            position.add(velocity);
            fill(#3455F5);
            ellipse(position.x, position.y, radius*2, radius*2);
            stroke(#00ccff);
            strokeWeight(3);
            noFill();
            ellipse(position.x, position.y, radius*2, radius*2);
        }
        else{
            position.x += velocity.x*cos(angle);
            position.y += velocity.y*sin(angle);
            PVector a = perpendicular(PVector.sub(position, center, null));
            a.normalize();
            a.mult(sin(t) * 15);
            fill(#3455F5);
            ellipse(position.x + a.x, position.y + a.y, radius*2, radius*2);
            stroke(#00ccff);
            strokeWeight(3);
            noFill();
            ellipse(position.x + a.x, position.y + a.y, radius*2, radius*2);
            t += PI / 12;
        }
        strokeWeight(1);
        stroke(0); 
        if(rising && position.y <= target.position.y - 50){
            rising = false;
            targetEnergyLevel -= (int)random(1,  5);
            if(targetEnergyLevel >= 0){
                target = energyLevels.get(targetEnergyLevel);
            }
        }
        else if(!rising && targetEnergyLevel >= 0 && position.y >= target.position.y - 50){
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
        
        if(rising){
            velocity.set(0, -speed*2);
        }
        else if(!rising){
            velocity.set(speed, speed);
        }
    }

    PVector perpendicular(PVector v)
    {
        return new PVector(-v.y, v.x);
    }
}
