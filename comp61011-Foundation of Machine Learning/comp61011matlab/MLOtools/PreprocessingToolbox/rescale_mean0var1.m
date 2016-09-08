%
% MLOTOOLS / RESCALE_MEAN0VAR1
%
% Centers and rescales to mean 0 variance 1
% Optional arguments allow rescaling according to statistics
% drawn from a different dataset.  e.g.:
%
% [traindata mu sigma] = rescale_mean0var1( traindata );
% testdata = rescale_mean0var1( testdata );
%
% function [rescaled mu sigma] = rescale_mean0var1 ( data, mu, sigma )
function [rescaled mu sigma] = rescale_mean0var1 ( data, mu, sigma )

if ~exist('data','var')
       error('RESCALE_MEAN0VAR1 : Please provide a data matrix.');
end

if ~exist('mu','var')
    %disp('calc mu');
    mu = mean(data);
end

if ~exist('sigma','var')
    %disp('calc sigma');
    sigma = std(data);
end

mu_matrix = repmat( mu, [size(data,1) 1] );
sigma_matrix  = repmat( sigma, [size(data,1) 1] );

rescaled = (data - mu_matrix) ./ (sigma_matrix+0.000001);
