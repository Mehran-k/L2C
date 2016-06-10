#include <iostream>
			#include <string>
#include <queue>
#include <cmath>
#define MAX 101
using namespace std;double sum(double a, double b){return max(a,b)+log1p(exp(-abs(a-b)));}double sum_arr(double array[], int n){double max = *std::max_element(array, array + n + 1);double sum = 0;for(int i = 0; i <= n; i++)sum += exp(array[i] - max);return max + log(sum);}double C_i_T_i,v1,v2,v3,v4,v5,v6,v9;
int main(){
double logs[MAX+1]; for(int i = 0; i <= MAX; i++) logs[i] = log(i);
C_i_T_i=0;double v2_arr[MAX];
for(int i_T_i=0;i_T_i<=3;i_T_i++){
    v6=0;
    v5=sum(0.0+v6,0.0+(0.693147*((1)*(3-i_T_i))));
    v4=v5*(i_T_i);
    v3=v4+(0.693147*((3-i_T_i)*(3-i_T_i)));
    v2_arr[i_T_i]=C_i_T_i+(0.0*i_T_i+0.0*(3-i_T_i))+v3+(0.693147*((i_T_i)*(i_T_i))+0.693147*((3-i_T_i)*(i_T_i)));
    C_i_T_i=(C_i_T_i-logs[i_T_i+1])+logs[(3)-i_T_i];}
v2=sum_arr(v2_arr, 3);
v1=v2;

cout << exp(v1) << endl;
return 0;}