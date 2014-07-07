// Play/Pause/Stop data acquisition, where data is typed words

String subjectName = "test";

float screenWidth = 800;
float screenHeight = 500;

boolean isPlaying = false;
boolean isPaused = false;
boolean wasReset = true;

String response = "";

long elapsedTime = 0;
long startTime;
long savedTime = 0;

static final int freeChoiceL = 5;
static final int freeChoiceR = 1;
static final int middleArm1 = 2;
static final int middleArm2 = 3;
static final int forcedChoiceL = 0;
static final int forcedChoiceR = 4;
static final int leftGate = 2;
static final int rightGate = 1;

int activeArm = freeChoiceL;
int activeGate = leftGate;
int previousArm = forcedChoiceR;

boolean inCenterArm = false;
boolean centerArmActive = false;
boolean forcedChoiceMode = true;

import processing.serial.*;
Serial myPort;        // The serial port
PrintWriter output;

StatCounter stats = new StatCounter();

boolean fileIsOpen = false;
boolean isCalibrating = false;

///////////////////////////////// 

void setup() 
{
  size(800,500);
  smooth();

  println(Serial.list());
  myPort = new Serial(this, Serial.list()[1], 9600);
  myPort.bufferUntil('\n');
}

void draw() {

  background(bkgdcolor);
  playPause.update();
  playPause.display();
  stopButton.update();
  stopButton.display();

  select1.update();
  select1.display();
  
  select2.update();
  select2.display();
  
  select3.update();
  select3.display();
  
  select4.update();
  select4.display();
  
   modeButton.update();
  modeButton.display();

  if (isCalibrating) {
    fill(yellow);
    text("Calibrating sensors...",635,470);
  } 
  else {

    if (isPlaying) {
      fill(151,155,152);

      if (isPaused) {
        text("Recording paused.",635,470);
      } 
      else {
        elapsedTime = millis() - startTime + savedTime;
        text("Saving data to disk...",635,470);
      }
    }
  }

  if (fileIsOpen) {
    fill(ggreen);
  } 
  else {
    fill(151,155,152);
  }
  textSize(45);
  drawClock(elapsedTime,635,320);


  fill(151,155,152);
  textSize(12);
  text(response,635,370);

  stats.display();

  drawTrack(activeArm,activeGate,previousArm,inCenterArm,centerArmActive);
}


void serialEvent (Serial myPort) {
  // get the ASCII string
  String inString = myPort.readStringUntil('\n');
  println(inString);

  if (inString != null) 
  {
    inString = trim(inString);
    String[] splitString = split(inString, ' ');

    int sensorNum = int(splitString[1]);
    int eventType = int(splitString[2]);
    int sensorVal = int(splitString[3]);
    int triggerVal = int(splitString[4]);
    
   // if (sensorNum == 2 || sensorNum == 3)
   //     return;
    //     float x = map(ts % timeWindow, 0, timeWindow, 0, plotWidth);
    // float y = map(sensorVal, 600, 1023, 0, plotHeight);

    switch(eventType) {
    case -1: // initial message
      break;
    case 0: // threshold
      isCalibrating = true;
      //threshVal[sensorNum] = map(sensorVal, 600, 1023, 0, plotHeight);
      //plotThresh(); 
      //drawTrack(sensorNum, triggerVal);
      break;
    case 1: // value
      if (isCalibrating)
      {
        isCalibrating = false;
        startTime = millis();
      }
        
      //plotData(x,y,sensorNum); 
      //drawTrack(sensorNum, triggerVal);
      break;
    case 2: // trigger
      
      isCalibrating = false;
    
      if (sensorNum != middleArm1 && sensorNum != middleArm2)
      {
    
      if (isPlaying && !isPaused) 
      {
        int isCorrect;
        if (sensorNum == activeArm) {
          isCorrect = 1;
        } 
        else {
          isCorrect = 0;
        }
        output.println(sensorNum + "\t" + isCorrect + "\t" + elapsedTime + "\t" + millis());
        output.flush();
      }

      trigger(sensorNum);
      break;
      } else {
        output.println(sensorNum + "\t" + 0 + "\t" + elapsedTime + "\t" + millis());
        output.flush();
         break;
      }
      
     case 8: // entering middle arm (no trigger)
       output.println(eventType + "\t" + sensorNum + "\t" + elapsedTime + "\t" + millis());
       output.flush();
       
       if (sensorNum == 1 || sensorNum == 2)
       {
         inCenterArm = true;
         centerArmActive = true;
       } else if (sensorNum == -1)
       {
         inCenterArm = true;
         centerArmActive = false;
       } else if (sensorNum == 0)
       {
         inCenterArm = false;
         centerArmActive = false;
       }
       break;
    }
  }
}

void keyPressed() {

  char k = (char)key;
  if (key != CODED) {
    switch(k) {
    case 8: // backspace
      if(response.length()>0) {
        response = response.substring(0,response.length()-1);
      }
      break;
    case 10: // new line
      if (isPlaying && !isPaused) {
        //output.println(response + " " + elapsedTime + " " millis());
        //output.flush();
      }
      response = "";
      break;
    case 13: // carriage return
    case 127: // delete
    case 27: // escape   

    default:
      if (k != 10) {
        response = response + k;
      }
    }
  }
}

