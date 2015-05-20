class LineP {
  PVector startLoc;
  PVector endLoc;
  float lifespan;
  boolean isDead;
  PVector velocity;

  LineP(PVector info) {
    startLoc = info;
    endLoc =  new PVector(info.x, info.y);
    lifespan = 113;
    isDead = false;
      velocity = new PVector (random(-7, 7), 15);
  }

  void update() {
    endLoc.add(velocity);
    if (lifespan == 0) {
      isDead = true;
    } else {
      lifespan = lifespan -1;
    }
  }

  void display() {
  }
}

