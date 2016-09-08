clc;
clear;

% -----------------------------------------------------------
left_image = imread('shaft3rec.l.pgm');
right_image = imread('shaft3rec.r.pgm');

% Find the edges
% -------------------------------------------------------------
left_edge_image = edge(left_image,'sobel');
right_edge_image = edge(right_image,'sobel');

%{
left1 = edge(left_image, 'canny');
right1 = edge(right_image, 'canny');

figure(1);
subplot(2,2,1);
imagesc(left_edge_image);
axis image, axis off, colormap gray;
title('Soble: Left Image');
subplot(2,2,2);
imagesc(right_edge_image);
axis image, axis off, colormap gray;
title('Sobel: Right Image');

subplot(2,2,3);
imagesc(left1);
axis image, axis off, colormap gray;
title('Canny: Left Edge Image');
subplot(2,2,4);
imagesc(right1);
axis image, axis off, colormap gray;
title('Canny: Right Edge Image');
%}

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


% do the matching
% -----------------------------------------------------------------------
num_rows = size(left_image,1);
num_cols = size(right_image,2);
array_of_disparities = [];

figure(2);
pl = 1;
for k = [0, 1, 10, 100, 1000, 10000]
%the 3d corrdinate, X, Y, Z
points = [];

       % k = 0; %has no effect on the distribution of Z corrdinate, onley scales
        %find the depth
        % Z is proportional to 1.0/(k+disparity)
        % the focal length of the camera used was 17.0mm
        f = 17.0; %has the same effect as the k value
        pixelSize = 0.011;
        baseline = 2;
        num_matches = 0;
for row = 1:num_rows
	left_edge_pixels = find(left_edge_image(row,:));% indices for the nonzero entries of pixels in a row
    right_edge_pixels = find(right_edge_image(row,:));% indices for the nonzero entries of pixels in a row in right image
	for xl = left_edge_pixels
        
        %using minimal value of disparities
        disparities = (right_edge_pixels - xl)';
        disparities = abs( disparities );
        disparities = min( disparities );
        disparities = disparities * pixelSize * 1000;
        
        num_matches = num_matches + 1
%		left_coords = repmat([i,r],num_matches,1);
%      array_of_disparities = [array_of_disparities; [left_coords, disparities] ]; 
              
        Z = ( 1.0 / ( k + disparities ) );
        X = ( Z * (xl/f) - baseline/2 );
        Y = ( Z*  (row/f) ) ;
        
        points = [ points; [X, Y, Z] ];      
        
    end   
end

% Display the table of candidate matches
subplot(2,3,pl); 
plot3( points(:,1), points(:,2), points(:,3), '.' );
view( 10, -80);
xlabel('X Corrdinate');
ylabel('Y Corrdinate');
zlabel('Z Corrdinate');
title(['3D view, K = ', num2str(k)]);
pl = pl + 1;
end

figure(3);
subplot(1,2,1);
plot( points(:,1), points(:,3), '.' );
title('X-Z Side View');
xlabel('X Corrdinate');
ylabel('Z Corrdinate');

%figure(4);
subplot(1,2,2);
plot( points(:,2), points(:,3), '.' );
title('Y-Z Above View');
xlabel('Y Corrdinate');
ylabel('Z Corrdinate');
