function result = week1()
load heart;
result = [];
[numRow, numColumn] = size(data);
for i= numColumn:50
    
model = logreg('iterations', i, 'learningrate', 0.01).train(data, labels);
res = model.test(data, labels);
e = res.err();
result(i)=e; 

end

end
