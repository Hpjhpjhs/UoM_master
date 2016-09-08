function som = lab_som (trainingData, neuronCount, trainingSteps, startLearningRate, startRadius)
% som = lab_som (trainingData, neuronCount, trainingSteps, startLearningRate, startRadius)
% -- Purpose: Trains a 1D SOM i.e. A SOM where the neurons are arranged
%             in a single line. 
%             
% -- <trainingData> data to train the SOM with
% -- <som> returns the neuron weights after training
% -- <neuronCount> number of neurons 
% -- <trainingSteps> number of training steps 
% -- <startLearningRate> initial learning rate
% -- <startRadius> initial radius used to specify the initial neighbourhood size

% complete this function so that it returns
% a matrix 'som' containing the weights of the trained SOM.
% The weight matrix should be arranged as follows, where
% N is the number of features and M is the number of neurons:
%
% Neuron1_Weight1 Neuron1_Weight2 ... Neuron1_WeightN
% Neuron2_Weight1 Neuron2_Weight2 ... Neuron2_WeightN
% ...
% NeuronM_Weight1 NeuronM_Weight2 ... NeuronM_WeightN
%
% It is important that this format is maintained as it is what
% lab_vis(...) expects.
%
% Some points that need to consider are:
%   - How should you randomise the weight matrix at the start?
%   - How do you decay both the learning rate and radius over time?
%   - How does updating the weights of a neuron effect those nearby?
%   - How do you calculate the distance of two neurons when they are
%     arranged on a single line?

%get size of input data
[tr_num, dimen] = size(trainingData);

%1. initilize weight matrix, neurons
mn = mean(trainingData);
tr_std = std(trainingData);
neuron = repmat( mn, neuronCount, 1) + repmat( tr_std, neuronCount, 1) .* randn(neuronCount, dimen);
lab_vis(neuron, trainingData);

%Order phase
%2. Iterate times
for step=0:trainingSteps
    %2a. iteratge each input point
    for point=1:tr_num
        input = trainingData(point,:);
        %2a1. calculate the eculidean distance between each neurons with input
        ecu_dis = sqrt( sum( ( neuron - repmat(input, neuronCount, 1) ).^2, 2) );
        %find the minimal neuron by its indice
        [neur, indices] = min(ecu_dis);
        %2a2. update the weights and its neighbours within the startRadius
        learningRate = startLearningRate * exp(-step/trainingSteps);
        sigma = startRadius * exp(-step/ (trainingSteps/log(startRadius)) );

        %find winner's neight positions
        startNeighbor = indices-startRadius;
        if( startNeighbor<1 ) startNeighbor = 1; end
        endNeighbor = indices+startRadius;
        if( endNeighbor > neuronCount ) endNeighbor = neuronCount; end
        for k=startNeighbor:1:endNeighbor
            H = exp( -abs(indices-k).^2 / (2*sigma.^2) );
            neuron(k,:) = neuron(k,:) + learningRate*H*(input-neuron(k,:));
        end     
    end
    
end

%Convergence phase
learningRate = 0.01;
startRadius = 1;
for step=0:(neuronCount*500)
    for p = 1:tr_num
        input = trainingData(point,:);
        %2a1. calculate the eculidean distance between each neurons with input
        ecu_dis = sqrt( sum( ( neuron - repmat(input, neuronCount, 1) ).^2, 2) );
        %find the minimal neuron by its indice
        [neur, indices] = min(ecu_dis);
        %2a2. update the weights and its neighbours within the startRadius
        sigma = startRadius * exp(-step/ ((neuronCount*500)/log(startRadius)) );

        %find winner's neight positions
        startNeighbor = indices-startRadius;
        if( startNeighbor<1 ) startNeighbor = 1; end
        endNeighbor = indices+startRadius;
        if( endNeighbor > neuronCount ) endNeighbor = neuronCount; end
        for k=startNeighbor:1:endNeighbor
            H = exp( -abs(indices-k).^2 / (2*sigma.^2) );
            neuron(k,:) = neuron(k,:) + learningRate*H*(input-neuron(k,:));
        end 
    end
end

som = neuron;
end