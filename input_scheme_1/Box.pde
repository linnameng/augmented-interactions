import java.awt.geom.*;

class Box {
  float x, y, w, h;
  float cx, cy;
  int degrees;
  int size;
  color fillColor;
  int borderWeight;

  AffineTransform aff;
  double[] checkPoint;
  float ox, oy;
  boolean isSelected = false;
  
  public Box(float newX, float newY, float newW, float newH) { 
    x = 0 - newW/2;
    y = 0 - newH/2;
    w = newW;
    h = newH;
    cx = newX + w/2;
    cy = newY + h/2; 
    degrees = 0;
    size = 1;
    fillColor = color(0,0,255, 255); // Added 4th parameter for adjusting transparency later, by default its 255  = 0 transparency
    borderWeight = 1;
    
    aff = new AffineTransform();
    checkPoint = new double[2];
  }

  void drawBox() {
    pushMatrix();
    //translate(200,200);
    translate(cx, cy);
    rotate(radians(degrees));
    scale(size);
    fill(fillColor);
    rect(x, y, w, h);
    if (!isSelected)
    {
      borderWeight = 5;
    }
    else
    {
      borderWeight = 1;
    }
    strokeWeight(borderWeight); //sets the thickness of the border
    popMatrix();
  }

  void checkForHit(float x, float y) {
    if (contains(x, y)) {
      fillColor = color(255,255,0);
    }
    else {
      fillColor = color(0,0,255);
    }
  }

  boolean contains(float px, float py) {
    aff.setToTranslation(cx, cy);
    aff.rotate(radians(degrees));
    aff.scale(size, size);
    // Store incoming coordinates in array for transforming
    checkPoint[0] = px; 
    checkPoint[1] = py;
    try {
      // Reverse the applied transformation to the coordinates 
      aff.inverseTransform(checkPoint, 0, checkPoint, 0, 1);
      ox = (float) checkPoint[0];
      oy = (float) checkPoint[1];
    } 
    catch (NoninvertibleTransformException e) {
      // Unable to invert point so not over shape
      return false;
    }
    // Is [ox,oy] over the un-transformed shape
    return (ox >= x && ox <= (y + w) && oy >= y && oy <= (y + h));
  }
  
  
  
  // This function dictates what changes need to be done on the properties of the box
  public void transformBox()
  {
    isSelected = true;
    
    if (keysActive.get("moveLeft") )
    {
         cx = cx - 2; 
    }
    if (keysActive.get("moveRight") )
    {
         cx = cx + 2; 
    }
    if (keysActive.get("moveUp") )
    {
         cy = cy - 2; 
    }
    if (keysActive.get("moveDown") )
    {
         cy = cy + 2; 
    }
    if (keysActive.get("rotateLeft") )
    {
         degrees = degrees - 3;
    }
     if (keysActive.get("rotateRight") )
    {
        degrees = degrees + 3;
    }
  }
  
  
  
}