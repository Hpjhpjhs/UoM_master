function errors = week3DTree (data, labels, maxDepth)

errors = [maxDepth, 2];

mysampler = sampler(data, labels);


for i=1:maxDepth
   
    model = dtree('maxdepth', i);
    mysampler = mysampler.randomize();
    [tr te] = mysampler.split(1,2);
    
    model = model.train(tr.data, tr.labels);
    res = model.test(te.data, te.labels);
    err = res.err();
    
    errors(i,:) = [i err];
end

end