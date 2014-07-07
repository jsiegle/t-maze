class StatCounter {
  
  int totalChoices;
  int correctChoices;
  int rightTurns;
  int leftTurns;
  float bias;
  
  StatCounter() {
    
    totalChoices = 0;
    correctChoices = 0;
    rightTurns = 0;
    leftTurns = 0;
    bias = 0.5;
    
  }
  
  void reset() {
   
    totalChoices = 0;
    correctChoices = 0;
    rightTurns = 0;
     leftTurns = 0;    
  }
  
  void update(boolean wasLeft, boolean wasCorrect) {
    
    totalChoices += 1;
    
    if (wasLeft) {
      leftTurns += 1;
    } else {
      rightTurns += 1;
    }
    
    if (wasCorrect) {
      correctChoices += 1;
    }
    
    bias = float(rightTurns) / totalChoices;
    
  }
  
  void display() {
    
    int leftMargin = 470;
    int topMargin = 200;
    int lineHeight = 20;
   
    textSize(lineHeight-4);
    text("STATISTICS",leftMargin,topMargin-10);
   
    String str1 = "Total choices: " + totalChoices; 
    String str2 = "Correct choices: " + correctChoices;
    String str3 = "Left turns: " + leftTurns;
    String str4 = "Right turns: " + (totalChoices-leftTurns);
    String str5 = " " + round(bias*100) + "%";
    String str6 = " " + round((1-bias)*100) + "%";
    
    text(str1,leftMargin,topMargin+lineHeight*1);
    text(str2,leftMargin,topMargin+lineHeight*2);
    text(str3,leftMargin,topMargin+lineHeight*3);
    text(str4,leftMargin,topMargin+lineHeight*4);
    
    fill(orange);
    textSize(25);
    text(str5,363,80);
        fill(rred);
    text(str6,87,80);
    
  }
  
}
