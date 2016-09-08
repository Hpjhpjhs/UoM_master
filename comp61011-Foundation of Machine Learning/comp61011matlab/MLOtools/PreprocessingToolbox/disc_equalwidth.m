function [data,moredata] = disc_equalwidth( originaldata, numintervals, testdata )
%function [data,moredata] = disc_equalwidth( originaldata, numintervals, [ testdata ] )

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%idx = find(isnan(originaldata));
%originaldata(idx) = 0;

%for each feature
for fnum = 1:size(originaldata,2)

    feat = originaldata(:,fnum);
    minval = min(feat);
    width = abs(max(feat)-min(feat))/numintervals;

    %create boundaries for equal width
    boundaryend=0;
    for n=1:numintervals
        boundaryend(n) = minval + n*width;
    end
    boundaryend(numintervals) = boundaryend(numintervals) + 1; %to stop bug below


    if exist('testdata','var')
        testfeat = testdata(:,fnum);
        
        %use boundaries
        lastboundaryend = minval;
        newfeature=0;
        for n=1:numintervals
            indices = find( feat>=lastboundaryend & feat<boundaryend(n) );
            newfeature(indices) = n;
            
            indices = find( testfeat>=lastboundaryend & testfeat<boundaryend(n) );
            newtestfeature(indices) = n;
            
            lastboundaryend = boundaryend(n);
        end
        testdata(:,fnum) = newtestfeature;
        originaldata(:,fnum) = newfeature;
        
    else
        
        %use boundaries
        lastboundaryend = minval;
        newfeature=0;
        for n=1:numintervals
            indices = find( feat>=lastboundaryend & feat<boundaryend(n) );
            newfeature(indices) = n;
            lastboundaryend = boundaryend(n);
        end

        originaldata(:,fnum) = newfeature;
    end
    
end

if exist('testdata','var')    
    data = originaldata;
    moredata = testdata;
else
    data = originaldata;
end

