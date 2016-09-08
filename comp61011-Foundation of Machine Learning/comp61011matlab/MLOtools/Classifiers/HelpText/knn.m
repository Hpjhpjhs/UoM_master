% Implements a knn classifier with Euclidean distance.
% Default k is 1.
%
% model = knn('k',3);                      %create 3-nn classifier.
% model.train(data,labels);                %train it
% accuracy = model.test(data,labels).acc() %get accuracy
%