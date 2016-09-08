%Stereo Vision Algorithm

%load left rectified image
left = imread('shaft3rec.l.pgm');
%load right rectified image
right = imread('shaft3rec.r.pgm');
%left and right image are lie on the same raster, that on the same
%horizontal line

% Find the edges
% -------------------------------------------------------------
left_edge_image = edge(left_image,'sobel');
right_edge_image = edge(right_image,'sobel');

% Display everything
% ------------------
figure(1);
subplot(2,2,1);
imagesc(left_image);
axis image, axis off, colormap gray;
title('Left Image');
subplot(2,2,2);
imagesc(right_image);
axis image, axis off, colormap gray;
title('Right Image');

subplot(2,2,3);
imagesc(left_edge_image);
axis image, axis off, colormap gray;
title('Left Edge Image');
subplot(2,2,4);
imagesc(right_edge_image);
axis image, axis off, colormap gray;
title('Right Edge Image');


% Now do the matching ( a basic understanding of Matlab is needed here )
% -----------------------------------------------------------------------
num_rows = size(left_image,1);
num_cols = size(right_image,2);
array_of_disparities = [];

for r = 1:num_rows
	left_edge_pixels = find(left_edge_image(r,:));% indices for the nonzero entries of pixels in a row
	for i = left_edge_pixels
		i1 = find(right_edge_image(r,:));
		disparities = (i1 - i)';
		num_matches = size(disparities,1);
		left_coords = repmat([i,r],num_matches,1);
		array_of_disparities = [array_of_disparities; [left_coords, disparities] ]; 
	end
end
