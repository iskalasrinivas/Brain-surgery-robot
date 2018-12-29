
/*
 Stepper Motor Control

 This program drives a unipolar or bipolar stepper motor.
 The motor is attached to digital pins 2 - 5 of the Arduino.

 The motor should rotate by specified number of steps.
 The specified number of steps come from MATLAB via serial connection 

 Program written for the course ENME489C.

 */

#include <Stepper.h>

int requiredSteps = 0;  // to build 2 byte integer from serial in coming from MATLAB
short dir; // Direction of Rotation; 1 for clockwise 2 for anticlockwise
short motor_num; //Which motor to run?
const int stepsPerRevolution = 200; // Pull this value from the Stepper Motor Spec Sheet

// initialize the stepper library on pins 2 through 13:
Stepper motor_z(stepsPerRevolution, 2, 3, 4, 5);
Stepper motor_y(stepsPerRevolution, 6, 7, 8, 9);
Stepper motor_x(stepsPerRevolution, 10,11, 12, 13);

void setup() {
  // initialize the serial port:
  Serial.begin(9600);
  /*Serial.println('a');
  char a = 'b';
  while (a != 'a')
  {
    a = Serial.read();
  }*/

  // set the speeds
  motor_x.setSpeed(30);
  motor_y.setSpeed(60);
  // set z -axis speed to be slow
  motor_z.setSpeed(30);
}

void loop() {
  
  while (Serial.available() == 0)
  {
  }
  
  if(Serial.available()>0)
  {
    motor_num = Serial.read();
    delay(10);
    dir = Serial.read();
    delay(10);
    requiredSteps = Serial.parseInt();
    switch(motor_num)
    {
      case 1: 
        spin_motor(motor_x, requiredSteps, dir);
        break;
      case 2:
        spin_motor(motor_y, requiredSteps, dir);
        break;
      case 3:
        spin_motor(motor_z, requiredSteps, dir);
        break;  
    }
    delay(500);
    //Serial.println('d');
  }

}


void spin_motor(Stepper mot, int requiredSteps, short dir)
{
  if (dir == 1)
    mot.step(requiredSteps);   
  if (dir == 2)
    mot.step(-(requiredSteps));
}
