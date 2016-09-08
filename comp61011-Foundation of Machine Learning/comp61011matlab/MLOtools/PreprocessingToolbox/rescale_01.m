%
% MLOTools / RESCALE_MEAN0VAR1
% Centers and rescales to mean 0 variance 1
%
% newdata = rescale_01(data);
%
function rescaled = rescale_01 ( data )

if ~exist('data','var')
       error('RESCALE_01 : Please provide a data matrix.');       
end

mins = repmat( min(data), size(data,1), 1 );
maxs = repmat( max(data), size(data,1), 1 );

rescaled = (data - mins) ./ (maxs-mins);
