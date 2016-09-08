% ------------------------------------------------------------
% 
% This is the MLOtools Version for COMP61011
%
% Type "help <command>" for details on any of the below.
% Some of the current tools are:
% 
% Non-Linear Classifiers:
%  knn          - Euclidean distance k nearest neighbour classifier.
%  svm          - Wraps the libsvm package.
%  cart         - Wraps the tree classifier from the Matlab stats toolbox.
%  dtree        - Another tree implementation, my own.
%
% Linear classifiers:
%  nbayes       - Naive Bayes for discrete features
%  gnbayes      - Gaussian Naive Bayes for continuous features
%  logreg       - Logistic Regression (batch training, cross-entropy)
%  lindisc      - Fisher Linear Discriminant (wraps the stats toolbox)
% 
% All classifiers have the following basic functionality:
% 
%  model   = gnbayes();
%  model   = model.train(data, labels);
%  res = model.test(data, labels);
%  acc = res.acc()
% 
% Core tools:
%  sampler      - helps you with basic data manipulation tasks
%  results      - class returned by all model.test calls
%  showtask     - displays data (2D only)
%  plotboundary - plots a decision boundary (2D only)
%  mlodata      - shows a set of available datasets
%
% Preprocessing Toolbox:
%  rescale_mean0var1  - rescales data to mean 0, var 1
%  rescale_polar      - rescales data to [-1 +1]
%  rescale_01         - rescales data to [ 0 +1]
%  disc_means         - discretizes data the mean value
%  disc_medians       - discretizes data the median value
%  disc_stdevs        - discretizes data at to [-1/0/+1]
%  disc_zero          - discretizes data at zero
% 
% Feature Selection Toolbox:
%  feast        - selects features via numerous mutual information methods
%  e.g. w = feast('jmi',10,data,labels) - selects top 10 features using JMI
%
% Demos:
%  demgd, demperceptron, demlogreg demsvm
% 
%
