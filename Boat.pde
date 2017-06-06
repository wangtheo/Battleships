/*Boat Object
Parameters: 
- x, y (top left corner) 
- rectLength (length of boat) 
- rotated (whether its horizontal or vertical). Default position is horizontal.
- list (the cells that are occupied by the boat)
- hide (whether the boats are "hidden" or not)
Methods:
- select() lets you "select" a boat by clicking on it. Selecting a boat allows you to use 
  other methods. You may not select a boat if they are "locked".
- rotateBoat() controls the orientation (rotated parameter) of the boat using the 'r' key.
- display() shows the boat on a screen. Colour is translucent red so you can see the
  cells underneath the boat. If the boat is selected, the outline is black. 
- findCells() determines which cells (list parameter) are occupied by the boat.
- move() controls the position of the boat (x, y parameter) by dragging it. It makes sure 
  that the boat is always aligned with the cells and that the boat is always within the
  board.
*/

class Boat{
  int x,y;
  int rectLength;
  int rotated;
  Cell[] list;
  boolean hide;
  Boat(int tempX, int tempY, int tempW, boolean tempH){
    x = tempX;
    y = tempY;
    rectLength = tempW;
    rotated = 0; 
    hide = tempH;
    list = new Cell[rectLength];
  }
  boolean select (int mx, int my, boolean lockBoats){
   boolean selected = false;
   if (lockBoats){
     return false;
   }
   if(rotated == 0){
     if (mx > x && mx < x + rectLength*width/cols && my > y && my < y +  (height-200)/rows) {
        selected = true;
      }
   } else {
     if (mx > x && mx < x + width/cols && my > y && my < y + rectLength*(height-200)/rows) {
       selected = true;
     }
   }
   return selected;
  }
  void rotateBoat (char a, boolean selected){
    if (selected && y+rectLength*((height-200)/rows) <= 600 && x+rectLength*(width/cols) <= 600){
      if (a == 'r' || a == 'R'){
        if (rotated == 0){
          rotated = 1;
        } else {
          rotated = 0;
        }
      }
    }
  }
  void display(boolean selected){
    if (selected){
      stroke(0);
    } else {
      stroke(255);
    }
    fill(255,0,0,63);
    if (!hide){
      if (rotated%2 == 0){
       rect(x, y, rectLength*(width/cols), (height-200)/rows);
      } else {
       rect(x, y, width/cols, rectLength*((height-200)/rows));
      }
    }
  }
  void findCells(Cell[][] c){
    int a = 0;
    for (int i = 0; i < 21; i++){
      for (int j = 0; j< 10; j++){
        if (rotated%2 == 0){
          if (c[i][j].x >= x && c[i][j].x < x+rectLength*(width/cols) && c[i][j].y >= y && c[i][j].y < y +(height-200)/rows){
            list[a] = c[i][j];
            a++;
            System.out.println(i+" "+j);
          }
        } else {
          if (c[i][j].x >= x && c[i][j].x < x+(width/cols) && c[i][j].y >= y && c[i][j].y < y+rectLength*((height-200)/rows)){
            list[a] = c[i][j];
            a++;
            System.out.println(i+" "+j);
          }
        }
      }
    }     
  }
  void setState(boolean lockBoats){
    if (lockBoats){
      for (int i = 0; i<rectLength; i++){
        if (list[i].state == 0){
          list[i].state = 1;
        }
      }
    }
  }
  void randomPlace(){
    rotated = (int)random(2);
    if (rotated == 0){
      x = 660+60*(int)random(11-rectLength);
      y = 60*(int)random(10);
    } else {
      x = 660+60*(int)random(10);
      y = 60*(int)random(11-rectLength);
    }
  }
  boolean sunk(){
    boolean boatSunk = true;
    for (int i = 0; i<rectLength; i++){ 
      if (list[i].state != 3){
        boatSunk = false;
      }
    }
    return boatSunk;
  }
  void move(int mx, int my, Cell[][] c, boolean selected){
    if (selected){
      for (int i = 0; i < 10; i++){
        for (int j = 0; j < 10; j++){
          if (mx>c[i][j].x && mx<c[i][j].x+c[i][j].w && my>c[i][j].y && my<c[i][j].y+c[i][j].h && i+(1-rotated)*rectLength<=10 && j+rotated*rectLength<=10){
            x = c[i][j].x;
            y = c[i][j].y;
          } 
        }
      }
    }
  }
}