% Set room size
vSize = 9; hSize = 9;

% Initialize position and object locations, then display.
loc = [1 7]; 
% For part a-iii) add 4 7 below. For part c) add 5 5.
%obj = [1 4; 3 8; 4 9; 6 6; 3 1; 2 3; 8 2]; 
obj = [1 4; 3 8; 4 9; 6 6; 3 1; 2 3; 8 2; 4 7; 5 5; 5 7];
room = figure;
displayRoom(loc, obj, vSize, hSize); pause;

while(1)
    % Make the robot move a certain direction
    nextStep = loc(end,:) + [1 0];
    
    % If there is an object to the South, move a different direction
    % START
    no_south = detectObject(loc, obj, 'S') || haveIBeenHereBefore(loc, nextStep);
    no_east = detectObject(loc, obj, 'E') || haveIBeenHereBefore(loc, nextStep+[-1 1]);
    no_west = detectObject(loc, obj, 'W') || haveIBeenHereBefore(loc, nextStep + [-1 -1]);
    no_north = detectObject(loc, obj, 'N') || haveIBeenHereBefore(loc, nextStep+ [-2 0]);
    if no_south
        if no_west && ~no_east
            nextStep = loc(end,:) + [0 1];
        elseif (no_east && ~no_west) || (~no_west && ~no_east)
            nextStep = loc(end,:) + [0 -1];
        elseif no_east && no_west
            nextStep = loc(end,:) + [-1 0];
        else
            nextStep = loc(end,:) + [1 0];
        end
    end
    % STOP
    
    % Update location if no object is in the way and within bounds
    if ~ismember(nextStep, obj, 'rows') ...
            && nextStep(1) >= 1 && nextStep(1) <= vSize ...
            && nextStep(2) >= 1
        loc = cat(1, loc, nextStep);
    end
    
    % Show new position
    displayRoom(loc, obj, vSize, hSize);
    
    % Check if the South side of the image has been reached
    if loc(end,1) == hSize
        break;
    end
    
    % Pause all operations until the user presses a key
    pause
end
