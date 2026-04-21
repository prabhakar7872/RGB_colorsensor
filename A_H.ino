#define S2 3
#define S3 4
#define sensorOut 2

// RGB LED Pins
#define RED_LED 9
#define GREEN_LED 10
#define BLUE_LED 11

int red = 0;
int green = 0;
int blue = 0;

void setup() {
  pinMode(S2, OUTPUT);
  pinMode(S3, OUTPUT);
  pinMode(sensorOut, INPUT);

  pinMode(RED_LED, OUTPUT);
  pinMode(GREEN_LED, OUTPUT);
  pinMode(BLUE_LED, OUTPUT);

  Serial.begin(9600);
}

void loop() {

  // SENSOR READ
  digitalWrite(S2, LOW);
  digitalWrite(S3, LOW);
  red = pulseIn(sensorOut, LOW);

  digitalWrite(S2, HIGH);
  digitalWrite(S3, HIGH);
  green = pulseIn(sensorOut, LOW);

  digitalWrite(S2, LOW);
  digitalWrite(S3, HIGH);
  blue = pulseIn(sensorOut, LOW);

  // NORMALIZE
  int r = map(red, 20, 300, 255, 0);
  int g = map(green, 20, 300, 255, 0);
  int b = map(blue, 20, 300, 255, 0);

  r = constrain(r, 0, 255);
  g = constrain(g, 0, 255);
  b = constrain(b, 0, 255);

  // 🔥 RGB LED OUTPUT
  analogWrite(RED_LED, r);
  analogWrite(GREEN_LED, g);
  analogWrite(BLUE_LED, b);

  // SEND TO PROCESSING
  Serial.print(r);
  Serial.print(",");
  Serial.print(g);
  Serial.print(",");
  Serial.println(b);

  delay(100);
}

