/* The board
- "Ocean" consists of 200 cells
- Boats are: tugboat (2 cells), freighter (3 cells), submarine (4 cells) and destroyer (5 cells)
- Before the boats are locked, they may be moved around or rotated. 
- Boats are locked in place when the spacebar is pressed. 
- After the boats are locked, the cells under them are set to state = 1
*/
Cell[][] board1; 
String msg;

Boat tug = new Boat (0, 0, 2, false);
boolean tugSelected;
Boat freighter = new Boat (0, 60, 3, false);
boolean freighterSelected;
Boat sub = new Boat(0, 120, 4, false);
boolean subSelected;
Boat destroyer = new Boat (0, 180, 5, false);
boolean destroyerSelected;
int cols = 21;  
int rows = 10;  

boolean lockBoats;

void setup() {   
  size(1260, 600);
  int w = width / cols;
  int h = height / rows;
  board1 = new Cell[cols][rows];
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
        board1[i][j] = new Cell(i * w, j * h, w, h);
    }
  }
  textSize(24);
  msg = "Click the ships in the upper-lefthand corner to select them. \n Drag a selected ship to move it. Press r to rotate it. Press space when done.";
 /* for (int j = 0; j < rows; j++) {
      board1[10][j] =  stroke(0);
      board1[10][j] =  fill(0);
  }
  */
}   

void draw() {  
  tug.findCells(board1);
  freighter.findCells(board1);
  sub.findCells(board1);
  destroyer.findCells(board1);
  background(255);  
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      if(i==10){
      board1[i][j].display2();
      }
      else{
      board1[i][j].display();
      }
    } 
  }
  textAlign(CENTER, CENTER);
  fill(0, 255, 0);
  text(msg, width/2, 560);
  tug.display(tugSelected);
  freighter.display(freighterSelected);
  sub.display(subSelected);
  destroyer.display(destroyerSelected);
  if (lockBoats){
     for (int i = 0; i<tug.rectLength; i++){
       tug.list[i].state = 1;
     }
     for (int i = 0; i<freighter.rectLength; i++){
       freighter.list[i].state = 1;
     }
     for (int i = 0; i<sub.rectLength; i++){
       sub.list[i].state = 1;
     }
     for (int i = 0; i<destroyer.rectLength; i++){
       destroyer.list[i].state = 1;
     }
  }
}   

void mousePressed() {   
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      board1[i][j].click(mouseX, mouseY);
    }
  }
  tugSelected = tug.select(mouseX, mouseY, lockBoats);
  subSelected = sub.select(mouseX, mouseY, lockBoats);
  freighterSelected = freighter.select(mouseX, mouseY, lockBoats);
  destroyerSelected = destroyer.select(mouseX, mouseY, lockBoats);
  
} 
void mouseDragged(){
  tug.move(mouseX, mouseY, board1, tugSelected);
  sub.move(mouseX, mouseY, board1, subSelected);
  freighter.move(mouseX, mouseY, board1, freighterSelected);
  destroyer.move(mouseX, mouseY, board1, destroyerSelected);
}

void keyPressed(){
  tug.rotateBoat(key, tugSelected);
  sub.rotateBoat(key, subSelected);
  freighter.rotateBoat(key, freighterSelected);
  destroyer.rotateBoat(key, destroyerSelected);
  if (keyPressed == true && key == ' '){
    lockBoats = true;
  }
}