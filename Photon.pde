public class Photon{
    public PVector position;
    public PVector velocity;
    public int radius;
    
    public Photon(PVector pos){
        position = pos;
        int xVel = random(0, 1) >= .5 ? 8 : -8; 
        int yVel = random(0, 1) >= .5 ? 8 : -8;
        velocity = new PVector(xVel, yVel);
        radius = 25;
    }
    public void render(){
        position.add(velocity);
        fill(#ff9933);
        ellipse(position.x, position.y, radius*2, radius*2);
        noFill();
        strokeWeight(3);
        stroke(#ffff00);
        ellipse(position.x, position.y, radius*2, radius*2);
        strokeWeight(1);
        stroke(0);
    }
}
