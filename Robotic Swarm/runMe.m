clear all; clc; close all;

addpath('astar');

% initialize parameters
params = [];
params.HEIGHT = 50; % map height
params.WIDTH = 50; % map width
params.NUM_BOTS = 5; % number of bots
params.MAX_ITR = 1000; % maximum number of iterations

% define constants for the map
const.WALL = 1; % value for a wall in the map matrix
const.MAPPED = 0.4; % value for a mapped area in map matrix
const.PLANNED = 0.2; % value for a bot's planned path in map matrix
const.UNMAPPED = 0; % value for a unmapped area in map matrix

% define structure to hold all information about the bots and map
botNetwork = [];

% define the provided blueprint map
botNetwork.MAP = padarray(const.UNMAPPED*ones([params.HEIGHT, params.WIDTH]-2),[1 1],const.WALL); % a map provided to the bot network
botNetwork.MAP(10:20,36) = const.WALL;
botNetwork.MAP(10:20,45) = const.WALL;
botNetwork.MAP(10,36:38) = const.WALL;
botNetwork.MAP(10,43:45) = const.WALL;
botNetwork.MAP(20,36:45) = const.WALL;

% define the bot's map of explored areas
botNetwork.explore_map = botNetwork.MAP; % a map the bot network uses to keep track of where bots have visited

% initialize positions, dest, route, and exploration map
for ii=1:params.NUM_BOTS
    botNetwork.bots(ii).curPos = [floor(params.HEIGHT/2) floor(params.WIDTH/2)]; % current position of bot
    botNetwork.explore_map(botNetwork.bots(ii).curPos(1),botNetwork.bots(ii).curPos(2)) = const.MAPPED;
    botNetwork.bots(ii).dest = []; % destination of bot (initialized as empty)
    botNetwork.bots(ii).route = [];
end

imagesc(botNetwork.explore_map); colormap gray;
title('press any button to begin');
pause;

for itr=1:params.MAX_ITR
    pause(0.01);
    for botNum=1:params.NUM_BOTS
        % extract bot's info from the botNetwork structure variable for convenience/code readability
        [curPos, dest, route, explore_map] = extract_bot_info(botNetwork,botNum);
        
        % if the bot doesn't have a destination then pick a new destination
        if isempty(dest)
            
            % get the locations of all areas that are labeled as unmapped (TODO: write this function)
            unexplored_areas = get_unexplored_areas(explore_map, const.UNMAPPED);
            
            % if there are no more unexplored areas, then this bot stops moving
            if isempty(unexplored_areas)
                dest = []; route = [];
                botNetwork = update_bot_info(curPos, dest, route, explore_map, botNetwork, botNum);
                continue;
            end
            
            % calculate bot's new destination (TODO: write this function)
            dest = get_new_destination(curPos, unexplored_areas);
            
            % calculates bot's route to the destination (you do not need to worry about this function)
            route = calculate_astar_path(curPos, dest, explore_map, const.WALL);
            
            % mark the location in explored_map as planned if it was unmapped (TODO: write this function)
            explore_map = update_explore_map(dest, route, explore_map, const.PLANNED, const.UNMAPPED);
        end
        
        % Using the calculated route, move the bot 1 step towards the destination bot's destination (TODO: write this function)
        [curPos, route, dest, explore_map] = update_position(curPos, route, dest, explore_map, const.MAPPED);
        
        % update bot's curr position, past position, destination, and map back into botNetwork structure variable
        botNetwork = update_bot_info(curPos, dest, route, explore_map, botNetwork, botNum);
    end
    
    % update display
    imagesc(botNetwork.explore_map,[0 1]); colormap gray;
    hold on;
    for ii=1:params.NUM_BOTS
        rectangle('position',[botNetwork.bots(ii).curPos([2 1])-0.5, 1, 1],'edgecolor','r','linewidth',2)
        if ~isempty(botNetwork.bots(ii).dest)
            plot(botNetwork.bots(ii).route(:,2),botNetwork.bots(ii).route(:,1),'r--');
            plot(botNetwork.bots(ii).dest(2),botNetwork.bots(ii).dest(1),'rx');
        end
    end
    
    hold off;
    if (sum(botNetwork.explore_map(:) == const.MAPPED) + ...
       sum(botNetwork.explore_map(:) == const.WALL)) ...
       == length(botNetwork.explore_map(:))
        break;
    end
end














