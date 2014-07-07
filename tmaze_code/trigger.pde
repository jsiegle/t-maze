  void trigger(int sensorNum) {
    
    if (sensorNum == middleArm1 || sensorNum == middleArm2)
    {
      return;
    }
    // update stats //
    
     if (isPlaying) {
       
    if (previousArm == forcedChoiceL || previousArm == forcedChoiceR) {
     
      if (sensorNum == freeChoiceL || sensorNum == freeChoiceR) {
        boolean wasCorrect;
        boolean wasLeft = false;
        
        if (sensorNum == activeArm) {
          wasCorrect = true;
          
          byte message;
          if (sensorNum == freeChoiceL) {
            message = 0;
          } else {
            message = 1;
          }
          myPort.write(message);
          
        } else {
          wasCorrect = false;
        }
        
        if (sensorNum == freeChoiceL) {
          wasLeft = true;
        }
       
        stats.update(wasLeft,wasCorrect);     
  
       
       float nextArmProb = random(0,1); // randomly choose a new forced-choice arm
       
       float biasRight = min(stats.bias,0.8); // bias not greater than 80%
       biasRight = max(biasRight,0.2); // bias not less than 20%
       
       if (nextArmProb > biasRight) {
           activeArm = forcedChoiceL;
           activeGate = rightGate;
       } else {
           activeArm = forcedChoiceR;
           activeGate = leftGate;
       }
      }
        
    } else { // mouse came from a free-choice arm
    
    if (sensorNum == activeArm) {  // mouse has entered a forced-choice arm
    
      switch (activeArm) {
        case forcedChoiceL:
           activeArm = freeChoiceR;
           break;
        case forcedChoiceR:
           activeArm = freeChoiceL;
           break;
        default:
          // do nothing
      }
    }
    }
    
    previousArm = sensorNum;
    
     }
    
    // }
    
  }
