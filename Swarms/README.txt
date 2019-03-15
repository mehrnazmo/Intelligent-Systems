***********************************************
Swarms
*******************************************************************
The goal of this project is to implement behaviors that increase the efficiency of the swarm. In this project we want to program swarm robots efficiently to explore an area, where the bots are provided with the locations of all the walls. We will be using "calculate_astar_path.m" to calculate our new position which will calculate a route for the bot to travel without colliding into a wall. 

Read through runMe.m to understand what is happening in the code.

The following functions direct the swarm:
get_unexplored_areas.m
get_new_destination.m
update_explore_map.m
update_position.m

These functions are all called in runMe.m and are commented with "(TODO: write this function)"

Variable details:
curPos: 1x2 matrix containing the location of the bot
dest: 1x2 matrix containing the next location the bot is headed towards (e.g. destination)
route: Nx2 matrix containing a sequence of locations the bot takes in order reach the destination. The first row (i.e. route(1,:) contains the next immediate step the box should take. The last row (i.e. route(end,:)) contains the same location as dest.
explore_map: a params.HEIGHT x params.WIDTH matrix containing information on whether locations are:
             - walls: locations where bots cannot move to
             - unmapped: locations where bots have not visited
             - planned: locations where bots have planned to go (either en route or the final destination)
             - mapped: location where bots have visited