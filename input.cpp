#include <iostream>
#include <string>
#include <queue>
#include <cmath>
#define MAX 101
using namespace std;double sum(double a, double b){return max(a,b)+log1p(exp(-abs(a-b)));}double sum_arr(double array[], int n){double max = *std::max_element(array, array + n + 1);double sum = 0;for(int i = 0; i <= n; i++)sum += exp(array[i] - max);return max + log(sum);}double C_i_S_i,v1,v2,v3,v4,v6,v7,v8,v9,v14,v15,v17;

int main(){
double logs[MAX+1]; for(int i = 0; i <= MAX; i++) logs[i] = log(i);
double v2_arr[MAX];
//~~~Boundary case where the prv is true for no individuals~~~
v4=0.9999999968880912*6+0.9999999968880912*3+(0.6931471805*6);
v3=v4;
v2_arr[0]=v3;
//~~~Going into the loop~~~
C_i_S_i=logs[3];
for(int i_S_i=1;i_S_i<3;i_S_i++){
    v9=sum(0.9999999968880912+0,0.0+0);
    v8=v9*(3-i_S_i);
    v7=v8*(i_S_i);
    v6=0.9999999968880912*((3-i_S_i))+0.9999999968880912*((i_S_i))+0.9999999968880912*((3-i_S_i)*(i_S_i))+0.9999999968880912*(3-i_S_i)*(3-i_S_i-1)+0.9999999968880912*(i_S_i)*(i_S_i-1)+v7+(0.6931471805*(i_S_i)*(i_S_i-1)+0.6931471805*((3-i_S_i)*(i_S_i))+0.6931471805*(3-i_S_i)*(3-i_S_i-1));
    v2_arr[i_S_i]=C_i_S_i+v6;
    C_i_S_i=(C_i_S_i-logs[i_S_i+1])+logs[(3)-i_S_i];
}
//~~~Boundary case where the prv is true for all individuals~~~
v15=0.9999999968880912*6+0.9999999968880912*3+(0.6931471805*6);
v14=v15;
v2_arr[3]=v14;
v2=sum_arr(v2_arr, 3);
v1=v2;

cout << exp(v1) << endl;
return 0;}