/*------------------------------------------------------------------------*/
Circl[] CO;
int count = 50;
PImage img;
/*------------------------------------------------------------------------*/
class Circl
{  
  float xpos;
  float ypos;
  float dia;
  float speedx;
  float speedy;
  float opa;
  float rc, gc, bc;
  int number; 
  float koef;
  boolean vop; 
  Circl(int num)
  {
    number = num;
    xpos = width/2;
    ypos = height/2;
    dia = 10;
    vop = false;
    speedx = random(-2.5, 2.5);
    speedy = random(-2.5, 2.5);
    opa = 60;
    rc = random(10,245);
    gc = random(10,245);
    bc = random(10,245);
  }
  void dra()
  {
    stroke(rc, gc, bc, opa/1.2);
    fill(rc, gc, bc, opa/1.2);
    ellipse(xpos, ypos, dia+koef, dia+koef);
    noStroke();
    fill(rc, gc, bc, opa/4);
    ellipse(xpos, ypos, dia+10+koef, dia+10+koef);
  }
  void mov()
  {
    xpos += speedx;
    ypos += speedy;
  }
  void dal()
  {
    koef = (sq(width/2 - xpos) + sq(height/2 - ypos))/7400;
    if ((sq(width/2 - xpos) + sq(height/2 - ypos) > sq(200)) && (vop == false))
    {
      vop = true;
      speedx = speedx/2.2;
      speedy = speedy/2.2;
    }
  }
  void die()
  {
    if ((xpos > 800) || (xpos < 0) || (ypos > 800) || (ypos < 0))
    {
       CO[number] = new Circl(number);
    }
  }  
}
/*------------------------------------------------------------------------*/
void setup()
{
  frameRate(60);
  size(800, 800);
  img = loadImage("noise.png"); 
  CO = new Circl[count];
  for (int i = 0; i < count; i++)
  {
    CO[i] = new Circl(i);
  }
}
/*------------------------------------------------------------------------*/
void draw()
{
  background(255);
  img.loadPixels();
  strokeWeight(2);
  stroke(0, 0, 0, 20);
  for (int j = 0; j<height/img.height+1; j++)
  {
    for (int i = 0; i<width/img.width+1; i++)
    {
      image(img, i*img.width, j*img.height);
    }
  }
  line(0,0,width,height);
  line(width,0,0,height);
  line(width/2,0,width/2,height);
  line(0,height/2,width,height/2);
  fill(0, 0, 0, 70);
  text("Developers", 30, 20);
  text("R&D", 410, 20);
  text("Managers", 30, 420);
  text("Engineers", 30, 790);
  text("QA", 410, 790);
  text("PM", 760, 420);
  text("Analysts", 720, 20);
  text("Architects", 720, 790);
  noFill();
  ellipse(width/2, height/2, 200, 200);
  ellipse(width/2, height/2, 400, 400);
  ellipse(width/2, height/2, 700, 700);
  for (int i = 0; i < count; i++)
  {
    CO[i].die();
    CO[i].dra();
    CO[i].dal();
    CO[i].mov();
  }  
}
/*------------------------------------------------------------------------*/
