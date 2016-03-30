import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class PhotonEmission extends PApplet {

Laser laser; // Laser for shooting out electrons
ArrayList<EnergyLevel> energyLevels; // List to hold the energy levels
ArrayList<Photon> photons; // List to hold the photons
ArrayList<Laser> lasers; // List to hold the electrons fired by the laser
ColorSpectrum spectrum;
UVPhoton legendUVPhoton;
VisiblePhoton legendVisPhoton;
IRPhoton legendIRPhoton;

// The usual setup stuff
public void setup() {
   
   
   init();
}

// Even more of the usual setup stuff
public void init() {
   energyLevels = new ArrayList<EnergyLevel>();
   for(int i = 1; i <= 5; i++){
      energyLevels.add(new EnergyLevel(i));
   }
   photons = new ArrayList<Photon>();
   lasers = new ArrayList<Laser>();
   
   lasers.add(new Laser(new PVector(200, 750), getEnergyLevel(1).electrons.get(0)));
   lasers.add(new Laser(new PVector(450, 750), getEnergyLevel(1).electrons.get(1)));
   lasers.add(new Laser(new PVector(700, 750), getEnergyLevel(1).electrons.get(2)));

   spectrum = new ColorSpectrum();

   legendUVPhoton = new UVPhoton(new PVector(750, 25), new PVector(0, 0));
   legendVisPhoton = new VisiblePhoton(new PVector(750, 50), new PVector(0, 0));
   legendIRPhoton = new IRPhoton(new PVector(750, 75), new PVector(0, 0));
}

// The usual drawing stuff
public void draw(){
   background(255);

   spectrum.render();

   // Render all the energy levels
   for(EnergyLevel level : energyLevels) {
      level.render();
   }


   for (Laser l : lasers)
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

   // Legend
   stroke(0);
   fill(255);
   rectMode(CORNER);
   rect(600, 10, 190, 80);
   textSize(15);
   fill(0);
   textAlign(LEFT);
   text("UV Photon", 610, 30);
   legendUVPhoton.drawPhoton();
   textSize(15);
   fill(0);
   textAlign(LEFT);
   text("Visible Photon", 610, 55);
   legendVisPhoton.drawPhoton();
   textSize(15);
   fill(0);
   textAlign(LEFT);
   text("IR Photon", 610, 80);
   legendIRPhoton.drawPhoton();

   // Reset button
   rectMode(CORNER);
   fill(255);
   stroke(0);
   rect(10, 10, 60, 25);
   fill(0);
   textAlign(CENTER);
   textSize(15);
   text("RESET", 40, 30);
}

public void addElectronToEnergyLevel(Electron e, int energyLevel) {
   energyLevels.get(energyLevel - 1).electrons.add(e);
}

public EnergyLevel getEnergyLevel(int energyLevel) {
   return energyLevels.get(energyLevel - 1);
}

public void addPhoton(Photon ph) {
   photons.add(ph);
}

public void keyPressed() {
   if (key == '1')
      lasers.get(0).fire();
   if (key == '2')
      lasers.get(1).fire();
   if (key == '3')
      lasers.get(2).fire();
   if (key == 'r')
      init();
}

public void mouseClicked(MouseEvent event) {
   float mx = pmouseX, my = pmouseY;

   if (mx >= 10 && mx <= 70 && my >= 10 && my <= 35)
      init();

   for (Laser laser : lasers) {
      if (mx > laser.position.x - 25 && mx < laser.position.x + 25 && my > 700)
         laser.fire();
   }
}

public boolean closeEnoughTo(PVector curr, PVector other, float closeness) {
   return abs(curr.y - other.y) < closeness;
}

public float yDist(PVector p1, PVector p2) {
   return sqrt((p2.y - p1.y) * (p2.y - p1.y));
}

// Helper method for checking if a position is off-screen
public boolean isOffScreen(PVector position) {
   float x = position.x;
   float y = position.y;
   return x < -15 || y < -15 || x > width + 15 || y > height + 15;
}
class Arrow {
   PVector tailPos, headPos;
   PVector velocity;
   boolean animating;
   int targetLevel;
   boolean photonFired;
   PVector halfway;
   final int SPEED = 10;

   Arrow(PVector pos, int target) {
      tailPos = new PVector(pos.x, pos.y);
      headPos = new PVector(pos.x, pos.y);
      EnergyLevel tarLevel = getEnergyLevel(target);
      float half = headPos.y + (tarLevel.position.y - headPos.y) / 2.0f;
      halfway = new PVector(0, half);
      velocity = new PVector(0, SPEED);
      targetLevel = target;
      animating = true;
      photonFired = false;
   }

   public void render() {
      drawArrow();
      if (animating)
         headPos.add(velocity);
      if (abs(yDist(headPos, halfway)) < SPEED && !photonFired) {
         if (targetLevel == 1) {
            addPhoton(new UVPhoton(new PVector(headPos.x, headPos.y)));
            spectrum.uvRevealed = true;
         }
         if (targetLevel == 2) {
            addPhoton(new VisiblePhoton(new PVector(headPos.x, headPos.y)));
            spectrum.visRevealed = true;
         }
         if (targetLevel == 3) {
            addPhoton(new IRPhoton(new PVector(headPos.x, headPos.y)));
            spectrum.irRevealed = true;
         }
         photonFired = true;
      }
      float dist = yDist(headPos, getEnergyLevel(targetLevel).position);
      if (animating && abs(dist) < SPEED) {
         headPos.y = getEnergyLevel(targetLevel).position.y;
         animating = false;
      }
   }

   public void drawArrow() {
      stroke(0);
      line(tailPos.x, tailPos.y, headPos.x, headPos.y);
      line(headPos.x, headPos.y, headPos.x + 10, headPos.y - 10);
      line(headPos.x, headPos.y, headPos.x - 10, headPos.y - 10);
   }

}
class ArrowElectron extends Electron {
   Arrow arrow;

   ArrowElectron(PVector pos, int target) {
      super(pos, target);
      PVector arrowPos = new PVector(pos.x, pos.y);
      arrow = new Arrow(arrowPos, target);
   }

   public void render() {
      drawElectron();
      position.y = arrow.headPos.y;
      arrow.render();
   }
}
class ColorSpectrum {
   PImage img;
   PVector pos;
   final int WIDTH = 700;
   final int HEIGHT = 150;
   boolean visRevealed, irRevealed, uvRevealed;
   int visOpactiy, irOpacity, uvOpacity;

   ColorSpectrum() {
      img = loadImage("spectrum.jpg"); 
      pos = new PVector(100, 525);

      visRevealed = false;
      irRevealed = false;
      uvRevealed = false;

      visOpactiy = 255;
      irOpacity = 255;
      uvOpacity = 255;
   }

   public void render() {
      drawSpectrum();
   }

   public void drawSpectrum() {
      noStroke();
      rectMode(CORNER);
      image(img, pos.x, pos.y, WIDTH - 1, HEIGHT);
      if (uvRevealed)
         if (frameCount % 2 == 0)
            uvOpacity -= 5;
         fill(255, uvOpacity);
         rect(pos.x, pos.y, WIDTH / 3, HEIGHT);
      if (visRevealed)
         if (frameCount % 2 == 0)
            visOpactiy -= 5;
      fill(255, visOpactiy);
      rect(pos.x + WIDTH / 3, pos.y, WIDTH / 3, HEIGHT);
      if (irRevealed)
         if (frameCount % 2 == 0)
            irOpacity -= 5;
      fill(255, irOpacity);
      rect(pos.x + WIDTH * 2 / 3, pos.y, WIDTH / 3, HEIGHT);
   }
}
class Electron {
   PVector position; // Position of electron
   PVector velocity; // Velocity of electron (directional)
   final int SPEED = 5; // Speed of electron (non-directional) 
   final int RADIUS = 10; // Radius of electron
   boolean animating; // Whether or not the elctron is in the rising phase of it's animation
   boolean done;
   int targetLevel;
   boolean arrowsMade;

   Electron(PVector pos, int target) {
      position = pos;
      animating = false;
      done = false;
      targetLevel = target;
      velocity = new PVector(0, -SPEED);
      arrowsMade = false;
   }

   public void render() {
      if (!done)
         drawElectron();
      if (animating)
         position.add(velocity);

      float dist = yDist(position, getEnergyLevel(targetLevel).position);
      if (abs(dist) < SPEED / 2) {
         animating = false;
         done = true;
      }
   }

   public void drawElectron() {
      fill(0xff3455F5);
      stroke(0xff00ccff);
      ellipse(position.x, position.y, RADIUS * 2, RADIUS * 2);
   }
}
class EnergyLevel {
   int number;
   PVector position;
   ArrayList<Electron> electrons; // List to hold the electrons fired by the laser

   int locs[][] = {{4, 1}, {3, 2}, {2, 3}}; // {quantity, target}

   EnergyLevel(int num) {
      number = num;
      position = new PVector(0, 50 / (num * .1f));
      electrons = new ArrayList<Electron>();
      if (num == 1) {
         electrons.add(new Electron(new PVector(200, position.y), 5));
         electrons.add(new Electron(new PVector(450, position.y), 5));
         electrons.add(new Electron(new PVector(700, position.y), 5));
      }
   }

   public void render() {
      drawEnergyLevel();
      drawElectrons();
   }

   public void drawElectrons() {
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

   public void drawEnergyLevel() {
      stroke(color(0, 0, 255));
      strokeWeight(3);
      line(100, position.y, 800, position.y);
      fill(0);
      textAlign(LEFT);
      textSize(25);
      text("n = " + number, 10, position.y);
      stroke(0);
   }
}
class IRPhoton extends Photon {
   IRPhoton(PVector pos) {
      super(pos);
   }

   IRPhoton(PVector pos, PVector vel) {
      super(pos, vel);
   }

   public void drawPhoton() {
      fill(0);
      stroke(0);
      ellipse(position.x, position.y, RADIUS * 2, RADIUS * 2);
      textSize(12);
      textAlign(CENTER);
      fill(0xffff3300);
      text("IR", position.x + 1, position.y + 6);
   }

}
class Laser {    
   Electron targetElectron;
   PVector position;
   int startFrame;

   Laser(PVector pos, Electron te) {
      targetElectron = te;   
      position = pos;
      startFrame = 0;
      frameCount = 30;
   }

   public void render() {
      fill(0);
      rectMode(CENTER);
      noStroke();
      rect(position.x, 750, 50, 100);
      rectMode(NORMAL);
      if (frameCount > 30 && frameCount - startFrame < 20) {
         fill(0xffffff00);
         rectMode(CORNER);
         rect(position.x - 7, 700 - 195, 14, 195);
      }
   }

   // fires an electron from the laser
   public void fire() {
      if (!targetElectron.done) {
         startFrame = frameCount;
         targetElectron.animating = true; 
      }
   }
}
abstract class Photon {
   PVector position; // position of photon
   PVector velocity; // velocity of photon
   int radius; // radius of photon
   final int SPEED = 8;
   final int RADIUS = 10;

   Photon(PVector pos) {
      position = pos;
      // assign random velocities
      float rand;
      float xVel = (rand = random(0, 1.0f)) >= .5f ? rand * SPEED : -rand * SPEED; 
      float yVel = (rand = random(0, 1.0f)) >= .5f ? rand * SPEED : -rand * SPEED; 
      velocity = new PVector(xVel, yVel);
      velocity.normalize();
   }

   Photon(PVector pos, PVector vel) {
      position = pos;
      velocity = vel;
   }

   public void render(){
      position.add(velocity);
      drawPhoton();
   }

   public abstract void drawPhoton();
}
class UVPhoton extends Photon {
   UVPhoton(PVector pos) {
      super(pos);
   }

   UVPhoton(PVector pos, PVector vel) {
      super(pos);
   }

   public void drawPhoton() {
      fill(0);
      stroke(0);
      ellipse(position.x, position.y, RADIUS * 2, RADIUS * 2);
      textSize(12);
      textAlign(CENTER);
      fill(0xffcc33ff);
      text("UV", position.x + 1, position.y + 6);
   }
}
class VisiblePhoton extends Photon{
   VisiblePhoton(PVector pos) {
      super(pos);
   }  

   VisiblePhoton(PVector pos, PVector vel) {
      super(pos, vel);
   }

   public void drawPhoton() {
      fill(0xffff9933);
      stroke(0xffffff00);
      ellipse(position.x, position.y, RADIUS * 2, RADIUS * 2);
   }
}
    public void settings() {  size(800, 800);  smooth(2); }
    static public void main(String[] passedArgs) {
        String[] appletArgs = new String[] { "PhotonEmission" };
        if (passedArgs != null) {
          PApplet.main(concat(appletArgs, passedArgs));
        } else {
          PApplet.main(appletArgs);
        }
    }
}
