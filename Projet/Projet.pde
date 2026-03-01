Bancdepoisson bp;
int G_nbpoisson = 100;
int zonevoisins = 100;
void setup()
{
  size(500, 500);
  bp = new Bancdepoisson(G_nbpoisson);
}


void draw()
{
  background(#d2e8df);
  bp.avancerpoissons();
  bp.dessinerpoissons();
  bp.trouvervoisins();
  bp.calculerbary();
  bp.separation();
  circle(bp.bary.x, bp.bary.y, 10);
}
