class Fish {
  int taille = 20;
  int numero;
  color couleur = #cde8e7;
  ArrayList <Fish> voisins = new ArrayList();
  Vect vitesse;
  Vect pos;

  Fish(int numero)
  {
    vitesse = new Vect(random(-3, 3), random(-3, 3));
    pos = new Vect(random(0, width), random(0, height));
    this.numero = numero;
  }

  void dessiner()
  {
    fill(couleur);
    ellipse(pos.x, pos.y, taille, taille/2);
    fill(255, 255, 255, 100);
   //circle(pos.x, pos.y, zonevoisins);
    for (Fish voisin : voisins)
    {
      fill(255, 0, 0);
     //line(voisin.pos.x, voisin.pos.y, pos.x, pos.y);
    } 
    fill(0);
    text(numero, pos.x, pos.y); 
  }
  void avancer()
  {
    // Limiter la vitesse maximale
    float vitesseMax = 2.0;
    float vitesseActuelle = vitesse.norm();
    if (vitesseActuelle > vitesseMax)
    {
      vitesse = vitesse.m(vitesseMax / vitesseActuelle);
    }
    
    pos.x = (pos.x + width + vitesse.x)%width;
    pos.y = (pos.y + height + vitesse.y)%height;
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
  void deplacerversbary(Vect bary)
  {
    float distx;
    float disty;
    
    distx = bary.x - pos.x;
    disty = bary.y - pos.y;
    vitesse.x += 0.001 * distx;
    vitesse.y += 0.001 * disty;
  }
  void evitervoisins()
  {
    Vect repulsion;
    float dist = 0;
    for (Fish voisin : voisins)
    {
      repulsion = pos.sub(voisin.pos);
      dist = repulsion.norm();
      if (dist > 0 && dist < 50) // Éviter division par zéro et limiter la zone de répulsion
      {
        repulsion = repulsion.m(1.0/dist); // Normaliser
        repulsion = repulsion.m(10.0/dist); // Force inversement proportionnelle à la distance
        vitesse = vitesse.add(repulsion.m(0.01)); // Ajouter la force de répulsion
      }
    }
  }
  void eviterBords()
  {
    if (this.pos.x < width - 50 || this.pos.x > width + 50)
    {
      
    }
  }
  boolean isvoisins(Fish voi) // voi = voisin
  {
    return ( dist( pos.x, pos.y, voi.pos.x, voi.pos.y) <= zonevoisins/2);
  }
}
