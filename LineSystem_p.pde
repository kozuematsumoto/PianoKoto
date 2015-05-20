class LineSystemP {

  ArrayList<LineP> lineCollectionP = new ArrayList<LineP>();
  int num;

  LineSystemP() {
  }

  void update() {
    Iterator<LineP> iter = lineCollectionP.iterator(); 
    while (iter.hasNext ()) {  
      LineP l = iter.next();    
      if (l.isDead == true) {     
        iter.remove();
      } else {
        l.update();
      }
    }
  }

  void display() {
    Iterator<LineP> iter = lineCollectionP.iterator();
    while (iter.hasNext ()) {
      iter.next().display();
    }

    for (int i = 0; i < lineCollectionP.size (); i++) {
      // Get particle 
      LineP l = lineCollectionP.get(i);

      stroke(255, l.lifespan);
      fill(255, l.lifespan);

      rect(l.startLoc.x, l.startLoc.y, l.endLoc.x/3, l.endLoc.y);
      //      ellipse(l.endLoc.x, l.endLoc.y, l.startLoc.x, l.endLoc.y);
      rect(l.startLoc.x+10, l.startLoc.y, l.endLoc.x/5, l.endLoc.y);
      //        ellipse(l.endLoc.x+50, l.endLoc.y, l.startLoc.x-5, l.endLoc.y);
    }
    noStroke();
  }

  //called to add new particles
  void addParticles(PVector chuckInfo) {
    lineCollectionP.add(new LineP(chuckInfo));
  }
}

