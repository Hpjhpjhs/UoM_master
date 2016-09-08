learners = {@dtree,@knn,@gnbayes,@knn,@lindisc,@logreg,@nbayes,@svm};

load heart_scale;
data = heart_scale_inst;
labels = heart_scale_label;

data = rescale_mean0var1(data);
labels = rescale_polar(labels);

d = sampler(data,labels);
[tr te] = d.split(1,2);



for i=1:length(learners)

    a = learners{i}; %get function handle
    a = a();         %create object

    a = a.train(tr.data,tr.labels); %train it
    res = a.test(te.data,te.labels); %est it


    results(i) = res.acc();
	%disp(a)
 
    
end

%results'
answers = mean(results(2:7)-[ 0.8444 0.7926 0.8074 0.8074 0.7333 0.8519 ]);
if answers<0.01
   disp('All MLOtools tests passed');
else
   disp('Potential MLOtools error');
   answers;
end

clear all

