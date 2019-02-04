class Blob {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float radius;
  
  float topspeed = 5;
  int minDistance;
  float maxForce;
  boolean isAlive = true;
  
  int[] gene = new int[11];
  int[] geneMag = new int [2];
  float fitness;
  float mutationRate = 0.05;
  int max_hits_on_wall = 50;
  int hits;
  
  Blob(PVector loc) {
    geneMag[0] = 5;
    geneMag[1] = 25;
  
    for (int i = 0; i < gene.length; i++){
      gene[i] = (int) random(geneMag[0],geneMag[1]);
    }
    location = new PVector(loc.x, loc.y);
    velocity = new PVector(gene[0],gene[1]);
    hits = 0;
    radius = (int)map(gene[5], geneMag[0], geneMag[1], 5, 10);
    acceleration = new PVector(gene[2],gene[3]);
    acceleration.normalize();
    
    acceleration.mult(gene[4]);
    
    minDistance = int(map(gene[9], geneMag[0], geneMag[1], 0, 100) + radius);
    maxForce = map(gene[10], geneMag[0], geneMag[1], -2, 4);
    fitness = 0;
  }
 
  int[] getGene(){
    return gene;
  }
  
  float getFitness() {
    return fitness/10;
  }
  void movement(Blob other) {
    PVector distanceVect = PVector.sub(other.location, location);

      if(other.radius > radius && distanceVect.mag() < minDistance && other.isAlive) {
        acceleration.add(prey(other));
        if(isAlive) {
          fitness++;
        }
      } else if (other.radius < radius && distanceVect.mag() > minDistance && other.isAlive) {
        acceleration.add(predator(other));
        if(isAlive) {
          fitness++;
        }
      } else if (other.radius == radius && distanceVect.mag() > minDistance && other.isAlive) {
        acceleration.add(PVector.random2D());
      }
      if (isAlive && (checkCollision(other) && radius < other.radius && other.isAlive)) {
        isAlive = false;
      }
      if (isAlive && (checkCollision(other) && radius > other.radius && other.isAlive)) {
        radius = radius + other.radius*0.5;
        if (topspeed > 0.5){
          topspeed = topspeed - radius*0.02;
        }
        
      }
  }
  
  void update(Blob[] others) {
    for (int i = 0; i < others.length; i++){
      movement(others[i]);
    }
    if(isAlive) {
      fitness = fitness+2;
    }
    if(hits > max_hits_on_wall) {
      isAlive = false;
    }
    velocity.add(acceleration);
    velocity.limit(topspeed);
    location.add(velocity);
    bounce();
    
    if(isAlive) {
     display(); 
    }
    
    
  }
  
  Blob crossover(Blob parent) {
    Blob child = new Blob(new PVector(random(0, width), random(0, height)));
    int[] genesA = getGene();
    int[] genesB = parent.getGene();
    
    for(int i = 0; i < genesA.length; i++) {
      int parentGene = (int) random(0, 1);
      if (parentGene == 0) {
        child.gene[i] = genesA[i];
      } else {
        child.gene[i] = genesB[i];
       }
    }
    
    return child;
  }
  
  void mutate() {
    for (int i = 0; i < gene.length; i++) {
      if (random(1) < mutationRate) {
        gene[i] = (int) random(geneMag[0], geneMag[1]);
      }
    }
  }
  
  void bounce() {
    if ((location.x > width - 20) || (location.x < 20)) {
      velocity.x = velocity.x * -1;
      acceleration.x = acceleration.x * -1;
      hits++;
    }
    if ((location.y > height - 20) || (location.y < 20)) {
      velocity.y = velocity.y * -1;
      acceleration.y = acceleration.y * -1;
      hits++;
    }
  }
  
  void display(){
    noStroke();
    int r = (int) map(gene[6], geneMag[0], geneMag[1], 10, 255);
    int g = (int) map(gene[7], geneMag[0], geneMag[1], 10, 255);
    int b = (int) map(gene[8], geneMag[0], geneMag[1], 10, 255);
    fill(r,g,b);
    ellipse(location.x, location.y,radius,radius);
  }
  
   boolean checkCollision(Blob other) {
     
    PVector distanceVect = PVector.sub(other.location, location);
    
    float distanceVectMag = distanceVect.mag();
    
    float hitDistance = radius + other.radius;
    if(distanceVectMag < hitDistance) {
        return true;
     } else {
       return false;
     }
   }
   PVector predator(Blob prey) {
    PVector distanceVect = PVector.sub(prey.location, location);
    
    float distanceVectMag = distanceVect.mag();
    float followDistance = minDistance + prey.radius;
    
    if (distanceVectMag < followDistance) {
      PVector desired = PVector.sub(prey.location, location);
      desired.setMag(topspeed);
      PVector steer = PVector.sub(desired, velocity);
      steer.limit(maxForce);  // Limit to maximum steering force
      return steer;
     } else {
      return new PVector(0,0);
    }
  }
  PVector prey(Blob predator) {
    PVector distanceVect = PVector.sub(predator.location, location);
    
    float distanceVectMag = distanceVect.mag();
    float fleeDistance = (minDistance + predator.radius) * 3;
    
    if (distanceVectMag < fleeDistance) {
      PVector keep = new PVector(predator.location.x + fleeDistance, predator.location.y+fleeDistance);
      PVector desired = PVector.sub(keep, location);
      desired.setMag(topspeed);
      PVector steer = PVector.sub(desired, velocity);
      steer.limit(maxForce);  // Limit to maximum steering force
      return steer;
     } else {
      return new PVector(0,0);
    }
  }
}
