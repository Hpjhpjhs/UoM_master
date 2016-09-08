function err = crovalid (model, data, labels, numFold)

errors = [numFold, 2];

mysampler = sampler(data, labels);

for i=1:numFold
    
    [tr te] = mysampler.split(i,numFold);
    
    model = model.train(tr.data, tr.labels);
    res = model.test(te.data, te.labels);
    err = res.err();
    
    errors(i,:) = [i err];
end

end