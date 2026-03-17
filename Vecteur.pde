class Vect
{
  float x;
  float y;
  float z;
  Vect(float x, float y, float z) // Constructeur
  {
    this.x = x;
    this.y = y;
    this.z = z;
  }
  float distvect(Vect u)
  {
    return (dist (x, y, z, u.x, u.y, u.z));
  }
  Vect add(Vect u)
  {
    return(new Vect(this. x + u.x, this.y + u.y, this.z + u.z));
  }
  Vect sub(Vect u)
  {
    return(new Vect(this.x - u.x, this.y - u.y, this.z - u.z));
  }
  Vect m(float a)
  {
    return (new Vect(this.x*a, this.y*a, this.z*a));
  }
  float ps(Vect u)
  {
    return(this.x*u.x + this.y*u.y);
  }
  float norm()
  {
    return (sqrt(pow(this.x, 2) + pow(this.y, 2) + pow(this.z, 2)));
  }
  void normalize()
  {
    x/=norm();
    y/=norm();
  }
  String toString()
  {
    return("x : " + this.x + '\n' + "y : " + this.y + "z : " + z);
  }
}
