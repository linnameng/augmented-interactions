Box b1, b2;
int keyOne = 50;
int keyTwo = 49;
int keyLeftArrow = 37;
int keyRightArrow = 39;
int activeBox = 1; //a variable to keep track of which box is currently selected
boolean inputScheme1 = true; //set the default input scheme to keyboard
boolean inputScheme2 = false;
boolean inputScheme3 = false;

void setup() {
  size(400, 400);
  b1 = new Box(75, 100, 100, 100);
  b1.degrees = 0;
  
  b2 = new Box(225, 100, 100, 100);
  b2.degrees = 0;
}

void draw() {
  background(255);
  b1.checkForHit(mouseX, mouseY); 
  b1.drawBox();
  b2.drawBox();
}

void keyPressed() {
  //use this line to check key codes (remove later)
  println("pressed " + int(key) + " " + keyCode);
  
  if(inputScheme1) {
    
     //set selection state
    if(keyCode == keyOne) {
      b1.borderWeight = 5;
      b2.borderWeight = 1;
      activeBox = 1;
    } else if (keyCode == keyTwo) {
      b2.borderWeight = 5;
      b1.borderWeight = 1;
      activeBox = 2;
    }
    
    //rotation
    if(keyCode == keyLeftArrow) {
      b1.degrees = b1.degrees + 3;
      b2.degrees = b2.degrees + 3;
    } 
    
    if(keyCode == keyRightArrow) {
      b1.degrees = b1.degrees - 3;
      b2.degrees = b2.degrees - 3;
    }
  }
  
  else if(inputScheme2) {
  }
  
  else if(inputScheme3) {
    
  }

}