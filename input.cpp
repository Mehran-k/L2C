#include <iostream>
#include <string>
#include <queue>
#include <cmath>
#define MAX 101
using namespace std;double sum(double a, double b){return max(a,b)+log1p(exp(-abs(a-b)));}double sum_arr(double array[], int n){double max = *std::max_element(array, array + n + 1);double sum = 0;for(int i = 0; i <= n; i++)sum += exp(array[i] - max);return max + log(sum);}double v1,v2,v3,v4,v6,v7,v9;
int main(){
double logs[MAX+1]; for(int i = 0; i <= MAX; i++) logs[i] = log(i);
v4=0;
v3=0.9999999895305024*1+v4;
v7=0;
v6=0.0*1+v7;
v2=sum(0.0+v3,0.0+v6);
v1=v2*(2);

cout << exp(v1) << endl;
return 0;}