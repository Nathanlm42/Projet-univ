Bancdepoisson bp;
int G_nbpoisson = 500;
int zonevoisins = 500;
float alignement = 0.02;
float cohesion = 0.001;
float repulsioncoeff = 0.001;
boolean influ = false;
boolean V = false;
PImage fish;
void setup()
{
  size(1000, 1000, P3D);
  bp = new Bancdepoisson(G_nbpoisson);
  dessinercommande();
  fish = loadImage("Poisson.png");
}


void draw()
{
  background(#d2e8df);
  bp.trouvervoisins();
  bp.avancerpoissons();
  bp.dessinerpoissons();
}

void dessinercommande()
{
  println("Bienvenue !");
  println("A et Q pour l'alignement : alignement actuel :" + alignement);
  println("Z et S pour la cohesion : cohesion actuel :" + cohesion);
  println("E et D pour la répulsion : repulsion actuel :" + repulsioncoeff);
  println("Appuyez sur T pour afficher le réseau d'influence");
  println("Appuyez V pour voir les vecteurs vitesse");
}

void keyPressed()
{
  float offset = 0.001;
  if (key == 'a' || key == 'A')
    alignement += offset;
  else if (key == 'q' || key == 'Q')
    alignement -= offset;
  else if (key == 'z' || key == 'Z')
    cohesion += offset;
  else if (key == 's' || key == 'S')
    cohesion -= offset;
  else if (key == 'e' || key == 'E')
    repulsioncoeff += offset;
  else if (key == 'd' || key == 'D')
    repulsioncoeff -= offset;
  else if (key == 't' || key == 'T')
    influ = !influ;
    else if (key == 'v' || key == 'V')
    V = !V;
  dessinercommande();
}
