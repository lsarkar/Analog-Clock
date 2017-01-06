
public class Clock {
  Theme theme;

  // Clock Color Themes
  color background, faceColor, hoursColor, minutesColor, secondsColor, segmentColor;
  
  float radius, diameter;
  float secondsRadius, minutesRadius, hoursRadius;
  int cx, cy;

  // Clock Stroke Weights
  int faceStrokeWeight = 3;
  int secondsStrokeWeight = 2;
  int minutesStrokeWeight = 3;
  int hoursStrokeWeight = 4;

  public Clock(float radius, Theme theme) {

    this.radius = radius;
    this.theme = theme;
    this.diameter = radius * 2;

    cx = width/2;
    cy = height/2;
    
    // apply Color theme to all parts drawn by clock, needs to be called before drawing clock parts
    applyTheme(); 

    // Clock Hands
    setClockHandSizes();
  }

  private void setClockHandSizes() {

    secondsRadius = radius * 0.95;
    minutesRadius = radius * 0.8;
    hoursRadius = radius * 0.66;
  }

  public void drawClockFace() {

    // draw outer circle
    stroke(faceColor);
    strokeWeight(faceStrokeWeight);
    fill(faceColor, 0);
    ellipse(cx, cy, diameter, diameter);

    // draw inner segments representing each hour    
    drawInnerSegments(12, 10, 3);

    // draw inner segments representing each minute
    drawInnerSegments(60, 5, 2);
  }

  // Draw segments of Clock inner circle
  private void drawInnerSegments(int pts, int size, int weight) {

    for (int i = 1; i<=pts; i++) {
      float angle = radians(i*(360.0/pts));

      float px = cx + cos(angle) * radius;
      float py = cy + sin(angle) * radius;

      float pxInner = cx + cos(angle) * (radius - size);
      float pyInner = cy + sin(angle) * (radius - size);

      fill(segmentColor);
      stroke(segmentColor);
      strokeWeight(weight);
      line(px, py, pxInner, pyInner);
    }
  } 

  public void drawHours() {
    float h = map(hour() + norm(minute(), 0, 60), 0, 24, 0, TWO_PI * 2) - HALF_PI;

    stroke(hoursColor);
    strokeWeight(hoursStrokeWeight);
    line(cx, cy, cx + cos(h) * hoursRadius, cy + sin(h) * hoursRadius);
  }

  public void drawMinutes() {
    float m = map(minute() + norm(second(), 0, 60), 0, 60, 0, TWO_PI) - HALF_PI; 

    stroke(minutesColor);
    strokeWeight(minutesStrokeWeight);
    line(cx, cy, cx + cos(m) * minutesRadius, cy + sin(m) * minutesRadius);
  }

  // draw seconds hands
  public void drawSeconds() {
    float s = map(second(), 0, 60, 0, TWO_PI) - HALF_PI;

    stroke(secondsColor);
    strokeWeight(secondsStrokeWeight);
    line(cx, cy, cx + cos(s) * secondsRadius, cy + sin(s) * secondsRadius);
  }

  public void setTheme(Theme theme) {
    this.theme = theme; 
    applyTheme();
  }

  private void applyTheme() {
    // Clock Colors Dark Theme
    if (theme == Theme.DARK) {
      background = color(34, 35, 38); // Hex #222326
      faceColor = color(200, 200); 
      hoursColor = color(103, 164, 204);
      minutesColor = color(185, 185, 255);
      secondsColor = color(52, 160, 40);
      segmentColor = color(faceColor, 150);
    }
    // Clock Colors Light Theme
    else {
      background = color(223, 223, 223); // Hex #DFDFDF
      faceColor = color(100, 200);
      hoursColor = color(78, 149, 196);
      minutesColor = color(121, 121, 255);
      secondsColor = color(35, 109, 27);
      segmentColor = color(faceColor, 150);
    }
  }

  public int getBackgroundColor() {
    return background;
  }
}