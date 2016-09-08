%
% DISC_ZEROSTDEVS
% Discretizes data according to being -1, below/above 0, or +1 standard deviations
% from the mean. I.E. four categories are output.
%

function discdata = disc_zerostdevs( data )
if ~exist('data')
       error('DISC_ZEROSTDEVS : Please provide a data matrix.');
       return
end

%CENTER AND RESCALE FIRST
data = rescale_mean0var1( data );

%FIND THE INTERVALS - SHORT AND UNINTELLIGIBLE MATLAB CODE! :-(
class1 = (data < -1);
class2 = (data > -1 & data < 0)*2;
class3 = (data >  0 & data < 1)*3;
class4 = (data > 1)*4;

discdata = class1+class2+class3+class4;
