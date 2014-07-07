void drawTrack(int rewardArm, int door, int lastArm, boolean centerArm, boolean active) {
  
  pushMatrix();
  translate(90,100);
  
  float s = 20;
  
  fill(dark_grey);
  stroke(med_grey);
  strokeWeight(4);
  
  beginShape();
  
  vertex(0,0);
  vertex(2*s,0);
  vertex(3*s,0.5*s);
  vertex(13*s,0.5*s);
  vertex(14*s,0);
  vertex(16*s,0);
  vertex(16*s,3*s);
  vertex(14*s,3*s);
  vertex(13*s,2.5*s);
  
  vertex(10*s,2.5*s);
  vertex(9*s,3.5*s);
  vertex(9*s,10*s);
  vertex(10*s,11*s);
  
  vertex(13*s,11*s);
  vertex(14*s,10.5*s);
  vertex(16*s,10.5*s);
  vertex(16*s,13.5*s);
  vertex(14*s,13.5*s);
  vertex(13*s,13*s);
  vertex(3*s,13*s);
  vertex(2*s,13.5*s);
  vertex(0,13.5*s);
  vertex(0,10.5*s);
  vertex(2*s,10.5*s);
  vertex(3*s,11*s);
  vertex(6*s,11*s);
  vertex(7*s,10*s);
  vertex(7*s,3.5*s);
  vertex(6*s,2.5*s);
  
  vertex(3*s,2.5*s);
  vertex(2*s,3*s);
  vertex(0,3*s);
  vertex(0,0);
  
  endShape();
  
  noStroke();
  pushMatrix();
  
  switch (rewardArm) {
    case forcedChoiceR: 
      fill(ggreen);
      translate(0,10.5*s);
      break;
    case freeChoiceL:
      fill(rred);
      translate(0*s,0*s);
      break;
    case freeChoiceR:
      fill(orange);
      translate(13*s,0*s);
      break;
    case forcedChoiceL:
      fill(yellow); 
      translate(13*s,10.5*s);
      break;
  }
  
  ellipse(1.5*s,1.5*s,2*s,2*s);
  
  popMatrix();
  
        stroke(255);
      strokeWeight(10);
  
  switch (door) {
    case 1:
      line(6*s,13*s,6*s,11*s);
      if (forcedChoiceMode)
      {
        line(6*s, 3*s-5, 6*s, 0*s+10); 
      }
      break;
    case 2:
      line(10*s,13*s,10*s,11*s);
      if (forcedChoiceMode)
      {
        line(10*s, 3*s-5, 10*s, 0*s+10); 
      }
      break;
  }
      

  
   noFill();
   strokeWeight(3.0);
  pushMatrix();
  
  switch (lastArm) {
    case forcedChoiceR: 
      stroke(ggreen);
      translate(0,10.5*s);
      break;
    case freeChoiceL:
      stroke(rred);
      translate(0*s,0*s);
      break;
    case freeChoiceR:
      stroke(orange);
      translate(14*s,0*s);
      break;
    case forcedChoiceL:
      stroke(yellow); 
      translate(14*s,10.5*s);
      break;
  }
  
  rect(0,0,2*s,3*s);
  
    popMatrix();
  
    
  
    // draw mouse location
    if (centerArm)
    {
      if (active)
        fill(bblue);
      else
        fill(light_grey); 
        
      noStroke();
      
      if (true) // switch this for stimulation type
      {
        rect(7*s, 3.5*s, 2*s, 6.5*s); // actual center arm
      } else {
        switch (door)
        {
         case 2:
            rect(3*s,11*s,3*s,2*s); // forced-choice arm 2
            break;
         case 1:
            rect(10*s,11*s,3*s,2*s); // forced-choice arm 1
            break;
        }
        
      }
      
      
      
    }
  
    popMatrix();
  
}
