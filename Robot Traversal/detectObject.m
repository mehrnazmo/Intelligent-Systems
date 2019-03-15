function [objectDetected] = detectObject(loc, obj, dir)
    % Check for object in specified direction
    switch dir
        case 'N'
            dirLoc = loc(end, :) + [-1 0];
        case 'E'
            dirLoc = loc(end, :) + [0 1];
        case 'S'
            dirLoc = loc(end, :) + [1 0];
        case 'W'
            dirLoc = loc(end, :) + [0 -1];
    end
    objectDetected = ismember(dirLoc, obj, 'rows');
end