#include <iostream>
#include <string>
#include <queue>
#include <cmath>
#define MAX 101
using namespace std;double sum(double a, double b){return max(a,b)+log1p(exp(-abs(a-b)));}double sum_arr(double array[], int n){double max = *std::max_element(array, array + n + 1);double sum = 0;for(int i = 0; i <= n; i++)sum += exp(array[i] - max);return max + log(sum);}double C_i_S_i,v1,v2,v4,v5,v6,v7,v8,v12,v14,v15,v17,v18,v19,v20,v21,v25,v26,v27,v28,v32,v33,v34,v37,v39,v40,v41,v42,v43,v47,v48,v49,v52,v54,v55,v56,v57,v58,v62,v63,v64,v67,v69,v70,v71,v72,v73,v77,v78,v79,v82,v84;

int main(){
double logs[MAX+1]; for(int i = 0; i <= MAX; i++) logs[i] = log(i);
if(4==0){
	v1=0;
}
if(4==1){
	v8=0.5*1;
	v7=sum(0.0+v8,0.0+0);
	v6=1.0*1+v7;
	v12=0.5*1+1.0*1+(0.6931471805*1);
	v5=sum(0.0+v6,0.0+v12);
	v4=v5*(4);
	v1=v4+(sum(1.0, 0.0)*12+0.6931471805*12);
}
else{
	double v2_arr[MAX];
	C_i_S_i=0;
	for(int i_S_i=0;i_S_i<=4;i_S_i++){
		if(i_S_i==0){
			v2_arr[i_S_i]=1.0*12+0.5*4+1.0*4+(0.6931471805*12+0.6931471805*4);
		}
		else if(i_S_i==4){
			v21=0.5*1;
			v20=sum(0.0+v21,0.0+0);
			v19=v20*(4);
			v2_arr[i_S_i]=1.0*12+1.0*4+v19+(0.6931471805*12);
		}
		else if(i_S_i==1 && 4==2){
			v28=0.5*1;
			v27=sum(0.0+v28,0.0+0);
			v26=v27*(i_S_i);
			v37=1.0*1;
			v34=sum(0.0+0,0.0+v37);
			v33=v34*(4-i_S_i);
			v32=v33*(i_S_i);
			v25=v26+v32;
			v2_arr[i_S_i]=C_i_S_i+0.5*((4-i_S_i))+1.0*((4-i_S_i))+1.0*((i_S_i))+1.0*((4-i_S_i)*(i_S_i))+v25+(0.6931471805*((4-i_S_i))+0.6931471805*((4-i_S_i)*(i_S_i))+sum(1.0, 0.0)*((4-i_S_i)*(4-i_S_i-1))+0.6931471805*((i_S_i)*(i_S_i-1))+sum(1.0, 0.0)*((i_S_i)*(i_S_i-1))+0.6931471805*((4-i_S_i)*(4-i_S_i-1)));
		}
		else if(i_S_i==1){
			v43=0.5*1;
			v42=sum(0.0+v43,0.0+0);
			v41=v42*(i_S_i);
			v52=1.0*1;
			v49=sum(0.0+0,0.0+v52);
			v48=v49*(4-i_S_i);
			v47=v48*(i_S_i);
			v40=v41+v47;
			v39=1.0*((4-i_S_i)*(4-i_S_i-1))+v40+(0.6931471805*((4-i_S_i)*(4-i_S_i-1)));
			v2_arr[i_S_i]=C_i_S_i+0.5*((4-i_S_i))+1.0*((4-i_S_i))+1.0*((i_S_i))+1.0*((4-i_S_i)*(i_S_i))+v39+(0.6931471805*((4-i_S_i))+0.6931471805*((4-i_S_i)*(i_S_i))+0.6931471805*((i_S_i)*(i_S_i-1))+sum(1.0, 0.0)*((i_S_i)*(i_S_i-1)));
		}
		else if(i_S_i==4-1){
			v58=0.5*1;
			v57=sum(0.0+v58,0.0+0);
			v56=v57*(i_S_i);
			v67=1.0*1;
			v64=sum(0.0+0,0.0+v67);
			v63=v64*(4-i_S_i);
			v62=v63*(i_S_i);
			v55=v56+v62;
			v54=1.0*((i_S_i)*(i_S_i-1))+v55+(0.6931471805*((i_S_i)*(i_S_i-1)));
			v2_arr[i_S_i]=C_i_S_i+0.5*((4-i_S_i))+1.0*((4-i_S_i))+1.0*((i_S_i))+1.0*((4-i_S_i)*(i_S_i))+v54+(0.6931471805*((4-i_S_i))+0.6931471805*((4-i_S_i)*(i_S_i))+sum(1.0, 0.0)*((4-i_S_i)*(4-i_S_i-1))+0.6931471805*((4-i_S_i)*(4-i_S_i-1)));
		}
		else{
			v73=0.5*1;
			v72=sum(0.0+v73,0.0+0);
			v71=v72*(i_S_i);
			v82=1.0*1;
			v79=sum(0.0+0,0.0+v82);
			v78=v79*(4-i_S_i);
			v77=v78*(i_S_i);
			v70=v71+v77;
			v69=1.0*((4-i_S_i)*(4-i_S_i-1))+1.0*((i_S_i)*(i_S_i-1))+v70+(0.6931471805*((i_S_i)*(i_S_i-1))+0.6931471805*((4-i_S_i)*(4-i_S_i-1)));
			v2_arr[i_S_i]=C_i_S_i+0.5*((4-i_S_i))+1.0*((4-i_S_i))+1.0*((i_S_i))+1.0*((4-i_S_i)*(i_S_i))+v69+(0.6931471805*((4-i_S_i))+0.6931471805*((4-i_S_i)*(i_S_i)));
		}
		C_i_S_i=(C_i_S_i-logs[i_S_i+1])+logs[(4)-i_S_i];
	}
	v1=sum_arr(v2_arr, 4);
}

cout << exp(v1) << endl;
return 0;}