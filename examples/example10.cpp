#include <iostream>
#include <string>
#include <queue>
#include <cmath>
#define MAX 11
using namespace std;double sum(double a, double b){return max(a,b)+log1p(exp(-abs(a-b)));}double sum_arr(double array[], int n){double max = *std::max_element(array, array + n + 1);double sum = 0;for(int i = 0; i <= n; i++)sum += exp(array[i] - max);return max + log(sum);}double C_i_S_i,v1,v2,v10,v12,v13,v14,v15;
queue<double> q1_1,q1_2;

int main(){
double logs[MAX+1]; for(int i = 0; i <= MAX; i++) logs[i] = log(i);
	double v2_arr[MAX];
	C_i_S_i=0;
	for(int i_S_i=0;i_S_i<=10;i_S_i++){
		if(i_S_i==0){
			v2_arr[i_S_i]=0;
		}
		else if(i_S_i==9){
			v2_arr[i_S_i]=C_i_S_i;
		}
		else if(i_S_i!=10){
			v2_arr[i_S_i]=C_i_S_i;
		}
		else{
			v2_arr[i_S_i]=(0.6931471805*10);
		}
		C_i_S_i=(C_i_S_i-logs[i_S_i+1])+logs[(10)-i_S_i];
	}
	v2=sum_arr(v2_arr, 10);
q1_1.push(v2);
q1_2.push(v2);
v13=q1_1.front(); q1_1.pop();
v14=q1_2.front(); q1_2.pop();
v12=sum(0.0+v13,0.0+v14);
v1=sum(0.0+v2+(0.6931471805*1),0.0+v12);

cout << "exp(" << v1 << ") = " << exp(v1) << endl;
return 0;}