%DISCRETIZE INTO EQUAL WIDTH BINS
% WHERE BIN WIDTH IS GIVEN BY THE SCOTT CRITERION
% SEE STURGESRULE_DSCOTT.PDF IN THIS DIRECTORY
%
function data = disc_scott( q )

%for each feature
for fnum = 1:size(q,2)

    feature = q(:,fnum);
    minval = min(feature);
    
    %scott criterion gives optimal bin width %or approx 3.49
    width = 3.490830212 * std(feature) * length(feature)^(-1/3);
    if width==0
        numintervals=1;
    else
        numintervals = ceil(range(feature)/width);
    end
    
    %equal width
    %width = range(feature)/numintervals;
     
    
    %create boundaries for equal width
    boundaryend=0;
    for n=1:numintervals
        boundaryend(n) = minval + n*width;
    end
    

    
    %use boundaries
    lastboundaryend = minval-1;
    newfeature=0;
    for n=1:numintervals
        indices = find( feature>lastboundaryend & feature<=boundaryend(n) );
        newfeature(indices) = n;
        lastboundaryend = boundaryend(n);
    end
    
    q(:,fnum) = round(newfeature');
end

data = q;

%return this instead if you want to start the values from 0
%data = q-1;


