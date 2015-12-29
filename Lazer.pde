public class Lazer{    
    public void render(){
        fill(0);
        rectMode(CENTER);
        rect(400, 750, 50, 100);
        rectMode(NORMAL);
    }
    
    // fires an electron from the lazer
    public void fire(){
       electrons.add(new Electron(new PVector(400, 750), 4));
    }
}
