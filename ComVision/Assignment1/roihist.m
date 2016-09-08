function [h] = roihist()

x = getimage(gcf);
%set(gcf,'Color',[1.0,0.0,0.0]);

%select a polygonal region of interest within an image, reture a binary
%image that can use as a mark.
bw = roipoly;
x2 = x(bw);
%set histogram bins
i = min(x2) : (max(x2)- min(x2))/64 : max(x2);
%draw histogram
h = hist( x2, double(i) );
figure;
%bar(i,h);
stem(i,h);
