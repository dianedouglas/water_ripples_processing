int cols = 400;
int rows = 400;
float[][] current = new float[cols][rows];
float[][] previous = new float[cols][rows];
// like reverb sustain. generally how long it takes for ripples to fade away in this 'puddle'
// .981 - .99999, more dampening to more sustain.

float dampening = .988;
//float dampening = .99999;
int index = 0;
// set limit to 30, light drizzle. 
// set limit to 1, downpour

// int limit = 40;
int limit = 10;
void setup() {
 size(400, 400);
}
 
void mousePressed() {
  // create raindrop at coordinates mouseX, mouseY
  // value controls how bright the raindrop is.
  previous[mouseX][mouseY] = random(50);
}

void addRainDrops() {
  int x = int(random(float(cols)));
  int y = int(random(float(rows)));
  previous[x][y] = random(50);
}

void draw() {
  background(0);
  loadPixels();
  
  if (index == 0) {
    addRainDrops();
  }
  index++;
  if(index == limit) {
    index = 0;
  }
  
  //go through all pixel coordinates
  //use current and previous to get next, which is put into current. 
  //changing offset is almost like zoom and speed at the same time. 
  //>> need to fill in the pixels arount current out to offset value.
  int offset = 1;
  for (int i = offset; i < cols - offset; i++){
    for (int j = offset; j < rows - offset; j++){

      // anything done in here is done to each pixel with access to both buffers 
      // so you can do your math on each pixel here with access to all values in the array. 
      current[i][j] = (
        previous[i-offset][j] +
        previous[i+offset][j] +
        previous[i][j-offset] +
        previous[i][j+offset]
        ) / 2 - 
        current[i][j];
      current[i][j] = current[i][j] * dampening;
      
      // pixels must be native to processing. 
      // set of all pixels on screen sorted by single index
      // which means current number of rows (i) + number of columns * current number of columns 
      
      int index = i + j * cols;
      pixels[index] = color(current[i][j] * 255);
    }
  }
  updatePixels();
  
  float[][]temp = previous;
  previous = current; 
  current = temp;
}
