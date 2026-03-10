class Vect
{
  float x;
  float y;
  Vect(float x, float y) // Constructeur
  {
    this.x = x;
    this.y = y;
  }
  float distvect(Vect u)
  {
    return (dist (x, y, u.x, u.y));
  }
  Vect add(Vect u)
  {
    return(new Vect(this. x + u.x, this.y + u.y));
  }
  Vect sub(Vect u)
  {
    return(new Vect(this.x - u.x, this.y - u.y));
  }
  Vect m(float a)
  {
    return (new Vect(this.x*a, this.y*a));
  }
  float ps(Vect u)
  {
    return(this.x*u.x + this.y*u.y);
  }
  float norm()
  {
    return (sqrt(pow(this.x, 2) + pow(this.y, 2)));
  }
  void normalize()
  {
    x/=norm();
    y/=norm();
  }
  String toString()
  {
    return("x : " + this.x + '\n' + "y : " + this.y);
  }
}
