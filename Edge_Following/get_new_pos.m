function [ newPos ] = get_new_pos( curPos, sensorInput, dir )
% sensorInput is a 3x3 matrix and follows the following convention. 
% sensorInput = [   a   b   c   ;
%                   d   x   e   ;
%                   f   g   h   ];
% 'x' is the location of the bot.
% a to h are either '0' or '1' depending on the presence of obstacle in
% those blocks. For example take the image shown in Q2. At this location
% sensorInput = [1 1 1;
%                0 0 0;
%                0 0 0];
    newPos = curPos;
    if dir == 0
        if (sensorInput(1,2) == 1) && (sensorInput(2,3) == 0)   %Object Up
            newPos(2) = newPos(2) + 1; % Move Right
        elseif (sensorInput(1,2) == 0) && (sensorInput(1,1) == 1)
            newPos(1) = newPos(1) -1;
        elseif (sensorInput(1,2) == 1) && (sensorInput(2,3) == 1) && (sensorInput(1,2) == 1) && (sensorInput(3,2) == 0) 
            newPos(1) = newPos(1) + 1; % Move Down
        elseif (sensorInput(1,2) == 0) && (sensorInput(2,3) == 1) && (sensorInput(3,2) == 0)
            newPos(1) = newPos(1) + 1; % Move Down
        elseif (sensorInput(1,2) == 0) && (sensorInput(2,3) == 1) && (sensorInput(3,2) == 1) 
            newPos(2) = newPos(2) -1; %Move Left
        elseif (sensorInput(3,2) == 1) && (sensorInput(2,3) == 0)
            newPos(2) = newPos(2) -1; %Move Left
        elseif (sensorInput(2,1) == 1) && (sensorInput(1,2) == 0)
            newPos(1) = newPos(1) - 1; % Move Up
        elseif (sensorInput(3,1) == 1) && (sensorInput(3,2) == 0)
            newPos(2) = newPos(2) -1; %Move Left
        elseif (sensorInput(3,3) == 1) && (sensorInput(2,3) == 0)
            newPos(1) = newPos(1) + 1; % Move Down
        elseif (sensorInput(1,3) == 1) && (sensorInput(1,2) == 0)
            newPos(2) = newPos(2) + 1; % Move Right          
        end
    elseif dir == 1
        if (sensorInput(1,2) == 1) && (sensorInput(2,1) == 0)
            newPos(2) = newPos(2) - 1; % Move Left
        elseif (sensorInput(1,2) == 1) && (sensorInput(2,1) == 1)
            newPos(1) = newPos(1) + 1; % Move Down
        elseif (sensorInput(1,2) == 0) && (sensorInput(1,1) == 1) && (sensorInput(2,1) == 0)
            newPos(2) = newPos(2) - 1; % Move Left
        elseif (sensorInput(1,2) == 0) && (sensorInput(1,3) == 1)
            newPos(1) = newPos(1) - 1; % Move Up
        elseif (sensorInput(1,2) == 0) && (sensorInput(2,1) == 1) && (sensorInput(3,2) == 0)
            newPos(1) = newPos(1) + 1; % Move Down 
        elseif (sensorInput(1,2) == 0) && (sensorInput(2,1) == 1) && (sensorInput(3,2) == 1)
            newPos(2) = newPos(2) + 1; % Move Right  
        elseif (sensorInput(3,2) == 1) && (sensorInput(2,1) == 0) && (sensorInput(2,3) == 0)
            newPos(2) = newPos(2) +1; %Move Right 
        elseif (sensorInput(2,3) == 1) && (sensorInput(1,3) == 0)
            newPos(1) = newPos(1) -1; %Move Up 
        elseif (sensorInput(3,3) == 1) && (sensorInput(3,2) == 0)
            newPos(2) = newPos(2) + 1; %Move Right 
        elseif (sensorInput(3,1) == 1) && (sensorInput(3,2) == 0)
            newPos(1) = newPos(1) + 1; % Move Down 

        end
    end
end