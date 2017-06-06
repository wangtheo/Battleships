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
Boat tug2 = new Boat (660, 0, 2, true);
Boat freighter2 = new Boat (660, 60, 3, true);
Boat sub2 = new Boat(660, 120, 4, true);
Boat destroyer2 = new Boat (660, 180, 5, true);
int cols = 21;  
int rows = 10;  

boolean lockBoats;
boolean playerWins;
boolean gameOver;

void setup() {   
  size(1260, 800);
  int w = width / cols;
  int h = (height-200) / rows;
  board1 = new Cell[cols][rows];
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
        board1[i][j] = new Cell(i * w, j * h, w, h);
    }
  }
  textSize(24);
 /* for (int j = 0; j < rows; j++) {
      board1[10][j] =  stroke(0);
      board1[10][j] =  fill(0);
  }
  */
  tug2.randomPlace();
  freighter2.randomPlace();
  sub2.randomPlace();
  destroyer2.randomPlace();
}   

void draw() {  
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
  fill(0);
  if (!lockBoats && !gameOver){
    msg = "Click the ships in the upper-lefthand corner to select them. \n Drag a selected ship to move it. Press r to rotate it. Press space when done.\n You may stack ships on each other... but if a missile hits one, both will sink!";
  } else if (lockBoats && !gameOver){
    msg = "Click on the cells to fire missiles at your opponent's ships!";
  } else if (gameOver && playerWins){
    msg = "You won! Congrats!";
  } else if (gameOver && !playerWins){
    msg = "You lost! GG BL";
  }
  text(msg, width/2, 700);
  if (gameOver){
    tug2.hide = false;
    freighter2.hide = false;
    sub2.hide = false;
    destroyer2.hide = false;
  }
  tug.display(tugSelected);
  freighter.display(freighterSelected);
  sub.display(subSelected);
  destroyer.display(destroyerSelected);
  tug2.display(tugSelected);
  freighter2.display(freighterSelected);
  sub2.display(subSelected);
  destroyer2.display(destroyerSelected);
}   
 
void mousePressed() {
  if (lockBoats){
    if (tug.sunk() && freighter.sunk() && sub.sunk() && destroyer.sunk()){
      gameOver = true;
      playerWins = false;
    } else if (tug2.sunk() && freighter2.sunk() && sub2.sunk() && destroyer2.sunk()){
      gameOver = true; 
      playerWins = true;
    } else {
      gameOver = false;
    }
  } else{
    gameOver = false;
  }
  for (int i = 11; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      if (!gameOver){
        board1[i][j].click(mouseX, mouseY, lockBoats);
      }
    }
  }
  if (lockBoats && mouseX > 660 && mouseY<600 && !gameOver){
    computerTurn();
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
  if (keyPressed == true && key == ' ' && !lockBoats){
    lockBoats = true;
    tug.findCells(board1);
    freighter.findCells(board1);
    sub.findCells(board1);
    destroyer.findCells(board1);
    tug2.findCells(board1);
    freighter2.findCells(board1);
    sub2.findCells(board1);
    destroyer2.findCells(board1);
    tug.setState(lockBoats);
    freighter.setState(lockBoats);
    sub.setState(lockBoats);
    destroyer.setState(lockBoats);
    tug2.setState(lockBoats);
    freighter2.setState(lockBoats);
    sub2.setState(lockBoats);
    destroyer2.setState(lockBoats);
  }
}
void computerTurn(){
  int x;
  int y;
  do{
    x = (int) random(10);
    y = (int) random(10);
  } while (board1[x][y].state == 2 || board1[x][y].state == 3);
  if (board1[x][y].state == 0 || board1[x][y].state == 1){
    board1[x][y].state +=2;
  }
}