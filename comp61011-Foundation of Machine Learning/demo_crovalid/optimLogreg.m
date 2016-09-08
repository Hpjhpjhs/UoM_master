function [model, err] = optimLogreg( data, labels )
    
    [~, numFeatures] = size(data);
    mysampler = sampler(data, labels);
    model = logreg();
    err = 1;
    
    for i=0.1:-0.01:0.01
        for j=numFeatures*10:numFeatures*100
            
            mysampler = mysampler.randomize();
            [tr te] = mysampler.split(1,2);
            tempModel = logreg('iterations',j, 'learningrate',i).train(tr.data, tr.labels);
            tempErr = tempModel.test(te.data, te.labels).err();
            if(tempErr < err)
                    model = tempModel;
                    err = tempErr;
            end
           
        end
    end
    
    
end
