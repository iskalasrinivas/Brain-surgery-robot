%% Takes centroids of fiducials in pixel co ordinates as input and returns targets in robot frame as output
function [Hot1, Hot2, Hot3] = robotcalib(centroids)
syms x y z
%% camera extrinsics obtained from camera calibration toolbox
re=[-0.04 0.999 0.014;0.9849 0.0371 0.1689;0.1682 0.0205 -0.9855];
te=[-66.4753;-28.6583;395.762];
%% camera frame represented in checkerboard frame

%% Calculating inverse of the camera extrinsic matrix
R=re'; 
t=-re'*te;
 Hbc=zeros(4,4);
 Hbc(1:3,1:3)=R;
 Hbc(1:3,4)=t;
 Hbc(4,:)=[0 0 0 1]; 
 
%% Transformation of cheker board frame to robot frame r1*r2
r1=[0 1 0 0;-1 0 0 0;0 0 1 0;0 0 0 1];
r2=[-1 0 0 0;0 1 0 0;0 0 -1 0;0 0 0 1];

%% The following homogeneous transformation matrix is obtained by robot calibration.
Hob=[0.998 0 -0.0519 10.8;0.01 0.999 0.1996 28;0.0499 -0.2 0.9970 22;0 0 0 1]; % Represents checker board frame in robot frame
%% The following matrix represents camera frame in robot frame 
Hoc=Hob*r1*r2*Hbc

%% Targets in fiducial frame
Hf1=[42.59;-79.22;54.77;1]; % Target 1 in fiducial frame
Hf2=[78.05;-58.50;54.77;1]; % Target 2 in fiducial frame
Hf3=[111.55;-78.97;54.77;1]; % Target 3 in fiducial frame

%% Calculation of fiducials in camera frame
Hcf = zeros(4,4); % represents fiducials in camera frame

i=[797.6443 0 411.9271;0 795.3714 262.8443;0 0 1]; % Intrinsic Matrix obtained from camera calibration
j=[re te]; % Extrinsic matrix obtained form camera calibration
k=i*j; % Product of intrinsic and extrinsic matrices

%% Computing Pseudo Inverse of K to get Pixel coordinates in World (Checker board) coordinates
l=pinv(k)*[centroids(1,1);centroids(1,2);1];

w1=l/l(4,1); % Fiducial 1 in checker board frame
l2=pinv(k)*[centroids(2,1);centroids(2,2);1];
w0=l2/l2(4,1); % Fiducial 2 in checker board frame (CHOSEN AS ORIGIN FOR FIDUCIAL FRAME)
l4=pinv(k)*[centroids(3,1);centroids(3,2);1];
w3=l4/l4(4,1); % Fiducial 3 in checker board frame

%% Computation for fiducial frame
Ry = (w1(1:3)-w0(1:3))/norm(w1(1:3)-w0(1:3));
Rx = (w3(1:3)-w0(1:3))/norm(w3(1:3)-w0(1:3));
Rz = cross(Rx,Ry);
t = w0(1:3);
Gcf = [Rx Ry Rz t];
H0f(1:3,1:4)=Gcf; % Fiducial frame in world frame (checker board)
H0f(4,:)=[0 0 0 1];
r3=[1 0 0 0;0 -1 0 0;0 0 -1 0;0 0 0 1]; 

%% Transformation of fiducial frame into camera frame
Hcf=[-0.04 0.999 0.014 -66.4753;0.9849 0.0371 0.1689 -28.6583;0.1682 0.0205 -0.9855 395.762;0 0 0 1]*H0f*r3


%% Computing targets in robot frame and compensating for errors (Deflection of given needle, etc.,.)
Hot1=(Hoc*Hcf*Hf1)+[37;-20;2;0] % Target 1 in robot frame 
Hot2=(Hoc*Hcf*Hf2)+[39;-18;2;0] % Target 2 in robot frame
Hot3=(Hoc*Hcf*Hf3)+[39;-20;0;0] % Target 3 in robot frame

end