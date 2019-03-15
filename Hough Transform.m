close all;
clear all;
clc;
lane = imread('lane.png');
imshow(lane);

E = edge(lane,'sobel');
%imshow(E);

%% Sample Image
sample_image = zeros(11,11);
sample_image(1,1) = 1;
sample_image(1,end) = 1;
sample_image(end,1) = 1;
sample_image(end,end) = 1;
sample_image(floor(end/2)+1,floor(end/2)+1) = 1;
sample_image(2,2)=1;
%figure();
%imagesc(sample_image);

%% HT Transform
[r_w,c_w] = find(E==1);
t= -90:90;
theta = t*pi/180;
rho_max = sqrt(size(lane,1)^2+size(lane,2)^2);
rho = zeros(length(r_w),length(theta));

for i=1:length(r_w)
    rho(i,:) = (r_w(i)-1)*cos(theta) + (c_w(i)-1)*sin(theta);
    plot(-90:90,rho(i,:));
    hold on;
end

%% HT Plane
minim = abs(min(min(rho)));
HT = zeros(ceil(minim+abs(max(max(rho))))+5,181);
for i=1:length(r_w)
    for j=1:181
        HT(round(rho(i,j)+abs(minim))+1,j) = HT(round(rho(i,j)+abs(minim))+1,j)+1;
    end 
end
HT = flipud(HT);
figure();
imagesc(HT);
title('HT');

%% more than 2 votes
[vote1,vote2] = find(HT>0.7*max(HT(:)));
%% more than 3 votes
%[vote1,vote2] = find(HT>3);
%% 
vote2 = vote2-91;

%Reducing noisy elements because of low resolution of rho
for c= 1:length(vote2)
    l = vote2(c,1);
    indices = find(abs(vote2-l)<10 & vote2~=l);
    vote2(indices)=0;
end
vote2_degree = vote2(find(vote2));
%vote2_degree = vote2;
vote2 = vote2_degree*pi/180;


%% Plotting back on the image
m = -1*cos(vote2)./sin(vote2);
b = zeros(size(rho,1),1);
for kk=1:size(rho,1)
    for jj=1:length(vote2)
        b(kk) = rho(kk,vote2_degree(jj)+91)./sin(vote2(jj)) + 1;
    end
end
x = 0:size(E,1);
h=16;
plane = zeros(11,11);

figure();
imagesc(E);
hold on;

for n=1:length(vote2)
    mm = m(n);
    bm = b(n);
    plot(mm*(x)+bm+abs(minim)+5,'r');
    hold on;
end
hold off;



    


