#include <iostream>
#include <string>
#include <queue>
#include <cmath>
#define MAX 101
using namespace std;double sum(double a, double b){return max(a,b)+log1p(exp(-abs(a-b)));}double sum_arr(double array[], int n){double max = *std::max_element(array, array + n + 1);double sum = 0;for(int i = 0; i <= n; i++)sum += exp(array[i] - max);return max + log(sum);}double C_i_Smokes_i,v1,v2,v3,v5,v6,v7,v8,v13,v14,v15,v16,v21,v22,v23,v28,v29,v30,v31,v36,v37,v38,v43,v44,v45,v46,v51,v52,v53,v58;

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
			v16=sum(0.5+0,0.0+0);
			v15=v16*(i_Smokes_i);
			v23=sum(1.0+0,0.0+0);
			v22=v23*(5-i_Smokes_i);
			v21=v22*(i_Smokes_i);
			v14=v15+v21;
			v13=1.0*((5-i_Smokes_i)*(5-i_Smokes_i-1))+v14+(0.6931471805*((5-i_Smokes_i)*(5-i_Smokes_i-1)));
			v1_arr[i_Smokes_i]=C_i_Smokes_i+0.5*((5-i_Smokes_i))+1.0*((5-i_Smokes_i))+1.0*((i_Smokes_i))+1.0*((5-i_Smokes_i)*(i_Smokes_i))+v13+(0.6931471805*((5-i_Smokes_i))+0.6931471805*((i_Smokes_i))+0.6931471805*((5-i_Smokes_i))+0.6931471805*((5-i_Smokes_i)*(i_Smokes_i))+0.6931471805*((i_Smokes_i)*(i_Smokes_i-1))+sum(1.0, 0.0)*((i_Smokes_i)*(i_Smokes_i-1)));
		}
		else if(i_Smokes_i==5-1){
			v31=sum(0.5+0,0.0+0);
			v30=v31*(i_Smokes_i);
			v38=sum(1.0+0,0.0+0);
			v37=v38*(5-i_Smokes_i);
			v36=v37*(i_Smokes_i);
			v29=v30+v36;
			v28=1.0*((i_Smokes_i)*(i_Smokes_i-1))+v29+(0.6931471805*((i_Smokes_i)*(i_Smokes_i-1)));
			v1_arr[i_Smokes_i]=C_i_Smokes_i+0.5*((5-i_Smokes_i))+1.0*((5-i_Smokes_i))+1.0*((i_Smokes_i))+1.0*((5-i_Smokes_i)*(i_Smokes_i))+v28+(0.6931471805*((5-i_Smokes_i))+0.6931471805*((i_Smokes_i))+0.6931471805*((5-i_Smokes_i))+0.6931471805*((5-i_Smokes_i)*(i_Smokes_i))+sum(1.0, 0.0)*((5-i_Smokes_i)*(5-i_Smokes_i-1))+0.6931471805*((5-i_Smokes_i)*(5-i_Smokes_i-1)));
		}
		else{
			v46=sum(0.5+0,0.0+0);
			v45=v46*(i_Smokes_i);
			v53=sum(1.0+0,0.0+0);
			v52=v53*(5-i_Smokes_i);
			v51=v52*(i_Smokes_i);
			v44=v45+v51;
			v43=1.0*((5-i_Smokes_i)*(5-i_Smokes_i-1))+1.0*((i_Smokes_i)*(i_Smokes_i-1))+v44+(0.6931471805*((i_Smokes_i)*(i_Smokes_i-1))+0.6931471805*((5-i_Smokes_i)*(5-i_Smokes_i-1)));
			v1_arr[i_Smokes_i]=C_i_Smokes_i+0.5*((5-i_Smokes_i))+1.0*((5-i_Smokes_i))+1.0*((i_Smokes_i))+1.0*((5-i_Smokes_i)*(i_Smokes_i))+v43+(0.6931471805*((5-i_Smokes_i))+0.6931471805*((i_Smokes_i))+0.6931471805*((5-i_Smokes_i))+0.6931471805*((5-i_Smokes_i)*(i_Smokes_i)));
		}
		C_i_Smokes_i=(C_i_Smokes_i-logs[i_Smokes_i+1])+logs[(5)-i_Smokes_i];
	}
	v1=sum_arr(v1_arr, 5);

cout << exp(v1) << endl;
return 0;}