clc;
clear;

%% read image with gray level
img = imread('color.jpg');
img = rgb2gray(img);

%% Difference of Gaussian filtering
g1 = fspecial('gaussian', 20, 10);
g2 = fspecial('gaussian', 20, 20);
dog = g1 - g2;
I = conv2(double(img), dog, 'same');

%% display
figure;
subplot(221), imshow(img); title('Original');
subplot(222), imhist(img), ylim( [0 3000] ), title('Hist Original');
subplot(223), imshow(I), title('DoG Filtering');
subplot(224), imhist(I), ylim( [0 300] ), title('Hist Original');