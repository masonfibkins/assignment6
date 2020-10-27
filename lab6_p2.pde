import processing.serial.*;

Serial myPort; // The serial port
int button = 1;
int xPos = 475;// horizontal position of the graph
int yPos = 325;
float xData = 0;
float yData = 0;




void setup () {
  // set the window size:
  size(1000, 700);

  // List all the available serial ports
  // if using Processing 2.1 or later, use Serial.printArray()

  //println(Serial.list()); //Used to check which serial ports are avaliable

  // I know that the first port in the serial list on my Mac is always my
  // Arduino, so I open Serial.list()[0].
  // Open whatever port is the one you're using.
  myPort = new Serial(this, "/dev/cu.usbmodem14101", 9600);

  // don't generate a serialEvent() unless you get a newline character:
  myPort.bufferUntil('\n');

  // set initial background:
  background(0);
}

void draw () {
  clear();
  fill(255,255,255);  
  rect(xPos, yPos, 50, 50);
  
  if(xPos >495){
    xPos += xData/150;
  }else if(xPos < 495){
    xPos -=(495 - xPos)/150;
  }

    if(yData >513){
    yPos += yData/150;
  }else if(yData < 513){
    yPos -=(513 - yData)/150;
  }
  
 
}

void serialEvent (Serial myPort) {
  // get the ASCII string:
  String inString = myPort.readStringUntil('\n');

  if (inString != null) {
    // trim off any whitespace:
    inString = trim(inString);
    String[] splitData = inString.split(",");
    
    xData = float(splitData[0]);
    yData = float(splitData[1]);
    
    
    println("X value: " +xData);
    println("Y value: " +yData);
    

}
}
