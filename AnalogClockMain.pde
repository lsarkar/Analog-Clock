/* Created by Lawrence Sarkar 04 JAN 2017 using Processing 3.2.1

Credit to: https://processing.org/examples/clock.html for original clock code

*/

Clock clock;
Theme theme;

void settings(){
  fullScreen(); 
}

void setup(){
  noCursor();
  
  theme = Theme.DARK;
  
  // Create Clock with radius just less than half of display height
  clock = new Clock(displayHeight * 0.45, theme); 
}

void draw(){
  background(clock.getBackgroundColor());
    
  // draw all of the clock components
  clock.drawClockFace();
  clock.drawHours();
  clock.drawMinutes();
  clock.drawSeconds();
}

void mousePressed(){
  
  if (theme == Theme.DARK) {
    theme = Theme.LIGHT;
  }
  else {
    theme = Theme.DARK; 
  }
  
  clock.setTheme(theme);
}