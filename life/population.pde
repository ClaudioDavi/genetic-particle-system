class Population {

  int size;
  Blob[] population;
  Population(int sz) {
    population = new Blob[sz];
    for (int i = 0; i < population.length; i++) {
      PVector loc = new PVector(random(0, width), random(0, height));
      population[i] = new Blob(loc);
    }
  }
  Blob matingPool(Blob[] population) {
    ArrayList<Blob> pool = new ArrayList<Blob>();
    float[] fitness = new float[population.length];
    
    for (int i =0; i < population.length; i++) {
      fitness[i] = population[i].getFitness();
    }
    
    float max_fitness = reverse(sort(fitness))[0];
    float mc_mating = random(sort(fitness)[0], max_fitness);
    
    for(Blob b: population) {
      if(b.getFitness() >= mc_mating) {
        pool.add(b);
      }
    }
    
    int a = int(random(pool.size()));
    int b = int(random(pool.size()));
    
    Blob parentA = pool.get(a);
    Blob parentB = pool.get(b);
    
    Blob child = parentA.crossover(parentB);
    child.mutate();
    return child;
  }
}
