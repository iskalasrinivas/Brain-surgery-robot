%% Takes in values for x,y and z co ordinates for targets
function Motor_move(x,y,z)
% Setting up serial commuincation with arduino
port_name = 'COM5';
arduino=serial(port_name,'BaudRate',9600);
fopen(arduino);
%% Declare Integers for our three motors
motor_x = 1;
motor_y = 2;
motor_z = 3;
%% Integers for Deciding the direction of rotation
clockwise = 1;
anticlockwise = 2;

%% Computation of step count of each motor from distances
stepsx = abs((x/8)*200);
stepsy = abs((y/8)*200);
stepsz = abs((z/80)*400);

%% Chosing direction of motor spin
if x<0
xdir= anticlockwise;
else
xdir= clockwise;
end

if y<0
ydir= anticlockwise;
else
ydir= clockwise;
end

if z<0
zdir= anticlockwise;
else
zdir= clockwise;
end


pause(2)

%% Sending commands to Arduino
fprintf(arduino, '%s', char(motor_x));
fprintf(arduino, '%s', char(xdir)); 
fprintf(arduino, '%u', floor(stepsx));

fprintf(arduino, '%s', char(motor_y));
fprintf(arduino, '%s', char(ydir)); 
fprintf(arduino, '%u', floor(stepsy));

fprintf(arduino, '%s', char(motor_z));
fprintf(arduino, '%s', char(zdir)); 
fprintf(arduino, '%u', floor(stepsz));

fclose(arduino);
end
