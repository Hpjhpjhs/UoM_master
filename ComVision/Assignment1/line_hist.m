%plot grey level histogramm along a selected line.
function [h] = line_hist(X)

%acquire image
imagesc(X);
colormap(gray);
axis image, axis off;
zoom;

%select line of interest
x = getimage(gcf);
bw = roipoly;
x2 = x(bw);

%draw histogram
i = min(x2) : (max(x2)- min(x2))/64 : max(x2);
h = hist( x2, double(i) );
figure;
stem(i,h);
