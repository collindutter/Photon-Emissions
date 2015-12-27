public class EnergyLevel{
    public int number;
    public PVector position;
    
    public EnergyLevel(int num){
        number = num;
        position = new PVector(0, 600 - (1 + num)*100);
    }
    
    public void render(){
       noFill();
       arc(400, position.y, 900, 100, PI+PI/16, TWO_PI-PI/16);
       textSize(50);
       text(number + 1, 750, position.y-50);
    }
}
