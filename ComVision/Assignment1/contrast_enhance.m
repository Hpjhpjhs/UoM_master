%A = imread('shaftim.pgm');
%imformats;
%MAP is the colormap of current image
%[A, MAP] = imread('shaftim.pgm');

%Contrast Enhancement
clear;
%load images
%two grayscale images
sha = imread('shaftim.pgm');
bro = imread('brodatz.pgm');
%one color image
%convert indexed image to RGB image
%[X, map] = imread('color.jpg');
%co = ind2rgb(X, map);
co = imread('color.jpg');

%Resize Images
% To make the image comparison easier, resize the images to have the
% same width.  Preserve their aspect ratios by scaling their heights.
%aspect ratios: 4:3 = 16:?, ?=3*16/4
width = 210;
images = {sha, bro, co};

%resize method:
%srcX=dstX* (srcWidth/dstWidth) , srcY = dstY * (srcHeight/dstHeight)
%1.nearest, round off, 相对最近点
%2.bilinear, srcX=i+u; srcY=j+v; f(i+u,j+v) = (1-u)(1-v)f(i,j) +
%(1-u)vf(i,j+1) + u(1-v)f(i+1,j) + uvf(i+1,j+1)，相邻四点加权值
%3.bicubic, 相邻16点加权卷积计算
for k = 1:3
  dim = size(images{k});
  images{k} = imresize(images{k},[width*dim(1)/dim(2) width],'bicubic');
end

sha = images{1};
bro = images{2};
co = images{3};

%% enhance gray image contrast
% imadjust, mapping input image gray scale to new scale
% histeq, modify entire input image histogram to new specified histogram( uniform
% distribution default
% adapthisteq, modify histogram of a small region of input image to new
% histogram

sha_imadjust = imadjust(sha);
sha_histeq = histeq(sha);
sha_adapthisteq = adapthisteq(sha);

bro_imadjust = imadjust(bro);
bro_histeq = histeq(bro);
bro_adapthisteq = adapthisteq(bro);

figure;
subplot(2,4, 1);
imshow(sha);
subplot(2,4, 2);
imshow(sha_imadjust);
subplot(2,4, 3);
imshow(sha_histeq);
subplot(2,4, 4);
imshow(sha_adapthisteq);
subplot(2,4, 5);
imshow(bro);
subplot(2,4, 6);
imshow(bro_imadjust);
subplot(2,4, 7);
imshow(bro_histeq);
subplot(2,4, 8);
imshow(bro_adapthisteq);

figure; imhist(sha);
figure; imhist(bro);



%% enhance color image
srgb2lab = makecform('srgb2lab');
lab2srgb = makecform('lab2srgb');

co_lab = applycform(co, srgb2lab); % convert to L*a*b*

% the values of luminosity can span a range from 0 to 100; scale them
% to [0 1] range (appropriate for MATLAB(R) intensity images of class double) 
% before applying the three contrast enhancement techniques
max_luminosity = 100;
L = co_lab(:,:,1)/max_luminosity;

% replace the luminosity layer with the processed data and then convert
% the image back to the RGB colorspace
co_imadjust = co_lab;
co_imadjust(:,:,1) = imadjust(L)*max_luminosity;
co_imadjust = applycform(co_imadjust, lab2srgb);

co_histeq = co_lab;
co_histeq(:,:,1) = histeq(L)*max_luminosity;
co_histeq = applycform(co_histeq, lab2srgb);

co_adapthisteq = co_lab;
co_adapthisteq(:,:,1) = adapthisteq(L)*max_luminosity;
co_adapthisteq = applycform(co_adapthisteq, lab2srgb);

figure;
subplot(1,4,1);
imshow(co);
subplot(1,4,2);
imshow(co_imadjust);
subplot(1,4,3);
imshow(co_histeq);
subplot(1,4,4);
imshow(co_adapthisteq);





























