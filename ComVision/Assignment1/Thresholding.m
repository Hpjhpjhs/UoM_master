clc;
clear;

%load image
%img = imread('brains.pgm');
img = imread('v1001.png');
img = imrotate(img, -90);
img = rgb2gray(img);
%% 
%file = 'trayRegion.mat';
%file = 'brainRegion.mat';
file = 'v1001Skin.mat';

%draw ROI
%BW = drawROI(img, file);

%load ROI from file
load( file, '-mat');

%get ROI
x2 = img(BW);
x2 = double(x2)/255;
%set histogram bins
i = min(x2) : (max(x2)- min(x2))/64 : max(x2);
%draw histogram
h = hist( x2, double(i) );
stem(i,h), title('Histogram of ROI');
figure;

%thresholding
level = graythresh(x2);
bw = im2bw(img, level);
subplot(131), imshow(bw), title('thresholding by graythresh');

level1 = 0.1;
bw1 = im2bw(img, level1);
subplot(132), imshow(bw1), title('thresholding 0.4');

level2 = 0.5;
bw2 = im2bw(img, level2);
subplot(133), imshow(bw2), title('thresholding 0.6');

