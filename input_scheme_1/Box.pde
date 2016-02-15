import java.awt.geom.*;

class Box {
  float x, y, w, h;
  float cx, cy;
  int degrees;
  int size;
  color fillColor;

  AffineTransform aff;
  double[] checkPoint;
  float ox, oy;

  public Box(float newX, float newY, float newW, float newH) { 
    x = 0 - newW/2;
    y = 0 - newH/2;
    w = newW;
    h = newH;
    cx = newX + w/2;
    cy = newY + h/2; 
    degrees = 0;
    size = 1;
    fillColor = color(0,0,255);

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
}

