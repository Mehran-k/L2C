#include <iostream>
#include <string>
#include <queue>
#include <cmath>
#define MAX 7
using namespace std;double sum(double a, double b){return max(a,b)+log1p(exp(-abs(a-b)));}double sum_arr(double array[], int n){double max = *std::max_element(array, array + n + 1);double sum = 0;for(int i = 0; i <= n; i++)sum += exp(array[i] - max);return max + log(sum);}double C_i_S_i,v1,v9,v11;

int main(){
double logs[MAX+1]; for(int i = 0; i <= MAX; i++) logs[i] = log(i);
double v1_arr[MAX]; C_i_S_i=0;
for(int i_S_i=0;i_S_i<=6;i_S_i++){
if(i_S_i==0){
v1_arr[i_S_i]=0;
}
else if(i_S_i==5){
v1_arr[i_S_i]=C_i_S_i+(0.6931471805*((6-i_S_i)));
}
else if(i_S_i!=6){
v1_arr[i_S_i]=C_i_S_i;
}
else{
v1_arr[i_S_i]=4.158883083;
}
C_i_S_i=(C_i_S_i-logs[i_S_i+1])+logs[(6)-i_S_i];
}
v1=sum_arr(v1_arr, 6);
	cout << "exp(" << v1 << ") = " << exp(v1) << endl;
	return 0;
}