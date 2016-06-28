#include <iostream>
#include <string>
#include <queue>
#include <cmath>
#define MAX 51
using namespace std;double sum(double a, double b){return max(a,b)+log1p(exp(-abs(a-b)));}double sum_arr(double array[], int n){double max = *std::max_element(array, array + n + 1);double sum = 0;for(int i = 0; i <= n; i++)sum += exp(array[i] - max);return max + log(sum);}double C_i_hot_i,v1,v2,v3,v4,v5,v7,v8,v9,v10,v14,v15,v16,v17,v21,v22,v23,v24,v25,v28,v30,v31,v32,v33,v35,v37,v38,v39,v40,v42,v44;

int main(){
double logs[MAX+1]; for(int i = 0; i <= MAX; i++) logs[i] = log(i);
	double v3_arr[MAX];
	C_i_hot_i=0;
	for(int i_hot_i=0;i_hot_i<=25;i_hot_i++){
		if(i_hot_i==0){
			v3_arr[i_hot_i]=0.30000014*1250+(0.6931471805*50);
		}
		else if(i_hot_i!=25){
			v10=0.30000014*((1)*(i_hot_i));
			v9=sum(0.0+v10,0.0+0);
			v8=v9*(50);
			v7=0.30000014*((50)*(25-i_hot_i))+v8;
			v3_arr[i_hot_i]=C_i_hot_i+v7;
		}
		else{
			v17=0.30000014*25;
			v16=sum(0.0+v17,0.0+0);
			v3_arr[i_hot_i]=v16*(50);
		}
		C_i_hot_i=(C_i_hot_i-logs[i_hot_i+1])+logs[(25)-i_hot_i];
	}
	v3=sum_arr(v3_arr, 25);
v2=0.2000002*50+v3;
	double v21_arr[MAX];
	C_i_hot_i=0;
	for(int i_hot_i=0;i_hot_i<=25;i_hot_i++){
		if(i_hot_i==0){
			v28=0.2000002*1;
			v25=sum(0.0+0,0.0+v28);
			v24=v25*(50);
			v21_arr[i_hot_i]=0.30000014*1250+v24;
		}
		else if(i_hot_i!=25){
			v33=0.30000014*((1)*(i_hot_i));
			v35=0.2000002*1;
			v32=sum(0.0+v33,0.0+v35);
			v31=v32*(50);
			v30=0.30000014*((50)*(25-i_hot_i))+v31;
			v21_arr[i_hot_i]=C_i_hot_i+v30;
		}
		else{
			v40=0.30000014*25;
			v42=0.2000002*1;
			v39=sum(0.0+v40,0.0+v42);
			v21_arr[i_hot_i]=v39*(50);
		}
		C_i_hot_i=(C_i_hot_i-logs[i_hot_i+1])+logs[(25)-i_hot_i];
	}
	v21=sum_arr(v21_arr, 25);
v1=sum(0.0+v2,0.0+v21);

cout << "exp(" << v1 << ") = " << exp(v1) << endl;
return 0;}