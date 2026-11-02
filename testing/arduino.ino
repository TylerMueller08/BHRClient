#include <Servo.h>

Servo myServo;

void setup() {
  myServo.attach(9);
  Serial.begin(9600);
}

void loop() {
  if (Serial.available()>0) {
    char com = Serial.read();
    if (com=='A') {
      myServo.write(180);
      delay(1000);
      myServo.write(0);
    }
  }
}