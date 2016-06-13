#include <iostream>
#include <string>
#include <queue>
#include <cmath>
#define MAX 101
using namespace std;double sum(double a, double b){return max(a,b)+log1p(exp(-abs(a-b)));}double sum_arr(double array[], int n){double max = *std::max_element(array, array + n + 1);double sum = 0;for(int i = 0; i <= n; i++)sum += exp(array[i] - max);return max + log(sum);}double C_i_C_i,C_i_G2_i,C_i_S1_i,v1,v2,v3,v4,v5,v6,v7,v8,v9,v10,v11,v12,v13,v14,v15,v16,v17,v19,v20,v22,v23,v24,v25,v26,v28,v29,v31,v32,v33,v34,v35,v37,v38,v40,v41,v42,v43,v44,v46,v47,v49;
int main(){
double logs[MAX+1]; for(int i = 0; i <= MAX; i++) logs[i] = log(i);
C_i_C_i=0;double v1_arr[MAX];
for(int i_C_i=0;i_C_i<=3;i_C_i++){
    C_i_G2_i=0;double v4_arr[MAX];
    for(int i_G2_i=0;i_G2_i<=3-i_C_i;i_G2_i++){
        C_i_S1_i=0;double v9_arr[MAX];
        for(int i_S1_i=0;i_S1_i<=i_C_i;i_S1_i++){
            v17=0;
            v16=0.0*1+v17;
            v20=0;
            v19=0.9999999968880912*1+v20;
            v15=sum(0.0+v16,0.0+v19);
            v14=v15*(i_G2_i);
            v13=v14*(i_S1_i);
            v26=0;
            v25=0.0*1+v26;
            v29=0;
            v28=0.9999999968880912*1+v29;
            v24=sum(0.0+v25,0.0+v28);
            v23=v24*(i_C_i-i_S1_i);
            v22=v23*(3-i_C_i-i_G2_i);
            v35=0;
            v34=0.0*1+v35;
            v38=0;
            v37=0.9999999968880912*1+v38;
            v33=sum(0.0+v34,0.0+v37);
            v32=v33*(i_C_i-i_S1_i);
            v31=v32*(i_S1_i);
            v12=v13+v22+v31;
            v11=v12+(0.6931471805*((i_C_i-i_S1_i)*(i_G2_i))+0.6931471805*((3-i_C_i-i_G2_i)*(i_S1_i))+0.6931471805*((i_S1_i)*(i_S1_i))+0.6931471805*((i_C_i-i_S1_i)*(i_S1_i))+0.6931471805*((i_C_i-i_S1_i)*(i_C_i-i_S1_i)));
            v10=0.9999999968880912*((i_C_i-i_S1_i)*(i_G2_i))+0.9999999968880912*((3-i_C_i-i_G2_i)*(i_S1_i))+0.9999999968880912*((i_C_i-i_S1_i)*(i_S1_i))+0.9999999968880912*((i_C_i-i_S1_i)*(i_C_i-i_S1_i))+0.9999999968880912*((i_S1_i)*(i_S1_i))+v11;
            v9_arr[i_S1_i]=C_i_S1_i+v10;
            C_i_S1_i=(C_i_S1_i-logs[i_S1_i+1])+logs[(i_C_i)-i_S1_i];}
        v9=sum_arr(v9_arr, i_C_i);
        v44=0;
        v43=0.0*1+v44;
        v47=0;
        v46=0.9999999968880912*1+v47;
        v42=sum(0.0+v43,0.0+v46);
        v41=v42*(i_G2_i);
        v40=v41*(3-i_C_i-i_G2_i);
        v8=v9+v40;
        v7=v8+(0.6931471805*((i_C_i)*(3-i_C_i-i_G2_i))+0.6931471805*((i_G2_i)*(i_C_i))+0.6931471805*((i_G2_i)*(i_G2_i))+0.6931471805*((i_G2_i)*(3-i_C_i-i_G2_i))+0.6931471805*((3-i_C_i-i_G2_i)*(3-i_C_i-i_G2_i)));
        v6=0.9999999968880912*((i_G2_i)*(i_C_i))+0.9999999968880912*((i_C_i)*(3-i_C_i-i_G2_i))+0.9999999968880912*((i_G2_i)*(i_G2_i))+0.9999999968880912*((i_G2_i)*(3-i_C_i-i_G2_i))+0.9999999968880912*((3-i_C_i-i_G2_i)*(3-i_C_i-i_G2_i))+v7;
        v5=v6;
        v4_arr[i_G2_i]=C_i_G2_i+(0.49999999957535085*i_G2_i+0.0*(3-i_C_i-i_G2_i))+v5;
        C_i_G2_i=(C_i_G2_i-logs[i_G2_i+1])+logs[(3-i_C_i)-i_G2_i];}
    v4=sum_arr(v4_arr, 3-i_C_i);
    v3=v4;
    v2=0.49999999957535085*((i_C_i))+v3;
    v1_arr[i_C_i]=C_i_C_i+v2;
    C_i_C_i=(C_i_C_i-logs[i_C_i+1])+logs[(3)-i_C_i];}
v1=sum_arr(v1_arr, 3);

cout << exp(v1) << endl;
return 0;}