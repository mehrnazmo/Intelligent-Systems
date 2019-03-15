function displayRoom(loc,obj,vSize,hSize)
    % Create empty room
    room = zeros(vSize,hSize);
    
    % Represent objects with gray
    room(obj(:,1) + vSize*(obj(:,2)-1)) = 127;
    
    % Represent past locations with light gray
    room(loc(1:end-1,1) + vSize*(loc(1:end-1,2)-1)) = 191;
    
    % Represent current location with white
    room(loc(end,1) + vSize*(loc(end,2)-1)) = 255;
    
    imagesc(uint8(room)); colormap('gray');
    title('Press any key to continue. Ctrl+C (or Cmd+C) to stop simulation.');
end