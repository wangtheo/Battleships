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
int difficulty = '1';
int[] coordinates = {0, 0};

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
    msg = "Click the ships in the upper-lefthand corner to select them. \n Drag a selected ship to move it. Press r to rotate it. Press space when done.\n You may stack ships on each other... but if a missile hits one, both will sink!\n Press 1 for easy mode, 2 for medium mode, and 3 for hard mode. Difficulty level: "+(difficulty-48);
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
    if (difficulty == '1'){
      computerTurnEasy();
    } else if (difficulty == '2'){
      coordinates = nextCoordinate(coordinates);
      computerTurnMedium(coordinates);
    } else if (difficulty == '3'){
      computerTurnHard();
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
  if ((key == '1' || key == '2' || key == '3') && !lockBoats){
    difficulty = key;
  }
  if (key == ' ' && !lockBoats){
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
void computerTurnEasy(){
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
int[] nextCoordinate(int[] coordinates){
  if (board1[coordinates[0]][coordinates[1]].state == 3){
    do {
      int rand = (int) random(2);  
      if (rand == 0 || coordinates[0] == 0 || coordinates[1] == 0){
        coordinates[(int) random(2)] ++;
      } else if (rand == 1 || coordinates[0] == 9 || coordinates[1] ==9) {
        coordinates[(int) random(2)] --;
      }
    } while (board1[coordinates[0]][coordinates[1]].state == 2 || board1[coordinates[0]][coordinates[1]].state == 3);
  } else {
    do {
        coordinates[0] = (int) random(10);
        coordinates[1] = (int) random(10);
    } while (board1[coordinates[0]][coordinates[1]].state == 2 || board1[coordinates[0]][coordinates[1]].state == 3);
  } 
  return coordinates;
}
void computerTurnMedium(int[] coordinates){
  if (board1[coordinates[0]][coordinates[1]].state == 0 || board1[coordinates[0]][coordinates[1]].state == 1){
    board1[coordinates[0]][coordinates[1]].state +=2;
  }
}

void computerTurnHard(){
  int priorityZero = 0;
  int priorityOne = 0;
  int priorityTwo = 0;
  for (int i = 0; i < 10; i++) {
    for (int j = 0; j < rows; j++) {
      if (board1[i][j].priority == 0|| board1[i][j].priority == 1){
        priorityZero++;
      } else if(board1[i][j].priority == 2){
        priorityOne++;
      } else if (board1[i][j].priority >= 3 && board1[i][j].priority <=12) {
        priorityTwo++;
      }
    }
  }
  Cell[] priorityZeroCells; 
  priorityZeroCells = new Cell[priorityZero];
  Cell[] priorityOneCells;
  priorityOneCells = new Cell[priorityOne];
  Cell[] priorityTwoCells; 
  priorityTwoCells = new Cell[priorityTwo];
  int pZero = 0;
  int pOne = 0;
  int pTwo = 0;
  for (int a = 0; a < 10; a++) {
    for (int b = 0; b < rows; b++) {
      if (board1[a][b].priority == 0 || board1[a][b].priority == 1){
        priorityZeroCells[pZero] = board1[a][b];
        pZero++;
      } else if(board1[a][b].priority == 2){
        priorityOneCells[pOne] = board1[a][b];
        pOne++;
      } else if (board1[a][b].priority >= 3 && board1[a][b].priority <=12){
        priorityTwoCells[pTwo] = board1[a][b];
        pTwo++;
      }
    }
  }
  int priorityBracket = (int) random(priorityZero+50*priorityOne+100*priorityTwo);
  int cellNumber;
  if (priorityBracket < priorityZero+50*priorityOne+100*priorityTwo && priorityTwo > 0){
    cellNumber = (int) random(priorityTwo);
    priorityTwoCells[cellNumber].state +=2;
    priorityTwoCells[cellNumber].priority = 13;
    if (priorityTwoCells[cellNumber].state == 3){
      board1[(1+(priorityTwoCells[cellNumber].x)/60)%10][(priorityTwoCells[cellNumber].y)/60].priority+=2;
      board1[(priorityTwoCells[cellNumber].x)/60][(1+(priorityTwoCells[cellNumber].y)/60)%10].priority+=2;
      board1[Math.abs((priorityTwoCells[cellNumber].x)/60 - 1)][(priorityTwoCells[cellNumber].y)/60].priority+=2;
      board1[(priorityTwoCells[cellNumber].x)/60][Math.abs((priorityTwoCells[cellNumber].y)/60 -1)].priority+=2;
      board1[(2+(priorityTwoCells[cellNumber].x)/60)%10][(priorityTwoCells[cellNumber].y)/60].priority++;
      board1[(priorityTwoCells[cellNumber].x)/60][(2+(priorityTwoCells[cellNumber].y)/60)%10].priority++;
      board1[Math.abs((priorityTwoCells[cellNumber].x)/60 - 2)][(priorityTwoCells[cellNumber].y)/60].priority++;
      board1[(priorityTwoCells[cellNumber].x)/60][Math.abs((priorityTwoCells[cellNumber].y)/60 -2)].priority++;
    }
  } else if (priorityBracket < priorityZero+50*priorityOne && priorityOne > 0){
    cellNumber = (int) random(priorityOne);
    priorityOneCells[cellNumber].state +=2;
    priorityOneCells[cellNumber].priority = 13;
    if (priorityOneCells[cellNumber].state == 3){
      board1[(1+(priorityOneCells[cellNumber].x)/60)%10][(priorityOneCells[cellNumber].y)/60].priority+=2;
      board1[(priorityOneCells[cellNumber].x)/60][(1+(priorityOneCells[cellNumber].y)/60)%10].priority+=2;
      board1[Math.abs((priorityOneCells[cellNumber].x)/60 - 1)][(priorityOneCells[cellNumber].y)/60].priority+=2;
      board1[(priorityOneCells[cellNumber].x)/60][Math.abs((priorityOneCells[cellNumber].y)/60 -1)].priority+=2;
      board1[(2+(priorityOneCells[cellNumber].x)/60)%10][(priorityOneCells[cellNumber].y)/60].priority++;
      board1[(priorityOneCells[cellNumber].x)/60][(2+(priorityOneCells[cellNumber].y)/60)%10].priority++;
      board1[Math.abs((priorityOneCells[cellNumber].x)/60 - 2)][(priorityOneCells[cellNumber].y)/60].priority++;
      board1[(priorityOneCells[cellNumber].x)/60][Math.abs((priorityOneCells[cellNumber].y)/60 -2)].priority++;
    }
  } else if (priorityBracket< priorityZero && priorityZero >0){
    cellNumber = (int) random(priorityZero);
    priorityZeroCells[cellNumber].state +=2;
    priorityZeroCells[cellNumber].priority = 13;
    if (priorityZeroCells[cellNumber].state == 3){
      board1[(1+(priorityZeroCells[cellNumber].x)/60)%10][(priorityZeroCells[cellNumber].y)/60].priority+=2;
      board1[(priorityZeroCells[cellNumber].x)/60][(1+(priorityZeroCells[cellNumber].y)/60)%10].priority+=2;
      board1[Math.abs((priorityZeroCells[cellNumber].x)/60 - 1)][(priorityZeroCells[cellNumber].y)/60].priority+=2;
      board1[(priorityZeroCells[cellNumber].x)/60][Math.abs((priorityZeroCells[cellNumber].y)/60 -1)].priority+=2;
      board1[(2+(priorityZeroCells[cellNumber].x)/60)%10][(priorityZeroCells[cellNumber].y)/60].priority++;
      board1[(priorityZeroCells[cellNumber].x)/60][(2+(priorityZeroCells[cellNumber].y)/60)%10].priority++;
      board1[Math.abs((priorityZeroCells[cellNumber].x)/60 - 2)][(priorityZeroCells[cellNumber].y)/60].priority++;
      board1[(priorityZeroCells[cellNumber].x)/60][Math.abs((priorityZeroCells[cellNumber].y)/60 -2)].priority++;
    }
  }
}