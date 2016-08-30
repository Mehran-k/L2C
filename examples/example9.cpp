#include <iostream>
#include <string>
#include <queue>
#include <cmath>
#define MAX 7
using namespace std;double sum(double a, double b){return max(a,b)+log1p(exp(-abs(a-b)));}double sum_arr(double array[], int n){double max = *std::max_element(array, array + n + 1);double sum = 0;for(int i = 0; i <= n; i++)sum += exp(array[i] - max);return max + log(sum);}double C_i_Old_i,C_i_Female_i,C_i_Female1_i,C_i_Female2_i,v1,v2,v3,v4,v6,v7,v9,v10,v14,v15,v16,v18,v19,v23,v24,v25,v26,v27,v28,v30,v31,v35,v37,v39,v40,v42,v43,v47,v48,v49,v51,v52,v56,v57,v58,v59,v61,v62,v66,v67,v68,v69,v73,v74,v78,v79,v83,v84,v85,v86,v88,v89,v93,v94,v95,v96,v100,v101,v105,v106,v110,v111,v112,v114,v115,v116,v120,v121,v125,v126,v127,v128,v132,v133,v134,v138,v139,v143,v144,v148,v149,v150,v151,v153,v154,v155,v159,v160,v164,v165,v166,v167,v171,v172,v173,v177,v178,v182,v183,v187,v188,v189,v190,v191,v193,v194,v198,v199,v200,v204,v205,v209,v210,v211,v212,v214,v215,v219,v220,v221,v225,v226,v230,v231,v232,v234,v235,v236,v240,v241,v245,v246,v247,v251,v252,v253,v257,v258,v262,v263,v264,v265,v267,v268,v269,v273,v274,v278,v279,v280,v284,v285,v286,v290,v291,v295,v296,v297,v301,v302,v303,v304,v305,v307,v308,v312,v313,v314,v316,v317,v321,v322,v323,v324,v328,v329,v333,v334,v338,v339,v340,v341,v343,v344,v348,v349,v350,v354,v355,v359;

