void calibrate() {

  //Serial.println("Calibrating IR receivers...");

  for (int n = 0; n < nSensors; n++) 
  {
    IRsensorPins[n] = n; // set pin number

    IRcanBePassed[n] = 1; // all sensors are active

    int calibrationValue = 0; // initialize value to zero

    for (int i = 0; i < 10; i++) {
      IRsensorValues[n] = analogRead(IRsensorPins[n]);
      delay(100);
      calibrationValue += IRsensorValues[n];
    }

    if (n == orangeArm) { 
      IRthresholds[n] = calibrationValue/10 + 80;
    } 
    else if (n == yellowArm) { 
      IRthresholds[n] = calibrationValue/10 + 80;
    } 
    else if (n == middleArm1) {
      IRthresholds[n] = calibrationValue/10 + 80;
    }
    else {
      IRthresholds[n] = calibrationValue/10 + 80;
    }

    serialPrint(n, 0, IRthresholds[n], IRcanBePassed[n]);

  }

  /*Serial.println(" ");
   Serial.println("Ready to begin.");
   Serial.println(" ");*/
}


