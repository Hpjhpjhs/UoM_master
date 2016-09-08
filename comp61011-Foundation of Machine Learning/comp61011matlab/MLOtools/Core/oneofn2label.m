function labels = oneofn2label ( targets )
%oneofn2label( targets )
%
%  Converts from a 1-of-N representation to a label form.
%  Argument 'targets' must be a binary matrix.
%  Example:
%
%  >> targets = [1 0 0; 0 0 1; 0 1 0; 1 0 0; 0 0 1];
%  >> oneofn2label( targets )
%
%  ans =
%
%     1
%     3
%     2
%     1
%     3
%
%  Note that this does the opposite of LABEL2ONEOFN.
%
%  See also
%  LABEL2ONEOFN
if ~(sum(sum(targets')==1)==size(targets',2))
    error('Target data is not in 1-of-n format.');
end

labels = find(targets')-[0:length(targets)-1]'*size(targets,2);
