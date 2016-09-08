%function BW = drawROI(I, file)

% display image in gray level
I = imread('v1001.png');
I = rgb2gray(I);
imshow(I);

imagesc(I);
colormap(gray);
axis image, axis off;
zoom;

% obtain current image
x = getimage(gcf);

%select a polygonal region of interest within an image, reture a binary
%image that can use as a mark.
BW3 = roipoly;

res = BW + BW2;
imshow(res);