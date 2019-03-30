int cols = 200;
int rows = 200;
float[][] current = new float[cols][rows];
float[][] previous = new float[cols][rows];
float dampening = .999;

void setup() {
 size(200, 200);
//initialize values in each array which hold a color. 
// at each spot on a grid, rows by columns, there is a value. 
// if that value is a distance to travel in upwards from that point, height => color of point.
 
 // initialize buffer values
 //for (int i = 0; i < cols; i++) {
 //  for (int j = 0; j < cols; j++) {
 //    current[i][j] = 100;
 //    previous[i][j] = 100;
 //  }
 //}
 
 previous[100][100] = 255;
}

void draw() {
  background(0);
  loadPixels();
  
  for (int i = 1; i < cols - 1; i++){
    for (int j = 1; j < rows - 1; j++){
      // anything done in here is done to each pixel with access to both buffers 
      // so you can do your math on each pixel here with access to all values in the array. 
      current[i][j] = (
        previous[i-1][j] +
        previous[i+1][j] +
        previous[i][j-1] +
        previous[i][j+1]
        ) / 2 - 
        current[i][j];
      current[i][j] = current[i][j] * dampening;
      
      int index = i + j * cols;
      pixels[index] = color(current[i][j] * 255);
    }
  }
  updatePixels();
  
  float[][]temp = previous;
  previous = current; 
  current = temp;
}
