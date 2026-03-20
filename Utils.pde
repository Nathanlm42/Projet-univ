class Bancdepoisson
{
  Fish poissons[];
  Vect bary = new Vect(0,0, 0);
  int nbpoissons;
  Bancdepoisson(int nbpoissons)
  {
    this.nbpoissons = nbpoissons;
    poissons = new Fish[nbpoissons];
    for (int i = 0; i < nbpoissons; i ++)
      poissons[i] = new Fish();
  }
  Bancdepoisson()
  {
    nbpoissons = 1000;
    poissons = new Fish[nbpoissons];
    for (int i = 0; i < nbpoissons; i ++)
      poissons[i] = new Fish();

  }
  void dessinerpoissons()
  {
    for (int i = 0; i < nbpoissons; i ++)
      poissons[i].dessiner();
  }
  void avancerpoissons()
  {
    for (int i = 0; i < nbpoissons; i ++)
     {
      bary = poissons[i].calculerbary();
      poissons[i].avancer(bary);
     }
  }

  void trouvervoisins()
  {
    for (int i = 0; i < nbpoissons; i ++)
      poissons[i].trouvervoisinspoisson(poissons); // Trouve les voisins de chaque poissons
  }
}
