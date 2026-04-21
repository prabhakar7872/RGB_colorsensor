import processing.serial.*;

Serial myPort;

int r = 0, g = 0, b = 0;
String colorName = "Unknown";

void setup() {
  size(500, 400);

  println(Serial.list());  
  // 👉 yaha correct port index select karo (0,1,2...)
  myPort = new Serial(this, Serial.list()[0], 9600);
  myPort.bufferUntil('\n');
}

void draw() {
  background(r, g, b);

  fill(255);
  textSize(20);
  text("RGB Color Detection", 20, 30);

  textSize(16);
  text("Red: " + r, 20, 80);
  text("Green: " + g, 20, 110);
  text("Blue: " + b, 20, 140);

  textSize(22);
  text("Color: " + colorName, 20, 200);
}

void serialEvent(Serial myPort) {
  String data = myPort.readStringUntil('\n');

  if (data != null) {
    data = trim(data);
    String[] values = split(data, ',');

    if (values.length == 3) {
      r = int(values[0]);
      g = int(values[1]);
      b = int(values[2]);

      detectColor();
    }
  }
}

// 🔥 PERFECT COLOR DETECTION FUNCTION
void detectColor() {

  int maxVal = max(r, max(g, b));

  // avoid divide by zero
  if (maxVal == 0) {
    colorName = "BLACK";
    return;
  }

  float nr = r / float(maxVal);
  float ng = g / float(maxVal);
  float nb = b / float(maxVal);

  // 🔴 BASIC COLORS
  if (r < 20 && g < 20 && b < 20) {
    colorName = "BLACK";
  }
  else if (r > 200 && g > 200 && b > 200) {
    colorName = "WHITE";
  }
  else if (abs(r - g) < 15 && abs(r - b) < 15) {
    colorName = "GREY";
  }

  // 🔴 PRIMARY COLORS
  else if (nr > 0.6 && ng < 0.4 && nb < 0.4) {
    colorName = "RED";
  }
  else if (ng > 0.6 && nr < 0.4 && nb < 0.4) {
    colorName = "GREEN";
  }
  else if (nb > 0.6 && nr < 0.4 && ng < 0.4) {
    colorName = "BLUE";
  }

  // 🟡 SECONDARY COLORS
  else if (nr > 0.5 && ng > 0.5 && nb < 0.3) {
    colorName = "YELLOW";
  }
  else if (nr > 0.5 && nb > 0.5 && ng < 0.3) {
    colorName = "MAGENTA / PINK";
  }
  else if (ng > 0.5 && nb > 0.5 && nr < 0.3) {
    colorName = "CYAN";
  }

  // 🟠 EXTRA COLORS
  else if (nr > 0.5 && ng > 0.3 && nb < 0.2) {
    colorName = "ORANGE";
  }

  else {
    colorName = "UNKNOWN";
  }
}
