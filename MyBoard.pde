//Battleship game, ICS3U final assignment, 2017
//By Hiro Ayettey and Theodore Wang
//Theodore worked on the functionality of the game, like moving the boats, determining hits and misses, and AI
//Hiro worked on the visual aspect, like the board, menus, buttons
/* The board
- "Ocean" consists of 200 cells
- Boats are: tugboat (2 cells), freighter (3 cells), submarine (4 cells) and destroyer (5 cells)
- Before the boats are locked, they may be moved around or rotated. 
- Boats are locked in place when the spacebar is pressed. 
- After the boats are locked, the cells under them are set to state = 1
Comments are usually put in the easy section of the switch statements that are used to divide the game, since each part is quite similar.
*/
Cell[][] board1; 
String msg;
String msgWinLose;
String msgLevel;
Button restartButton;
Button easyButton;
Button hardButton;
Button backToMenu;
Button mediumButton;
int gameState = 0;
final int menu = 0;
final int easyGame = 1;
final int mediumGame = 2;
final int hardGame = 3;
int wins = 0;
int losses = 0;
PImage img;
int[] coordinates = {0, 0};

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
  //Opens with main menu and computer difficulty selection
  //Screen loads are split up with a switch statement
  size(1260, 800);
  
  img = loadImage("Battleship-H.jpg");
  
  switch(gameState){
  case(menu):
  {
    textSize(32);
    
    easyButton = new Button("Easy", 560, 350, 150, 80);
    mediumButton = new Button("Medium", 560, 440, 150, 80);
    hardButton = new Button("Hard", 560, 530, 150, 80);
    break;
  }
  case(easyGame):
  {
  //Makes the board and places the boats
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
  restartButton = new Button("Reset", 25, 700, 80, 50);
  backToMenu = new Button("Menu", 1130, 700, 80, 50);
  break;
  }
  case(mediumGame):
  {
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
  restartButton = new Button("Reset", 25, 700, 80, 50);
  backToMenu = new Button("Menu", 1130, 700, 80, 50);
  break;
  }
  case(hardGame):
  {
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
  restartButton = new Button("Reset", 25, 700, 80, 50);
  backToMenu = new Button("Menu", 1130, 700, 80, 50);
  break;
  }
}
}   

