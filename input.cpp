#include <iostream>
#include <string>
#include <queue>
#include <cmath>
#define MAX 101
using namespace std;double sum(double a, double b){return max(a,b)+log1p(exp(-abs(a-b)));}double sum_arr(double array[], int n){double max = *std::max_element(array, array + n + 1);double sum = 0;for(int i = 0; i <= n; i++)sum += exp(array[i] - max);return max + log(sum);}double C_i_S_i,v1,v2,v4;

int main(){
double logs[MAX+1]; for(int i = 0; i <= MAX; i++) logs[i] = log(i);
C_i_S_i=0;double v1_arr[MAX];
for(int i_S_i=0;i_S_i<=3;i_S_i++){
    v2=0;
    v1_arr[i_S_i]=C_i_S_i+v2;
    C_i_S_i=(C_i_S_i-logs[i_S_i+1])+logs[(3)-i_S_i];}
v1=sum_arr(v1_arr, 3);

cout << exp(v1) << endl;
return 0;}