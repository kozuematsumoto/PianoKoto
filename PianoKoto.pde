import java.util.*;                           

import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

boolean lineKExist;
boolean linePExist;

LineSystemK linesystemK;
LineSystemP linesystemP;

float kotoPitch;
float pianoPitch;

// native osc function      
void oscEvent(OscMessage msg) {
  if (msg.checkAddrPattern("/kotoPitch") == true) {
    kotoPitch = msg.get(0).floatValue();
  }
  if (msg.checkAddrPattern("/pianoPitch") == true) {
    pianoPitch = msg.get(0).floatValue();
  }

  if (kotoPitch != 0) {
    float mapped = map(kotoPitch, 50, 2500, 0, height);  
    //      float mapped = map(freq, 150, 1000, 0, height);  
    linesystemK.addParticles(new PVector (width, mapped));

    lineKExist = true;
    kotoPitch = 0;
  }

  if (pianoPitch != 0) {
    float mapped = map(pianoPitch, 50, 2000, 0, width);  
    //      float mapped = map(freq, 150, 1000, 0, height);  
    linesystemP.addParticles(new PVector (mapped, 0));

    linePExist = true;
    pianoPitch = 0;
  }
}


void setup() {
  //size(1470, 918, P3D);
  //  size(1250, 750, P3D);
  //  size(1680, 1050, P3D);
  size(displayWidth, displayHeight, P3D);
  frameRate(37);
  smooth();
  noStroke();      
  noCursor();

  oscP5 = new OscP5(this, 12001);
  myRemoteLocation = new NetAddress("127.0.0.1", 12000);

  linesystemK = new LineSystemK();
  linesystemP = new LineSystemP();

  lineKExist = false;  
  linePExist = false;
}

void draw() {
  background(0);
  text(frameRate, 20, 80);

  if (lineKExist) {
    linesystemK.update();
    linesystemK.display();
  }

  if (linePExist) {
    linesystemP.update();
    linesystemP.display();
  }
}

