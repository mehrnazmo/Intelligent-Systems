%% This code detects a bird template in two images using convolution and normalized cross correlation
close all;
clear all;
clc;

birds1=imread('birds1.jpeg');
template=imread('template.jpeg');
imshow(birds1);
figure;
imshow(template)

%% Converting to double grayscale
birds1_gray = double(rgb2gray(birds1));
template_gray = double(rgb2gray(template));
figure;
imagesc(birds1_gray);
figure;
imagesc(template_gray);

%% Cross Correlation
correlation = conv2(birds1_gray,template_gray);
figure;
imagesc(correlation);
colorbar;
[yc,xc] = find(correlation==max(max(correlation)));
yoffSetc = yc-size(template,1);
xoffSetc = xc-size(template,2);
figure;
imshow(birds1);
imrect(gca, [xoffSetc+1, yoffSetc+1, size(template,2), size(template,1)]);


%% ii) Normalized cross correlation bird1
C = normxcorr2(template_gray,birds1_gray);
figure;
imagesc(C);
colorbar;
[y,x] = find(C==max(max(C)));
yoffSet = y-size(template,1);
xoffSet = x-size(template,2);
figure;
RGB = insertShape(birds1,'Rectangle',[xoffSet+1, yoffSet+1, size(template,2), size(template,1)],'LineWidth',5);
imshow(RGB)
%Another way of implementing the box on the image:
%imshow(birds1);
%imrect(gca, [xoffSet+1, yoffSet+1, size(template,2), size(template,1)]);


%% iii) Normalized cross correlation bird2
birds2=imread('birds2.jpeg');
figure;
imshow(birds2);
birds2_gray = double(rgb2gray(birds2));
figure;
imagesc(birds2_gray);

C2 = normxcorr2(template_gray,birds2_gray);
figure;
imagesc(C2);
colorbar;
[y2,x2] = find(C2==max(max(C2)));
yoffSet2 = y2-size(template,1);
xoffSet2 = x2-size(template,2);
figure;
RGB2 = insertShape(birds2,'Rectangle',[xoffSet2+1, yoffSet2+1, size(template,2), size(template,1)],'LineWidth',5);
imshow(RGB2)
%imshow(birds2);
%imrect(gca, [xoffSet2+1, yoffSet2+1, size(template,2), size(template,1)]);

