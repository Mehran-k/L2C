#include <iostream>
			#include <string>
#include <queue>
#include <cmath>
#define MAX 101
using namespace std;double sum(double a, double b){return max(a,b)+log1p(exp(-abs(a-b)));}double sum_arr(double array[], int n){double max = *std::max_element(array, array + n + 1);double sum = 0;for(int i = 0; i <= n; i++)sum += exp(array[i] - max);return max + log(sum);}double C_i_Friend_r1_i,C_i_T1_i,v1,v2,v3,v4,v5,v6,v7,v9,v11,v12,v14,v16,v17,v19,v21;
int main(){
double logs[MAX+1]; for(int i = 0; i <= MAX; i++) logs[i] = log(i);
C_i_Friend_r1_i=0;double v2_arr[100];
for(int i_Friend_r1_i=0;i_Friend_r1_i<=3;i_Friend_r1_i++){
    C_i_T1_i=0;double v4_arr[100];
    for(int i_T1_i=0;i_T1_i<=i_Friend_r1_i;i_T1_i++){
        
        
        v9=0;
        v7=sum(0.0+(0.693147*((1)*(i_Friend_r1_i-i_T1_i))),0.0+v9);
        v6=v7*(3-i_Friend_r1_i);
        
        
        v14=0;
        v12=sum(0.0+(0.693147*((1)*(i_Friend_r1_i-i_T1_i))),0.0+v14);
        v11=v12*(i_T1_i);
        
        
        v19=0;
        v17=sum(0.0+(0.693147*((1)*((i_Friend_r1_i-i_T1_i-1)))),0.0+v19);
        v16=v17*(i_Friend_r1_i-i_T1_i);
        v5=v6+v11+v16;
        v4_arr[i_T1_i]=C_i_T1_i+(0.0*i_T1_i+0.0*(i_Friend_r1_i-i_T1_i))+v5+(0.693147*((3-i_Friend_r1_i)*(i_T1_i))+0.693147*((i_T1_i)*(i_T1_i))+0.693147*((i_Friend_r1_i-i_T1_i)*(i_T1_i)));
        C_i_T1_i=(C_i_T1_i-logs[i_T1_i+1])+logs[(i_Friend_r1_i)-i_T1_i];}
    v4=sum_arr(v4_arr, i_Friend_r1_i);
    v3=v4+(0.693147*((i_Friend_r1_i)*(3-i_Friend_r1_i))+0.693147*((3-i_Friend_r1_i)*(3-i_Friend_r1_i)));
    v2_arr[i_Friend_r1_i]=C_i_Friend_r1_i+(0.0*i_Friend_r1_i+0.0*(3-i_Friend_r1_i))+v3;
    C_i_Friend_r1_i=(C_i_Friend_r1_i-logs[i_Friend_r1_i+1])+logs[(3)-i_Friend_r1_i];}
v2=sum_arr(v2_arr, 3);
v1=v2;

cout << exp(v1) << endl;
return 0;}