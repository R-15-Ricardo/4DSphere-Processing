import peasy.*;

//0 solid mode. 1 frame mode. 2 mesh mode. -1 cloud mode 
int mode=0;
int nhplanes=50;
int slicenum=24;
int cutpts=slicenum/2+1;

P4Vector hsphere[][][]= new P4Vector [nhplanes][cutpts+1][slicenum+1];
PVector psphere[][][]= new PVector [nhplanes][cutpts+1][slicenum+1];

void initiazlizhesphere (int r,float pw)
{
  int npts=0;
  for (int i=0;i<nhplanes;i++)
  {
    float w=map(i,0,nhplanes-1,-r,r);
    float nr=sqrt(r*r-w*w);
    for (int j=0;j<=cutpts;j++)
    {
      float the=PI/(cutpts-1)*j;
      for (int k=0;k<=slicenum;k++)
      {
        float phi=2*PI/slicenum*k;
        float x,y,z;
        x=nr*sin(the)*cos(phi);
        y=nr*sin(the)*sin(phi);
        z=nr*cos(the);
        hsphere[i][j][k]=new P4Vector(x,y,z,w);
        npts++;
        print((float)npts*100/(2*nhplanes*(slicenum+1)*(cutpts+1)),"% COMPLETE\n");
      }
    }
  }
  for (int i=0;i<nhplanes;i++)
  {
    for (int j=0;j<=cutpts;j++)
    {
      for (int k=0;k<=slicenum;k++)
      {
        P4Vector p=hsphere[i][j][k]; 
        float x,y,z;
        x=(p.x*pw)/(pw-p.w);
        y=(p.y*pw)/(pw-p.w);
        z=(p.z*pw)/(pw-p.w);
        psphere[i][j][k]=new PVector(x,y,z);
        npts++;
        print((float)npts*100/(2*nhplanes*(slicenum+1)*(cutpts+1)),"% COMPLETE\n");
      }
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
  initiazlizhesphere(10,2.5);
}

void draw ()
{
  background(255);
  stroke(0);
  for (int i=0;i<nhplanes;i++)
  {
    stroke(0);
    noFill();
    for (int j=0;j<cutpts;j++)
    {
      beginShape(TRIANGLE_STRIP);
      for (int k=0;k<=slicenum;k++)
      {
        PVector p=psphere[i][j][k];
        vertex(p.x,p.y,p.z);
        p=psphere[i][j+1][k];
        vertex(p.x,p.y,p.z);
      }
      endShape();
    }
  }
}
