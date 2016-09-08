% this script learns the SIFT descriptors for a pair of images containing
% the same object and search for correspondences



clear all
close all
% set the top level directory containing the tutorial
matlabVisRoot = '/opt/info/courses/COMP61342/matlab';
% matlabVisRoot = '/home/shaobohou/teaching/COMP604/matlab';
% Add the SIFT tutorial directory to the matlab path
tutorial_path = [matlabVisRoot '/utvisToolbox/tutorials/SIFTtutorial'];
addpath( tutorial_path );
% set the path for the images
im_path = [tutorial_path,'/files_to_copy/more_images/'];
% add additional paths
addpath( [matlabVisRoot '/utvisToolbox/file'] );
addpath( [matlabVisRoot '/iseToolbox/pyrTools'] );
addpath( [tutorial_path '/netlab'] );

% Set the number of octaves and intervals per octave for pyramid used
% by the SIFT transform.
octaves = 4;
intervals = 2;



% learn models
% set subsample to values greater than 1 to make testing faster
subsample = 1;

% comment out the next 4 lines to reuse cache
fprintf( 2, ['Learning training images.\n'] )
dataset_name = 'nutshell_cache';
switch dataset_name
    case 'phone'
        training_im_names = {[im_path 'image1_1'] [im_path 'image1_2'] [im_path 'image1_3']   ...
                             [im_path 'image2_1'] [im_path 'image2_2'] [im_path 'image2_3'] [im_path 'image2_4'] ...
                             [im_path 'image3_1'] [im_path 'image3_2']};
        training_info = learnSIFT(training_im_names, octaves, intervals, subsample, 0.02, 10.0, 0);

    case 'nutshell'
        training_im_names = {['../images/nutshell0003'] ['../images/nutshell0004'] ['../images/nutshell0007'] ...
                             ['../images/nutshell0008'] ['../images/nutshell0009'] ['../images/nutshell0010'] ...
                             ['../images/nutshell0011'] ['../images/nutshell0012']};
        training_info = learnSIFT(training_im_names, octaves, intervals, subsample, 0.02, 10.0, 0);
                  
    case 'phone'
        training_im_names = {['../images/phone0003'] ['../images/phone0005'] ['../images/phone0007'] ...
                             ['../images/phone0016'] ['../images/phone0017'] ['../images/phone0018']};
        training_info = learnSIFT(training_im_names, octaves, intervals, subsample, 0.02, 10.0, 0);
                  
    case 'wadham'
        training_im_names = {['../images/wadham001'] ['../images/wadham002'] ['../images/wadham003'] ...
                             ['../images/wadham004'] ['../images/wadham005']};
        training_info = learnSIFT(training_im_names, octaves, intervals, subsample, 0.02, 10.0, 0);
        
    otherwise
        % load cache
        load([tutorial_path '/files_to_copy/' dataset_name '.mat']);
end

% % save cache
% save sift_cache.mat training_info



% indices for the image pair
left_image_index = 1; 
right_image_index = 3;

left_image = training_info.images{left_image_index};
right_image = training_info.images{right_image_index};

left_desc = training_info.desc{left_image_index};
right_desc = training_info.desc{right_image_index};

left_pos = training_info.pos{left_image_index};
right_pos = training_info.pos{right_image_index};

left_scale = training_info.scale{left_image_index};
right_scale = training_info.scale{right_image_index};

left_orient = training_info.orient{left_image_index};
right_orient = training_info.orient{right_image_index};



% % threshold value for determining uniqueness of candidate correspondences
% dist_threshold = 0.65;
% % threshold value for pixel position distances between candidate correspondences
% neighbour_threshold = 0;
% distances = dist2(training_info.desc{i}, training_info.desc{j});



% find correspondences from left image to right image
% [correspondences discarded] = findCorrespondences(distances, left_desc, right_desc, left_pos, right_pos, dist_threshold, neighbour_threshold);
tic
nn_thresh = 0.6;
correspondences = find_nearest_neighbours_shaobo(left_desc, right_desc, nn_thresh);
toc
fprintf('%d correspondences found between image %d and %d\n', length(correspondences), left_image_index, right_image_index);

% visualise descriptors for which correspondences have been found
figure
subplot(1, 2, 1)
showIm(left_image);
display_keypoints(left_pos(correspondences(:, 1), :), left_scale(correspondences(:, 1), :), left_orient(correspondences(:, 1), :), 10);
subplot(1, 2, 2)
showIm(right_image);
display_keypoints(right_pos(correspondences(:, 2), :), right_scale(correspondences(:, 2), :), right_orient(correspondences(:, 2), :), 10);

