Cell[][] board;  
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
}   

void mousePressed() {   
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      board[i][j].click(mouseX, mouseY);
    }
  }
}  