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
      poissons[i].avancer();
     }
  }

  void trouvervoisins()
  {
    for (int i = 0; i < nbpoissons; i ++)
      poissons[i].trouvervoisinspoisson(poissons);
  }
}
