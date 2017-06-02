/*Stuff we should work on:
- AI
- Implementing the stages of the game. Important stages include:
  - Set-up: mainly placing the boats

*/
Cell[][] board; 
Boat sub = new Boat(0, 0, 3);
int cols = 21;  
int rows = 10;  

void setup() {   
  size(1200, 600);

  int w = width / cols;
  int h = height / rows;
  board = new Cell[cols][rows];
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
        board[i][j] = new Cell(i * w, j * h, w, h);
    }
  }
 /* for (int j = 0; j < rows; j++) {
      board[10][j] =  stroke(0);
      board[10][j] =  fill(0);
  }
  */
}   

void draw() {  
  background(255);  
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      if(i==10){
      board[i][j].display2();
      }
      else{
      board[i][j].display();
      }
    } 
  }
  sub.display();
}   

void mousePressed() {   
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      board[i][j].click(mouseX, mouseY);
    }
  }
  sub.click(mouseX, mouseY);
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      sub.move(mouseX, mouseY, board[i][j]);
    }
  }
} 
void keyPressed(){
  sub.key();
}