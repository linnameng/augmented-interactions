// Mappings of various key codes that we need
//
String currentMode = "";
String mode1 = "1 - only keyboard";
String mode2 = "2 - only mouse";
String mode3 = "3 - mouse and keyboard";

int leftArrow = 37;
int rightArrow = 39;
int upArrow = 38;
int downArrow = 40;
int f1 = 112;
int f2 = 113;
int f3 = 114;
int w = 87;
int s = 83;
int a = 65;
int d = 68;
int keyOne = 49;
int keyTwo = 50;
int ctrl = 17;
int space = 32; 
int sevenKey = 55;
int eightKey = 56;
int nineKey = 57;
int zeroKey = 48;
int backspaceKey = 8;

boolean enableMouse = false;
int equalKey = 187;
int minusKey = 189;

String scrollUp = "scrolledUp";
String scrollDown = "scrolledDown";
String drag = "dragged";
String leftClick = "clicked";
String leftClickRelease = "releaseClick";
String pressed = "pressed";

// selectors for scheme type (keyboard, mouse, keyboard/mouse). By default we set scheme1 when the code runs.
boolean scheme1 = true;
boolean scheme2 = false;
boolean scheme3 = false;

// This Map tells what manipulation the user is currently doing. Key press events are different instances, so won't perform 2 functions at the same time. So we need to maintain a structure with multiple transformation states
HashMap<String, Boolean> keysActive;
void initializeControls() {
  keysActive = new HashMap<String, Boolean>();
  keysActive.put("moveLeft", false);
  keysActive.put("moveRight", false);
  keysActive.put("moveUp", false);
  keysActive.put("moveDown", false);
  keysActive.put("rotateLeft", false);
  keysActive.put("rotateRight", false);
  keysActive.put("rotateLeftByScroll", false);
  keysActive.put("rotateRightByScroll", false);
  keysActive.put("transparencyUp", false);
  keysActive.put("transparencyUpByScroll", false);
  keysActive.put("transparencyDownByScroll", false);
  keysActive.put("transparencyDown", false);
  keysActive.put("dragMove", false);
  currentMode = mode1;

  b1.isSelected = true;
  b2.isSelected = false;
}

// ALL functions for scheme 1
// To set the different transformations that need to be done when the next frame is drawn
void scheme1SetKey(int keyCode) {
  if(keyCode == leftArrow) {
    keysActive.put("rotateLeft", true);
  } 
  if(keyCode == rightArrow) {
   keysActive.put("rotateRight", true);
  }
  if (keyCode ==  w) {
   keysActive.put("moveUp", true);
  }
  if (keyCode ==  s) {
   keysActive.put("moveDown", true);
  }
  if (keyCode ==  a) {
   keysActive.put("moveLeft", true); 
  }
  if (keyCode ==  d) {
   keysActive.put("moveRight", true);  
  }
  if (keyCode == keyOne) {
   b1.isSelected = true;
   b2.isSelected = false;
  }
  if (keyCode == keyTwo) {
   b2.isSelected = true;
   b1.isSelected = false;
  }
  if (keyCode == space) {
   keysActive.put("transparencyUp", true);  
  }
  if (keyCode == ctrl) {
   keysActive.put("transparencyDown", true);  
  }
}

// To tell the system that the current manipulation has been stopped, (Example -  to stop rotating when the key is released )
// This release key function is needed to make 2 actions happen at the same time. Without it, only one is happening at a time
void  scheme1ReleaseKey(int keyCode)
{
  if(keyCode == leftArrow) {
    keysActive.put("rotateLeft", false);
  } 
  if(keyCode == rightArrow) {
   keysActive.put("rotateRight", false);
  }
  if (keyCode ==  w) {
   keysActive.put("moveUp", false);
  }
  if (keyCode ==  s) {
   keysActive.put("moveDown", false);
  }
  if (keyCode ==  a) {
   keysActive.put("moveLeft", false); 
  }
  if (keyCode ==  d) {
   keysActive.put("moveRight", false);  
  }
  if (keyCode == space) {
   keysActive.put("transparencyUp", false);  
  }
  if (keyCode == ctrl) {
   keysActive.put("transparencyDown", false);  
  }
}


void scheme2Manipulation (String transformation) {
  if (transformation.equalsIgnoreCase(leftClick) ) {
    if (b2.mouseInside) {
      b2.isSelected = true;
      b1.isSelected = false;
      } else if (b1.mouseInside) {
        b1.isSelected = true;
        b2.isSelected = false;
      } 
  }
  
  if (transformation.equalsIgnoreCase(pressed)) {
    // if the user presses the left mouse button outside either box, update transparency
    if(!b2.mouseInside && !b1.mouseInside && mouseButton == CENTER) {
      keysActive.put("transparencyUp", true);
    }
    if(mouseButton == RIGHT) {
      currentBox().colorSwapUp();
    } 
  }

  if (transformation.equalsIgnoreCase(drag)) {
     if (b2.mouseInside) {
       // IF WE ARE DRAGGING B1 INSIDE B2
       if( (b1.isSelected) && !(b1.mouseInside) ) {
         b2.isSelected = true;
         b1.isSelected = false;
       }
       keysActive.put("dragMove", true);
     } else if (b1.mouseInside) {
       b1.isSelected = true;
       b2.isSelected = false;
       keysActive.put("dragMove", true);
     }
  }

  // stop dragging box with mouse
  if (transformation.equalsIgnoreCase (leftClickRelease)) {
      if (mouseButton == LEFT)
      {
        keysActive.put("dragMove", false);
      }
      if (mouseButton == CENTER)
      {
        keysActive.put("transparencyUp", false);
      }
  }
  
  if (transformation.equalsIgnoreCase (scrollUp)) {
    keysActive.put("rotateRightByScroll", false);
    keysActive.put("rotateLeftByScroll", true);  
  }
  
  if (transformation.equalsIgnoreCase (scrollDown)) {
    keysActive.put("rotateLeftByScroll", false);
    keysActive.put("rotateRightByScroll", true);
  }
}


void scheme3SetKey(int keyCode) {
  if (keyCode == backspaceKey) {
    if (b2.isSelected)
    {
     b1.isSelected = false;
     b2.isSelected = false;
    }
    else if (b1.isSelected)
    {
      b1.isSelected = false;
      b2.isSelected = true;
    }
    else
    {
      b1.isSelected = true;
      b2.isSelected = false;
    }
  }
}

void scheme3ReleaseKey(int keyCode) {}

void scheme3Manipulation (String transformation) {
  if (transformation.equalsIgnoreCase (scrollUp)) {
    keysActive.put("transparencyUpByScroll", true);
    keysActive.put("transparencyDownByScroll", false);
  }
  
  if (transformation.equalsIgnoreCase (scrollDown)) {
    keysActive.put("transparencyDownByScroll", true);
    keysActive.put("transparencyUpByScroll", false);
  }
 
   if (transformation.equalsIgnoreCase (leftClickRelease)) {
   
     if(mouseButton == RIGHT) {
      keysActive.put("rotateRight", false);
     }
     if(mouseButton == LEFT) {
      keysActive.put("rotateLeft", false);
     }
    }
    
   if (transformation.equalsIgnoreCase(pressed)) {
     if(mouseButton == RIGHT) {
      keysActive.put("rotateRight", true);
     }
     if(mouseButton == LEFT) {
      keysActive.put("rotateLeft", true);
     }
   }
}