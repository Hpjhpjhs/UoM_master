%
% function discdata = disc_stdevs( data )
%
% Discretizes continuous data into 3-valued data (-1/0/+1)
% with values being -1, 0 or +1 standard deviations
% from the mean.
%
function discdata = disc_stdevs( data )
if ~exist('data')
       error('DISC_STDEVS : Please provide a data matrix.');
       return
end

% %CENTER AND RESCALE FIRST
% data = rescale_mean0var1( data );
% 
% %FIND THE INTERVALS - SHORT AND UNINTELLIGIBLE MATLAB CODE! :-(
% class1 = (data < -1)*-1;
% class2 = (data > -1 & data < 1)*0;
% class3 = (data > 1)*1;
% 
% 
% d = class1+class2+class3;


%ALTERNATIVE IMPLMENTATION BELOW

%CENTER THE DATA
means = repmat( mean(data), [size(data,1) 1] );
%stds  = repmat( std(data), [size(data,1) 1] );
centered = (data - means);

%FIND THE STANDARD DEVIATIONS
stds = repmat( std(centered), [size(centered,1) 1] );

%FIND THE INTERVALS - SHORT AND UNINTELLIGIBLE MATLAB CODE! :-(
discdata = double(centered > stds) - double(centered < -1*stds);

