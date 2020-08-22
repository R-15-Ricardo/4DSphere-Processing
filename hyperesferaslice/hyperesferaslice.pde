import peasy.*;

int gr=100;
float gw=-gr;
float off=1;
int slicenum=24;
int cutpts=slicenum/2+1;

PVector hsphere[][]= new PVector [cutpts+1][slicenum+1];

void initiazlizhesphere (int r,float w)
{
  int npts=0;
  float nr=sqrt(r*r-w*w);
  for (int i=0;i<=cutpts;i++)
  {
    float the=PI/(cutpts-1)*i;
    for (int j=0;j<=slicenum;j++)
    {
      float phi=2*PI/slicenum*j;
      float x,y,z;
      x=nr*sin(the)*cos(phi);
      y=nr*sin(the)*sin(phi);
      z=nr*cos(the);
      hsphere[i][j]=new PVector(x,y,z);
      npts++;
      print((float)npts*100/((slicenum+1)*(cutpts+1)),"% COMPLETE\n");
    }
  }
}

PeasyCam cam;

void setup() 
{
  size(800, 600, P3D);
  colorMode(RGB);
  cam = new PeasyCam(this, 500);
  background(255);
}

void draw ()
{
  gw=gw+off;
  if (gw==gr)
  {
    gw=-gr;
  }
  initiazlizhesphere(gr,gw);
  background(255);
  stroke(0);
  noFill();
  for (int i=0;i<cutpts;i++)
  {
    beginShape(TRIANGLE_STRIP);
    for (int j=0;j<=slicenum;j++)
    {
      PVector p=hsphere[i][j];
      vertex(p.x,p.y,p.z);
      p=hsphere[i+1][j];
      vertex(p.x,p.y,p.z);
    }
    endShape();
  }
}
