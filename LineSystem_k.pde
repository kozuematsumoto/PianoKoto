class LineSystemK {

  ArrayList<LineK> lineCollectionK = new ArrayList<LineK>();
  int num;

  LineSystemK() {
  }

  void update() {
    Iterator<LineK> iter = lineCollectionK.iterator(); 
    while (iter.hasNext ()) {  
      LineK l = iter.next();    
      if (l.isDead == true) {     
        iter.remove();
      } else {
        l.update();
      }
    }
  }

  void display() {
    Iterator<LineK> iter = lineCollectionK.iterator();
    while (iter.hasNext ()) {
      iter.next().display();
    }

    for (int i = 0; i < lineCollectionK.size (); i++) {
      // Get particle 
      LineK l = lineCollectionK.get(i);

      stroke(0, 0, 255, l.lifespan);
      fill(0, 0, 255, l.lifespan);

      rect(l.startLoc.x, l.startLoc.y, l.endLoc.x, l.endLoc.y);
      rect(l.endLoc.x, l.startLoc.y-70, l.startLoc.x, l.endLoc.y+15);
      rect(l.startLoc.x, l.startLoc.y+10, l.endLoc.x, l.endLoc.y-15);
    }
    noStroke();
  }

  //called to add new particles
  void addParticles(PVector chuckInfo) {
    lineCollectionK.add(new LineK(chuckInfo));
  }
}

