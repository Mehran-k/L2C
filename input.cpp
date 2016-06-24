#include <iostream>
#include <string>
#include <queue>
#include <cmath>
#define MAX 101
using namespace std;double sum(double a, double b){return max(a,b)+log1p(exp(-abs(a-b)));}double sum_arr(double array[], int n){double max = *std::max_element(array, array + n + 1);double sum = 0;for(int i = 0; i <= n; i++)sum += exp(array[i] - max);return max + log(sum);}double C_i_T_i,v1,v2,v3,v7,v10,v11,v12;
queue<double> q11,q21;

int main(){
double logs[MAX+1]; for(int i = 0; i <= MAX; i++) logs[i] = log(i);
	double v3_arr[MAX];
	C_i_T_i=0;
	for(int i_T_i=0;i_T_i<=4;i_T_i++){
		if(i_T_i==0){
			v3_arr[i_T_i]=0;
		}
		else if(i_T_i==4){
			v3_arr[i_T_i]=(0.6931471805*4);
		}
		else{
			v3_arr[i_T_i]=C_i_T_i;
		}
		C_i_T_i=(C_i_T_i-logs[i_T_i+1])+logs[(4)-i_T_i];
	}
	v3=sum_arr(v3_arr, 4);
q11.push(v3);
v10=q11.front(); q11.pop();
v2=sum(0.0+v3,0.0+v10);
q21.push(v2);
v11=q21.front(); q21.pop();
v1=sum(0.0+v2,0.0+v11);

cout << exp(v1) << endl;
return 0;}