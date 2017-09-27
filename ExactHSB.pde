float[] RGBtoHSB(float r, float g, float b) {
  float H, S, B, 
    max = max(r, g, b), 
    min = min(r, g, b);
  if (max == min)H = 0;
  else H = atan(sqrt(3)*(g-b)/(2*r-g-b))*57.2957;
  while(H < 0)H+=360;
  while(H >= 360)H-=360;
  if (max == b & 0 <= H & H <= 90)H+=180;
  if (max == g & 270 <= H & H <= 360)H-=180;

  S = max==0?0:256*(max-min)/max;
  B = max;
  return new float[]{H, S, B};
}

float[] HSBtoRGB(float H, float S, float B) {
  float 
    max = B, 
    min = int( max - max * S / 256), 
    r=-1, g=-1, b=-1, 
    tan = tan(H/57.2957), r3 = sqrt(3);

  if (0 <= H & H < 60) {
    r = max;
    b = min;
  } else if (60 <= H & H < 120) {
    b = min;
    g = max;
  } else if (120 <= H & H < 180) {
    g = max;
    r = min;
  } else if (180 <= H & H < 240) {
    r = min;
    b = max;
  } else if (240 <= H & H < 300) {
    b = max;
    g = min;
  } else if (300 <= H & H < 360) {
    g = min;
    r = max;
  }
  if (r == -1)r = (g-b)*r3/(2*tan)+(g+b)/2;
  if (g == -1)g = (b*r3-b*tan+2*r*tan)/(r3+tan);
  if (b == -1)b = (g*r3+g*tan-2*r*tan)/(r3-tan);
  return new float[]{r, g, b};
}

color HSBtoCOL(float H, float S, float B) {
  float[] hoge = HSBtoRGB(H, S, B);
  return color(hoge[0], hoge[1], hoge[2]);
}

float[] COLtoHSB(color hoge) {
  return RGBtoHSB(hoge>>16&0xFF, hoge>>8&0xFF, hoge&0xFF);
}
