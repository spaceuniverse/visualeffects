/*------------------------------------------------------------------------*/
Circl[] CO;
Tap[] TP;
int count = 1000;
int nom = 0;
int nom2 = 0;
int nx = 0;
int ny = 0;
PImage img;
/*------------------------------------------------------------------------*/
class Circl
{  
  float xpos;
  float ypos;
  float dia;
  float opa;
  float rc, gc, bc;
  int number;
  int act;
  Circl(int num, int x, int y)
  {
    number = num;
    act = 0;
    xpos = x;
    ypos = y;
    dia = 10;
    opa = 60;
    rc = random(10,245);
    gc = random(10,245);
    bc = random(10,245);
  }
  void dra()
  {
    stroke(rc, gc, bc, opa/1.1);
    fill(rc, gc, bc, opa/1.1);
    ellipse(xpos, ypos, dia, dia);
    noStroke();
    fill(rc, gc, bc, opa/3);
    ellipse(xpos, ypos, dia+10, dia+10);
  }
  void mov()
  {
    act = 1;
    dia = dia + 1.5;
    
    if (dia > 20)
    {
      act = 0;
    }
  }
  void men()
  {
    if (dia > 10)
    {
      dia = dia - 0.5;
    }
    else
    {
      act = 2;
    }
  }
}
/*------------------------------------------------------------------------*/
class Tap
{
  float xpos;
  float ypos;
  float dia;
  float vdia;
  int number;
  boolean live; 
  Tap(int num)
  {
    xpos = mouseX;
    ypos = mouseY;
    dia = 0;
    vdia = 0;
    number = num;
    live = true;
  }
  void liv()
  {
    noFill();
    stroke(0, 0, 0, 1);
    //noStroke();
    ellipse(xpos, ypos, dia, dia);
    dia = dia + 5;
    if (dia > 60)
    {
      vdia = dia - 60;
    }
  }
  void chk()
  {
    for (int i = 0 ; i < 494; i++)
    {
      if ( (sq(CO[i].xpos - xpos) + sq(CO[i].ypos - ypos) < sq(dia/2)) && (sq(CO[i].xpos - xpos) + sq(CO[i].ypos - ypos) > sq(vdia/2)) && (live == true) ) 
      {
        CO[i].mov();
      }
      else if ( (sq(CO[i].xpos - xpos) + sq(CO[i].ypos - ypos) < sq(vdia/2)) && (CO[i].act != 1) && (CO[i].act != 2) && (live == true) )
      {
        CO[i].men();
      }
    }
  } 
  void die()
  {
    if ( dia/2 > sqrt(width*width+height*height)+50 )
    {
      live = false;
    }
  }
}
/*------------------------------------------------------------------------*/
void mousePressed()
{
  TP[nom2] = new Tap(nom2);
  nom2++;
}
/*------------------------------------------------------------------------*/
void setup()
{
  frameRate(60);
  size(800, 600);
  img = loadImage("noise.png"); 
  CO = new Circl[count];
  TP = new Tap[count];
  for (int i = 0; i < height; i++)
  {
    if (i-ny > 30)
    {
      ny = ny + 30;            
      for (int j = 0; j < width; j++)
      {
        if (j-nx > 30)
        {
          nx = nx + 30; 
          CO[nom] = new Circl(nom,j,i);
          nom++;
        }
      }
      nx = 0;
    }
  }
}
/*------------------------------------------------------------------------*/
void draw()
{
  background(255);
  strokeWeight(2);
  for (int j = 0; j<height/img.height+1; j++)
  {
    for (int i = 0; i<width/img.width+1; i++)
    {
      image(img, i*img.width, j*img.height);
      tint(255, 126);
    }
  }
  for (int i = 0; i < nom; i++)
  {
    CO[i].dra();
  }
  for (int i = 0; i < nom2; i++)
  {
    TP[i].liv();
    TP[i].chk();
    TP[i].die();
  }
  stroke(0, 0, 0, 55);
  fill(0, 0, 0, 55);
  text(nom, width - 40, height - 20); 
  text(nom2, width - 100, height - 20); 
  text(CO.length, width - 160, height - 20); 
  text(TP.length, width - 220, height - 20); 
}
/*------------------------------------------------------------------------*/
