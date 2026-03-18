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
    vitesse = new Vect(random(-3, 3), random(-3, 3), random(-3,3));
    pos = new Vect(random(0, width), random(0, height), random(profondeur,0));
    this.numero = numero;
    angle = 0;
  }

  void dessiner()
  {
    pos.x = pos.x + vitesse.x;
    pos.y = pos.y + vitesse.y;
    pos.z = pos.z + vitesse.z;
    pos.x = constrain(pos.x, 0, width);
    pos.y = constrain(pos.y, 0, height);
    pos.z = constrain(pos.z, profondeur, 0);
    if (influ)
    {
      for (Fish voisin : voisins)
      {
        fill(255, 0, 0);
        line(voisin.pos.x, voisin.pos.y, pos.x, pos.y);
      }
    }
    if (V)
    {
      line(pos.x, pos.y, pos.x + vitesse.x*width/10, pos.y + vitesse.y*width/10);
    }
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    rotateZ(atan2(vitesse.y, vitesse.x) + PI);
    rotateY(-atan2(-vitesse.z, sqrt(vitesse.x*vitesse.x + vitesse.y*vitesse.y + vitesse.z*vitesse.z)));
    fill(couleur);
    shape(fishobj);
    fill(255, 255, 255, 100);
    fill(0);
    popMatrix();
  }
  void avancer(Vect bary)
  {
    vitesse.x = constrain(vitesse.x, -2, 2);
    vitesse.y = constrain(vitesse.y, -2, 2);
    vitesse.z = constrain(vitesse.z, -2, 2);
    alignement();
    deplacerversbary(bary);
    evitervoisins();
    eviterbord();
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
    float moyennez = 0;
    int i = 0;
    if (voisins.size() == 0)
      return (new Vect(0, 0, 0));
    for (Fish voisin : voisins)
    {
      moyennex += voisin.pos.x;
      moyenney += voisin.pos.y;
      moyennez += voisin.pos.z;
      i ++;
    }
    moyennex /= i;
    moyenney /= i;
    moyennez /= i;
    return (new Vect(moyennex, moyenney, moyennez));
  }
  void deplacerversbary(Vect bary)
  {
    float distx;
    float disty;
    float distz;
    float norm;

    if (bary.x == 0 && bary.y == 0 && bary.z == 0)
      return;
    distx = bary.x - pos.x;
    disty = bary.y - pos.y;
    distz = bary.z - pos.z;
    norm = dist(bary.x, bary.y, bary.z, pos.x, pos.y, pos.z);
    if (norm == 0)
      return;
    vitesse.x += cohesion*(distx/norm);
    vitesse.y += cohesion*(disty/norm);
    vitesse.z += cohesion*(distz/norm);
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
        dist = dist(pos.x, pos.y, pos.z, voisin.pos.x, voisin.pos.y, voisin.pos.z);
        if (dist == 0)
          continue;
        repulsion = repulsion.m(1/(dist*dist));
        vitesse.x += repulsion.x*repulsioncoeff;
        vitesse.y += repulsion.y*repulsioncoeff;
        vitesse.z -= repulsion.z*repulsioncoeff;
      }
    }
  }
  void alignement()
  {
    float moyennex = 0;
    float moyenney = 0;
    float moyennez = 0;
    int i = 0;

    if (voisins.size() == 0)
      return;
    for (Fish voisin : voisins)
    {
      moyennex += voisin.vitesse.x;
      moyenney += voisin.vitesse.y;
      moyennez += voisin.vitesse.z;
      i ++;
    }
    moyennex /= i;
    moyenney /= i;
    vitesse.x += moyennex*alignement;
    vitesse.y += moyenney*alignement;
    vitesse.z -= moyennez*alignement;
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
    if (pos.z >= 0 - frontieres)
      vitesse.z += (frontieres + pos.z)*coeff;
    if (pos.z <= profondeur + frontieres)
      vitesse.z -= (profondeur + frontieres - pos.z)*coeff;
  }
  boolean isvoisins(Fish voi) // voi = voisin
  {
    return ( dist( pos.x, pos.y, pos.z, voi.pos.x, voi.pos.y, voi.pos.z) <= zonevoisins &&
      dist( pos.x, pos.y, pos.z,  voi.pos.x, voi.pos.y, voi.pos.z) != 0);
  }
}
