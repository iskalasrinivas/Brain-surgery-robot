%% Main file
% This is the main file that executes all functions
clear all 
% We extract pixel coordinates of fiducials from this function
[centroids] = camera_calib; 
% We compute location of targets in robot frame using the function below
[Hot1, Hot2, Hot3] = robotcalib(centroids);
% The next command runs the GUI for our target selection and homing
RobotGUI