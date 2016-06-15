#include <iostream>
#include <string>
#include <queue>
#include <cmath>
#define MAX 101
using namespace std;double sum(double a, double b){return max(a,b)+log1p(exp(-abs(a-b)));}double sum_arr(double array[], int n){double max = *std::max_element(array, array + n + 1);double sum = 0;for(int i = 0; i <= n; i++)sum += exp(array[i] - max);return max + log(sum);}double C_i_F_r1_i,C_i_S_i,v1,v2,v3,v4,v5,v6,v7,v8,v9,v11,v12,v13,v14,v15,v17,v19,v20,v22;

int main(){
double logs[MAX+1]; for(int i = 0; i <= MAX; i++) logs[i] = log(i);
double v2_arr[MAX];
//~~~Boundary case where the prv is true for no individuals~~~
v4=-2000;
v3=0.0*3+v4;
v2_arr[0]=v3;
//~~~Going into the loop~~~
C_i_F_r1_i=logs[3];
for(int i_F_r1_i=1;i_F_r1_i<3;i_F_r1_i++){
    v5=-2000;
    v2_arr[i_F_r1_i]=C_i_F_r1_i+(1.0*i_F_r1_i+0.0*(3-i_F_r1_i))+v5;
    C_i_F_r1_i=(C_i_F_r1_i-logs[i_F_r1_i+1])+logs[(3)-i_F_r1_i];
}
//~~~Boundary case where the prv is true for all individuals~~~
double v7_arr[MAX];
//~~~Boundary case where the prv is true for no individuals~~~
v9=1.0*6+(0.6931471805*6);
v8=v9;
v7_arr[0]=v8;
//~~~Going into the loop~~~
C_i_S_i=logs[3];
for(int i_S_i=1;i_S_i<3;i_S_i++){
    v15=0.0*1+0;
    v17=1.0*1+0;
    v14=sum(0.0+v15,0.0+v17);
    v13=v14*(3-i_S_i);
    v12=v13*(i_S_i);
    v11=1.0*((3-i_S_i)*(i_S_i))+1.0*(3-i_S_i)*(3-i_S_i-1)+1.0*(i_S_i)*(i_S_i-1)+v12+(0.6931471805*(i_S_i)*(i_S_i-1)+0.6931471805*((3-i_S_i)*(i_S_i))+0.6931471805*(3-i_S_i)*(3-i_S_i-1));
    v7_arr[i_S_i]=C_i_S_i+v11;
    C_i_S_i=(C_i_S_i-logs[i_S_i+1])+logs[(3)-i_S_i];
}
//~~~Boundary case where the prv is true for all individuals~~~
v20=1.0*6+(0.6931471805*6);
v19=v20+(0.6931471805*3);
v7_arr[3]=v19;
v7=sum_arr(v7_arr, 3);
v6=1.0*3+v7;
v2_arr[3]=v6;
v2=sum_arr(v2_arr, 3);
v1=v2;

cout << exp(v1) << endl;
return 0;}