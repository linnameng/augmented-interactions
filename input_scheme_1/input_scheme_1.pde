Box b1, b2;


void setup() {
  size(400, 400);
  initializeControls();
  
  b1 = new Box(75, 100, 100, 100);
  b1.degrees = 0;
  
  b2 = new Box(225, 100, 100, 100);
  b2.degrees = 0;
}

void draw() {
  background(255);
  //b1.checkForHit(mouseX, mouseY); 
  if(selectFirstSquare)
  {
      b1.transformBox();  
      b2.isSelected = false;
  }
  b1.drawBox();
  if (selectSecondSquare)
  {
      b2.transformBox();  
      b1.isSelected = false;
  }
  b2.drawBox();
}

void keyPressed() {
  if (keyCode == f1) // see if there is a scheme change
  {
     initializeControls();
     scheme1 = true;
     scheme2 = false;
     scheme3 = false;
  }
   if (keyCode == f2)
  {
     initializeControls();
     scheme1 = false;
     scheme2 = true;
     scheme3 = false;
  }
   if (keyCode == f3)
  {
     initializeControls();
     scheme1 = false;
     scheme2 = false;
     scheme3 = true;
  }
  
   if (scheme1) // when any key is pressed, it runs changes for the currently selected scheme
  {
    scheme1SetKey(keyCode);
  }
   else if (scheme2)
  {
    scheme2SetKey(keyCode);
  }
   else 
  {
    scheme3SetKey(keyCode);
  }
  
}

void keyReleased() // when any key is released, it tries to stop doing the changes for that selected scheme
{
   if (scheme1)
  {
    scheme1ReleaseKey(keyCode);
  }
   else if (scheme2)
  {
    scheme2ReleaseKey(keyCode);
  }
   else 
  {
    scheme3ReleaseKey(keyCode);
  }
}