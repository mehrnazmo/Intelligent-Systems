clc; clear; close all;

data = load('data.mat');
cur_loc = 1;
h = figure();
show_maze(data, h);
draw_cursor(cur_loc, [data.num_rows, data.num_cols], 'r', h);

% TODO: Implement DFS
N = data.num_rows * data.num_cols;
stack_loc = java.util.Stack();
visited = zeros(N,1);
parents = zeros(N,1);
stack_loc.push(cur_loc);
while (~stack_loc.isEmpty()) && (cur_loc ~= N)
    i = stack_loc.pop();
    if visited(i)==0
       visited(i)=1;
       neighbors = sense_maze(i, data);
       for j=1:length(neighbors)
           if visited(neighbors(j))==0
               stack_loc.push(neighbors(j));
               parents(neighbors(j))=i;
           end
       end
    end
    %pause(0.00001);
    cur_loc = i;
    draw_cursor(cur_loc, [data.num_rows, data.num_cols], 'r', h);
end

cur_loc = N;
while parents(cur_loc)~=0
    draw_cursor(cur_loc, [data.num_rows, data.num_cols], 'g', h);
    cur_loc = parents(cur_loc); 
end
