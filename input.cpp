#include <iostream>
#include <string>
#include <queue>
#include <cmath>
#define MAX 101
using namespace std;double sum(double a, double b){return max(a,b)+log1p(exp(-abs(a-b)));}double sum_arr(double array[], int n){double max = *std::max_element(array, array + n + 1);double sum = 0;for(int i = 0; i <= n; i++)sum += exp(array[i] - max);return max + log(sum);}double C_i_S_i,v1,v2,v3,v4,v6,v8,v10,v11,v12,v13;
queue<double> q11,q12;

int main(){
double logs[MAX+1]; for(int i = 0; i <= MAX; i++) logs[i] = log(i);
double v2_arr[MAX];
v4=0;
v3=v4;
v2_arr[0]=v3;
C_i_S_i=logs[3];
for(int i_S_i=1;i_S_i<3;i_S_i++){
    v6=0;
    v2_arr[i_S_i]=C_i_S_i+0;
    C_i_S_i=(C_i_S_i-logs[i_S_i+1])+logs[(3)-i_S_i];
}
v8=(0.6931471805*3);
v2_arr[3]=v8;
v2=sum_arr(v2_arr, 3);
q11.push(v2);
q12.push(v2);
v11=q11.front(); q11.pop();
v12=q12.front(); q12.pop();
v10=sum(0.0+v11,0.0+v12);
v1=sum(0.0+v2+(0.6931471805*1),0.0+v10);

cout << exp(v1) << endl;
return 0;}