int main(){
double logs[MAX+1]; for(int i = 0; i <= MAX; i++) logs[i] = log(i);
	double v1_arr[MAX]; C_i_Old_i=0;
	for(int i_Old_i=0;i_Old_i<=6;i_Old_i++){
		if(i_Old_i==0){
			double v3_arr[MAX]; C_i_Female_i=0;
			for(int i_Female_i=0;i_Female_i<=6;i_Female_i++){
				if(i_Female_i==0){
					v3_arr[i_Female_i]=60.2601513;
				}
				else if(i_Female_i!=6){
					v10=1.46328247;
					v9=v10*(i_Female_i);
					v7=sum(0.0+(1.2*((i_Female_i)*(1))+0.69314718*((i_Female_i)*(1))),0.0+v9);
					v6=v7*(5);
					v3_arr[i_Female_i]=C_i_Female_i+(0.0*i_Female_i+0.0*(6-i_Female_i))+v6+(1.2*((6-i_Female_i)*(5))+0.69314718*((6-i_Female_i)*(5)));
				}
				else{
					v19=1.46328247;
					v18=v19*(6);
					v16=sum(11.358883079999998,0.0+v18);
					v3_arr[i_Female_i]=v16*(5);
				}
				C_i_Female_i=(C_i_Female_i-logs[i_Female_i+1])+logs[(6)-i_Female_i];
			}
			v3=sum_arr(v3_arr, 6);
			v1_arr[i_Old_i]=v3+(30.0+20.7944154+36.0+3.4657359+6.0+4.15888308);
		}
		else if(i_Old_i!=6){
			double v24_arr[MAX]; C_i_Female1_i=0;
			for(int i_Female1_i=0;i_Female1_i<=i_Old_i;i_Female1_i++){
				if(i_Female1_i==0){
					v31=1.46328247;
					v30=v31*(i_Old_i);
					v28=sum(0.0+(1.2*((i_Old_i)*(1))+0.69314718*((i_Old_i)*(1))),0.0+v30);
					v27=v28*(5);
					if(6-i_Old_i==0){
						v35=0;
					}
					else{
						double v35_arr[MAX]; C_i_Female2_i=0;
						for(int i_Female2_i=0;i_Female2_i<=6-i_Old_i;i_Female2_i++){
							if(i_Female2_i==0){
								v35_arr[i_Female2_i]=(1.2*((6-i_Old_i)*(5))+0.69314718*((6-i_Old_i)*(5))+3.4657359);
							}
							else if(i_Female2_i!=6-i_Old_i){
								v43=1.46328247;
								v42=v43*(i_Female2_i);
								v40=sum(0.0+(1.2*((i_Female2_i)*(1))+0.69314718*((i_Female2_i)*(1))),0.0+v42);
								v39=v40*(5);
								v35_arr[i_Female2_i]=C_i_Female2_i+(0.0*i_Female2_i+0.0*(6-i_Old_i-i_Female2_i))+v39+(1.2*((6-i_Old_i-i_Female2_i)*(5))+0.69314718*((6-i_Old_i-i_Female2_i)*(5)));
							}
							else{
								v52=1.46328247;
								v51=v52*(6-i_Old_i);
								v49=sum(0.0+(1.2*((6-i_Old_i)*(1))+0.69314718*((6-i_Old_i)*(1))),0.0+v51);
								v35_arr[i_Female2_i]=v49*(5);
							}
							C_i_Female2_i=(C_i_Female2_i-logs[i_Female2_i+1])+logs[(6-i_Old_i)-i_Female2_i];
						}
						v35=sum_arr(v35_arr, 6-i_Old_i);
					}
					v26=v27+v35;
					v24_arr[i_Female1_i]=v26+(1.2*((i_Old_i)*(5)));
				}
				else if(i_Female1_i!=i_Old_i){
					if(6-i_Old_i==0){
						v62=1.46328247;
						v61=v62*(i_Female1_i);
						v59=sum(0.0+(1.2*((i_Female1_i)*(1))+0.69314718*((i_Female1_i)*(1))),0.0+v61);
						v69=1.46328247;
						v68=v69*(i_Female1_i);
						v74=sum(0.0,2.4);
						v73=v74*(i_Female1_i);
						v67=sum(0.0+v68+(1.2*((i_Female1_i)*(1))),0.0+v73);
						v79=1.46328247;
						v78=v79*(i_Old_i-i_Female1_i);
						v66=v67+v78;
						v58=sum(0.0+v59+(1.2*((i_Female1_i)*(1))+1.2*((i_Old_i-i_Female1_i)*(1))+0.69314718*((i_Old_i-i_Female1_i)*(1))),0.0+v66);
						v57=v58*(5);
						v56=v57;
					}
					else{
						double v56_arr[MAX]; C_i_Female2_i=0;
						for(int i_Female2_i=0;i_Female2_i<=6-i_Old_i;i_Female2_i++){
							if(i_Female2_i==0){
								v89=1.46328247;
								v88=v89*(i_Female1_i);
								v86=sum(0.0+(1.2*((i_Female1_i)*(1))+0.69314718*((i_Female1_i)*(1))),0.0+v88);
								v96=1.46328247;
								v95=v96*(i_Female1_i);
								v101=sum(0.0,2.4);
								v100=v101*(i_Female1_i);
								v94=sum(0.0+v95+(1.2*((i_Female1_i)*(1))),0.0+v100);
								v106=1.46328247;
								v105=v106*(i_Old_i-i_Female1_i);
								v93=v94+v105;
								v85=sum(0.0+v86+(1.2*((i_Female1_i)*(1))+1.2*((i_Old_i-i_Female1_i)*(1))+0.69314718*((i_Old_i-i_Female1_i)*(1))),0.0+v93);
								v84=v85*(5);
								v56_arr[i_Female2_i]=v84+(1.2*((6-i_Old_i)*(5))+0.69314718*((6-i_Old_i)*(5)));
							}
							else if(i_Female2_i!=6-i_Old_i){
								v116=1.46328247;
								v115=v116*(i_Female1_i);
								v121=1.46328247;
								v120=v121*(i_Female2_i);
								v114=v115+v120;
								v112=sum(0.0+(1.2*((i_Female1_i)*(1))+0.69314718*((i_Female1_i)*(1))+1.2*((i_Female2_i)*(1))+0.69314718*((i_Female2_i)*(1))),0.0+v114);
								v128=1.46328247;
								v127=v128*(i_Female1_i);
								v134=sum(0.0,2.4);
								v133=v134*(i_Female1_i);
								v139=1.46328247;
								v138=v139*(i_Female2_i);
								v132=v133+v138;
								v126=sum(0.0+v127+(1.2*((i_Female1_i)*(1))+1.2*((i_Female2_i)*(1))+0.69314718*((i_Female2_i)*(1))),0.0+v132);
								v144=1.46328247;
								v143=v144*(i_Old_i-i_Female1_i);
								v125=v126+v143;
								v111=sum(0.0+v112+(1.2*((i_Female1_i)*(1))+1.2*((i_Old_i-i_Female1_i)*(1))+0.69314718*((i_Old_i-i_Female1_i)*(1))),0.0+v125);
								v110=v111*(5);
								v56_arr[i_Female2_i]=C_i_Female2_i+(0.0*i_Female2_i+0.0*(6-i_Old_i-i_Female2_i))+v110+(1.2*((6-i_Old_i-i_Female2_i)*(5))+0.69314718*((6-i_Old_i-i_Female2_i)*(5)));
							}
							else{
								v155=1.46328247;
								v154=v155*(6-i_Old_i);
								v160=1.46328247;
								v159=v160*(i_Female1_i);
								v153=v154+v159;
								v151=sum(0.0+(1.2*((6-i_Old_i)*(1))+0.69314718*((6-i_Old_i)*(1))+1.2*((i_Female1_i)*(1))+0.69314718*((i_Female1_i)*(1))),0.0+v153);
								v167=1.46328247;
								v166=v167*(i_Female1_i);
								v173=1.46328247;
								v172=v173*(6-i_Old_i);
								v178=sum(0.0,2.4);
								v177=v178*(i_Female1_i);
								v171=v172+v177;
								v165=sum(0.0+v166+(1.2*((6-i_Old_i)*(1))+0.69314718*((6-i_Old_i)*(1))+1.2*((i_Female1_i)*(1))),0.0+v171);
								v183=1.46328247;
								v182=v183*(i_Old_i-i_Female1_i);
								v164=v165+v182;
								v150=sum(0.0+v151+(1.2*((i_Female1_i)*(1))+1.2*((i_Old_i-i_Female1_i)*(1))+0.69314718*((i_Old_i-i_Female1_i)*(1))),0.0+v164);
								v56_arr[i_Female2_i]=v150*(5);
							}
							C_i_Female2_i=(C_i_Female2_i-logs[i_Female2_i+1])+logs[(6-i_Old_i)-i_Female2_i];
						}
						v56=sum_arr(v56_arr, 6-i_Old_i);
					}
					v24_arr[i_Female1_i]=C_i_Female1_i+(0.0*i_Female1_i+0.0*(i_Old_i-i_Female1_i))+v56+(1.2*((i_Old_i-i_Female1_i)*(5)));
				}
				else{
					if(6-i_Old_i==0){
						v194=1.46328247;
						v193=v194*(i_Old_i);
						v191=sum(0.0+(1.2*((i_Old_i)*(1))+0.69314718*((i_Old_i)*(1))),0.0+v193);
						v200=1.46328247;
						v199=v200*(i_Old_i);
						v205=sum(0.0,2.4);
						v204=v205*(i_Old_i);
						v198=sum(0.0+v199+(1.2*((i_Old_i)*(1))),0.0+v204);
						v190=sum(0.0+v191+(1.2*((i_Old_i)*(1))),0.0+v198);
						v189=v190*(5);
						v24_arr[i_Female1_i]=v189;
					}
					else{
						double v188_arr[MAX]; C_i_Female2_i=0;
						for(int i_Female2_i=0;i_Female2_i<=6-i_Old_i;i_Female2_i++){
							if(i_Female2_i==0){
								v215=1.46328247;
								v214=v215*(i_Old_i);
								v212=sum(0.0+(1.2*((i_Old_i)*(1))+0.69314718*((i_Old_i)*(1))),0.0+v214);
								v221=1.46328247;
								v220=v221*(i_Old_i);
								v226=sum(0.0,2.4);
								v225=v226*(i_Old_i);
								v219=sum(0.0+v220+(1.2*((i_Old_i)*(1))),0.0+v225);
								v211=sum(0.0+v212+(1.2*((i_Old_i)*(1))),0.0+v219);
								v210=v211*(5);
								v188_arr[i_Female2_i]=v210+(1.2*((6-i_Old_i)*(5))+0.69314718*((6-i_Old_i)*(5)));
							}
							else if(i_Female2_i!=6-i_Old_i){
								v236=1.46328247;
								v235=v236*(i_Old_i);
								v241=1.46328247;
								v240=v241*(i_Female2_i);
								v234=v235+v240;
								v232=sum(0.0+(1.2*((i_Old_i)*(1))+0.69314718*((i_Old_i)*(1))+1.2*((i_Female2_i)*(1))+0.69314718*((i_Female2_i)*(1))),0.0+v234);
								v247=1.46328247;
								v246=v247*(i_Old_i);
								v253=sum(0.0,2.4);
								v252=v253*(i_Old_i);
								v258=1.46328247;
								v257=v258*(i_Female2_i);
								v251=v252+v257;
								v245=sum(0.0+v246+(1.2*((i_Old_i)*(1))+1.2*((i_Female2_i)*(1))+0.69314718*((i_Female2_i)*(1))),0.0+v251);
								v231=sum(0.0+v232+(1.2*((i_Old_i)*(1))),0.0+v245);
								v230=v231*(5);
								v188_arr[i_Female2_i]=C_i_Female2_i+(0.0*i_Female2_i+0.0*(6-i_Old_i-i_Female2_i))+v230+(1.2*((6-i_Old_i-i_Female2_i)*(5))+0.69314718*((6-i_Old_i-i_Female2_i)*(5)));
							}
							else{
								v269=1.46328247;
								v268=v269*(i_Old_i);
								v274=1.46328247;
								v273=v274*(6-i_Old_i);
								v267=v268+v273;
								v265=sum(0.0+(1.2*((i_Old_i)*(1))+0.69314718*((i_Old_i)*(1))+1.2*((6-i_Old_i)*(1))+0.69314718*((6-i_Old_i)*(1))),0.0+v267);
								v280=1.46328247;
								v279=v280*(i_Old_i);
								v286=sum(0.0,2.4);
								v285=v286*(i_Old_i);
								v291=1.46328247;
								v290=v291*(6-i_Old_i);
								v284=v285+v290;
								v278=sum(0.0+v279+(1.2*((i_Old_i)*(1))+1.2*((6-i_Old_i)*(1))+0.69314718*((6-i_Old_i)*(1))),0.0+v284);
								v264=sum(0.0+v265+(1.2*((i_Old_i)*(1))),0.0+v278);
								v188_arr[i_Female2_i]=v264*(5);
							}
							C_i_Female2_i=(C_i_Female2_i-logs[i_Female2_i+1])+logs[(6-i_Old_i)-i_Female2_i];
						}
						v24_arr[i_Female1_i]=sum_arr(v188_arr, 6-i_Old_i);
					}
				}
				C_i_Female1_i=(C_i_Female1_i-logs[i_Female1_i+1])+logs[(i_Old_i)-i_Female1_i];
			}
			v24=sum_arr(v24_arr, i_Old_i);
			v297=1.31326169;
			v296=v297*(6-i_Old_i);
			v295=v296*(i_Old_i);
			v23=v24+v295;
			v1_arr[i_Old_i]=C_i_Old_i+(0.0*i_Old_i+0.0*(6-i_Old_i))+v23+(1.2*((6-i_Old_i)*(5))+1.0*((i_Old_i))+0.69314718*((i_Old_i))+1.0*((6-i_Old_i))+0.69314718*((6-i_Old_i))+1.0*((i_Old_i)*(i_Old_i-1))+0.69314718*((i_Old_i)*(i_Old_i-1))+1.0*((6-i_Old_i)*(i_Old_i))+0.69314718*((6-i_Old_i)*(i_Old_i))+1.0*((6-i_Old_i)*(6-i_Old_i-1))+0.69314718*((6-i_Old_i)*(6-i_Old_i-1)));
		}
		else{
			double v302_arr[MAX]; C_i_Female_i=0;
			for(int i_Female_i=0;i_Female_i<=6;i_Female_i++){
				if(i_Female_i==0){
					v308=1.46328247;
					v307=v308*(6);
					v305=sum(11.358883079999998,0.0+v307);
					v304=v305*(5);
					v302_arr[i_Female_i]=v304+(36.0+3.4657359);
				}
				else if(i_Female_i!=6){
					v317=1.46328247;
					v316=v317*(i_Female_i);
					v314=sum(0.0+(1.2*((i_Female_i)*(1))+0.69314718*((i_Female_i)*(1))),0.0+v316);
					v324=1.46328247;
					v323=v324*(i_Female_i);
					v329=sum(0.0,2.4);
					v328=v329*(i_Female_i);
					v322=sum(0.0+v323+(1.2*((i_Female_i)*(1))),0.0+v328);
					v334=1.46328247;
					v333=v334*(6-i_Female_i);
					v321=v322+v333;
					v313=sum(0.0+v314+(1.2*((i_Female_i)*(1))+1.2*((6-i_Female_i)*(1))+0.69314718*((6-i_Female_i)*(1))),0.0+v321);
					v312=v313*(5);
					v302_arr[i_Female_i]=C_i_Female_i+(0.0*i_Female_i+0.0*(6-i_Female_i))+v312+(1.2*((6-i_Female_i)*(5)));
				}
				else{
					v344=1.46328247;
					v343=v344*(6);
					v341=sum(11.358883079999998,0.0+v343);
					v350=1.46328247;
					v349=v350*(6);
					v355=sum(0.0,2.4);
					v354=v355*(6);
					v348=sum(0.0+v349+(7.199999999999999),0.0+v354);
					v340=sum(0.0+v341+(7.199999999999999),0.0+v348);
					v302_arr[i_Female_i]=v340*(5);
				}
				C_i_Female_i=(C_i_Female_i-logs[i_Female_i+1])+logs[(6)-i_Female_i];
			}
			v302=sum_arr(v302_arr, 6);
			v1_arr[i_Old_i]=v302+(30.0+20.7944154+6.0+4.15888308);
		}
		C_i_Old_i=(C_i_Old_i-logs[i_Old_i+1])+logs[(6)-i_Old_i];
	}
	v1=sum_arr(v1_arr, 6);
	cout << "exp(" << v1 << ") = " << exp(v1) << endl;
	return 0;
}