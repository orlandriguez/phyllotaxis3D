size(600, 800);
background(255);
stroke (81,169,64);

// INPUT PARAMETERS
float beta = radians(39.f);          // Parastichy Slope
float gamma = radians(132.f);         // Transversal floral slope
int development = 1;                 // Type P parastichy development: Counter clockwise: 1 ; clockwise = -1 
int parastichyType =2;               // For Beta<90 & 90<Gamma<180: 0 = 1P; 1 = 2P; 2 = 3P; 3 = 4P; 
                                     // For 90<Beta<180 & Gamma<90: 4 = 1S; 5 = 2S; 6 = 3S 
//  CONSTANTS
float gold = development * radians(137.50776405f);
float[] hztlIntercenterAngle  = {2.399963f, 0.916704f, 0.350150f, 0.133745f, -1.48325885f, -0.566554f, -0.216405f}; //  in Radians
int[] secondFlower = {1, 3, 8, 21, 2, 5, 13};    // second Embrionary flower unit. 0 = first flower

// VARIABLE DECLARATION
float horizontalInterCenter;          //  X distance between adjacent floral centers
float verticalInterCenter;            //  Y distance between adjacent floral centers
float distanceInterCenter;            //  Distance between floral centers
float embrionaryElevation;            //  Embrionary Y distance
float parastichyHeight;               //  Parastichy height (mm) (altura envolvente/botones(2PI))

// CALCULUS OF VARIABLES
horizontalInterCenter = development * hztlIntercenterAngle[parastichyType];
verticalInterCenter   = horizontalInterCenter*tan(beta); 
distanceInterCenter = verticalInterCenter/sin(beta);    
embrionaryElevation = verticalInterCenter/(secondFlower[parastichyType]);
parastichyHeight = abs(2*PI/hztlIntercenterAngle[parastichyType] * embrionaryElevation); 

// REFERENCE TO ZERO INTER-VERTEX RELATIVE DISTANCES 
float x1 = parastichyHeight /(tan(gamma)-tan(beta));  
float y1 = x1*tan(gamma);
float x2 = x1 + distanceInterCenter*cos(beta);          
float y2 = y1 + distanceInterCenter*sin(beta);
float x3 = horizontalInterCenter;
float y3 = verticalInterCenter;
println("Horizontal deformation angle : ", degrees(atan(x2/y2)));
println("Vertical  deformation angle : ", degrees(atan((y3-y1)/(x3-x1))));
//GRAPHIC GENERATION
float pixelFactor = width/(2*PI);      // Conversion factor to pixels
float x0 = 0;                          // Flower Po(x) inicialization
float y0 = height;                     // Flower Po(y) inicialization
int count = 0;
PFont f;
f = createFont("Arial",7); 
while(y0 >= 0){  
  textFont(f);
  fill(0);
  if (development == 1 && x0 > 2*PI){
    x0 = x0 - 2 * PI;                 
  }
  else if (development == -1 && x0 < 0){
    x0 = x0 + 2 * PI;                  
  }   
  // VERTEX SCALING AND CENTERING
  float px0 = width/2 - cos(x0) * pixelFactor;     
  float py0 = y0;
  float px1 = width/2 -cos(x0 + x1)*pixelFactor;  
  float px2 = width/2 -cos(x0 + x2)*pixelFactor;  
  float px3 = width/2 -cos(x0 + x3)*pixelFactor;
  float py1 = y0 - y1*pixelFactor;
  float py2 = y0 - y2*pixelFactor;
  float py3 = y0 - y3*pixelFactor;
  if (x0 < PI){      
    text(count, px0, y0-(parastichyHeight/2)*pixelFactor);
    line(px0, py0, px1, py1);
    line(px1, py1,  px2, py2);
    line(px2,py2, px3, py3);
    line(px3,py3, px0, py0); 
  }
//  (x0, y0)  INCREMENTAL FUNCTIONS
  count = count + 1;
  x0 = x0 + gold;
  y0 = y0 - embrionaryElevation* pixelFactor; 
}
//save("crassisimum.tif");
