
void drawClock(float ts, float x, float y) {
  
  int milliseconds = int(ts) % 1000;
  int totalseconds = (int(ts) - milliseconds)/1000;
  int seconds = int(totalseconds % 60);
  int minutes = int((totalseconds - seconds) / 60);

  String minuteString = String.valueOf(minutes);

  String secondString = String.valueOf(seconds);
  String secondFill;

  if (seconds < 10) {
    secondFill = "0";
  } 
  else {
    secondFill = "";
  }

  String milliString = String.valueOf(milliseconds);
  String milliFill;

  if (milliseconds < 10) {
    milliFill = "00";
  } 
  else if (milliseconds > 10 && milliseconds < 100) {
    milliFill = "0";
  } 
  else {
    milliFill = "";
  }

  String[] clockValues = new String[4];

  clockValues[0] = minuteString;
  clockValues[1] = ":";
  clockValues[2] = secondFill;
  clockValues[3] = secondString;

  text(join(clockValues,""),x,y);

}
