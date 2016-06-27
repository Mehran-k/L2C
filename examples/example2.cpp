#include <iostream>
#include <string>
#include <queue>
#include <cmath>
#define MAX 101
using namespace std;double sum(double a, double b){return max(a,b)+log1p(exp(-abs(a-b)));}double sum_arr(double array[], int n){double max = *std::max_element(array, array + n + 1);double sum = 0;for(int i = 0; i <= n; i++)sum += exp(array[i] - max);return max + log(sum);}double C_i_Smokes_i,v1,v2,v3,v5,v6,v7,v8,v13,v14,v15,v20,v21,v26,v27,v28,v29,v34,v35,v40,v41,v42,v43,v48,v49,v50,v55;

int main(){
double logs[MAX+1]; for(int i = 0; i <= MAX; i++) logs[i] = log(i);
	double v1_arr[MAX];
	C_i_Smokes_i=0;
	for(int i_Smokes_i=0;i_Smokes_i<=5;i_Smokes_i++){
		if(i_Smokes_i==0){
			v1_arr[i_Smokes_i]=1.0*20+0.5*5+1.0*5+(0.6931471805*20+0.6931471805*5+0.6931471805*5);
		}
		else if(i_Smokes_i==5){
			v8=sum(0.5+0,0.0+0);
			v7=v8*(5);
			v1_arr[i_Smokes_i]=1.0*20+1.0*5+v7+(0.6931471805*20+0.6931471805*5);
		}
		else if(i_Smokes_i==1){
			v15=sum(0.5+0,0.0+0);
			v21=sum(1.0+0,0.0+0);
			v20=v21*(5-1);
			v14=v15+v20;
			v13=0.5*((5-1))+1.0*((5-1))+1.0*1+1.0*((5-1)*(1))+1.0*((5-1)*(5-1-1))+v14+(0.6931471805*((5-1))+0.6931471805*1+0.6931471805*((5-1))+0.6931471805*((5-1)*(1))+0.6931471805*((5-1)*(5-1-1)));
			v1_arr[i_Smokes_i]=C_i_Smokes_i+v13+(sum(1.0, 0.0)*((i_Smokes_i)*(i_Smokes_i-1))+0.6931471805*((i_Smokes_i)*(i_Smokes_i-1)));
		}
		else if(i_Smokes_i==4){
			v29=sum(0.5+0,0.0+0);
			v28=v29*(4);
			v35=sum(1.0+0,0.0+0);
			v34=v35*(4);
			v27=v28+v34;
			v26=0.5*1+1.0*1+1.0*4+1.0*4+1.0*12+v27+(0.6931471805*1+0.6931471805*4+0.6931471805*1+0.6931471805*12+0.6931471805*4);
			v1_arr[i_Smokes_i]=C_i_Smokes_i+v26+(sum(1.0, 0.0)*((5-i_Smokes_i)*(5-i_Smokes_i-1))+0.6931471805*((5-i_Smokes_i)*(5-i_Smokes_i-1)));
		}
		else{
			v43=sum(0.5+0,0.0+0);
			v42=v43*(i_Smokes_i);
			v50=sum(1.0+0,0.0+0);
			v49=v50*(5-i_Smokes_i);
			v48=v49*(i_Smokes_i);
			v41=v42+v48;
			v40=0.5*((5-i_Smokes_i))+1.0*((5-i_Smokes_i))+1.0*((i_Smokes_i))+1.0*((5-i_Smokes_i)*(i_Smokes_i))+1.0*((5-i_Smokes_i)*(5-i_Smokes_i-1))+1.0*((i_Smokes_i)*(i_Smokes_i-1))+v41+(0.6931471805*((5-i_Smokes_i))+0.6931471805*((i_Smokes_i))+0.6931471805*((5-i_Smokes_i))+0.6931471805*((i_Smokes_i)*(i_Smokes_i-1))+0.6931471805*((5-i_Smokes_i)*(i_Smokes_i))+0.6931471805*((5-i_Smokes_i)*(5-i_Smokes_i-1)));
			v1_arr[i_Smokes_i]=C_i_Smokes_i+v40;
		}
		C_i_Smokes_i=(C_i_Smokes_i-logs[i_Smokes_i+1])+logs[(5)-i_Smokes_i];
	}
	v1=sum_arr(v1_arr, 5);

cout << "exp(" << v1 << ")= " << exp(v1) << endl;
return 0;}