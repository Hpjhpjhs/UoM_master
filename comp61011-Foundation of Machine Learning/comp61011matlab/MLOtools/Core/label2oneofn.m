function oneofn = label2oneofn ( targets )
%label2oneofn( targets )
%
%  Converts from a label representation to a 1-of-N form.
%  Argument 'targets' must be a column vector.
%  Example:
%
%  >> targets = [ 1 3 2 1 3 ]';
%  >> label2oneofn( targets )
%
%  ans =
%
%      1     0     0
%      0     0     1
%      0     1     0
%      1     0     0
%      0     0     1
%
%  Note that this does the opposite of ONEOFN2LABEL.
%
%  See also
%  ONEOFN2LABEL
if size(targets,2) > 1
    error('label2oneofn expects a column vector.');
end

oneofn = repmat(targets, 1, length(unique(targets))) == repmat(unique(targets)', length(targets), 1);
