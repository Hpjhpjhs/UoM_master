% function data = disc_medians( q )
%
% Discretizes continuous data into binary data,
% using the median value of each column as the
% discretization point.
%
function data = disc_medians( q )

medians = repmat( median(q), size(q,1), 1 );

data = double(q > medians);
