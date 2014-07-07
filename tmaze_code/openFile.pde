void openFile() {

  int d = day();
  int m = month();
  int y = year();
  int hh = hour();
  int mm = minute();
  int ss = second();

  String[] fileName = new String[4];

  String[] dateString = new String[3];
  String[] timeString = new String[3];

  dateString[0] = String.valueOf(y);
  dateString[1] = String.valueOf(m);
  dateString[2] = String.valueOf(d);

  timeString[0] = String.valueOf(hh);
  timeString[1] = String.valueOf(mm);
  timeString[2] = String.valueOf(ss);

  fileName[0] = join(dateString,"-");
  fileName[1] = join(timeString,"-");
  fileName[2] = subjectName;
  fileName[3] = ".txt";

  output = createWriter(join(fileName,"_"));
  
}

