int countP = 15; //35
int countB = 20; //90
Proj[] ObjP;
Bot[] ObjB;
Link[] Lnk;
PImage img;
/*------------------------------------------------------------------------*/
class Proj
{
  int number;
  float xpos;
  float ypos;
  float dia;
  float speedx;
  float speedy;
  float opa;
  float rc, gc, bc;
  int n;  
  Proj(int num)
  {
    number = num;
    xpos = random(width);
    ypos = random(height);
    dia = random(50, 100);
    speedx = random(-1.5, 1.5);
    speedy = random(-1.5, 1.5);
    opa = 100;
    rc = random(10,245);
    gc = random(10,245);
    bc = random(10,245);
    n = 0;
  }  
  void dra()
  {
    stroke(rc, gc, bc, opa);
    fill(rc, gc, bc, opa+n*10);
    ellipse(xpos, ypos, dia+n*5, dia+n*5);
  }  
  void mov()
  {
    xpos += speedx;
    ypos += speedy;
    if (xpos < -dia)
    {
      xpos = width + dia;
    }
    if (xpos > width+dia)
    {
      xpos = -dia;
    }
    if (ypos < 0-dia)
    {
      ypos = height + dia;
    }
    if (ypos > height+dia)
    { 
      ypos = -dia;
    }
  }
  void inf()
  {
    n = 0;
    for (int i= 0 ; i<countB; i++)
    {
      if ( sq(ObjB[i].xpos - xpos) + sq(ObjB[i].ypos - ypos) < sq((dia+n*5)/2)+10 )
      {
        n++;
      }
    }
    fill(20, 20, 20, 100);
    text(n, xpos-3, ypos+5);
  }  
}
/*------------------------------------------------------------------------*/
class Bot
{
  int number;
  int iter;
  float xpos;
  float ypos;
  float dia;
  float speedx;
  float speedy;
  float opa;
  float rc, gc, bc;  
  Bot(int num)
  {
    number = num;
    xpos = random(width);
    ypos = random(height);
    dia = 15;
    iter = int(random(0, 100));
    speedx = random(-1.5, 1.5);
    speedy = random(-1.5, 1.5);
    opa = random(120,200);
    rc = random(100,200);
    gc = random(100,200);
    bc = random(100,200);
  }  
  void dra()
  {
    stroke(rc, gc, bc, opa/2);
    fill(rc, gc, bc, opa/2-20);
    ellipse(xpos, ypos, dia, dia);
    noStroke();
    fill(rc, gc, bc, opa-100);
    ellipse(xpos, ypos, dia+10, dia+10);
  }  
  void mov()
  {
    xpos += speedx;
    ypos += speedy;
    if (xpos < -dia)
    {
      xpos = width + dia;
    }
    if (xpos > width+dia)
    {
      xpos = -dia;
    }
    if (ypos < 0-dia)
    {
      ypos = height + dia;
    }
    if (ypos > height+dia)
    { 
      ypos = -dia;
    }
  }
  void inf()
  {
    for (int i= 0 ; i<countP; i++)
    {
      if ( sq(ObjP[i].xpos - xpos) + sq(ObjP[i].ypos - ypos) < sq((ObjP[i].dia)/2) )      // + ObjP[i].n*5
      {
        speedx =  ObjP[i].speedx;
        speedy =  ObjP[i].speedy;
        String hash = str(ObjP[i].number) + str(number);
        int hash2 = int(hash);
        if (Lnk[hash2].act == false)
        {
          Lnk[hash2] = new Link(ObjP[i].number, number, true);
        }
      }
    }
  }
  void tim()
  {
    iter++;
    if (iter>300)
    {
      iter = 0;
      speedx = random(-5.5, 5.5);
      speedy = random(-5.5, 5.5);
    }    
  }  
}
/*------------------------------------------------------------------------*/
class Link
{
  float opa;
  float rc, gc, bc;
  int ox1, oy1;
  boolean act;  
  Link(int x1, int y1, boolean nll)
  {
    ox1 = x1;
    oy1 = y1;
    act = nll;
    opa = random(30,40);
    rc = random(100,200);
    gc = random(100,200);
    bc = random(100,200);
  }  
  void dra()
  {
    stroke(rc, gc, bc, opa);
    line(ObjP[ox1].xpos, ObjP[ox1].ypos, ObjB[oy1].xpos, ObjB[oy1].ypos);
  } 
}
/*------------------------------------------------------------------------*/
void setup()
{
  frameRate(60);
  //size(1200, 800, P3D);
  size(1200, 800);
  img = loadImage("noise.png");
  strokeWeight(2);
  ObjP = new Proj[countP];
  ObjB = new Bot[countB];
  String hash = str(countP) + str(countB);
  int hash2 = int(hash);
  Lnk = new Link[hash2+1];
  for (int i = 0; i <= hash2; i++)
  {
    Lnk[i] = new Link(0, 0, false);
  }
  for (int j=0; j<countP; j++)
  {
    ObjP[j] = new Proj(j);
  }
  for (int j=0; j<countB; j++)
  {
    ObjB[j] = new Bot(j);    
  } 
}

void draw()
{
  background(255);
  img.loadPixels();
  for (int j = 0; j<height/img.height+1; j++)
  {
    for (int i = 0; i<width/img.width+1; i++)
    {
      image(img, i*img.width, j*img.height);
    }
  }
  //camera(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
  for (int i = 0; i < countP; i++)
  {
    ObjP[i].dra();
    ObjP[i].mov();
    ObjP[i].inf();
  }
  for (int i = 0; i < countB; i++)
  {
    ObjB[i].dra();
    ObjB[i].mov();
    ObjB[i].inf();
    ObjB[i].tim();
  }
  String hash = str(countP) + str(countB);
  int hash2 = int(hash);
  for (int i = 0; i <= hash2; i++)
  {
    if (Lnk[i].act != false)
    {
      Lnk[i].dra();
    }
  }
}

