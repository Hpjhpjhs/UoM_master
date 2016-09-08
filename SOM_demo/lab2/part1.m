%part1
clear;
trainingData = nicering;
%data = niceball;
%data = nicesquare;

% steps = 1000; 
% learningRate = 0.1;
% radius = ceil(numNeurons/2);
% numNeurons = 20;
% som = lab_som(data, numNeurons, steps, learningRate, radius);
% lab_vis(som,data);

trainingSteps = 1000; 
startLearningRate = 0.9;
neuronCountW = 3;
neuronCountH = 10;
startRadius = 3;
[som, grid] =lab_som2d(trainingData, neuronCountW, neuronCountH, trainingSteps, startLearningRate, startRadius);
lab_vis2d(som, grid, trainingData);