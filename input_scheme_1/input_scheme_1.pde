Box b1, b2;
int leftArrow = 37;
int rightArrow = 39;

void setup() {
  size(400, 400);
  b1 = new Box(75, 100, 100, 100);
  b1.degrees = 0;
  
  b2 = new Box(225, 100, 100, 100);
  b2.degrees = 0;
}

void draw() {
  background(255);
  //b1.checkForHit(mouseX, mouseY); 
  b1.drawBox();
  b2.drawBox();
}

void keyPressed() {
  if(keyCode == leftArrow) {
    b1.degrees = b1.degrees + 3;
    b2.degrees = b2.degrees + 3;
  } 
  
  if(keyCode == rightArrow) {
    b1.degrees = b1.degrees - 3;
    b2.degrees = b2.degrees - 3;
  }
}