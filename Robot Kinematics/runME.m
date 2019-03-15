% You can use this file to invoke the functions in this problem
% For example, initialize your lengths and theta values
% Call ForwardKinematics(), drawRobot(), and InverseKinematics in this file
close all;
clear all;
clc;

%% Part a
l0 = 3;
l1 =5;
l2 =7;
theta0 = pi/6;
theta1 = pi/4;
theta2 = -1*pi/3;

[x_1,y_1,x_2,y_2,x_e,y_e] = ForwardKinematics(l0,l1,l2, theta0, theta1, theta2);
drawRobot(x_1,y_1,x_2,y_2,x_e,y_e);

%hold on; 

%% Part b
l0 = 5;
l1 =5;
l2 =5;
theta0 = pi/6;
theta1 = pi/6;
theta2 = pi/6;
[x_1,y_1,x_2,y_2,x_e,y_e] = ForwardKinematics(l0,l1,l2, theta0, theta1, theta2);
drawRobot(x_1,y_1,x_2,y_2,x_e,y_e);

%% Part ii
x_e_target = 6;
y_e_target= 9;
InverseKinematics(l0,l1,l2,x_e_target,y_e_target);
