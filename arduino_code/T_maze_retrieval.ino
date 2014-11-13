// IR sensor identities
const int nSensors = 6;
const int yellowArm = 0;
const int orangeArm = 1;
const int middleArm1 = 2;
const int middleArm2 = 3;
const int greenArm = 4;
const int redArm = 5;

// Arduino pin mappings
const int leftArmBuzzer = 8;
const int rightArmBuzzer = 4;
const int outPin1 = 12; // gate 5
const int outPin2 = 11; // gate 4

// State variables
boolean inMiddleArm = false;    // location of mouse
boolean middleArmSetA = false;   // middle arm can be triggered in reverse
boolean middleArmSetB = true;   // middle arm can be triggered going forward

// initialize IR sensor info
int IRsensorPins[nSensors];
int IRsensorValues[nSensors];
int IRthresholds[nSensors];
int IRcanBePassed[nSensors];

// timing variables
unsigned long lastTime;
unsigned long entryTime;
unsigned long timeOut = 3000;

void setup() {

  Serial.begin(9600); // start serial communication at 9600 baud rate  

  calibrate();

  // initialize pins
  pinMode(leftArmBuzzer, OUTPUT);
  pinMode(rightArmBuzzer, OUTPUT);
  pinMode(outPin1, OUTPUT);
  pinMode(outPin2, OUTPUT);
 
  // seed the random number generator
  randomSeed(analogRead(5));

}

////////////LOOP IT/////////////////////////////////////

void loop() {

  checkSensors();
  
  checkTime();
  
  if (Serial.available() > 0) {
    
    byte incomingByte = Serial.read();

    if (incomingByte == 0) {
      tone(leftArmBuzzer, 2000, 250);
    } else if (incomingByte == 1) {
      tone(rightArmBuzzer, 2000, 250);
    } else {
      calibrate();
    }    
  }
}

////////////HELPER FUNCTIONS//////////////////////

void checkSensors() {

  for (int n = 0; n < nSensors; n++) {

    IRsensorValues[n] = analogRead(IRsensorPins[n]); // read in data from each channel

    if (IRsensorValues[n] > IRthresholds[n] && IRcanBePassed[n] == 1) {
      
      // indicate that arm was crossed
      serialPrint(n, 2, IRsensorValues[n], IRcanBePassed[n]);
      
      if (n == yellowArm || n == redArm || n == greenArm || n == orangeArm)
      {
         inMiddleArm = false;
         
         if (n == orangeArm || n == redArm) // free choice arms
         {
            middleArmSetA = true;  // first check
            
         } else { // forced choice arms
             middleArmSetB = true; // secondCheck
         }
        
      } else if (n == middleArm1) 
      {
        
          if (inMiddleArm)
          {
             inMiddleArm = false;
             deactivateLED(); 
          }
        
          if (middleArmSetB)
          {
            activateLED();

            inMiddleArm = true;
            middleArmSetB = false;
          }
          
          
          
      } else if (n == middleArm2)
      {
          if (inMiddleArm)
          {
             inMiddleArm = false;
             deactivateLED();

          } 
          
          if (middleArmSetA)
          {
             activateLED();

            inMiddleArm = true;
            middleArmSetA = false;
          }

      }
      
      // reset sensors
      for (int m = 0; m < nSensors; m++) {
        if (m != n) {
          IRcanBePassed[m] = 1;
        } 
        else {
          IRcanBePassed[m] = 0;
        } 
      } 
    } else { // threshold was not crossed

      // print to serial port at a rate of 200 Hz
      if (millis() - lastTime > 5) {
        
        //serialPrint(n, 1, IRsensorValues[n], IRcanBePassed[n]);
        lastTime = millis();

      }
    } 

  }
}

void checkTime()
{
  if (inMiddleArm)
  {
     if (millis() - entryTime > timeOut)
     {
        deactivateLED();
        inMiddleArm = false;
     } 
  }
}

void activateLED()
{
    int r = random(0,100);
    
    entryTime = millis();
       
    if (r <= 33) // 33% chance of activation at phase 1
    {
      digitalWrite(outPin1, HIGH);
      serialPrint(1, 8, 0, 0); // inform the computer of activation
    } else if (r > 33 && r <= 66) {
      digitalWrite(outPin2, HIGH); // 33% chance of activation at phase 2
      serialPrint(2, 8, 0, 0); // inform the computer either way
    } else {
      // 33% blank
      digitalWrite(outPin1, LOW);
      digitalWrite(outPin2, LOW);
      serialPrint(-1, 8, 0, 0); // inform the computer either way
    } 
    
}

void deactivateLED()
{
  digitalWrite(outPin1, LOW);
  digitalWrite(outPin2, LOW);
  serialPrint(0, 8, 0, 0); // inform the computer either way
}
