#include <iostream>
#include <string>
#include <queue>
#include <cmath>
#define MAX 7
using namespace std;double sum(double a, double b){return max(a,b)+log1p(exp(-abs(a-b)));}double sum_arr(double array[], int n){double max = *std::max_element(array, array + n + 1);double sum = 0;for(int i = 0; i <= n; i++)sum += exp(array[i] - max);return max + log(sum);}double C_i_Smokes_i,v1,v2,v3,v4,v5,v10,v11,v12,v13,v18,v19,v20,v21,v26,v27,v28,v29,v30,v35,v36,v41,v42,v43,v48;

int main(){
double logs[MAX+1]; for(int i = 0; i <= MAX; i++) logs[i] = log(i);
	double v2_arr[MAX];
	C_i_Smokes_i=0;
	for(int i_Smokes_i=0;i_Smokes_i<=6;i_Smokes_i++){
		if(i_Smokes_i==0){
			v5=sum(0.0+0,0.0+0);
			v2_arr[i_Smokes_i]=v5*(((6)*(6 - 1)) / 2.0);
		}
		else if(i_Smokes_i==1){
			v13=sum(0.0+0,0.0+0);
			v10=v13*(((6-1)*(6-1 - 1)) / 2.0);
			v2_arr[i_Smokes_i]=C_i_Smokes_i+v10+(0.6931471805*((i_Smokes_i)*(i_Smokes_i-1)));
		}
		else if(i_Smokes_i==5){
			v21=sum(0.0+0,0.0+0);
			v18=v21*(((5)*(5 - 1)) / 2.0);
			v2_arr[i_Smokes_i]=C_i_Smokes_i+v18+(0.6931471805*((6-i_Smokes_i)*(6-i_Smokes_i-1)));
		}
		else if(i_Smokes_i!=6){
			v30=sum(0.0+0,0.0+0);
			v29=v30*(((i_Smokes_i)*(i_Smokes_i - 1)) / 2.0);
			v36=sum(0.0+0,0.0+0);
			v35=v36*(((6-i_Smokes_i)*(6-i_Smokes_i - 1)) / 2.0);
			v26=v29+v35;
			v2_arr[i_Smokes_i]=C_i_Smokes_i+v26;
		}
		else{
			v43=sum(0.0+0,0.0+0);
			v2_arr[i_Smokes_i]=v43*(((6)*(6 - 1)) / 2.0);
		}
		C_i_Smokes_i=(C_i_Smokes_i-logs[i_Smokes_i+1])+logs[(6)-i_Smokes_i];
	}
	v1=sum_arr(v2_arr, 6);

cout << "exp(" << v1 << ") = " << exp(v1) << endl;
return 0;}