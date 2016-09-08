function result = ROCtest(data, labels, model)

    mysampler = sampler(data, labels);
    [tr te] = mysampler.split(1,2);
    model = model.train(tr.data, tr.labels);
    model(te.data);
    [tpr, fpr, th] = roc(te.labels, y);
 

end