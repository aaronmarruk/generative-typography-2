// Imports
// ----------------------------------------------------

import processing.opengl.*;
import geomerative.*;
import java.util.Date;


// Declarations
// ----------------------------------------------------

Particle p;
ArrayList particles;
RFont font;
RShape s;
RShape fontShape; 
RPoint topLeft, bottomRight;  
RGroup fontGroup;
RPoint[] points;


// Variables: edit these to alter behaviour of program
// ----------------------------------------------------

float distMin = 56; // Minimum distance allowed between 
                    // points when drawing a line

String myText = "A"; // The text used as geometry for 
                     // rendering points and lines

int fontSize = 740; // The text size 


float randomAmount = 20; // The points are rendered 
                         // around the outside of the
                         // shape. We use randomness
                         // to place points in the shape
                         // ... points that fall outside
                         // aren't drawn.

// fill colour
int fillR = 255; 
int fillG = 255;
int fillB = 255; // E.g. 255,255,255 == #fff;

int fillOpacity = 100;

int strokeWeight = 1;

int backgroundColour = 0;

int lineColour = 255;

color color1 = #50514f;
color color2 = #f25f5c;
color color3 = #ffe066;
color color4 = #247ba0;
color color5 = #70c1b3;

color[] Color = { 
  color1, color2, color3, color4, color5
};


// Setup
// ----------------------------------------------------
void setup() {
  
  // Basic settings
  size(1280, 800, P3D);
  smooth();
  
  noLoop();
  
  
  // Initialise geomerative objects
  RG.init(this);
  RCommand.setSegmentLength(random(0, 150));
  RCommand.setSegmentator(RCommand.UNIFORMLENGTH);
  
  particles = new ArrayList();
  
  // Load the font from .ttf
  font = new RFont("FreeSans.ttf", fontSize, RFont.CENTER);
  
  // Renders the font into a group
  fontGroup = font.toGroup(myText);
  points = fontGroup.getPoints();

  // Loops through the points in the shape
  for (int i = 0; i < points.length; i++) {
    
    // Grabs the point values and randomise
    float x = points[i].x;
    float y = points[i].y;
    
    x = y + random(-randomAmount, randomAmount);
    y = y + random(-randomAmount, randomAmount);
    
    // Are the randomised points in the shape
    boolean isInShape = fontGroup.contains(new RPoint(x, y));
    
    // If they are, add a new particle with the coords
    if (isInShape) {
      particles.add(new Particle(x, y, 3));
    }
    
    // We also add some points along the shape (i.e. around
    // the edge of the letter)
    if (random(0, 50) > 40) {
      particles.add(new Particle(points[i].x, points[i].y, 3));
    }
  }
}


// Draw
// ----------------------------------------------------
void draw() {
  
  // Basic setup
  translate(width/2, 600);
  
  background(backgroundColour);
  fill(fillR, fillG, fillB, fillOpacity);
  strokeWeight(strokeWeight);
  
  // Loops throught the particles
  for (int i = 0; i < particles.size(); i++) {
    
    // Draw the current particle
    Particle particle = (Particle) particles.get(i);
    particle.draw();
    
    fill(Color[int(random(0, 5))]);
    
    int radius = int(random(0, 50)); 
    ellipse(particle.x, particle.y, radius, radius);
      
    // Set up an initial space between variable, we'll use
    // this to keep track of space between points
    float spaceBetween = 0; 
      
    // Loops through particles again
    for (int j = 0; j < particles.size(); j++) {
       
      Particle neighbouringParticle = (Particle)particles.get(j);
      spaceBetween = particle.distance(neighbouringParticle);
      
      if (spaceBetween <= distMin) {
        stroke(lineColour);
        line(particle.x, particle.y, neighbouringParticle.x, neighbouringParticle.y);
      }
    }
  }
}

// Press spacebar to save a frame
// ----------------------------------------------------
void keyPressed() {
  if (key == ' ') {
    saveFrame("captures/capture_"+(new Date().getTime())+".tiff");
    println("save TIFF");
  }
}