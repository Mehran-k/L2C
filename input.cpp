#include <iostream>
			#include <string>
#include <queue>
#include <cmath>
#define MAX 101
using namespace std;double sum(double a, double b){return max(a,b)+log1p(exp(-abs(a-b)));}double sum_arr(double array[], int n){double max = *std::max_element(array, array + n + 1);double sum = 0;for(int i = 0; i <= n; i++)sum += exp(array[i] - max);return max + log(sum);}double C_i_F_r1_i,C_i_T2_i,C_i_T1_i,v1,v2,v3,v4,v5,v6,v7,v8,v9,v10,v11,v12,v13,v16,v17,v18,v19,v23,v24,v25,v26,v27,v28,v29,v32,v33,v34,v35,v39,v40,v41,v42,v43,v44,v45,v48,v49,v50,v51,v55;
int main(){
double logs[MAX+1]; for(int i = 0; i <= MAX; i++) logs[i] = log(i);
C_i_F_r1_i=0;double v2_arr[MAX];
for(int i_F_r1_i=0;i_F_r1_i<=3;i_F_r1_i++){
    C_i_T2_i=0;double v3_arr[MAX];
    for(int i_T2_i=0;i_T2_i<=3-i_F_r1_i;i_T2_i++){
        C_i_T1_i=0;double v5_arr[MAX];
        for(int i_T1_i=0;i_T1_i<=i_F_r1_i;i_T1_i++){
            v13=0;
            v12=0.4054651081081644*1+v13;
            v11=sum(0.0+v12,0.0+(sum(0.4054651081081644, 0.0)*1));
            v10=v11*(3-i_F_r1_i-i_T2_i);
            v19=0;
            v18=0.4054651081081644*1+v19;
            v17=sum(0.0+v18,0.0+(sum(0.4054651081081644, 0.0)*1));
            v16=v17*(i_F_r1_i-i_T1_i);
            v9=v10+v16;
            v8=sum(0.0+v9,0.0+(sum(0.4054651081081644, 0.0)*((1)*(3-i_F_r1_i-i_T2_i))+0.6931471805*((1)*(3-i_F_r1_i-i_T2_i))+sum(0.4054651081081644, 0.0)*((1)*(i_F_r1_i-i_T1_i))+0.6931471805*((1)*(i_F_r1_i-i_T1_i))));
            v7=v8*(i_T2_i);
            v29=0;
            v28=0.4054651081081644*1+v29;
            v27=sum(0.0+v28,0.0+(sum(0.4054651081081644, 0.0)*1));
            v26=v27*(3-i_F_r1_i-i_T2_i);
            v35=0;
            v34=0.4054651081081644*1+v35;
            v33=sum(0.0+v34,0.0+(sum(0.4054651081081644, 0.0)*1));
            v32=v33*(i_F_r1_i-i_T1_i);
            v25=v26+v32;
            v24=sum(0.0+v25,0.0+(sum(0.4054651081081644, 0.0)*((1)*(3-i_F_r1_i-i_T2_i))+0.6931471805*((1)*(3-i_F_r1_i-i_T2_i))+sum(0.4054651081081644, 0.0)*((1)*(i_F_r1_i-i_T1_i))+0.6931471805*((1)*(i_F_r1_i-i_T1_i))));
            v23=v24*(i_T1_i);
            v45=0;
            v44=0.4054651081081644*1+v45;
            v43=sum(0.0+v44,0.0+(sum(0.4054651081081644, 0.0)*1));
            v42=v43*(3-i_F_r1_i-i_T2_i);
            v51=0;
            v50=0.4054651081081644*1+v51;
            v49=sum(0.0+v50,0.0+(sum(0.4054651081081644, 0.0)*1));
            v48=v49*((i_F_r1_i-i_T1_i-1));
            v41=v42+v48;
            v40=sum(0.0+v41,0.0+(sum(0.4054651081081644, 0.0)*((1)*(3-i_F_r1_i-i_T2_i))+0.6931471805*((1)*(3-i_F_r1_i-i_T2_i))+sum(0.4054651081081644, 0.0)*((1)*((i_F_r1_i-i_T1_i-1)))+0.6931471805*((1)*((i_F_r1_i-i_T1_i-1)))));
            v39=v40*(i_F_r1_i-i_T1_i);
            v6=v7+v23+v39;
            v5_arr[i_T1_i]=C_i_T1_i+(0.0*i_T1_i+0.0*(i_F_r1_i-i_T1_i))+v6+(sum(0.4054651081081644, 0.0)*((i_T2_i)*(i_T1_i))+0.6931471805*((i_T2_i)*(i_T1_i))+sum(0.4054651081081644, 0.0)*((i_T1_i)*(i_T1_i))+0.6931471805*((i_T1_i)*(i_T1_i))+sum(0.4054651081081644, 0.0)*((i_F_r1_i-i_T1_i)*(i_T1_i))+0.6931471805*((i_F_r1_i-i_T1_i)*(i_T1_i)));
            C_i_T1_i=(C_i_T1_i-logs[i_T1_i+1])+logs[(i_F_r1_i)-i_T1_i];}
        v5=sum_arr(v5_arr, i_F_r1_i);
        v4=v5+(sum(0.4054651081081644, 0.0)*((3-i_F_r1_i-i_T2_i)*(i_F_r1_i))+0.6931471805*((3-i_F_r1_i-i_T2_i)*(i_F_r1_i))+sum(0.4054651081081644, 0.0)*((3-i_F_r1_i-i_T2_i)*(3-i_F_r1_i-i_T2_i))+0.6931471805*((3-i_F_r1_i-i_T2_i)*(3-i_F_r1_i-i_T2_i)));
        v3_arr[i_T2_i]=C_i_T2_i+(0.0*i_T2_i+0.0*(3-i_F_r1_i-i_T2_i))+v4+(sum(0.4054651081081644, 0.0)*((i_F_r1_i)*(i_T2_i))+0.6931471805*((i_F_r1_i)*(i_T2_i))+sum(0.4054651081081644, 0.0)*((i_T2_i)*(i_T2_i))+0.6931471805*((i_T2_i)*(i_T2_i))+sum(0.4054651081081644, 0.0)*((3-i_F_r1_i-i_T2_i)*(i_T2_i))+0.6931471805*((3-i_F_r1_i-i_T2_i)*(i_T2_i)));
        C_i_T2_i=(C_i_T2_i-logs[i_T2_i+1])+logs[(3-i_F_r1_i)-i_T2_i];}
    v3=sum_arr(v3_arr, 3-i_F_r1_i);
    v2_arr[i_F_r1_i]=C_i_F_r1_i+(0.4054651081081644*i_F_r1_i+0.0*(3-i_F_r1_i))+v3;
    C_i_F_r1_i=(C_i_F_r1_i-logs[i_F_r1_i+1])+logs[(3)-i_F_r1_i];}
v2=sum_arr(v2_arr, 3);
v1=v2;

cout << exp(v1) << endl;
return 0;}