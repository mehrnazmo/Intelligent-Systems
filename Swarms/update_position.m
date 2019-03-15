function [curPos, route, dest, explore_map] = update_position(curPos, route, dest, explore_map, MAPPED)
% Write this function so that:
% 1) update curPos 1 step closer to the destination using route
% 2) mark the new location of the bot as MAPPED
% 3) if the new location of the bot is at the destination, set destination
%    to be empty, i.e. dest = []
% 4) update the route by removing the location that the bot was just
%    updated to e.g. if route was inputted as an Nx2 matrix, it should
%    output as a (N-1)x2 matrix.

% The lines below are not part of the solution and are only written here
% so that runMe.m can actually run without having written the functions yet
%curPos = curPos + randi([-1 1],[1 2]);

curPos = route(1,:);
explore_map(curPos) = MAPPED;
if curPos==dest
    dest = [];
end
route = route(2:end,:);

end

