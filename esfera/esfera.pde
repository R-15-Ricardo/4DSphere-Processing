import peasy.*;

//0 solid mode. 1 frame mode. 2 mesh mode. -1 cloud mode 
int mode=0;
int slicenum=150;
int cutpts=slicenum/2+1;
PVector sphere[][]= new PVector [cutpts+1][slicenum+1];

void initiazlizesphere (int r, int it)
{
  int ptnum=0;
  float the;
  float phi;
  for (int i=0; i<=it/2+1; i++)
  {
    the=PI/(it/2)*i;
    for (int j=0;j<=it;j++)
    {
      phi=2*PI/it*j;
      float x,y,z;
      x=r*sin(the)*cos(phi);
      y=r*sin(the)*sin(phi);
      z=r*cos(the);
      sphere[i][j]=new PVector(x,y,z); 
      ptnum++;
      print((float)(ptnum*100/((slicenum+1)*(cutpts+1))),"% COMPLETE\n");
    }
  }
}

PeasyCam cam;

void setup() 
{
  size(800, 600, P3D);
  colorMode(RGB);
  cam = new PeasyCam(this, 500);
  background(20,0,0);
  initiazlizesphere(100,slicenum);
}

void draw ()
{
  background(255);
  if (keyPressed)
  {
    if (key=='1') mode=-1;
    else if (key=='2') mode=1;
    else if (key=='3') mode=2;
    else if (key=='4') mode=0;
  }
  if (mode==0)
  {
    lights();
    noStroke();
    fill(134, 176, 244);
    for (int i=0;i<cutpts;i++)
    {
      beginShape(TRIANGLE_STRIP);
      for (int j=0;j<=slicenum;j++)
      {
        PVector p=sphere[i][j];
        vertex(p.x,p.y,p.z);
        p=sphere[i+1][j];
        vertex(p.x,p.y,p.z);
      }
    endShape();
    }
  }
  else if (mode==1)
  {
    stroke(0);
    noFill();
    for (int j=0;j<slicenum;j++)
    {
      beginShape();
      for (int i=0;i<cutpts;i++)
      {
        PVector p=sphere[i][j];
        vertex(p.x,p.y,p.z);
      }
      endShape();
    }
    for (int i=0;i<cutpts;i++)
    {
      beginShape();
      for (int j=0;j<slicenum;j++)
      {
        PVector p=sphere[i][j];
        vertex(p.x,p.y,p.z);
      }
      PVector p=sphere[i][0];
      vertex(p.x,p.y,p.z);
    endShape();
    }
  }
  else if (mode==2)
  {
    stroke(0);
    noFill();
    for (int i=0;i<cutpts;i++)
    {
      beginShape(TRIANGLE_STRIP);
      for (int j=0;j<=slicenum;j++)
      {
        PVector p=sphere[i][j];
        vertex(p.x,p.y,p.z);
        p=sphere[i+1][j];
        vertex(p.x,p.y,p.z);
      }
      endShape();
    }
  }
  else if (mode==-1)
  {
    stroke(0);
    for (int i=0;i<cutpts;i++)
    {
      for (int j=0;j<slicenum;j++)
      {
        PVector p=sphere[i][j];
        point(p.x,p.y,p.z);
      }
    }
  }
}
