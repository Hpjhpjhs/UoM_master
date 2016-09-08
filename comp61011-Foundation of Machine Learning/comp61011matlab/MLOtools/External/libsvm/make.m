% This make.m is used under Windows

% add -largeArrayDims on 64-bit machines

mex -c -largeArrayDims svm.cpp
mex -c -largeArrayDims svm_model_matlab.c

if ispc
    mex -largeArrayDims svmtrain.c svm.obj svm_model_matlab.obj
    mex -largeArrayDims svmpredict.c svm.obj svm_model_matlab.obj
else
    mex -largeArrayDims svmtrain.c svm.o svm_model_matlab.o
    mex -largeArrayDims svmpredict.c svm.o svm_model_matlab.o
end        

mex -largeArrayDims libsvmread.c
mex -largeArrayDims libsvmwrite.c
