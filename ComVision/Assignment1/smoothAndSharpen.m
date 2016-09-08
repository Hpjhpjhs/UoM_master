clc;
clear;

%% load image into gray level
I = imread('color.jpg');
I = rgb2gray(I);

% averaging filter
h = ones(5,5) /25;

% linear filtering: mulitply each kernel element with pixel, then sum up as output
% linear filtering, suitable for removing noise from a photograph, since each pixel is set to the average of its neightbourhood, thus local variations caused by grain are reduced. 

h = [-1 0 1,
     -1 0 1,
     -1 0 1];
I2 = imfilter(I, h);%filter using correlation
I3 = imfilter(I, h, 'conv');%filtering using convolution
% I = [1 2 3 4 5,
%      6 7 8 9 10,
%     11 12 13 14 15,
%      16 17 18 19 20]
% correlation filtering by h: e.g. pixel(2, 3) = 8
% op(2, 3) = 2*-1 + 0*3 + 4*1 + 7*-1 + 8*0 + 9*1 + 12*-1 + 13*0 + 14*1 = 6
%
% convoluton filtering, rotate kernel 180 degrees firstly
% op(2, 3) = 2*1 + 3*0 + 4*-1 + 7*1 + 8*0 + 9*-1 + 12*1 + 13*0 + 14*-1 = -6
% as input data is range from 0-255, the op(2, 3) should be modified to 0

% boundary padding:
% 1. zero padding. set the off-the-edge image pixel by assuming that they
% are 0
% 2. border replication, outside image pixel is set to be the value of its
% nearest border.


%% Predefined Filter
H = fspecial('unsharp');%unsharp filter can make edge and fine detail in the image more crisp.That sharpen the image.
I4 = imfilter(I, H);


%% show images
figure;
subplot(221), imshow(I), title('Source Image');
subplot(222), imshow(I2), title('Coorelation Filtered Image');
subplot(223), imshow(I3), title('Convolution Filtered Image');
subplot(224), imshow(I4), title('sharpen Image');
