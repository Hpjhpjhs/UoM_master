%
% MLOtools/Classifiers/LogReg
% Implements the Logistic Regression classifier.
% Optional arguments: learningrate, iterations
%
% Trains by simple gradient descent in batch updates.
% Handles multiple classes by softmax.
%
% Train/Test with default iterations/learning rate:
%  model = logreg().train(data,labels);
%  accuracy = model.test(data,labels).acc();
%
% Or specify yourself:
%  model = logreg('iterations',100, 'learningrate',0.01).train(data,labels);
%
% Default learning rate = 0.1, iterations = (10 x numFeatures);
%