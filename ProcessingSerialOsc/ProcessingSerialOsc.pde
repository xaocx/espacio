
import cc.arduino.*;
Arduino arduino; 

import processing.serial.*;
Serial myPort;
int brightness = 0; 

import processing.video.*;
Movie natura;
import processing.video.*;
Movie agua;

import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

int cont ; 
PImage foto;

float angle = 0;
int x = 0 ;
int z = 0 ;
int [] x1 ;
int [] y1 ; 
void setup () {
  size(600,800, P3D);

colorMode(HSB); 
  // println(Serial.list());

  //  String portName = Serial.list()[0];

  oscP5 = new OscP5(this, 12001);
  myRemoteLocation = new NetAddress("127.0.0.1", 12001);
  
  //ARDUINO !! 
  myPort = new Serial(this, "COM3", 9600); 
  myPort.bufferUntil('\n');

 natura = new Movie(this, "hojas.mov");
  natura.loop();
 foto = loadImage("2.jpg");
 image(foto, 0, 0, width, height);
  foto.loadPixels();
  x1 = new int [width]; 
  y1 = new int [height];
//  values = new int[width][height];
background(255);
  //for (int y = 0; y < foto.height; y++) {
  //  for (int x = 0; x < foto.width; x++) {
  //    color pixel = foto.get(x, y);
  //    values[x][y] = int(brightness(pixel));
  //  }
  //}
}


void movieEvent(Movie video) {
  natura.read();
}
void draw() {
  // background(0);
  constrain(brightness, 0, 255); 
  
  OscMessage numb = new OscMessage("number");
  if (brightness < 23) {
    cont ++; 

    numb.add(cont);
  }



tint(random(200, 255), brightness);  
//tint(random(200, 255), 10);  
//image(natura, 0, 0, 396, 711);



  translate(x, 0, z);
 // ARDUINO 

 if (z == 300) {
 z= 0;
// x  = x+1;
 } else {
   z=z+5;
  }
  println(z);
 for (int y = 0; y < foto.height; y+=+1) {
    for (int x = 0; x < foto.width; x+=1) {
      color c = foto.get(int(x), int(y)); 
      float h = hue(c);
      float s  = saturation(c);
      float b = brightness(c);
      //  noStroke();
     if (brightness <= 50) {
  // z = z + 1;
     stroke(h, s, b,200);
  } else {
 // z=-100;
    noStroke();
}
      strokeWeight(2);
      // fill (r, g, b); 
      x1[x] = int(saturation(c));
      y1[y] = int(saturation(c));
  point(x, y, +(x1[x]));

      }
    }

  ////  println(brightness);

  //for (int y = 0; y < foto.height; y=y+2) {
  //  for (int x = 0; x < foto.width; x=x+2) {
  //    stroke(values[x][y]);
  //    point(x, y, -values[x][y]);
  //  }
  //}
  
  
  
// saveFrame("output4/tlandscape_####.png");
      oscP5.send(numb, myRemoteLocation);
}
//arduino 
void serialEvent (Serial port) {
  brightness = int(port.readStringUntil('\n'));
 //     constrain(brightness, 0, 255);
}
