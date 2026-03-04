class Fish {
  int taille = 20;
  int numero;
  color couleur = #cde8e7;
  ArrayList <Fish> voisins = new ArrayList();
  float angle;
  Vect vitesse;
  Vect pos;

  Fish(int numero)
  {
    vitesse = new Vect(random(-3, 3), random(-3, 3));
    pos = new Vect(random(0, width), random(0, height));
    this.numero = numero;
    angle = 0;
  }

  void dessiner()
  {
    pos.x = (pos.x + width + vitesse.x)%width;
    pos.y = (pos.y + height + vitesse.y)%height;
    if (influ)
    {
      for (Fish voisin : voisins)
      {
        fill(255, 0, 0);
        line(voisin.pos.x, voisin.pos.y, pos.x, pos.y);
      }
    }
    fill(couleur);
    image(fish, pos.x, pos.y, taille, taille);
    fill(255, 255, 255, 100);
    fill(0);
    text(numero, pos.x, pos.y);
  }
  void avancer()
  {
    vitesse.x = constrain(vitesse.x, -2, 2);
    vitesse.y = constrain(vitesse.y, -2, 2);
    alignement();
    eviterbord();
    deplacerversbary(calculerbary());
    evitervoisins();
  }

  void trouvervoisinspoisson(Fish poissons[])
  {
    voisins.clear();
    for (int i = 0; i < poissons.length; i ++)
    {
      if (this.isvoisins(poissons[i]))
        voisins.add(poissons[i]);
    }
  }
  Vect calculerbary()
  {
    float moyennex = 0;
    float moyenney = 0;
    int i = 0;
    if (voisins.size() == 0)
      return (new Vect(0, 0));
    for (Fish voisin : voisins)
    {
      moyennex += voisin.pos.x;
      moyenney += voisin.pos.y;
      i ++;
    }
    moyennex /= i;
    moyenney /= i;
    return (new Vect(moyennex, moyenney));
  }
  void deplacerversbary(Vect bary)
  {
    float distx;
    float disty;
    float norm;

    if (bary.x == 0 && bary.y == 0)
      return;
    distx = bary.x - pos.x;
    disty = bary.y - pos.y;
    norm = dist(bary.x, bary.y, pos.x, pos.y);
    vitesse.x += cohesion*(distx/norm);
    vitesse.y += cohesion*(disty/norm);
  }
  void evitervoisins()
  {
    Vect repulsion;
    float dist = 0;
    for (Fish voisin : voisins)
    {
      if (dist(voisin.pos.x, voisin.pos.y, pos.x, pos.y) <= zonevoisins/10)
      {
        repulsion = pos.sub(voisin.pos);
        dist = dist(pos.x, pos.y, voisin.pos.x, voisin.pos.y);
        repulsion.m(1/(dist*dist));
        vitesse.x += repulsion.x*repulsioncoeff;
        vitesse.y += repulsion.y*repulsioncoeff;
      }
    }
  }
  void alignement()
  {
    float moyennex = 0;
    float moyenney = 0;
    int i = 0;

    if (voisins.size() == 0)
      return;
    for (Fish voisin : voisins)
    {
      moyennex += voisin.vitesse.x;
      moyenney += voisin.vitesse.y;
      i ++;
    }
    moyennex /= i;
    moyenney /= i;
    vitesse.x += moyennex*alignement;
    vitesse.y += moyenney*alignement;
  }
  void eviterbord()
  {
    int frontieres = 50;
    float coeff = 0.01;
    if (pos.x >= width - frontieres)
      vitesse.x += ((pos.x - width))*coeff;
    if (pos.x <= frontieres)
      vitesse.x += (pos.x)*coeff;
    if (pos.y >= height - frontieres)
      vitesse.y += ((pos.y - height))*coeff;
    if (pos.y <= frontieres)
      vitesse.y += (pos.y)*coeff;
  }
  boolean isvoisins(Fish voi) // voi = voisin
  {
    return ( dist( pos.x, pos.y, voi.pos.x, voi.pos.y) <= zonevoisins &&
      dist( pos.x, pos.y, voi.pos.x, voi.pos.y) != 0);
  }
}
