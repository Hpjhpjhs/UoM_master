function errors = week3KNN(data, labels)

    topK = 15;

    errors = [10, 2];

    mysampler = sampler(data, labels);
    
    for j=1:10

        mysampler.randomize();
        [tr te] = mysampler.split(1,2);
        tempErr = [topK, 2];
        for i=1:topK
            model = knn('k', i);
            model = model.train(tr.data, tr.labels);
            res = model.test(te.data, te.labels);
            err = res.err();
            tempErr(i,:) = [i err];
        end
        ave = mean( tempErr(:,2) );
        errors(j,:)= [j, ave];
    end
end