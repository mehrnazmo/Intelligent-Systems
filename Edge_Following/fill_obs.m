function [ newFrame ] = fill_obs( obs_pos, frame, OBS_COL)
    newFrame = frame;
    [x,y] = meshgrid(1:1:size(frame,2),1:1:size(frame,2));
    in = inpolygon(x,y,obs_pos(:,2),obs_pos(:,1));
    newFrame(ind2sub(size(frame),find(in ~= 1))) = OBS_COL;
end
