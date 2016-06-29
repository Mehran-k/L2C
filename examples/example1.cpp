#include <iostream>
#include <string>
#include <queue>
#include <cmath>
#define MAX 6
using namespace std;double sum(double a, double b){return max(a,b)+log1p(exp(-abs(a-b)));}double sum_arr(double array[], int n){double max = *std::max_element(array, array + n + 1);double sum = 0;for(int i = 0; i <= n; i++)sum += exp(array[i] - max);return max + log(sum);}double C_i_Smokes_i,v1,v2,v3,v5,v6,v7,v10,v12,v13,v14,v17,v19,v20,v21,v22,v25,v27,v28,v30;

int main(){
double logs[MAX+1]; for(int i = 0; i <= MAX; i++) logs[i] = log(i);
double v1_arr[MAX]; C_i_Smokes_i=0;
for(int i_Smokes_i=0;i_Smokes_i<=5;i_Smokes_i++){
if(i_Smokes_i==0){
v1_arr[i_Smokes_i]=42.3286795125;
}
else if(i_Smokes_i==1){
v10=1.0;
v7=sum(0, v10);
v6=v7*(5-1);
v5=1.0*((5-1))+1.0*1+1.0*((5-1)*(1))+1.0*((5-1)*(5-1-1))+v6+(0.6931471805*1+0.6931471805*((5-1))+0.6931471805*((5-1)*(1))+0.6931471805*((5-1)*(5-1-1)));
v1_arr[i_Smokes_i]=C_i_Smokes_i+v5+(sum(1.0, 0.0)*((i_Smokes_i)*(i_Smokes_i-1))+0.6931471805*((i_Smokes_i)*(i_Smokes_i-1)));
}
else if(i_Smokes_i==4){
v17=1.0;
v14=sum(0, v17);
v13=v14*(4);
v12=1.0*1+1.0*4+1.0*4+1.0*12+v13+(0.6931471805*4+0.6931471805*1+0.6931471805*12+0.6931471805*4);
v1_arr[i_Smokes_i]=C_i_Smokes_i+v12+(sum(1.0, 0.0)*((5-i_Smokes_i)*(5-i_Smokes_i-1))+0.6931471805*((5-i_Smokes_i)*(5-i_Smokes_i-1)));
}
else if(i_Smokes_i!=5){
v25=1.0;
v22=sum(0, v25);
v21=v22*(5-i_Smokes_i);
v20=v21*(i_Smokes_i);
v19=1.0*((5-i_Smokes_i))+1.0*((i_Smokes_i))+1.0*((5-i_Smokes_i)*(i_Smokes_i))+1.0*((5-i_Smokes_i)*(5-i_Smokes_i-1))+1.0*((i_Smokes_i)*(i_Smokes_i-1))+v20+(0.6931471805*((i_Smokes_i))+0.6931471805*((5-i_Smokes_i))+0.6931471805*((i_Smokes_i)*(i_Smokes_i-1))+0.6931471805*((5-i_Smokes_i)*(i_Smokes_i))+0.6931471805*((5-i_Smokes_i)*(5-i_Smokes_i-1)));
v1_arr[i_Smokes_i]=C_i_Smokes_i+v19;
}
else{
v1_arr[i_Smokes_i]=42.3286795125;
}
C_i_Smokes_i=(C_i_Smokes_i-logs[i_Smokes_i+1])+logs[(5)-i_Smokes_i];
}
v1=sum_arr(v1_arr, 5);
	cout << "exp(" << v1 << ") = " << exp(v1) << endl;
	return 0;
}