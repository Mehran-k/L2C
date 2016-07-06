#include <iostream>
#include <string>
#include <queue>
#include <cmath>
#define MAX 6
using namespace std;double sum(double a, double b){return max(a,b)+log1p(exp(-abs(a-b)));}double sum_arr(double array[], int n){double max = *std::max_element(array, array + n + 1);double sum = 0;for(int i = 0; i <= n; i++)sum += exp(array[i] - max);return max + log(sum);}double C_i_Smokes_i,v1,v2,v3,v5,v6,v7,v8,v12,v13,v16,v18,v19,v20,v21,v22,v26,v27,v30,v32,v33,v34,v35,v36,v40,v41,v42,v45,v47,v48,v49,v50,v51,v55;

int main(){
	double v1_arr[n+1];
    double C = 0;
	for(int i = 0;i <= n; i++){
        v4 = log_sum(0.07918, 0) * i * i;
        v5 = log_sum(0, 0.17609) * (n-i) * i;
        v3 = v4 + v5;
        v2 = 0.07918 * (n-i) + 0.17609 * (n*n + n - n*i + i*i) + (0.6931 * (n*n + 2*n - i - n*i + i*i);
        v1_arr[i] = C + v32;
		C = C - log(i+1) + log(5-i);
	}
	v1=sum_arr(v1_arr, n);
	cout << "Z = exp(" << v1 << ") = " << exp(v1) << endl;
	return 0;
}