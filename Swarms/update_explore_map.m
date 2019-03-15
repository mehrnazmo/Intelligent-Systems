function explore_map = update_explore_map(dest, route, explore_map, PLANNED, UNMAPPED)
% Write this function so that all the locations specified in route and dest
% are marked as PLANNED only if it was previous UNMAPPED in the explore_map
% variable.

for i=1:size(route,1)
    m = route(i,1);
    n = route(i,2);
    if explore_map(m,n) == UNMAPPED
        explore_map(m,n) = PLANNED;
    end
end

% if explore_map(dest)==UNMAPPED
%     explore_map(dest)=PLANNED;
% end

end