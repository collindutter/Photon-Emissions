public class Photon{
    public PVector position; // position of photon
    public PVector velocity; // velocity of photon
    public int radius; // radius of photon
    
    public Photon(PVector pos){
        position = pos;
        // assign random velocities
        int xVel = random(0, 1) >= .5 ? 8 : -8; 
        int yVel = random(0, 1) >= .5 ? 8 : -8;
        velocity = new PVector(xVel, yVel);
        radius = 25;
    }
    public void render(){
        position.add(velocity);
        // draw base of photon
        fill(#ff9933);
        ellipse(position.x, position.y, radius*2, radius*2);
        // draw stroke of photon
        noFill();
        strokeWeight(3);
        stroke(#ffff00);
        ellipse(position.x, position.y, radius*2, radius*2);
        strokeWeight(1);
        stroke(0);
    }
}
