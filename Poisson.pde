class Fish {
  int taille = 20;
  ArrayList <Fish> voisins = new ArrayList();
  float angle;
  Vect vitesse;
  Vect pos;

  Fish()
  {
    vitesse = new Vect(random(-3, 3), random(-3, 3), random(-3,3));
    pos = new Vect(random(frontieres, width - frontieres), random(frontieres, height- frontieres), random(profondeur,0));
    angle = 0;
  }

  void dessiner()
  {
    pos = pos.add(vitesse); // Actualise la position des poissons
    pos.x = constrain(pos.x, 0, width);
    pos.y = constrain(pos.y, 0, height); // Empeche le poisson de sortir du cube sur la frontière ne le repousse pas assez fort
    pos.z = constrain(pos.z, profondeur, 0);
    pushMatrix();
    translate(pos.x, pos.y, pos.z); // Déplace l'origine sur la position du poisson
    rotateZ(atan2(vitesse.y, vitesse.x) + PI); // Utilisation des coordonéess sphérique afin de determiner l'angle du poisson
    rotateY(-atan2(-vitesse.z, sqrt(vitesse.x*vitesse.x + vitesse.y*vitesse.y + vitesse.z*vitesse.z)));
    shape(fishobj);
    fill(255, 255, 255, 100);
    fill(0);
    popMatrix();
  }
  void avancer(Vect bary)
  {
    vitesse.x = constrain(vitesse.x, -2, 2);
    vitesse.y = constrain(vitesse.y, -2, 2);
    vitesse.z = constrain(vitesse.z, -2, 2); // Contrain la vitesse a [-2; 2]
    alignement(); // Enclenchement l'alignement des poissons
    deplacerversbary(bary); // Enclenche la cohésion
    evitervoisins(); // Enclenche la répulsion
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
    Vect moyenne = new Vect(0,0,0);
    int i = 0;
    if (voisins.size() == 0)
      return (new Vect(0, 0, 0));
    for (Fish voisin : voisins)
    {
      moyenne = moyenne.add(voisin.pos); // Calcul de la moyenne des positions
      i ++;
    }
    moyenne = moyenne.m(float(1/i));
    return (moyenne);
  }
  void deplacerversbary(Vect bary)
  {
    Vect dist = new Vect(0,0,0);
    float norm;

    if (bary.x == 0 && bary.y == 0 && bary.z == 0)
      return;
    dist = bary.sub(pos);
    norm = dist.norm();
    if (norm == 0)
      return;
    vitesse.x += cohesion*(dist.x/norm); // Les poissons convergent vers le barycentre de ses voisins
    vitesse.y += cohesion*(dist.y/norm);
    vitesse.z += cohesion*(dist.z/norm);
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
        if (dist == 0) // évite la division par zéro
          continue;
        repulsion = repulsion.m(1/(dist*dist));
        vitesse = vitesse.add(repulsion.m(repulsioncoeff)); // Repousse les poissons par rapport a chacune des composantes
      }
    }
  }
  void alignement()
  {
    Vect moyenne = new Vect(0,0,0);
    int i = 0;

    if (voisins.size() == 0)
      return;
    for (Fish voisin : voisins)
    {
      moyenne = moyenne.add(voisin.vitesse);
      i ++;
    }
    moyenne = moyenne.m(float(1/i));
    vitesse = vitesse.add(moyenne.m(alignement));  // Les poissons s'alignent par rapport aux vecteurs vitesse moyen des poissons
  }
  void eviterbord()
  {
    float coeff = 0.01;

    if (pos.x >= width - frontieres) // Repousse les poissons si trop proche des bords
      vitesse.x -= (pos.x - (width - frontieres))*coeff;
    if (pos.x <= frontieres)
      vitesse.x += (frontieres - pos.x)*coeff;
    if (pos.y >= height - frontieres)
      vitesse.y -= (pos.y - (height - frontieres))*coeff;
    if (pos.y <= frontieres)
      vitesse.y += (frontieres - pos.y)*coeff;
    if (pos.z >= 0 - frontieres)
      vitesse.z -= (pos.z + frontieres)*coeff;
    if (pos.z <= profondeur + frontieres)
      vitesse.z += ((profondeur + frontieres) - pos.z)*coeff;
  }
  boolean isvoisins(Fish voi) // voi = voisin
  {
    return ( dist( pos.x, pos.y, pos.z, voi.pos.x, voi.pos.y, voi.pos.z) <= zonevoisins &&
      dist( pos.x, pos.y, pos.z,  voi.pos.x, voi.pos.y, voi.pos.z) != 0); // Determine si deux poissons se situent dans leur cercle d'influence
  }
}
