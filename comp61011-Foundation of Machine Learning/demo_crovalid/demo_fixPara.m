%comparison between logreg and gnbayes on breast dataset (continuous)
function result = demo_fixPara(data, labels)
    trainingTimes = 10;
    increasingTimes = 10;

    [~, clm] = size(data);
    %rescale features to range of 0-1
    for col=1:clm
        data(:,col) = mat2gray(data(:,col));
    end
    
    %find the optimal learningrate and iterations via cross validation on
    %whole dataset
    [iterations, learningrate] = crovalid(data, labels, 10)

    mysampler = sampler(data, labels).randomize();
    %split by half, one half for test
    [tr te] = mysampler.split(1,2);
    
    [trRows, trColumns] = size(tr.data);
    increasingRate = ceil(trRows/increasingTimes);
 
    for i=1:increasingTimes% increasing the amount of training data by 10 times

        for j=1:trainingTimes%for same amount of training data, average multi times on different data
            tr = tr.randomize();
            
            %increasing the trainingset by times
            numExamples = i*increasingRate;
            if(numExamples>trRows)
                numExamples = trRows;
            end
            trData = tr.data( 1:numExamples, : );
            trLabels = tr.labels(1:numExamples, :);
            %one label in tr data, nothing to learning
            if( isequal( trLabels, ones(numExamples, 1) ) || isequal( trLabels, zeros(numExamples,1) ) ) 
                j = j-1;
                continue;
            end
            
            %logreg with fixed para by corss validation
            logModel = logreg('iterations',iterations*10, 'learningrate',learningrate).train(trData, trLabels);
            logErr = logModel.test(te.data, te.labels).err();
            %logreg end

            %gnb
            gnbModel = gnbayes().train(trData, trLabels);
            gnbErr = gnbModel.test(te.data, te.labels).err();
            %gnb end
            
            errors(j, :) = [logErr gnbErr];
        end
        
        result(i, :) = [i mean(errors(:,1)) mean(errors(:,2))];
        
    end
    
        x = result(:,1) *increasingRate;
        %error of logistic regression
        y1 = result(:,2);
        %error of GNB
        y2 = result(:,3);
        
        %plot(x, y1, 'r+-', x, y2, 'g+-')
        errorbar( x, y1, std(y1)*ones(size(x)), 'r--' );
        hold on;
        errorbar( x, y2, std(y2)*ones(size(x)), 'g+-' );
        
        xlabel('number of training examples');
        ylabel('err rate of model on same testData');
        legend('logreg', 'gnbayes');
        title('Comparison between Logistic Regression and Guassian Naive Bayes on increassing amount of training data');

end
