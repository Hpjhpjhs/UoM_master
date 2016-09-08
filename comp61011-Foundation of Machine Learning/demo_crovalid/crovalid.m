function [iterat, learnrate] = crovalid (data, labels, numfolds)

[~, numCol] = size(data);
mysampler = sampler(data, labels);
error = 1;

for learningrate=0.1:-0.01:0.01
    for iterations=numCol*(10:10:50)
        mysampler = mysampler.randomize();
        
        for i=1:numfolds

            [tr te] = mysampler.split(i,numfolds);

            model = logreg('iterations',iterations, 'learningrate',learningrate).train(tr.data, tr.labels);
            res = model.test(te.data, te.labels);
            err = res.err();

            errors(i,:) = err;
        end
        tempErr = mean(errors);
        if(tempErr < error)
            iterat = iterations;
            learnrate = learningrate;
            error = tempErr;
        end
        
    end
end

end