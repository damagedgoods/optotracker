import java.awt.*;
PImage photo;

int puntero = 0;
int cellWidth = 100;
int threshold = 150;

void setup() {
  size(801,401); 
  frameRate(60);  
  photo = loadImage("grid.png");
  
  photo.loadPixels();
}


void draw() {
  
  background(255);
  image(photo,0,0);
  
  fill(255,0,0);
  noStroke();
  rect(puntero, 0, 1, height);
  
  if (puntero%100 == 0) {
    // Nueva celda, miro cuál es
    int x = puntero / 100;
    // println(x);
    for (int i=0; i<4; i++) {
      //println("Columna "+x+", fila "+i+", brillo "+getCellBrightness(x, i));
      boolean nota = (getCellBrightness(x, i) < threshold);
      if (nota) {
        playSample(x, i);
      }
    }        
  }
  
  // Actualizo el puntero
  puntero++;
  if (puntero == width) puntero = 0;    
  
}

color getCellBrightness(int x, int y) {
  // Devuelve el brillo medio de la celda x, y
  int brightnessAccumulator = 0;
  for (int i=0; i<cellWidth; i++) {
    for (int j=0; j<cellWidth; j++) {
      float brightness = brightness(photo.get(x*cellWidth+j, y*cellWidth+i));
      brightnessAccumulator += brightness;
    }
  }    
  return brightnessAccumulator / (cellWidth*cellWidth);
}

void playSample(int x, int y) {
  println(puntero +": playing sample in track "+y);
}