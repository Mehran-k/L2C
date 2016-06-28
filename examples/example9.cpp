#include <iostream>
#include <string>
#include <queue>
#include <cmath>
#define MAX 1001
using namespace std;double sum(double a, double b){return max(a,b)+log1p(exp(-abs(a-b)));}double sum_arr(double array[], int n){double max = *std::max_element(array, array + n + 1);double sum = 0;for(int i = 0; i <= n; i++)sum += exp(array[i] - max);return max + log(sum);}double C_i_a_i,C_i_d_i,v1,v2,v3,v4,v5,v6,v7,v8,v9,v10,v14,v15,v16,v20,v21,v22,v23,v24,v28,v29,v30,v34,v35,v36,v40,v41,v42,v43,v44,v45,v49,v50,v51,v55,v56,v57,v58,v59,v60,v61,v65,v66,v67,v71,v72,v73,v77,v78,v79,v80,v81,v85,v86,v87,v91,v92,v93,v97,v98,v99,v103,v104,v105,v106,v107,v108,v112,v113,v114,v118,v119,v120,v121,v122,v123,v124,v125,v129,v130,v131,v135,v136,v137,v138,v139,v143,v144,v145,v149,v150,v152,v153,v154,v155,v156,v157,v158,v159,v160,v164,v165,v166,v170,v171,v172,v173,v174,v178,v179,v180,v184,v185,v186,v190,v191,v192,v193,v194,v195,v199,v200,v201,v205,v206,v207,v208,v209,v210,v211,v212,v216,v217,v218,v222,v223,v224,v228,v229,v230,v231,v232,v233,v234,v235,v239,v240,v241,v245,v246,v247,v248,v249,v250,v251,v252,v253,v257,v258,v259,v263,v264,v265,v266,v267,v271,v272,v273,v277,v278,v280;
queue<double> q9_1;

