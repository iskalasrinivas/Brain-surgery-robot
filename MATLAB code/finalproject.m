%%
% Use following digitial pins on the arduino for the appropriate motor
% 2-3-4-5 for motor X
% 6-7-8-9 for motor Y
% 10-11-12-13 for motor Z
clear all
%%
% Setup Arduino Connection
port_name = 'COM5';
arduino=serial(port_name,'BaudRate',9600);

%% Declare Integers for our three motors
motor_x = 1;
motor_y = 2;
motor_z = 3;

%% Integers for Deciding the direction of rotation
clockwise = 1;
anticlockwise = 2;

%% 
% Sample code for running the motor of your choice.
% This can be used for testing your connections and checking whether all
% three motor are spining correctly.
% The serial connection on the Arduino end is expecting three inputs(in
% the same order) - 
% 1. Motor_number(motor_x(1), motor_y(2), motor_z(3))
% 2. Direction of rotation(clock(1), antoclock(2))
% 3. Number of steps(integer value for number of steps required)

% Choose the number of steps
steps =0 ;

fopen(arduino);
pause(2)
fprintf(arduino, '%s', char(motor_x));
fprintf(arduino, '%s', char(anticlockwise)); 
fprintf(arduino, '%u', floor(steps)); % send answer variable content to arduino
fclose(arduino);