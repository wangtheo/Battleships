/* A Cell object
state = 0: cell contains water
state = 1: cell contains boat
state = 2: water cell was fired at
state = 3: boat cell was fired at
*/
class Cell  {   
  int x,y;  
  int w,h;  
  int state;  

  // Cell Constructor  
  Cell(int tempX, int tempY, int tempW, int tempH)  {   
    x = tempX;
    y = tempY;
    w = tempW;
    h = tempH;
    state = 0; 
  }   
  void click(int mx, int my)  {   
    if (mx > x && mx < x + w && my > y && my < y + h) {
      
    }
    
  }   

  void display()  {   
    stroke(255);
    fill(48, 139, 206);
    rect(x,y,w,h);
    
    int b = 8;
    
    if (state == 0) {
      fill(48, 139, 206);
      rect(x,y,w,h);
    } else if (state == 1) {
      ellipse(x+w/2,y+h/2,w-b,h-b);
    } else if (state == 2) {
      fill(0, 9, 206);
      rect(x,y,w,h);
    }
  }
    void display2(){   
    stroke(0);
    fill(0);
    rect(x,y,w,h);
    
    int b = 8;
    
    if (state == 0) {
      // nothing
    } else if (state == 1) {
      // Draw an O
      ellipse(x+w/2,y+h/2,w-b,h-b);
    } else if (state == 2) {
      // Draw an X
      line(x+b,y+b,x+w-b,y+h-b);
      line(x+w-b,y+b,x+b,y+h-b); 
    }
  }


}   