void draw() {
   background(255);
   
   switch(gameState){
   case(menu):
   {
     //Draws menu and buttons
     tint(255,200);
     image(img,0,0,1260,800);
     easyButton.Draw2();
     mediumButton.Draw2();
     hardButton.Draw2();
     if (mousePressed == true && easyButton.MouseIsOver() == true){
     gameState = easyGame;
     }
     else if (mousePressed == true && hardButton.MouseIsOver() == true){
     gameState = hardGame;
     }
     else if (mousePressed == true && mediumButton.MouseIsOver() == true){
     gameState = mediumGame;
     }
     break;
   }
   case(easyGame):
   { 
     //Draws board, same for other difficulties
    background(8,111,161);  
    msgLevel = "Easy Mode \n";
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
   fill(255);
  if (!lockBoats && !gameOver){
    
    msg = msgLevel + "Click the ships in the upper-lefthand corner to select them. \n Drag a selected ship to move it. Press r to rotate it. Press space when done.\n You may stack ships on each other... but if a missile hits one, both will sink!";
  } else if (lockBoats && !gameOver){
    msg = msgLevel + "Click on the cells to fire missiles at your opponent's ships!";
  } else if (gameOver && playerWins){
    msg = "You won! Congrats! \n Press reset to play again!";
  } else if (gameOver && !playerWins){
    msg = "You lost! \n Press reset to play again!";
  }
  msgWinLose = "Wins: " + wins + "\n Losses: " + losses;

  text(msg, width/2, 700);
  text(msgWinLose, 60, 650);
  
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
  backToMenu.Draw();
  restartButton.Draw();
  break;
  }
     case(mediumGame):
   { 
    background(8,111,161);  
    msgLevel = "Medium Mode \n";
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
   fill(255);
  if (!lockBoats && !gameOver){
    
    msg = msgLevel + "Click the ships in the upper-lefthand corner to select them. \n Drag a selected ship to move it. Press r to rotate it. Press space when done.\n You may stack ships on each other... but if a missile hits one, both will sink!";
  } else if (lockBoats && !gameOver){
    msg = msgLevel + "Click on the cells to fire missiles at your opponent's ships!";
  } else if (gameOver && playerWins){
    msg = "You won! Congrats! \n Press reset to play again!";
  } else if (gameOver && !playerWins){
    msg = "You lost! \n Press reset to play again!";
  }
  msgWinLose = "Wins: " + wins + "\n Losses: " + losses;

  text(msg, width/2, 700);
  text(msgWinLose, 60, 650);
  
  if (gameOver){
    tug2.hide = false;
    freighter2.hide = false;
    sub2.hide = false;
    destroyer2.hide = false;
  }
  tug.display3(tugSelected);
  freighter.display3(freighterSelected);
  sub.display3(subSelected);
  destroyer.display3(destroyerSelected);
  tug2.display(tugSelected);
  freighter2.display(freighterSelected);
  sub2.display(subSelected);
  destroyer2.display(destroyerSelected);
  backToMenu.Draw();
  restartButton.Draw();
  break;
  }
  case(hardGame):
  { 
    background(8,111,161);  
     msgLevel = "Hard Mode \n";
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
   fill(255);
  if (!lockBoats && !gameOver){
    
    msg = msgLevel + "Click the ships in the upper-lefthand corner to select them. \n Drag a selected ship to move it. Press r to rotate it. Press space when done.\n You may stack ships on each other... but if a missile hits one, both will sink!";
  } else if (lockBoats && !gameOver){
    msg = msgLevel + "Click on the cells to fire missiles at your opponent's ships!";
  } else if (gameOver && playerWins){
    msg = "You won! Congrats! \n Press reset to play again!";
  } else if (gameOver && !playerWins){
    msg = "You lost! \n Press reset to play again!";
  }
  msgWinLose = "Wins: " + wins + "\n Losses: " + losses;

  text(msg, width/2, 700);
  text(msgWinLose, 60, 650);
  
  if (gameOver){
    tug2.hide = false;
    freighter2.hide = false;
    sub2.hide = false;
    destroyer2.hide = false;
  }
  tug.display2(tugSelected);
  freighter.display2(freighterSelected);
  sub.display2(subSelected);
  destroyer.display2(destroyerSelected);
  tug2.display(tugSelected);
  freighter2.display(freighterSelected);
  sub2.display(subSelected);
  destroyer2.display(destroyerSelected);
  backToMenu.Draw();
  restartButton.Draw();
  break;
  }
  }
}   
 
