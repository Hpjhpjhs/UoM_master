function result = demo(data, labels, numFold)
    
    result = zeros( numFold, 3 );
    
    [rowNum, colNum] = size(data);
    increasingRate = rowNum/numFold;
    
    mysampler = sampler(data, labels);
    
    for j=1:numFold
        
        temp = zeros( (numFold-1), 2 );
        
        mysampler = mysampler.randomize();
        [tr te] = mysampler.split(j, numFold);


        for i=1:(numFold-1)

            logModel = logreg();
            bayesModel = gnbayes();

            td = tr.data(1:increasingRate*i,:);
            tl = tr.labels(1:increasingRate*i,:);

            logModel = logModel.train( td, tl);
            logAcc = logModel.test( te.data, te.labels).acc();

            bayesModel = bayesModel.train( td, tl);
            bayesAcc = bayesModel.test( te.data, te.labels).acc();

            temp(i,:) = [logAcc bayesAcc];

        end
        
        logTemp = mean( temp(:,1) );        
        bayesTemp = mean( temp(:,2) );
        result(j,:) = [j logTemp bayesTemp];
        
    end
    
    
        x = result(:,1);
        %accuracy of logistic regression
        y1 = result(:,2);
        plot(x, y1, 'r*-');

        hold();
        %achold();curacy of GNB
        y2 = result(:,3);
        plot(x, y2, 'go--');

end
