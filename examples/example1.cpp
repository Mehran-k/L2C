#include <iostream>
#include <string>
#include <queue>
#include <cmath>
#define MAX 101
using namespace std;double sum(double a, double b){return max(a,b)+log1p(exp(-abs(a-b)));}double sum_arr(double array[], int n){double max = *std::max_element(array, array + n + 1);double sum = 0;for(int i = 0; i <= n; i++)sum += exp(array[i] - max);return max + log(sum);}double C_i_Smokes_i,v1,v2,v3,v5,v6,v8,v9,v10,v15,v16,v17,v22,v23,v24,v25,v30;

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
			v10=sum(1.0+0,0.0+0);
			v9=v10*(5-1);
			v8=1.0*((5-1))+1.0*1+1.0*((5-1)*(1))+1.0*((5-1)*(5-1-1))+v9+(0.6931471805*1+0.6931471805*((5-1))+0.6931471805*((5-1)*(1))+0.6931471805*((5-1)*(5-1-1)));
			v1_arr[i_Smokes_i]=C_i_Smokes_i+v8+(sum(1.0, 0.0)*((i_Smokes_i)*(i_Smokes_i-1))+0.6931471805*((i_Smokes_i)*(i_Smokes_i-1)));
		}
		else if(i_Smokes_i==4){
			v17=sum(1.0+0,0.0+0);
			v16=v17*(4);
			v15=1.0*1+1.0*4+1.0*4+1.0*12+v16+(0.6931471805*4+0.6931471805*1+0.6931471805*12+0.6931471805*4);
			v1_arr[i_Smokes_i]=C_i_Smokes_i+v15+(sum(1.0, 0.0)*((5-i_Smokes_i)*(5-i_Smokes_i-1))+0.6931471805*((5-i_Smokes_i)*(5-i_Smokes_i-1)));
		}
		else{
			v25=sum(1.0+0,0.0+0);
			v24=v25*(5-i_Smokes_i);
			v23=v24*(i_Smokes_i);
			v22=1.0*((5-i_Smokes_i))+1.0*((i_Smokes_i))+1.0*((5-i_Smokes_i)*(i_Smokes_i))+1.0*((5-i_Smokes_i)*(5-i_Smokes_i-1))+1.0*((i_Smokes_i)*(i_Smokes_i-1))+v23+(0.6931471805*((i_Smokes_i))+0.6931471805*((5-i_Smokes_i))+0.6931471805*((i_Smokes_i)*(i_Smokes_i-1))+0.6931471805*((5-i_Smokes_i)*(i_Smokes_i))+0.6931471805*((5-i_Smokes_i)*(5-i_Smokes_i-1)));
			v1_arr[i_Smokes_i]=C_i_Smokes_i+v22;
		}
		C_i_Smokes_i=(C_i_Smokes_i-logs[i_Smokes_i+1])+logs[(5)-i_Smokes_i];
	}
	v1=sum_arr(v1_arr, 5);

cout << "exp(" << v1 << ")= " << exp(v1) << endl;
return 0;}