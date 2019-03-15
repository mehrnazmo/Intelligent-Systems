function out = haveIBeenHereBefore(loc, nextStep)
% This function can be used to determine if the robot has previously been 
% to the location specified in nextStep.
% -- loc is the set of previous locations traversed by the robot
% -- nextStep is the new location for which the test is to be performed
% -- out is a boolean value equal to 1 if nextStep has been previosuly
% visited, else 0
out = ~isempty(find(ismember(loc, nextStep, 'rows'), 1));

end

