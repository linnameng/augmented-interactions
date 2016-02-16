Box b1, b2;
String scheme2ManipulationType = "";

void setup() {
  size(400, 400);
  
  b1 = new Box(75, 100, 100, 100);
  b1.degrees = 0;
  
  b2 = new Box(225, 100, 100, 100);
  b2.degrees = 0;
    
  initializeControls();

}

void draw() {
  background(255);
   if (scheme2 || scheme3)
   {
       enableMouse = true;
       b1.mouseHandles();
       b2.mouseHandles();
   }
   if(b1.isSelected) {
      b1.transformBox();  
   }
    b1.drawBox();

  if (b2.isSelected) {
     b2.transformBox();  
  }
  b2.drawBox();

}

void keyPressed() {
  // see if there is a scheme change
  if (keyCode == f1) {
     initializeControls();
     scheme1 = true;
     scheme2 = false;
     scheme3 = false;
  }
  
  if (keyCode == f2) {
     initializeControls();
     scheme1 = false;
     scheme2 = true;
     scheme3 = false;
  }
  
  if (keyCode == f3) {
     initializeControls();
     scheme1 = false;
     scheme2 = false;
     scheme3 = true;
  }
  
  // when any key is pressed, it runs changes for the currently selected scheme
  if (scheme1) {
    scheme1SetKey(keyCode);
    if(keyCode == upArrow) {
      currentBox().colorSwapUp();
    }
    if(keyCode == downArrow) {
      currentBox().colorSwapDown();
    }
  } 
    else if(scheme3) {
    scheme3SetKey(keyCode);
  }
  
}

// when any key is released, it tries to stop doing the changes for that selected scheme
void keyReleased() {
  if (scheme1) {
    scheme1ReleaseKey(keyCode);
  } 
  else if(scheme3){
    scheme3ReleaseKey(keyCode);
  }
}

//returns the box that is currently active
Box currentBox() {
  if(b1.isSelected) {
    return b1;
  } else {
    return b2;
  }
}

void mouseClicked()
{
  if (scheme2 || scheme3) // since for both scheme 2 and 3, clicking is our selection
  {
    scheme2ManipulationType = leftClick;
    scheme2Manipulation(scheme2ManipulationType);
  }
}

void mouseDragged()
{
  if (scheme2)
  {
    scheme2ManipulationType = drag;
    scheme2Manipulation(scheme2ManipulationType);
  }
}

void mouseWheel(MouseEvent event) 
{
  if (scheme2)
  {
    float e = event.getCount();
    if (e > 0)
    {
      scheme2ManipulationType = scrollUp;
    }
    if (e < 0)
    {
      scheme2ManipulationType = scrollDown;
    }
    scheme2Manipulation(scheme2ManipulationType);
  }
}

void mouseReleased()
{
      scheme2ManipulationType = leftClickRelease;
      scheme2Manipulation(scheme2ManipulationType);
}