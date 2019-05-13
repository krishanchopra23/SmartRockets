class Rocket {

  DNA dna = new DNA();
  PVector position;
  PVector velocity;
  PVector acceleration;
  PVector target = new PVector(width/2, 100);

  float size;
  float fitness;
  int geneCounter = 0;
  boolean stopped = false;
  ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();

  Rocket(PVector location) {
    acceleration = new PVector();
    velocity = new PVector();
    position = location.get();
    size = 4;
    obstacles.add(new Obstacle(new PVector(width/2, height/2), 160, 40));
  }

  void applyForce(PVector f) {
    acceleration.add(f);
  }
  
  void run() {
     if(!stopped) {
    applyForce(dna.genes[geneCounter]);
    geneCounter++;
    update();
    obstacles();
    display();
    }
    //applyForce(dna.genes[geneCounter]);
    //++geneCounter;
    //update();
    //display();
  }
  
  //void fitness() {
  //  float distance  = PVector.dist(position, target);
  //  fitness =  pow(1.0 / distance, 2);
  //}

  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);
  }

  void display() {
    float theta = velocity.heading2D() + PI/2;
    fill(200, 100);
    stroke(0);
    pushMatrix();
    translate(position.x, position.y);
    rotate(theta);

    // Thrusters
    rectMode(CENTER);
    fill(0);
    rect(-size/2, size*2, size/2, size);
    rect(size/2, size*2, size/2, size);

    // Fuselage
    fill(175);
    beginShape(TRIANGLES);
    vertex(0, -size*2);
    vertex(-size, size*2);
    vertex(size, size*2);
    endShape();

    popMatrix();
  }
  
  void fitness() {
    float d = PVector.dist(position, target);
    fitness = (1/d);
    if(stopped) {
      fitness *= 0.001;
    }
  }

  Rocket crossover(Rocket partner) {
    Rocket child = new Rocket(new PVector(width/2, 700));
    int midpoint = int(random(dna.genes.length));
    for(int i = 0; i < dna.genes.length; i++) {
      if(i > midpoint) {
        child.dna.genes[i] = dna.genes[i];
      }
      else {
        child.dna.genes[i] = partner.dna.genes[i];
      }
    }
    return child;
  }

  void obstacles() {
    for (Obstacle obs : obstacles) {
      obs.display();
      if (obs.contains(position)) {
        stopped = true;
      }
    }
  }

}
