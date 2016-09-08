clear;

%load image and convert to gray level
cell = imread('cell.jpg');
cell = rgb2gray(cell);
%figure, imshow(cell);

%estimate background
background = imopen(cell, strel('disk',20));

%figure, surf(double(background(1:8:end,1:8:end))),zlim([0 255]);
%set(gca,'ydir','reverse');
%imshow(background);

%substract the background
c2 = cell -background;
%figure, imshow(c2);

%increase the contrast
c3 = imadjust(c2);
%figure, imshow(c3);

%thresholding the image
level = graythresh(c3);
bw = im2bw(c3, level);
bw = bwareaopen(bw, 200);
%figure, imshow(bw);

cc = bwconncomp(bw, 4);

grain = false(size(bw));
grain(cc.PixelIdxList{5}) = true;
%figure, imshow(grain);

label = labelmatrix(cc);
whos label

RGB_label = label2rgb(label, @spring, 'c', 'shuffle');
imshow(RGB_label);


















