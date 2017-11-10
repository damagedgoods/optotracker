import java.awt.*;
import processing.sound.*;

SoundFile[] samples = new SoundFile[8];
PImage photo;

int puntero = 0;
int cellWidth = 50;
int threshold = 150;

void setup() {
  size(801,401); 
  frameRate(240);  
  photo = loadImage("grid2.png");  
  photo.loadPixels();
  
  samples[0] = new SoundFile(this, "CLAP1.aif");
  samples[1] = new SoundFile(this, "CONGA1.aif");
  samples[2] = new SoundFile(this, "HIHAT01.aif");
  samples[3] = new SoundFile(this, "STICK.aif");
  samples[4] = new SoundFile(this, "berimbau.aif");
  samples[5] = new SoundFile(this, "fingered-bassnote-short.wav");
  samples[6] = new SoundFile(this, "hawaii_guitar.aif");
  samples[7] = new SoundFile(this, "shortwarm.aif");
}

void draw() {
  
  background(255);
  image(photo,0,0);
  
  fill(255,0,0);
  noStroke();
  rect(puntero, 0, 1, height);
  
  if (puntero%cellWidth == 0) {
    // Nueva celda, miro cuál es
    int x = puntero / cellWidth;
    for (int i=0; i<8; i++) {
      //println("Columna "+x+", fila "+i+", brillo "+getCellBrightness(x, i));
      boolean nota = (getCellBrightness(x, i) < threshold);
      if (nota) {
        playSample(x, i);
      }
    }        
  }
  
  puntero++;
  if (puntero == width-1) puntero = 0;    
  
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
  // println(puntero +": playing sample in track "+y);
  stroke(255,0,0);
  strokeWeight(2);
  noFill();
  rect(x*cellWidth, y*cellWidth, cellWidth, cellWidth);
  samples[y].play();
}