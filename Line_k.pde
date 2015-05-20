class LineK {
  PVector startLoc;
  PVector endLoc;
  float lifespan;
  boolean isDead;
  PVector velocity;

  LineK(PVector info) {
    startLoc = info;
    endLoc =  new PVector(info.x, info.y);
    lifespan = 147;
    isDead = false;
    velocity = new PVector (-15, random(-3, 3));
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

