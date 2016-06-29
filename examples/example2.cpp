#include <iostream>
#include <string>
#include <queue>
#include <cmath>
#define MAX 6
using namespace std;double sum(double a, double b){return max(a,b)+log1p(exp(-abs(a-b)));}double sum_arr(double array[], int n){double max = *std::max_element(array, array + n + 1);double sum = 0;for(int i = 0; i <= n; i++)sum += exp(array[i] - max);return max + log(sum);}double C_i_Smokes_i,v1,v2,v3,v5,v6,v7,v8,v12,v13,v16,v18,v19,v20,v21,v22,v26,v27,v30,v32,v33,v34,v35,v36,v40,v41,v42,v45,v47,v48,v49,v50,v51,v55;

int main(){
double logs[MAX+1]; for(int i = 0; i <= MAX; i++) logs[i] = log(i);
double v1_arr[MAX]; C_i_Smokes_i=0;
for(int i_Smokes_i=0;i_Smokes_i<=5;i_Smokes_i++){
if(i_Smokes_i==0){
v1_arr[i_Smokes_i]=48.294415415;
}
else if(i_Smokes_i==1){
v8=0.5;
v7=sum(v8, 0);
v16=1.0;
v13=sum(0, v16);
v12=v13*(5-1);
v6=v7+v12;
v5=0.5*((5-1))+1.0*((5-1))+1.0*1+1.0*((5-1)*(1))+1.0*((5-1)*(5-1-1))+v6+(0.6931471805*((5-1))+0.6931471805*1+0.6931471805*((5-1))+0.6931471805*((5-1)*(1))+0.6931471805*((5-1)*(5-1-1)));
v1_arr[i_Smokes_i]=C_i_Smokes_i+v5+(sum(1.0, 0.0)*((i_Smokes_i)*(i_Smokes_i-1))+0.6931471805*((i_Smokes_i)*(i_Smokes_i-1)));
}
else if(i_Smokes_i==4){
v22=0.5;
v21=sum(v22, 0);
v20=v21*(4);
v30=1.0;
v27=sum(0, v30);
v26=v27*(4);
v19=v20+v26;
v18=0.5*1+1.0*1+1.0*4+1.0*4+1.0*12+v19+(0.6931471805*1+0.6931471805*4+0.6931471805*1+0.6931471805*12+0.6931471805*4);
v1_arr[i_Smokes_i]=C_i_Smokes_i+v18+(sum(1.0, 0.0)*((5-i_Smokes_i)*(5-i_Smokes_i-1))+0.6931471805*((5-i_Smokes_i)*(5-i_Smokes_i-1)));
}
else if(i_Smokes_i!=5){
v36=0.5;
v35=sum(v36, 0);
v34=v35*(i_Smokes_i);
v45=1.0;
v42=sum(0, v45);
v41=v42*(5-i_Smokes_i);
v40=v41*(i_Smokes_i);
v33=v34+v40;
v32=0.5*((5-i_Smokes_i))+1.0*((5-i_Smokes_i))+1.0*((i_Smokes_i))+1.0*((5-i_Smokes_i)*(i_Smokes_i))+1.0*((5-i_Smokes_i)*(5-i_Smokes_i-1))+1.0*((i_Smokes_i)*(i_Smokes_i-1))+v33+(0.6931471805*((5-i_Smokes_i))+0.6931471805*((i_Smokes_i))+0.6931471805*((5-i_Smokes_i))+0.6931471805*((i_Smokes_i)*(i_Smokes_i-1))+0.6931471805*((5-i_Smokes_i)*(i_Smokes_i))+0.6931471805*((5-i_Smokes_i)*(5-i_Smokes_i-1)));
v1_arr[i_Smokes_i]=C_i_Smokes_i+v32;
}
else{
v51=0.5;
v50=sum(v51, 0);
v49=v50*(5);
v1_arr[i_Smokes_i]=1.0*20+1.0*5+v49+(0.6931471805*20+0.6931471805*5);
}
C_i_Smokes_i=(C_i_Smokes_i-logs[i_Smokes_i+1])+logs[(5)-i_Smokes_i];
}
v1=sum_arr(v1_arr, 5);
	cout << "exp(" << v1 << ") = " << exp(v1) << endl;
	return 0;
}