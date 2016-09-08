%
% MLOtools Decision tree
% Optional arguments: minex, maxdepth
%
%   model = dtree().train(data,labels);
%   err = model.test(data,labels).err();
%
% Specify maximum tree depth by passing to the constructor:
%
%   model = dtree('maxdepth',5);
%
% Default maximum depth of 10.
%
% Change the minimum number of examples required to make a
% split in the same way:
%
%   model = dtree('maxdepth',5,'minex',30);
%
% Default minimum examples is 20.
%