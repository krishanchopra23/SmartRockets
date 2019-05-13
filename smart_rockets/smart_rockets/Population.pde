class Population {
   
  float mutationRate;
  Rocket [] population;
  ArrayList<Rocket> matingPool = new ArrayList<Rocket>();
  int generations;
  PVector target;
  //float fitness;
  
   Population(float rate, int pop){
    mutationRate = rate;
    population = new Rocket[pop];
    //generations = 0;
    //matingPool = new ArrayList<Rocket>();
    for(int i = 0; i < pop; i++) {
      population[i] = new Rocket(new PVector(width/2, 700));
    }
    
    //for (int i = 0; i < population.length; i++) {
    //  PVector position = new PVector(width/2,height+20);
    //  population[i] = new Rocket(position, new DNA());
    //}
  }
  
  void fitness() {
    for(int i=0;i<population.length;i++){
      population[i].fitness();
    }
  }
  
  
  void selection() {
    matingPool = new ArrayList<Rocket>();
    for(int i = 0; i < population.length; i++) {
      int n = int(population[i].fitness * 1000);
      if(n == 0) {
        n = 1;
      }
      for(int j = 0; j < n; j++) {
        matingPool.add(population[i]);
      }
    }
  }
  
  void reproduction() {
    for(int i = 0; i < population.length; i++) {
      int A = int(random(matingPool.size()));
      int B = int(random(matingPool.size()));
      while(A == B) {
        B = int(random(matingPool.size()));
      }

      Rocket partnerA = matingPool.get(A);
      Rocket partnerB = matingPool.get(B);

      Rocket child = partnerA.crossover(partnerB);
      population[i] = child;
    }
  }
  
  void live () {
    for (int i = 0; i < population.length; i++) {
      population[i].run();
    }
  }
  
}