int main(){
double logs[MAX+1]; for(int i = 0; i <= MAX; i++) logs[i] = log(i);
	double v3_arr[MAX];
	C_i_a_i=0;
	for(int i_a_i=0;i_a_i<=1000;i_a_i++){
		if(i_a_i==0){
				double v5_arr[MAX];
				C_i_d_i=0;
				for(int i_d_i=0;i_d_i<=1000;i_d_i++){
					if(i_d_i==0){
						v10=0.2000002*1000+0.2000002*1;
						v9=sum(0.0+v10,0.0+0);
						v8=v9*(1000);
						v16=0.2000002*1+0.2000002*1000;
						v15=sum(0.0+v16,0.0+0);
						v14=v15*(1000);
						v5_arr[i_d_i]=v8+v14;
					}
					else if(i_d_i!=1000){
						v24=0.2000002*1+0.2000002*((1)*(1000-i_d_i));
						v23=sum(0.0+v24,0.0+0);
						v22=v23*(1000);
						v30=0.2000002*1000;
						v29=sum(0.0+v30,0.0+0);
						v28=v29*(i_d_i);
						v36=0.2000002*1000+0.2000002*1;
						v35=sum(0.0+v36,0.0+0);
						v34=v35*(1000-i_d_i);
						v21=v22+v28+v34;
						v20=0.2000002*((i_d_i))+0.2000002*((1000)*(i_d_i))+v21;
						v5_arr[i_d_i]=C_i_d_i+v20;
					}
					else{
						v45=0.2000002*1000;
						v44=sum(0.0+v45,0.0+0);
						v43=v44*(1000);
						v51=0.2000002*1;
						v50=sum(0.0+v51,0.0+0);
						v49=v50*(1000);
						v42=v43+v49;
						v5_arr[i_d_i]=0.2000002*1000+0.2000002*1000000+v42;
					}
					C_i_d_i=(C_i_d_i-logs[i_d_i+1])+logs[(1000)-i_d_i];
				}
				v3_arr[i_a_i]=sum_arr(v5_arr, 1000);
		}
		else if(i_a_i!=1000){
				double v56_arr[MAX];
				C_i_d_i=0;
				for(int i_d_i=0;i_d_i<=1000;i_d_i++){
					if(i_d_i==0){
						v61=0.2000002*1+0.2000002*((1000-i_a_i)*(1));
						v60=sum(0.0+v61,0.0+0);
						v59=v60*(1000);
						v67=0.2000002*1+0.2000002*1000;
						v66=sum(0.0+v67,0.0+0);
						v65=v66*(1000-i_a_i);
						v73=0.2000002*1000;
						v72=sum(0.0+v73,0.0+0);
						v71=v72*(i_a_i);
						v56_arr[i_d_i]=v59+v65+v71;
					}
					else if(i_d_i!=1000){
						v81=0.2000002*1+0.2000002*((1)*(1000-i_d_i));
						v80=sum(0.0+v81,0.0+0);
						v79=v80*(1000-i_a_i);
						v87=0.2000002*1+0.2000002*((1000-i_a_i)*(1));
						v86=sum(0.0+v87,0.0+0);
						v85=v86*(1000-i_d_i);
						v93=0.2000002*((1000-i_a_i)*(1));
						v92=sum(0.0+v93,0.0+0);
						v91=v92*(i_d_i);
						v99=0.2000002*((1)*(1000-i_d_i));
						v98=sum(0.0+v99,0.0+0);
						v97=v98*(i_a_i);
						v78=v79+v85+v91+v97;
						q9_1.push(v78);
						v77=0.2000002*((i_d_i))+0.2000002*((i_a_i)*(i_d_i))+0.2000002*((1000-i_a_i)*(i_d_i))+v78;
						v56_arr[i_d_i]=C_i_d_i+v77;
					}
					else{
						v108=0.2000002*((1000-i_a_i)*(1));
						v107=sum(0.0+v108,0.0+0);
						v106=v107*(1000);
						v114=0.2000002*1;
						v113=sum(0.0+v114,0.0+0);
						v112=v113*(1000-i_a_i);
						v105=v106+v112;
						v56_arr[i_d_i]=0.2000002*1000+0.2000002*((i_a_i)*(1000))+0.2000002*((1000-i_a_i)*(1000))+v105+(0.6931471805*((i_a_i)));
					}
					C_i_d_i=(C_i_d_i-logs[i_d_i+1])+logs[(1000)-i_d_i];
				}
				v56=sum_arr(v56_arr, 1000);
			v55=0.2000002*((i_a_i)*(1000))+0.2000002*((i_a_i))+v56;
			v3_arr[i_a_i]=C_i_a_i+v55;
		}
		else{
				double v120_arr[MAX];
				C_i_d_i=0;
				for(int i_d_i=0;i_d_i<=1000;i_d_i++){
					if(i_d_i==0){
						v125=0.2000002*1;
						v124=sum(0.0+v125,0.0+0);
						v123=v124*(1000);
						v131=0.2000002*1000;
						v130=sum(0.0+v131,0.0+0);
						v129=v130*(1000);
						v120_arr[i_d_i]=v123+v129;
					}
					else if(i_d_i!=1000){
						v139=0.2000002*1;
						v138=sum(0.0+v139,0.0+0);
						v137=v138*(1000-i_d_i);
						v145=0.2000002*((1)*(1000-i_d_i));
						v144=sum(0.0+v145,0.0+0);
						v143=v144*(1000);
						v136=v137+v143;
						v135=0.2000002*((i_d_i))+0.2000002*((1000)*(i_d_i))+v136+(0.6931471805*((i_d_i)));
						v120_arr[i_d_i]=C_i_d_i+v135;
					}
					else{
						v120_arr[i_d_i]=0.2000002*1000+0.2000002*1000000+(0.6931471805*1000+0.6931471805*1000);
					}
					C_i_d_i=(C_i_d_i-logs[i_d_i+1])+logs[(1000)-i_d_i];
				}
				v120=sum_arr(v120_arr, 1000);
			v3_arr[i_a_i]=0.2000002*1000000+0.2000002*1000+v120;
		}
		C_i_a_i=(C_i_a_i-logs[i_a_i+1])+logs[(1000)-i_a_i];
	}
	v3=sum_arr(v3_arr, 1000);
v2=0.2000002*1000+v3;
	double v152_arr[MAX];
	C_i_a_i=0;
	for(int i_a_i=0;i_a_i<=1000;i_a_i++){
		if(i_a_i==0){
				double v154_arr[MAX];
				C_i_d_i=0;
				for(int i_d_i=0;i_d_i<=1000;i_d_i++){
					if(i_d_i==0){
						v160=0.2000002*1000+0.2000002*1;
						v159=sum(0.0+v160,0.0+0);
						v158=v159*(1000);
						v166=0.2000002*1+0.2000002*1000;
						v165=sum(0.0+v166,0.0+0);
						v164=v165*(1000);
						v154_arr[i_d_i]=v158+v164;
					}
					else if(i_d_i!=1000){
						v174=0.2000002*1+0.2000002*((1)*(1000-i_d_i));
						v173=sum(0.0+v174,0.0+0);
						v172=v173*(1000);
						v180=0.2000002*1000;
						v179=sum(0.0+v180,0.0+0);
						v178=v179*(i_d_i);
						v186=0.2000002*1000+0.2000002*1;
						v185=sum(0.0+v186,0.0+0);
						v184=v185*(1000-i_d_i);
						v171=v172+v178+v184;
						v170=0.2000002*((i_d_i))+0.2000002*((1000)*(i_d_i))+0.2000002*((i_d_i))+v171;
						v154_arr[i_d_i]=C_i_d_i+v170;
					}
					else{
						v195=0.2000002*1000;
						v194=sum(0.0+v195,0.0+0);
						v193=v194*(1000);
						v201=0.2000002*1;
						v200=sum(0.0+v201,0.0+0);
						v199=v200*(1000);
						v192=v193+v199;
						v154_arr[i_d_i]=0.2000002*1000+0.2000002*1000000+0.2000002*1000+v192;
					}
					C_i_d_i=(C_i_d_i-logs[i_d_i+1])+logs[(1000)-i_d_i];
				}
				v152_arr[i_a_i]=sum_arr(v154_arr, 1000);
		}
		else if(i_a_i!=1000){
				double v206_arr[MAX];
				C_i_d_i=0;
				for(int i_d_i=0;i_d_i<=1000;i_d_i++){
					if(i_d_i==0){
						v212=0.2000002*1+0.2000002*((1000-i_a_i)*(1));
						v211=sum(0.0+v212,0.0+0);
						v210=v211*(1000);
						v218=0.2000002*1+0.2000002*1000;
						v217=sum(0.0+v218,0.0+0);
						v216=v217*(1000-i_a_i);
						v224=0.2000002*1000;
						v223=sum(0.0+v224,0.0+0);
						v222=v223*(i_a_i);
						v206_arr[i_d_i]=v210+v216+v222;
					}
					else if(i_d_i!=1000){
						v229=q9_1.front(); q9_1.pop();
						v228=0.2000002*((i_d_i))+0.2000002*((i_d_i))+0.2000002*((i_a_i)*(i_d_i))+0.2000002*((1000-i_a_i)*(i_d_i))+v229;
						v206_arr[i_d_i]=C_i_d_i+v228;
					}
					else{
						v235=0.2000002*((1000-i_a_i)*(1));
						v234=sum(0.0+v235,0.0+0);
						v233=v234*(1000);
						v241=0.2000002*1;
						v240=sum(0.0+v241,0.0+0);
						v239=v240*(1000-i_a_i);
						v232=v233+v239;
						v206_arr[i_d_i]=0.2000002*1000+0.2000002*1000+0.2000002*((i_a_i)*(1000))+0.2000002*((1000-i_a_i)*(1000))+v232+(0.6931471805*((i_a_i)));
					}
					C_i_d_i=(C_i_d_i-logs[i_d_i+1])+logs[(1000)-i_d_i];
				}
				v206=sum_arr(v206_arr, 1000);
			v205=0.2000002*((i_a_i)*(1000))+0.2000002*((i_a_i))+v206;
			v152_arr[i_a_i]=C_i_a_i+v205;
		}
		else{
				double v247_arr[MAX];
				C_i_d_i=0;
				for(int i_d_i=0;i_d_i<=1000;i_d_i++){
					if(i_d_i==0){
						v253=0.2000002*1;
						v252=sum(0.0+v253,0.0+0);
						v251=v252*(1000);
						v259=0.2000002*1000;
						v258=sum(0.0+v259,0.0+0);
						v257=v258*(1000);
						v247_arr[i_d_i]=v251+v257;
					}
					else if(i_d_i!=1000){
						v267=0.2000002*1;
						v266=sum(0.0+v267,0.0+0);
						v265=v266*(1000-i_d_i);
						v273=0.2000002*((1)*(1000-i_d_i));
						v272=sum(0.0+v273,0.0+0);
						v271=v272*(1000);
						v264=v265+v271;
						v263=0.2000002*((i_d_i))+0.2000002*((1000)*(i_d_i))+0.2000002*((i_d_i))+v264+(0.6931471805*((i_d_i)));
						v247_arr[i_d_i]=C_i_d_i+v263;
					}
					else{
						v247_arr[i_d_i]=0.2000002*1000+0.2000002*1000000+0.2000002*1000+(0.6931471805*1000+0.6931471805*1000);
					}
					C_i_d_i=(C_i_d_i-logs[i_d_i+1])+logs[(1000)-i_d_i];
				}
				v247=sum_arr(v247_arr, 1000);
			v152_arr[i_a_i]=0.2000002*1000000+0.2000002*1000+v247;
		}
		C_i_a_i=(C_i_a_i-logs[i_a_i+1])+logs[(1000)-i_a_i];
	}
	v152=sum_arr(v152_arr, 1000);
v1=sum(0.0+v2,0.0+v152);

cout << "exp(" << v1 << ")= " << exp(v1) << endl;
return 0;}