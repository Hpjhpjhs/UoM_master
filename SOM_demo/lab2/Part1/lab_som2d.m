function [som,grid] = lab_som2d (trainingData, neuronCountW, neuronCountH, trainingSteps, startLearningRate, startRadius)
% som = lab_som2d (trainingData, neuronCountW, neuronCountH, trainingSteps, startLearningRate, startRadius)
% -- Purpose: Trains a 2D SOM, which consists of a grid of
%             (neuronCountH * neuronCountW) neurons.
%             
% -- <trainingData> data to train the SOM with
% -- <som> returns the neuron weights after training
% -- <grid> returns the location of the neurons in the grid
% -- <neuronCountW> number of neurons along width
% -- <neuronCountH> number of neurons along height
% -- <trainingSteps> number of training steps 
% -- <startLearningRate> initial learning rate
% -- <startRadius> initial radius used to specify the initial neighbourhood size
%

% grid(n, :) contains the grid location of neuron 'n'
%
% For example, if grid = [[1,1];[1,2];[2,1];[2,2]] then:
% 
%   - som(1,:) are the weights for the neuron at position x=1,y=1 in the grid
%   - som(2,:) are the weights for the neuron at position x=2,y=1 in the grid
%   - som(3,:) are the weights for the neuron at position x=1,y=2 in the grid 
%   - som(4,:) are the weights for the neuron at position x=2,y=2 in the grid
%
% It is important to return the grid in the correct format so that
% lab_vis2d() can render the SOM correctly

%get size of input data
[tr_num, dimen] = size(trainingData);

%1. initilize weight matrix, with neuronCountW, neuronCountH
som = rand(neuronCountW*neuronCountH, dimen);
grid = zeros( neuronCountW*neuronCountH, 2);
for h=1:1:neuronCountH
    for w=1:1:neuronCountW
        grid( (h-1)*neuronCountW+w,:) = [h,w];
    end
end
% lab_vis2d(som, grid, trainingData);
% figure

%order phase
%2. Iterate times
for step=0:trainingSteps
    learningRate = startLearningRate * exp(-step/trainingSteps);
    sigma = startRadius * exp(-step / (trainingSteps/log(startRadius)) );
    %2a. iteratge each input point
    for point=1:tr_num
        input = trainingData(point,:);
        %2a1. calculate the eculidean distance between each neurons with input
        %euc_dis = sqrt( sum( ( som - repmat(input, neuronCountW*neuronCountH, 1) ).^2, 2 ) );
        euc_dis = eucdist( repmat(input, size(som,1),1),som );
        %find the winner and its indice
        [~, indices] = min(euc_dis);
        %prosition of winner in grid
        winner_y = grid(indices,1);
        winner_x = grid(indices,2);
        %2a2. update the weights and its neighbours within the startRadius
        %neurons_dis = sum(abs( grid - repmat([winner_y, winner_x],size(grid, 1), 1 ) ), 2);
%         neurons_dis = eucdist( grid, repmat([winner_y, winner_x], size(grid, 1), 1 ) );
        neurons_dis = zeros(neuronCountW*neuronCountH,1);
        for nd=1:1:neuronCountW*neuronCountH
            n_y = grid(nd,1);
            n_x = grid(nd,2);
            neurons_dis(nd) = eucdist([n_y,n_x],[winner_y,winner_x]);
        end
        H = exp( - neurons_dis.^2 / (2*(sigma^2) ) );
        H(indices) = 1;
        som = som + ( learningRate .* repmat(H,1,dimen) .* (repmat(input,size(som,1),1) - som) );  
    end
    
%     lab_vis2d(som, grid, trainingData);
%     pause(0.001);
end

convergence phase
learningRate = 0.01;
startRadius = 1;
for con_step=0:(neuronCountW*neuronCountH*500)
    sigma = startRadius * exp(-con_step/ ( (neuronCountW*neuronCountH*500)/log(startRadius) ) );
    %2a. iteratge each input point
    for point=1:tr_num
        input = trainingData(point,:);
        %2a1. calculate the eculidean distance between each neurons with input
        euc_dis = sqrt( sum( ( som - repmat(input, neuronCountW*neuronCountH, 1) ).^2, 2) );
        %find the winner and its indice
        [~, indices] = min(euc_dis);
        %prosition of winner in grid
        winner_y = grid(indices,1);
        winner_x = grid(indices,2);
        %2a2. update the weights and its neighbours within the startRadius
        neurons_dis = sum(abs( grid - repmat([winner_y, winner_x],size(grid, 1), 1 ) ), 2);
        H = exp( -neurons_dis.^2 / (2*sigma.^2) );
        for tt=1:size(neurons_dis,1)
            if( neurons_dis(tt) > 1)
                H(tt,:) = 0;
            end
        end
        som = som + learningRate .* repmat(H,1,dimen) .* (repmat(input,size(som,1),1) - som);  
    end
end

 
end