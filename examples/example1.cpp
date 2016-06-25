#include <iostream>
#include <string>
#include <queue>
#include <cmath>
#define MAX 101
using namespace std;double sum(double a, double b){return max(a,b)+log1p(exp(-abs(a-b)));}double sum_arr(double array[], int n){double max = *std::max_element(array, array + n + 1);double sum = 0;for(int i = 0; i <= n; i++)sum += exp(array[i] - max);return max + log(sum);}double C_i_Smokes_i,v1,v2,v3,v5,v6,v8,v9,v10,v11,v16,v17,v18,v19,v24,v25,v26,v27,v32;

int main(){
double logs[MAX+1]; for(int i = 0; i <= MAX; i++) logs[i] = log(i);
	double v1_arr[MAX];
	C_i_Smokes_i=0;
	for(int i_Smokes_i=0;i_Smokes_i<=5;i_Smokes_i++){
		if(i_Smokes_i==0){
			v1_arr[i_Smokes_i]=1.0*20+1.0*5+(0.6931471805*20+0.6931471805*5);
		}
		else if(i_Smokes_i==5){
			v1_arr[i_Smokes_i]=1.0*20+1.0*5+(0.6931471805*20+0.6931471805*5);
		}
		else if(i_Smokes_i==1){
			v11=sum(1.0+0,0.0+0);
			v10=v11*(5-i_Smokes_i);
			v9=v10*(i_Smokes_i);
			v8=1.0*((5-i_Smokes_i)*(5-i_Smokes_i-1))+v9+(0.6931471805*((5-i_Smokes_i)*(5-i_Smokes_i-1)));
			v1_arr[i_Smokes_i]=C_i_Smokes_i+1.0*((5-i_Smokes_i))+1.0*((i_Smokes_i))+1.0*((5-i_Smokes_i)*(i_Smokes_i))+v8+(0.6931471805*((i_Smokes_i))+0.6931471805*((5-i_Smokes_i))+0.6931471805*((5-i_Smokes_i)*(i_Smokes_i))+0.6931471805*((i_Smokes_i)*(i_Smokes_i-1))+sum(1.0, 0.0)*((i_Smokes_i)*(i_Smokes_i-1)));
		}
		else if(i_Smokes_i==5-1){
			v19=sum(1.0+0,0.0+0);
			v18=v19*(5-i_Smokes_i);
			v17=v18*(i_Smokes_i);
			v16=1.0*((i_Smokes_i)*(i_Smokes_i-1))+v17+(0.6931471805*((i_Smokes_i)*(i_Smokes_i-1)));
			v1_arr[i_Smokes_i]=C_i_Smokes_i+1.0*((5-i_Smokes_i))+1.0*((i_Smokes_i))+1.0*((5-i_Smokes_i)*(i_Smokes_i))+v16+(0.6931471805*((i_Smokes_i))+0.6931471805*((5-i_Smokes_i))+0.6931471805*((5-i_Smokes_i)*(i_Smokes_i))+sum(1.0, 0.0)*((5-i_Smokes_i)*(5-i_Smokes_i-1))+0.6931471805*((5-i_Smokes_i)*(5-i_Smokes_i-1)));
		}
		else{
			v27=sum(1.0+0,0.0+0);
			v26=v27*(5-i_Smokes_i);
			v25=v26*(i_Smokes_i);
			v24=1.0*((5-i_Smokes_i)*(5-i_Smokes_i-1))+1.0*((i_Smokes_i)*(i_Smokes_i-1))+v25+(0.6931471805*((i_Smokes_i)*(i_Smokes_i-1))+0.6931471805*((5-i_Smokes_i)*(5-i_Smokes_i-1)));
			v1_arr[i_Smokes_i]=C_i_Smokes_i+1.0*((5-i_Smokes_i))+1.0*((i_Smokes_i))+1.0*((5-i_Smokes_i)*(i_Smokes_i))+v24+(0.6931471805*((i_Smokes_i))+0.6931471805*((5-i_Smokes_i))+0.6931471805*((5-i_Smokes_i)*(i_Smokes_i)));
		}
		C_i_Smokes_i=(C_i_Smokes_i-logs[i_Smokes_i+1])+logs[(5)-i_Smokes_i];
	}
	v1=sum_arr(v1_arr, 5);

cout << exp(v1) << endl;
return 0;}