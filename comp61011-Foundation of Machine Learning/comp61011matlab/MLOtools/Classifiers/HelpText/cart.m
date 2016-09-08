% MLOtools CART
%
% Wraps the Matlab statistics toolbox CART function.
% NB: CART = Classification And Regression Tree.
%
% Note that for simplicity this implementation only supports classification.
% You may like to use the underlying "classregtree" function if you want
% more control over how this works.
%
% model = cart();             %create tree classifier.
% model.train(data, labels);  %train it
% model.test(data).err()      %get the results
%