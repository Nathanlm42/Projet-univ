class Bancdepoisson
{
  Fish poissons[];
  Vect bary = new Vect(0,0);
  int nbpoissons;
  Bancdepoisson(int nbpoissons)
  {
    this.nbpoissons = nbpoissons;
    poissons = new Fish[nbpoissons];
    for (int i = 0; i < nbpoissons; i ++)
    {
      poissons[i] = new Fish(i);
      fill(0);
    }
  }
  void dessinerpoissons()
  {
    for (int i = 0; i < nbpoissons; i ++)
    {
      poissons[i].dessiner();
      fill(0);
    }
  }
  void avancerpoissons()
  {
    for (int i = 0; i < nbpoissons; i ++)
     {
       poissons[i].deplacerversbary(bary);
      poissons[i].avancer();
     }
  }

  void trouvervoisins()
  {
    for (int i = 0; i < nbpoissons; i ++)
      poissons[i].trouvervoisinspoisson(poissons);
  }
  void calculerbary()
  {
    int moyennex = 0;
    int moyenney = 0; 
    for (int i = 0; i < nbpoissons; i ++)
    {
      moyennex += poissons[i].pos.x;
      moyenney += poissons[i].pos.y;
    }
    moyennex /= nbpoissons;
    moyenney /= nbpoissons;
    bary.x = moyennex;
    bary.y = moyenney;
  }
  
  void separation()
  {
    for (int i = 0; i < nbpoissons; i ++)
    {
      poissons[i].evitervoisins();
    }
  }
}
