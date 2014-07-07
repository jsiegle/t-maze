
class Button
{
  float x,y;
  float buttonSize;
  color basecolor, highlightcolor;
  color currentcolor;

  void update()
  {
    if(over()) {
      currentcolor = highlightcolor;
      if (mousePressed) {
        pressed();
      }
    }
    else {
      currentcolor = basecolor;
    }
  }

  boolean over() 
  {
    return true;
  }

  void pressed()
  {
  }
}

class CircleButton extends Button
{
  boolean over() {
    float dx = x - mouseX;
    float dy = y - mouseY;
    if (sqrt(sq(dx) + sq(dy)) < buttonSize/2) {
      return true;
    } 
    else {
      return false;
    }
  }
}

class RectButton extends Button
{

  float buttonHeight;
  float buttonWidth;

  boolean over() {
    if (mouseX >= x && mouseX <= x+buttonWidth && mouseY >= y && mouseY <= y+buttonHeight) {
      return true;
    } 
    else {
      return false;
    }
  }
}

class NameButton extends RectButton
{
  String name;
  boolean selected;

  NameButton(int ix, int iy, int iwidth, int iheight, color icolor, color ihighlight, String iname) {
    x = ix;
    y = iy;
    buttonSize = 0;
    buttonWidth = iwidth;
    buttonHeight = iheight;
    basecolor = icolor;
    highlightcolor = ihighlight;
    currentcolor = basecolor;
    name = iname;
    selected = false;
  }

  void update()
  {

    String[] m = match(name,subjectName);

    if (m != null) {
      selected = true;
    } 
    else {
      selected = false;
    }

    if (!selected) {
      if (!isPlaying) {
        if(over()) {
          currentcolor = highlightcolor;
          if (mousePressed) {
            pressed();
          }
        }
        else {
          currentcolor = basecolor;
        }
      } 
      else {
        currentcolor = basecolor;
      }
    } 
    else {
      currentcolor = highlightcolor;
    }
  }

  void pressed() {

    if (!isPlaying) {
      if (!selected)
        subjectName = name;
    } 
    else {
    }
  }


  void display() {

    fill(currentcolor);
    noStroke();

    rect(x,y,buttonHeight,buttonHeight);
    float textHeight = buttonHeight;

    textSize(textHeight);
    // float sw = textWidth(name);

    fill(currentcolor);
    text(name,x+buttonHeight*1.75,y+buttonHeight);
  }
}

class ModeButton extends RectButton
{
  String name;
  boolean selected;

  ModeButton(int ix, int iy, int iwidth, int iheight, color icolor, color ihighlight, String iname) {
    x = ix;
    y = iy;
    buttonSize = 0;
    buttonWidth = iwidth;
    buttonHeight = iheight;
    basecolor = icolor;
    highlightcolor = ihighlight;
    currentcolor = basecolor;
    name = iname;
    selected = false;
  }

  void update()
  {
    if(over()) {
      currentcolor = highlightcolor;
      if (mousePressed) {
        pressed();
      }
    }
    else {
      currentcolor = basecolor;
    }
  }

  void pressed() {

    forcedChoiceMode = !forcedChoiceMode;
    
    if (forcedChoiceMode)
    {
      highlightcolor = rred;
    } else {
      highlightcolor = ggreen;
    }
    
    if (fileIsOpen)
    {
      if (forcedChoiceMode)
        output.println("999" + "\t" + 0 + "\t" + elapsedTime + "\t" + millis());
      else
        output.println("999" + "\t" + 1 + "\t" + elapsedTime + "\t" + millis());
        
       output.flush();
    }
    
    stats.reset();
    
    currentcolor = highlightcolor;
    display();
    delay(200);
  }


  void display() {

    float textHeight = buttonHeight;

    textSize(textHeight);

    fill(currentcolor);

    if (forcedChoiceMode)
    {
      text("FORCED CHOICE",x+buttonHeight*1.75,y+buttonHeight);
    }
    else {
      text("FREE CHOICE",x+buttonHeight*1.75,y+buttonHeight);
    }
  }
}


class PlayButton extends CircleButton
{
  PlayButton(int ix, int iy, int isize, color icolor, color ihighlight)
  {
    x = ix;
    y = iy;
    buttonSize = isize;
    basecolor = icolor;
    highlightcolor = ihighlight;
    currentcolor = basecolor;
  }

  void pressed() 
  {
    if (!isPlaying) {

      isCalibrating = true;
      reset();

      isPlaying = true;

      isPaused = false;
      startTime = millis();
      openFile();
      fileIsOpen = true;

      wasReset = false;
    }
    else {
      isPaused = !isPaused;
      if (isPaused) {
        savedTime = elapsedTime;
      } 
      else {
        startTime = millis();
      }
    }

    delay(200);
  }


  void display()
  {

    pushMatrix();
    translate(x,y);

    noStroke();
    fill(currentcolor);

    if(!isPlaying || isPaused) {
      float d0 = buttonSize*0.6;
      float d1 = d0/2;
      float d2 = d0/2*tan(PI/6);
      float d3 = d0*sin(PI/3)-d2;
      rotate(PI/2);
      triangle(-d1,d2,0,-d3,d1,d2);
    } 
    else {
      float d0 = buttonSize*0.15;
      float d1 = buttonSize*0.5;
      rect(-d0-d0/2,-d1/2,d0,d1);
      rect(d0-d0/2,-d1/2,d0,d1);
    }

    popMatrix();
  }
}




class StopButton extends CircleButton
{
  StopButton(int ix, int iy, int isize, color icolor, color ihighlight)
  {
    x = ix;
    y = iy;
    buttonSize = isize;
    basecolor = icolor;
    highlightcolor = ihighlight;
    currentcolor = basecolor;
  }

  void pressed() 
  {
    isPlaying = false;
    isPaused = false;

    if (fileIsOpen) { // close the file, but don't reset
      output.close();
      fileIsOpen = false;
    } 
    else { // reset on the next button press
      if (!wasReset) {
        reset();
        wasReset = true;
      }
    }



    savedTime = 0;

    delay(200);
  }

  void display()
  {

    pushMatrix();
    translate(x,y);

    noStroke();
    fill(currentcolor);

    float d0 = buttonSize*0.5;
    rect(-d0/2,-d0/2,d0,d0);

    popMatrix();
  }
}



