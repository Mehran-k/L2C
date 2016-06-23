#include <iostream>
#include <string>
#include <queue>
#include <cmath>
#define MAX 101
using namespace std;double sum(double a, double b){return max(a,b)+log1p(exp(-abs(a-b)));}double sum_arr(double array[], int n){double max = *std::max_element(array, array + n + 1);double sum = 0;for(int i = 0; i <= n; i++)sum += exp(array[i] - max);return max + log(sum);}double C_i_S_i,v1,v2,v3,v4,v6,v7,v8,v9,v10,v14,v15,v16,v17,v18,v22,v23,v24,v27,v29,v30,v31,v32,v33,v37,v38,v39,v42,v44,v45,v46,v47,v48,v52,v53,v54,v57,v59;

int main(){
double logs[MAX+1]; for(int i = 0; i <= MAX; i++) logs[i] = log(i);
	double v2_arr[MAX];
	C_i_S_i=0;
	for(int i_S_i=0;i_S_i<=4;i_S_i++){
		if(i_S_i==0){
			v2_arr[i_S_i]=1.0*12+0.5*4+1.0*4+(0.6931471805*12+0.6931471805*4);
		}
		else if(i_S_i==4){
			v10=0.5*1;
			v9=sum(0.0+v10,0.0+0);
			v8=v9*(4);
			v2_arr[i_S_i]=1.0*12+1.0*4+v8+(0.6931471805*12);
		}
		else if(i_S_i==1){
			v18=0.5*1;
			v17=sum(0.0+v18,0.0+0);
			v16=v17*(i_S_i);
			v27=1.0*1;
			v24=sum(0.0+0,0.0+v27);
			v23=v24*(4-i_S_i);
			v22=v23*(i_S_i);
			v15=v16+v22;
			v14=1.0*((4-i_S_i)*(4-i_S_i-1))+v15+(0.6931471805*((4-i_S_i)*(4-i_S_i-1)));
			v2_arr[i_S_i]=C_i_S_i+0.5*((4-i_S_i))+1.0*((4-i_S_i))+1.0*((i_S_i))+1.0*((4-i_S_i)*(i_S_i))+v14+(0.6931471805*((4-i_S_i))+0.6931471805*((4-i_S_i)*(i_S_i))+0.6931471805*((i_S_i)*(i_S_i-1))+sum(1.0, 0.0)*((i_S_i)*(i_S_i-1)));
		}
		else if(i_S_i==4-1){
			v33=0.5*1;
			v32=sum(0.0+v33,0.0+0);
			v31=v32*(i_S_i);
			v42=1.0*1;
			v39=sum(0.0+0,0.0+v42);
			v38=v39*(4-i_S_i);
			v37=v38*(i_S_i);
			v30=v31+v37;
			v29=1.0*((i_S_i)*(i_S_i-1))+v30+(0.6931471805*((i_S_i)*(i_S_i-1)));
			v2_arr[i_S_i]=C_i_S_i+0.5*((4-i_S_i))+1.0*((4-i_S_i))+1.0*((i_S_i))+1.0*((4-i_S_i)*(i_S_i))+v29+(0.6931471805*((4-i_S_i))+0.6931471805*((4-i_S_i)*(i_S_i))+sum(1.0, 0.0)*((4-i_S_i)*(4-i_S_i-1))+0.6931471805*((4-i_S_i)*(4-i_S_i-1)));
		}
		else{
			v48=0.5*1;
			v47=sum(0.0+v48,0.0+0);
			v46=v47*(i_S_i);
			v57=1.0*1;
			v54=sum(0.0+0,0.0+v57);
			v53=v54*(4-i_S_i);
			v52=v53*(i_S_i);
			v45=v46+v52;
			v44=1.0*((4-i_S_i)*(4-i_S_i-1))+1.0*((i_S_i)*(i_S_i-1))+v45+(0.6931471805*((i_S_i)*(i_S_i-1))+0.6931471805*((4-i_S_i)*(4-i_S_i-1)));
			v2_arr[i_S_i]=C_i_S_i+0.5*((4-i_S_i))+1.0*((4-i_S_i))+1.0*((i_S_i))+1.0*((4-i_S_i)*(i_S_i))+v44+(0.6931471805*((4-i_S_i))+0.6931471805*((4-i_S_i)*(i_S_i)));
		}
		C_i_S_i=(C_i_S_i-logs[i_S_i+1])+logs[(4)-i_S_i];
	}
	v1=sum_arr(v2_arr, 4);

cout << exp(v1) << endl;
return 0;}