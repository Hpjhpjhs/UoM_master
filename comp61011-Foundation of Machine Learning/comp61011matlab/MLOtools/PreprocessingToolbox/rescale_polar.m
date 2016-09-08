%
% MLOTools / RESCALE_POLAR
% Centers and rescales to range [-1 ... +1]
%
function rescaled = rescale_polar ( data )

if ~exist('data','var')
       error('RESCALE_POLAR : Please provide a data matrix.');       
end

mins = repmat( min(data), size(data,1), 1 );
maxs = repmat( max(data), size(data,1), 1 );

rescaled01 = (data - mins) ./ (maxs-mins); %scale to 0 to 1

rescaled = rescaled01 * 2 - 1; %now in range -1 to +1