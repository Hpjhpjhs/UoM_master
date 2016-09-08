% function data = disc_means( q )
%
% Discretizes continuous data into binary data,
% using the mean value of each column as the
% discretization point.
%
function data = disc_means( q )

means = repmat( mean(q), size(q,1), 1 );

data = double(q > means);
