import peasy.*;

int thetapart=50;
int alphapart=24;
int betapart=alphapart/2+1;

int zeropoint=(int)thetapart/4+1;
int totalpts=(thetapart)*(alphapart+1)*(betapart+1);

PVector phyperset[][][]=new PVector [thetapart][betapart+1][alphapart+1];

PeasyCam cam;

void initsphere (int r)
{
    int pts=0;
    float percent;
    for (int i=0;i<thetapart;i++)
    {
        float theta=map(i,0,thetapart,0,4*PI);
        for (int j=0;j<=betapart;j++)
        {
            for (int k=0;k<=alphapart;k++)
            {
                float r_theta=r*sin(theta/2);
                float alpha=map(k,0,alphapart,0,2*PI);
                float beta=map(j,0,betapart,0,PI);
                float x,y,z;
                x=r_theta*cos(alpha)*sin(beta);
                y=r_theta*sin(alpha)*sin(beta);
                z=r_theta*cos(beta);
                phyperset[i][j][k]=new PVector(x,y,z);
                pts++;
                percent=map(pts,0,totalpts,0,100);
                print(percent,"% COMPLETE\n");
                vertex(p.x,p.y,p.z);
            }
        }
    }
}

PVector rotate (PVector p, float phi)
{
    float a [][]={{cos(phi),-sin(phi),0},{sin(phi),cos(phi),0},{0,0,1}};
    float b []={p.x,p.y,p.z};
    float rot [] = new float [3];
    for (int i=0;i<3;i++)
    {
        rot[i]=0;
        for (int j=0;j<3;j++)
        {
            a[i][j]=a[i][j]*b[j];
            rot[i]+=a[i][j];
        }
    }
    PVector r=new PVector(rot[0],rot[1],rot[2]);
    return r;
}

void setup ()
{
    size(800,600,P3D);
    colorMode(RGB);
    cam=new PeasyCam(this,500);
    background(255);
    initsphere(50);
}

void draw ()
{
    background(255);
    for (int i=0;i<thetapart;i++)
    {
        float theta=map(i,0,thetapart,0,4*PI);
        strokeWeight(3);
        stroke(255,0,0);
        if (i!=zeropoint)
        {
            for (int j=0;j<betapart;j++)
            {
                for (int k=0;k<=alphapart;k++)
                {
                    PVector p=phyperset[i][j][k];
                    if (cos(theta/2)<0)
                    {
                        strokeWeight(4);
                        stroke(0,0,255);
                        p=rotate(p,PI/8);
                        point(p.x,p.y,p.z);
                    }
                    else point(p.x,p.y,p.z);
                }
            }
        }
        else
        {
            for (int j=0;j<betapart;j++)
            {
                strokeWeight(1);
                stroke(0,255,0);
                noFill();
                beginShape(TRIANGLE_STRIP);
                for (int k=0;k<=alphapart;k++)
                {
                    PVector p=phyperset[i][j][k];
                    vertex(p.x,p.y,p.z);
                    p=phyperset[i][j+1][k];
                    vertex(p.x,p.y,p.z);
                }
                endShape();
            }
        }
    }
}
