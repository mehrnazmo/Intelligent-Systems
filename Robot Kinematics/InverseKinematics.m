%{
This function is supposed to implement inverse kinematics for a robot arm
with 3 links constrained to move in 2-D. The comments will walk you through
the algorithm for the Jacobian Method for inverse kinematics

INPUTS:
l0, l1, l2: lengths of the robot links
x_e_target, y_e_target: Desired final position of the end effector 

OUTPUTS:
theta0_target, theta1_target, theta2_target: Joint angles of the robot that
take the end effector to [x_e_target,y_e_target]
%}

function [theta0_target, theta1_target, theta2_target] = InverseKinematics(l0,l1,l2,x_e_target,y_e_target)
    % Initialize the thetas to some value
    theta0 = pi/3;
    theta1 = 0;
    theta2 = 0;
    
    alpha = 0.1;

    % Obtain end effector position x_e, y_e for current thetas: 
    % HINT: use your ForwardKinematics function
    [x_1,y_1,x_2,y_2,x_e,y_e] = ForwardKinematics(l0,l1,l2, theta0, theta1, theta2);
    

    while  sqrt((x_e_target - x_e)^2 + (y_e_target - y_e)^2) > 0.1 %(Replace the '1'  with a condition that checks if your estimated [x_e,y_e] is close to [x_e_target,y_e_target])

        % Calculate the Jacobian matrix for current values of theta:
        % HINT: write a function for doing this
        j1 = -1*l0*sin(theta0) - l1*sin(theta0 +theta1) - l2*sin(theta0 +theta1 +theta2);
        j2 = -1*l1*sin(theta0 +theta1) - l2*sin(theta0 +theta1 +theta2);
        j3 = -1*l2*sin(theta0 +theta1 +theta2);
        j4 = l0*cos(theta0)+l1* cos(theta0 +theta1)+l2*cos(theta0 +theta1 +theta2);
        j5 = l1*cos(theta0 + theta1) +l2*cos(theta0 +theta1 +theta2);
        j6 = l2*cos(theta0 +theta1 +theta2);
        
        J = [j1,j2,j3;j4,j5,j6];
        % Calculate the pseudo-inverse of the jacobian using 'pinv()': 
        J_inv = pinv(J);
        % Update the values of the thetas by a small step:
        del = alpha * J_inv * [x_e_target - x_e; y_e_target - y_e];
        theta0 = del(1) + theta0;
        theta1 = del(2) + theta1;
        theta2 = del(3) + theta2;
        % Obtain end effector position x_e, y_e for the updated thetas:
        [x_1,y_1,x_2,y_2,x_e,y_e] = ForwardKinematics(l0,l1,l2, theta0, theta1, theta2);
        % Draw the robot using drawRobot( ) : This will help you visualize how the robot arm moves through the iteration: 
        drawRobot(x_1,y_1,x_2,y_2,x_e,y_e);
        pause(0.00001)  % This will slow the loop just a little bit to help you visualize the robot arm movement 
        hold on;
    end
    % Set the theta_target values:
    theta0_target = theta0;
    theta1_target = theta1;
    theta2_target = theta2;
end