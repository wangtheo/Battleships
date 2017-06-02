/*Boat Object
Parameters: 
- x, y (top left corner) 
- rectLength (length of boat) 
- rotated (whether its horizontal or vertical). Default position is horizontal.

Methods:
- key() controls the size (rectLength) of the boat using key inputs
- click() controls the orientation (rotated) of the boat using mouseclicks.
- display() shows the boat on a screen. Colour is translucent red so you can see the
  cells underneath the boat.
- move() controls the position of the boat (x, y) using mouseclicks. It makes sure that
  the boat is always aligned with the cells.
*/
class Boat{
  int x,y;
  int rectLength;
  int rotated;
  Boat(int tempX, int tempY, int tempW){
    x = tempX;
    y = tempY;
    rectLength = tempW;
    rotated = 0; 
  }
  void key(){
    if (key == '1'){
      rectLength = 1;
    } if (key == '3'){
      rectLength = 3;
    } if (key == '5'){
      rectLength = 5;
    }
  }
  void click (int mx, int my){
   if(rotated%2 == 0){
     if (mx > x && mx < x + rectLength*width/cols && my > y && my < y +  height/rows) {
        rotated = (rotated + 1) % 2; 
      }
   } else {
     if (mx > x && mx < x + width/cols && my > y && my < y + rectLength*height/rows) {
       rotated = (rotated + 1) % 2;
     }
   }
  }
  void display(){
    stroke(255);
    fill(255,0,0,63);
    if (rotated == 0){
     rect(x, y, rectLength*(width/cols), height/rows);
    } else {
     rect(x, y, width/cols, rectLength*(height/rows));
    }
  }
  void move(int mx, int my, Cell i){
    if (mx>i.x && mx<i.x+i.w && my>i.y && my<i.y+i.h){
      x = i.x;
      y = i.y;
    }
  }
}