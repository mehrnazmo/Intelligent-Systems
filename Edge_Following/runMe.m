clear all;clc;close all;

PATH_COL = 0.5;
BOT_COL = 0.75;
OBS_COL = 1;
MAP_SIZE = [25 25];
OBS_POS = [2, 2; 2, 5; 4, 10; 2, 21; 2, 24; 24, 24; 24, 17; 12, 17; 16 8; 24, 8; 24, 2];
BOT_DIR = 0; %Also test for BOT_DIR = 1;

curPos = OBS_POS(1,:) - [-1, -16]; %Robot starting point.

cleanFrame = zeros(MAP_SIZE);
cleanFrame = fill_obs(OBS_POS, cleanFrame, OBS_COL); %Dont worry about this function
frame = cleanFrame;
frame(curPos(1),curPos(2)) = PATH_COL;
anim_h = imagesc(frame);
colormap gray;

hold on;
MAX_ITR = 1000;
for itr=1:1:MAX_ITR
    pause; % Keep pressing ENTER to continue
    sensorInput = cleanFrame(curPos(1)-1:curPos(1)+1,curPos(2)-1:curPos(2)+1);
    frame(curPos(1),curPos(2)) = PATH_COL;
    curPos  = get_new_pos( curPos, sensorInput, BOT_DIR);
    frame(curPos(1),curPos(2)) = BOT_COL;
    imagesc(frame);
end
hold off;
