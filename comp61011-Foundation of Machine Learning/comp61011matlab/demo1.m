function result = demo1(data, labels, numFold)
    
    result = zeros( (numFold-1), 3 );
    
    [rowNum, colNum] = size(data);
    increasingRate = rowNum/numFold;
    
    mysampler = sampler(data, labels);
    mysample = mysampler.randomize();
    [tr te] = mysampler.split(numFold, numFold);
    

    for i=1:(numFold-1)
        
        logModel = logreg();
        bayesModel = gnbayes();
        
        td = tr.data(1:increasingRate*i,:);
        tl = tr.labels(1:increasingRate*i,:);
        
        logModel = logModel.train( td, tl);
        logAcc = logModel.test( te.data, te.labels).acc();
        
        bayesModel = bayesModel.train( td, tl);
        bayesAcc = bayesModel.test( te.data, te.labels).acc();
        
        result(i, :) = [i logAcc bayesAcc];
        
    end
    
    x = result(:,1);
    y1 = result(:,2);
    y2 = result(:,3);
    plot(x, y1, 'r*-');
    hold();
    %GNB
    plot(x, y2, 'go--');
    
end