void mousePressed() {
  switch(gameState){
    case(menu):{
      //Moves to the proper game screen on mouse click and sets up + draws the board
     if (easyButton.MouseIsOver() == true){
       gameState = easyGame;
       setup();
       draw();
     }
     if (mediumButton.MouseIsOver() == true){
       gameState = mediumGame;
       setup();
       draw();
     }
     if (hardButton.MouseIsOver() == true){
       gameState = hardGame;
       setup();
       draw();
     }
     break;
    }
    case(easyGame):{
    if (restartButton.MouseIsOver()==true){
    restartGame();
    gameOver= false;
    playerWins = false;
    }
    
    if (backToMenu.MouseIsOver()==true){
     //Back to menu option, also resets the game.
    restartGame();
    gameState = 0;
    }
    
  if (lockBoats){
    //Locks boat when all have been hit
    if (tug.sunk() && freighter.sunk() && sub.sunk() && destroyer.sunk()){
      gameOver = true;
      playerWins = false;
      losses = losses +1;
    } else if (tug2.sunk() && freighter2.sunk() && sub2.sunk() && destroyer2.sunk()){
      gameOver = true; 
      playerWins = true;
      wins = wins + 1;
    } else {
      gameOver = false;
    }
  } else{
    gameOver = false;
  }
  for (int i = 11; i < cols; i++) {
    //Allows for moving boats
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
  break;
  } 
  
  case(mediumGame):
  {
    if (restartButton.MouseIsOver()==true){
    restartGame();
    gameOver= false;
    playerWins = false;
    }
    
    if (backToMenu.MouseIsOver()==true){
    restartGame();
    gameState = 0;
    }
    
  if (lockBoats){
    if (tug.sunk() && freighter.sunk() && sub.sunk() && destroyer.sunk()){
      gameOver = true;
      playerWins = false;
      losses = losses +1;
    } else if (tug2.sunk() && freighter2.sunk() && sub2.sunk() && destroyer2.sunk()){
      gameOver = true; 
      playerWins = true;
      wins = wins + 1;
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
  break;
  }
  
  case(hardGame):
  {
    if (restartButton.MouseIsOver()==true){
    restartGame();
    gameOver= false;
    playerWins = false;
    }
    
     if (backToMenu.MouseIsOver()==true){
       restartGame();
    gameState = menu;
    }
    
  if (lockBoats){
    if (tug.sunk() && freighter.sunk() && sub.sunk() && destroyer.sunk()){
      gameOver = true;
      playerWins = false;
      losses = losses +1;
    } else if (tug2.sunk() && freighter2.sunk() && sub2.sunk() && destroyer2.sunk()){
      gameOver = true; 
      playerWins = true;
      wins = wins + 1;
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
  break;
  }
  }
} 
void mouseDragged(){
  tug.move(mouseX, mouseY, board1, tugSelected);
  sub.move(mouseX, mouseY, board1, subSelected);
  freighter.move(mouseX, mouseY, board1, freighterSelected);
  destroyer.move(mouseX, mouseY, board1, destroyerSelected);
}

void keyPressed(){
  switch(gameState){
    case(menu):{
      break;
    }
    case(easyGame):{
      //Rotates boat
  tug.rotateBoat(key, tugSelected);
  sub.rotateBoat(key, subSelected);
  freighter.rotateBoat(key, freighterSelected);
  destroyer.rotateBoat(key, destroyerSelected);
  if (keyPressed == true && key == ' ' && !lockBoats){
    //Space bar to start game
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
   break;
  }
  case(mediumGame):
  {
    {
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
  }
  
  case(hardGame):
  {
    {
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
  }
  }
}

void restartGame(){
  //Resets all the values of the game
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
  lockBoats = false;
  playerWins = false;
  gameOver = false;
  tug2.hide = true;
  freighter2.hide = true;
  sub2.hide = true;
  destroyer2.hide = true;
  
  tug.x = 0;
  tug.y = 0;
  tug.rotated =0;
  
  freighter.x = 0;
  freighter.y = 60;
  freighter.rotated = 0;
  
  sub.x= 0;
  sub.y = 120;
  sub.rotated = 0;
  
  destroyer.x = 0;
  destroyer.y= 180;
  destroyer.rotated = 0;
  
  tug.display(tugSelected);
  freighter.display(freighterSelected);
  sub.display(subSelected);
  destroyer.display(destroyerSelected);
  tug2.display(tugSelected);
  freighter2.display(freighterSelected);
  sub2.display(subSelected);
  destroyer2.display(destroyerSelected);
  tug2.randomPlace();
  freighter2.randomPlace();
  sub2.randomPlace();
  destroyer2.randomPlace();
}
void computerTurn(){
  switch(gameState){
  case(easyGame):
  {
    //Computer randomly chooses where to attack
  int x;
  int y;
  do{
    x = (int) random(10);
    y = (int) random(10);
  } while (board1[x][y].state == 2 || board1[x][y].state == 3);
  if (board1[x][y].state == 0 || board1[x][y].state == 1){
    board1[x][y].state +=2;
  }
  break;
}
   case(mediumGame):
{
computerTurnMedium(coordinates);
}

  
  case(hardGame):
  {
   //Assigns priorities to squares around where a hit was found.
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
  break;
}
  }
}

void computerTurnMedium(int[] coordinates){
  if (board1[coordinates[0]][coordinates[1]].state == 0 || board1[coordinates[0]][coordinates[1]].state == 1){
    board1[coordinates[0]][coordinates[1]].state +=2;
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