% visualise correspondences between descriptors
composite_image = [left_image right_image];
left_match_pos = left_pos(correspondences(:, 1), :);
right_match_pos = right_pos(correspondences(:, 2), :);
% offset the right match pos
right_match_pos(:, 1) = right_match_pos(:, 1) + size(left_image, 2);
figure
subplot(2, 1, 1)
showIm(composite_image);
title('Before Fitting Affine Transform')
hold on
for k = 1:size(correspondences, 1)
    temp_line = [left_match_pos(k, :);right_match_pos(k, :)];
    plot(temp_line(:, 1), temp_line(:, 2), 'Color', [0 1 0]);
end
% for k = 1:size(discarded, 1)
%     temp_line = [left_match_pos(k, :);right_match_pos(k, :)];
%     plot(temp_line(:, 1), temp_line(:, 2), 'Color', [1 0 0]);
% end


% draw correspondences
left_points = left_pos(correspondences(:, 1), :);
plot(left_points(:, 1), left_points(:, 2), 'o')
right_points = right_pos(correspondences(:, 2), :);
plot(right_points(:, 1)+size(left_image, 2), right_points(:, 2), 'o')





% fit affine transformation
correspondences_aff = correspondences;
left_points_aff_temp = left_pos(correspondences_aff(:, 1), :);
right_points_aff_temp = right_pos(correspondences_aff(:, 2), :);
[aff outliers robustError] = fit_robust_affine_transform(left_points_aff_temp', right_points_aff_temp');
correspondences_aff(outliers, :) = [];



% visualise correspondences between descriptors
left_match_pos_aff = left_pos(correspondences_aff(:, 1), :);
right_match_pos_aff = right_pos(correspondences_aff(:, 2), :);
aff = fit_robust_affine_transform(left_match_pos_aff', right_match_pos_aff');

% offset the right match pos
right_match_pos_aff(:, 1) = right_match_pos_aff(:, 1) + size(left_image, 2);
subplot(2, 1, 2)
showIm(composite_image);
title('After Fitting Affine Transform')
hold on
for k = 1:size(correspondences_aff, 1)
    temp_line = [left_match_pos_aff(k, :);right_match_pos_aff(k, :)];
    plot(temp_line(:, 1), temp_line(:, 2), 'Color', [0 1 0]);
end

% draw correspondences
left_points_aff = left_pos(correspondences_aff(:, 1), :);
plot(left_points_aff(:, 1), left_points_aff(:, 2), 'o')
right_points_aff = right_pos(correspondences_aff(:, 2), :);
plot(right_points_aff(:, 1)+size(left_image, 2), right_points_aff(:, 2), 'o')



figure
subplot(2, 2, 1)
showIm(left_image)

subplot(2, 2, 2)
showIm(right_image)

subplot(2, 2, 3)
aligned2 = imWarpAffine(right_image, aff, 1 );
showIm(aligned2)

subplot(2, 2, 4)
aligned1 = imWarpAffine(left_image, inv(aff), 1 );
showIm(aligned1)

% % remove any near matches to prevent singularity
% flags = zeros(size(left_points_aff, 1), 1);
% left_dists = dist2(left_points_aff, left_points_aff);
% right_dists = dist2(right_points_aff, right_points_aff);
% for i = 1:size(left_points_aff, 1)
%     if(flags(i) == 0)
%         near_matches = find(left_dists(i, i:end) < 1);
%         inds = near_matches+i-1;
%         if numel(inds) > 1
%             flags(inds(2:end)) = 1;
%         end
%     end
%    if(flags(i) == 0)
%         near_matches = find(right_dists(i, i:end) < 1);
%         inds = near_matches+i-1;
%         if numel(inds) > 1
%             flags(inds(2:end)) = 1;
%         end
%     end
% end
% % flags'
% left_points_aff_pruned = left_points_aff;
% left_points_aff_pruned(find(flags), :) = [];
% right_points_aff_pruned = right_points_aff;
% right_points_aff_pruned(find(flags), :) = [];
% 
% subplot(3, 2, 5)
% aligned22 = tpsWarp(left_points_aff_pruned, right_points_aff_pruned, right_image);
% showIm(aligned22)
% 
% subplot(3, 2, 6)
% aligned11 = tpsWarp(right_points_aff_pruned, left_points_aff_pruned, left_image);
% showIm(aligned11)
