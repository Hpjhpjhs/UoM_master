function BW = drawROI(I, file)

% display image in gray level
imagesc(I);
colormap(gray);
axis image, axis off;
zoom;

% obtain current image
x = getimage(gcf);

%select a polygonal region of interest within an image, reture a binary
%image that can use as a mark.
BW = roipoly;
save( file, 'BW');
