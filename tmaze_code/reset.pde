void reset() {
    stats.reset();
      elapsedTime = 0;
      activeArm = freeChoiceL;
      activeGate = leftGate;
      previousArm = forcedChoiceR;
       myPort.write(65); // send byte to Arduino to force hardware reset
       randomSeed(millis());
}
