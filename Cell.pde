// A Cell object  
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
  public int  getH(){
    return h;
  }
  void click(int mx, int my)  {   
    if (mx > x && mx < x + w && my > y && my < y + h) {
      state = (state + 1) % 3; 
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
      fill(0, 139, 0);
      rect(x,y,w,h);
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