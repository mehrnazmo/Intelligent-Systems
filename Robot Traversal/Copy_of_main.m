clc; clear all; close all;

% There are three functions you need to use from the Potential class.
% The constructor is Potential(x_size, y_size);
% addGoal(loc, intensity, width);
% addRepulsor(loc, intensity, width)
% addAttractor(loc, intensity, width)
% The the comments in Potential for more information on these calls.

loc = [5, 75];
goal = [95, 5];
potentialField = Potential(100, 100);
% TODO: Add the goal and repulsors to the potential field.
% They must be added before the next comment.


%% initial floor plan
potentialField.goal = addGoal(potentialField,goal);
repulsor = [4,50];
obj1 = addRepulsor(potentialField,repulsor,1,[5,5]);
%Comment the following line if runnig the secondary floor plan
%potentialField.repulsor  = obj1;

% Secondary floor plan
%loc = [95,95];
%goal = [50,1];
%loc = [70,70];
repulsor2 = [50,50];
%addRepulsor(obj, loc, intensity, width)
obj2 = addRepulsor(potentialField,repulsor2,1,[30,30]);
repulsor3 = [50,5];
obj3 = addRepulsor(potentialField,repulsor3);
repulsor4 = [90,90];
obj4 = addRepulsor(potentialField,repulsor4,1,[10,5]);
repulsor5 = [30,85];
obj5 = addRepulsor(potentialField,repulsor5,1,100);
repulsor6 = [20,20];
obj6 = addRepulsor(potentialField,repulsor6);
potentialField.repulsor = [obj1;obj2;obj3;obj4;obj5;obj6];
%attractor = [10,90];
%potentialField.attractor = addAttractor(potentialField,attractor);


%% 
% ************Above Here**************
x = potentialField.x;
y = potentialField.y;
z = potentialField.getField();
dx = potentialField.getdx();
dy = potentialField.getdy();

% Example plotting DO NOT INCLUDE IN YOUR REPORT.
% figure();
% meshc(x, y, z(x, y)); hold on;

% TODO: Plot the field in 3 separate figures as follows
% 1) The mesh
% 2) The contours
% 3) The arrows
% On each, indicate where the bot begins with a red asteriks

%Initial plots
figure(1);
mesh(x,y,z(x,y));
hold on;
plot3(loc(1), loc(2), z(loc(1),loc(2)),'r','Marker','*');

figure(2);
contour(x,y,z(x,y));
hold on;
plot3(loc(1), loc(2), z(loc(1),loc(2)),'r','Marker','*');
hold on;
quiver(x,y,-1*dx(x,y),-1*dy(x,y));


%% 
% TODO: Implement the gradient descent algorithm. The dx and dy objects will be
% useful :)

figure(3);
%Plotting the contour
% contour(x,y,z(x,y));
% hold on;
% quiver(x,y,-1*dx(x,y),-1*dy(x,y));
% hold on;

mesh(x,y,z(x,y));
hold on;
plot3(loc(1), loc(2), z(loc(1),loc(2)),'r','Marker','*');

%alpha = 1; %Non-diminishing method
while (sqrt(dx(loc(1),loc(2)).^2 + dy(loc(1),loc(2)).^2)) > 0.0001
    alpha = 1/sqrt(dx(loc(1),loc(2)).^2 + dy(loc(1),loc(2)).^2);
    loc = loc - alpha * [dx(loc(1),loc(2)),dy(loc(1),loc(2))];
    plot3(loc(1), loc(2), z(loc(1),loc(2)),'r','Marker','*');
    hold on; 
end









