
Population pop;
int size = 50;
int score;
int generation;
void setup() {
  size(1200, 600);
  smooth();
  background(0);
  pop = new Population(size);
  score = 0;
  generation = 0;
}

void draw(){
  background(0);
  ArrayList<Float> fitness_total = new ArrayList<Float>();
  ArrayList<Float> fitness_alive = new ArrayList<Float>();
  int aliveCount = 0;
  for(int i=0; i < pop.population.length; i++) {
    pop.population[i].update(pop.population);
    fitness_total.add(pop.population[i].getFitness());
    if(pop.population[i].isAlive){
      aliveCount++;
      fitness_alive.add(pop.population[i].getFitness());
    }
    
  }
  float total = 0;
  for(Float f : fitness_total) {
    total = total+f;
  }
  float alive_total = 0;
  for(Float f : fitness_alive){
    alive_total = alive_total + f;
  }
  score++;
  fill(255,0,0);
  textSize(18);
  
  text("Fitness total avg: " + (int)total/fitness_total.size(),width/64, 40);
  text("Fitness alive avg: " + (int)alive_total/fitness_alive.size(),width/64, 60);
  text("Alive Count: " + aliveCount,width/64,80);
  text("Generation: " + generation ,width/64,100);
  
  if(aliveCount < 5 || score > 2000) {
    for(int i=0; i < size; i++) {
      pop.population[i] = pop.matingPool(pop.population);  
    }
    
    generation++;
    score = 0;
  }
  
  
}
