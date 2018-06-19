float boxSize = 100;
float boxX, boxY;

void setup(){
  size(640,480);
  boxX = width/2 - boxSize / 2;
  boxY = height/2 - boxSize / 2;
  //rectMode(RADIUS);
}
void draw() {
  background(255);
  fill(0);
  //ellipse(mouseX, mouseY, 20,20);
  //draw center box
  drawRect(int(boxX), int(boxY), int(boxSize), int(boxSize));
/*
  drawQuad(new PVector[] {
    new PVector(boxX-boxSize,boxY-boxSize),
    new PVector(boxX+boxSize,boxY-boxSize),
    new PVector(boxX+boxSize,boxY+boxSize),
    new PVector(boxX-boxSize,boxY+boxSize)}
  );
  //draw top
  drawQuad(new PVector[] {
    new PVector(0,0),
    new PVector(width,0),
    new PVector(width/2+boxSize, height/2-boxSize),
    new PVector(width/2-boxSize, height/2-boxSize)}
  );
  //draw bottom
  drawQuad(new PVector[] {
    new PVector(width,height),
    new PVector(0,height),
    new PVector(width/2-boxSize, height/2+boxSize),
    new PVector(width/2+boxSize, height/2+boxSize)}
  );
  //draw left
  drawQuad(new PVector[] {
    new PVector(0,0),
    new PVector(0,height),
    new PVector(width/2-boxSize, height/2+boxSize),
    new PVector(width/2-boxSize, height/2-boxSize)}
  );
  //draw right
  drawQuad(new PVector[] {
    new PVector(width,0),
    new PVector(width,height),
    new PVector(width/2+boxSize, height/2+boxSize),
    new PVector(width/2+boxSize, height/2-boxSize)}
  );
*/
}

// DRY - Don't Repeat Yourself!
// http://en.wikipedia.org/wiki/Don't_repeat_yourself
void drawRect(int x, int y, int w, int h) {
  if(containsPoint(x,y,w,h,mouseX,mouseY)) {
    fill(200,200);
  } else {
    noFill();
  }
  rect(x,y,w,h);
}

// DRY - Don't Repeat Yourself!
// http://en.wikipedia.org/wiki/Don't_repeat_yourself
void drawQuad(PVector[] vertices) {
  if(containsPoint(vertices,mouseX,mouseY)) {
    fill(200,200);
  } else {
    noFill();
  }
  beginShape();
  for(PVector v : vertices) {
    println("vert.x=" + v.x+"vert.y=" + v.y);
    vertex(v.x,v.y);
  }
  endShape(CLOSE);
}

// taken from:
// http://hg.postspectacular.com/toxiclibs/src/tip/src.core/toxi/geom/Polygon2D.java
boolean containsPoint(PVector[] verts, float px, float py) {
  int num = verts.length;
  int i, j = num - 1;
  boolean oddNodes = false;
  println("verts.length=" + verts.length);
  for (i = 0; i < num; i++) {
    PVector vi = verts[i];
    PVector vj = verts[j];
    println("i="+i+":vi.x=" + vi.x+"vi.y=" + vi.y);
    println("j="+j+":vj.x=" + vj.x+"vj.y=" + vj.y);
    if (vi.y < py && vj.y >= py || vj.y < py && vi.y >= py) {
      if (vi.x + (py - vi.y) / (vj.y - vi.y) * (vj.x - vi.x) < px) {
        oddNodes = !oddNodes;
      }
    }
    j = i;
  }
  return oddNodes;
}

// taken from:
// http://hg.postspectacular.com/toxiclibs/src/tip/src.core/toxi/geom/Polygon2D.java
boolean containsPoint(int x, int y, int w, int h, int px, int py) {
  println("x="+x+",y="+y+",w="+w+",h="+h+",px="+px+",py="+py);
  if (px >= x && py >= y && px <= x + w && py <= y +h) return true;
  return false;
}
