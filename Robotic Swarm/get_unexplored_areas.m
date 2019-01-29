function unexplored_areas = get_unexplored_areas(explore_map, UNMAPPED)
% Write this function so that unexplored_areas is a Nx2 matrix
% where N is the number of locations the bots have not explored, and each
% row of unexplored_areas represents a location (row,col) in the map.
% We define unexplored areas as locations which have values UNMAPPED in
% explore_map. Locations with values PLANNED/MAPPED/WALL are not considered
% unexplored areas in this case. If there are no unexplored areas, then
% unexplored_areas should return empty [], i.e. unexplored_areas = [];

% The lines below are not part of the solution and are only written here
% so that runMe.m can actually run without having written the functions yet


[cols,rows] = ...
    meshgrid(1:size(explore_map,2),1:size(explore_map,1));
unexplored_areas = [rows(:),cols(:)];
unexplored_areas = unexplored_areas(find(explore_map==UNMAPPED),:);

end

