// Particle Class 
// --------------------------------------------------

class Particle {
  PVector position;
  PVector speed;

  // Position
  float x;
  float y;
  float z;

  // Diameter
  float d;
  
  // Speed
  float s = 0;
  

  // Constructor 
  // --------------------------------------------------
  Particle(float x_, float y_, float d_) {

    this.x = x_;
    this.y = y_;
    this.d = d_;   
    
    position = new PVector (x, y);
    speed = new PVector(random(-s, s), random(-s, s));
  }

  // --------------------------------------------------
  void draw() {
    //movement();
  }
  
  void movement() {
    x += speed.x;
    y += speed.y;
  }

  // This returns a value which we can use to determine
  // whether we draw a line from point to point
  float distance(Particle p) {
    return dist(this.x, this.y, p.x, p.y);
  }
}