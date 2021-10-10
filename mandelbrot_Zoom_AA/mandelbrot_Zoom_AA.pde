float n = 100, aa = 1, min = -2.84, max = 1, f = 1;
// n -> fractional iteration count
// aa -> anti aliasing level. The higher, the slower the rendering process. Choose a multiple of 8
void setup() {
  // time taken to render each frame increases with increasing canvas size
  size(400, 400);
  background(0);
}
void draw() {
  background(0);
  float x = -width/2, y = -height/2, minc = 0;
  translate(width/2, height/2);
  while (y < height/2) {
    x = -width/2;
    while (x < width/2) {
      float zx = map(x, -width/2, width/2, min, max), zy = map(y, -height/2, height/2, min, max), tx, ty, cx = zx, cy = zy;
      float c = 0;
      while (c < n) {
        tx = zx*zx-zy*zy;
        ty = 2*zx*zy;
        zx = tx+cx;
        zy = ty+cy;
        if (sqrt(zx*zx+zy*zy) > 2)
          break;
        c++;
      }
      if (x-floor(x) == 0 && y-floor(y) == 0)
        minc = c;
      else if (c < minc)
        minc = c;
      if (x-floor(x) == (aa-1)/aa && y-floor(y) == (aa-1)/aa) {
        colorMode(RGB, 255);
        if (minc == 0)
          stroke(20, 0, 0);
        else if (n-minc < 1)
          stroke(0);
        else {
          colorMode(HSB, 1);
          stroke(color(minc/256, 1, minc/(minc+8)));
        }
        point(x, y);
      }
      if (x-floor(x) == (aa-1)/aa) {
        x-=(aa-1)/aa;
        y+=1/aa;
        if (y-floor(y) == 0) {
          x++;
          y--;
        }
      } else
        x+=1/aa;
    }
    y++;
  }
  max -= 0.1 * f;
  min += 0.15 * f;
  f *= 0.9349;
  n += 5;
  if (frameCount > 30)
    n *= 1.02;
  // uncomment this line if you want to save the frames rendered
  //save("Zoom/my"+frameCount+".png");
}
