% MLOtools SVM
% 
% A wrapper round the LibSVM implementation of an SVM.
%
% Usage: model = svm('libsvm_options');
%
% libsvm_options:
% -t kernel_type : set type of kernel function (default 2)
% 	0 -- linear: u'*v
% 	1 -- polynomial: (gamma*u'*v + coef0)^degree
% 	2 -- radial basis function: exp(-gamma*|u-v|^2)
% 	3 -- sigmoid: tanh(gamma*u'*v + coef0)
% -d degree : set degree in kernel function (default 3)
% -g gamma : set gamma in kernel function (default 1/num_features)
% -r coef0 : set coef0 in kernel function (default 0)
% -c cost : set the parameter C of C-SVC, epsilon-SVR, and nu-SVR (default 1)
% -m cachesize : set cache memory size in MB (default 100)
% -e epsilon : set tolerance of termination criterion (default 0.001)
% -wi weight : set the parameter C of class i to weight*C, for C-SVC (default 1)
% -v n : n-fold cross validation mode
% -q : quiet mode (no outputs)
%
% Returns a results object.
%
% Examples
%  model = svm('-t 2 -g 1');          %% builds an RBF SVM with gamma=1
%  model = model.train(data,labels);  %%train it
%  model.test(data,labels).err()
%
%