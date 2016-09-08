#include <stdio.h>
#include <stdlib.h>
//#include <time.h>
#include <sys/time.h>

//#include "./MIToolbox.h"
#include "ArrayOperations.h"
#include "Entropy.h"
#include "MutualInformation.h"


int main(int argc, char *argv[])
{
  double *firstVector = (double *) calloc(4,sizeof(double));
  double *secondVector = (double *) calloc(4,sizeof(double));
  double *thirdVector = (double *) calloc(4,sizeof(double));
  double *targetVector = (double *) calloc(4,sizeof(double));
  
  firstVector[0] = 0.0;
  firstVector[1] = 0.0;
  firstVector[2] = 1.0;
  firstVector[3] = 1.0;
  
  secondVector[0] = 0.0;
  secondVector[1] = 1.0;
  secondVector[2] = 0.0;
  secondVector[3] = 1.0;
  
  thirdVector[0] = 0.0;
  thirdVector[1] = 1.0;
  thirdVector[2] = 1.0;
  thirdVector[3] = 1.0;
  
  targetVector[0] = 0.0;
  targetVector[1] = 1.0;
  targetVector[2] = 1.0;
  targetVector[3] = 0.0;
  
  double firstEntropy = calculateEntropy(firstVector,4);
  double secondEntropy = calculateEntropy(secondVector,4);
  double thirdEntropy = calculateEntropy(thirdVector,4);
  double targetEntropy = calculateEntropy(targetVector,4);
  
  printf("Entropies - first: %f, second: %f, third: %f, target %f\n",firstEntropy,secondEntropy,thirdEntropy,targetEntropy);
    
  double firstMItarget = calculateMutualInformation(firstVector,targetVector,4);
  double secondMItarget = calculateMutualInformation(secondVector,targetVector,4);
  double thirdMItarget = calculateMutualInformation(thirdVector,targetVector,4);
  double targetMItarget = calculateMutualInformation(targetVector,targetVector,4);
  
  printf("MIs - first: %f, second: %f, third: %f, target %f\n",firstMItarget,secondMItarget,thirdMItarget,targetMItarget);
  
  double *testFirstVector = (double *) calloc(10000,sizeof(double));
  double *testSecondVector = (double *) calloc(10000,sizeof(double));
  double *testThirdVector = (double *) calloc(10000,sizeof(double));
  double *testMergedVector = (double *) calloc(10000,sizeof(double));
  
  
  for (int i = 0; i < 10000; i++)
  {
    testFirstVector[i] = i % 2;
    testSecondVector[i] = i % 4;
    testThirdVector[i] = i % 3;
  }
  timeval start,end;
  //struct timeval
  //{
  //time_t         tv_sec      seconds
  //suseconds_t    tv_usec     microseconds
  //}
  
  gettimeofday(&start, NULL);
  for (int i = 0; i < 1000; i++)
  {
    double miTarget = calculateMutualInformation(testFirstVector,testSecondVector,10000);
    double entropyTarget = calculateEntropy(testFirstVector,10000);
    double cmiTarget = calculateConditionalMutualInformation(testFirstVector,testSecondVector,testThirdVector,10000);
    mergeArrays(testFirstVector,testSecondVector,testMergedVector,10000);
  }
  gettimeofday(&end, NULL);
  
  double length = end.tv_sec - start.tv_sec;
  length = length + (end.tv_usec - start.tv_usec) / 1000000.0;
  
  printf("Time taken for a thousand I(X;Y), H(X), I(X;Y|Z), merge(X,Y) is %lf seconds\n",length);
}//main(int, char **)
