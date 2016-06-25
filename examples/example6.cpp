#include <iostream>
#include <string>
#include <queue>
#include <cmath>
#define MAX 101
using namespace std;double sum(double a, double b){return max(a,b)+log1p(exp(-abs(a-b)));}double sum_arr(double array[], int n){double max = *std::max_element(array, array + n + 1);double sum = 0;for(int i = 0; i <= n; i++)sum += exp(array[i] - max);return max + log(sum);}double v1,v2,v3,v8,v9,v12;

int main(){
double logs[MAX+1]; for(int i = 0; i <= MAX; i++) logs[i] = log(i);
v3=sum(0.0+0,0.0+0);
v2=v3*(((6)*(6 - 1)) / 2.0);
v9=sum(0.0+0,0.0+0);
v8=v9*(6);
v1=v2+v8;

cout << exp(v1) << endl;
return 0;}