% Removing noise by Median Filtering
% The median is much less senstive than the mean to extreme values
% (outliers). It is better able to remove these outliers without reducing
% the sharpeness of the images.

clc;
clear;

%read image
I = imread('color.jpg');
I = rgb2gray(I);
figure;
subplot(231), imshow(I), title('original');

%add noise
%In = imnoise(I, 'salt & pepper', 0.02);
In = imnoise(I, 'gaussian');
subplot(232), imshow(In), title('with noise');

%% filtering noise by average filter
I2 = filter2( fspecial('average',3), In )/255;
subplot(233), imshow(I2), title('average filtering');

%% filtering noise by median filter
I3 = medfilt2( In, [3 3] );
subplot(234), imshow(I3), title('median filtering');


%% filtering noise by Adaptive Filter
% wiener2 applies a Winener filter( type of linear filter) to an image
% adaptively, tailoring itself to the local image variance. large variance,
% little smoothing, vice verse.
I4 = wiener2(In, [5 5]);
subplot(235), imshow(I4), title('Adaptive Filter');



%% summary
% salt & pepper noise, filtering better by median filtering
% gaussian noise, filtering better by Apadtive Filtering