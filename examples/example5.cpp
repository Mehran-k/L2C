#include <iostream>
#include <string>
#include <queue>
#include <cmath>
#define MAX 101
using namespace std;double sum(double a, double b){return max(a,b)+log1p(exp(-abs(a-b)));}double sum_arr(double array[], int n){double max = *std::max_element(array, array + n + 1);double sum = 0;for(int i = 0; i <= n; i++)sum += exp(array[i] - max);return max + log(sum);}double C_i_Old_i,C_i_Female_i,C_i_Female2_i,C_i_Female1_i,v1,v2,v3,v4,v5,v6,v8,v9,v10,v11,v13,v14,v17,v19,v20,v21,v22,v24,v25,v28,v30,v31,v32,v33,v34,v35,v36,v37,v38,v39,v40,v42,v45,v47,v48,v49,v54,v55,v56,v61,v62,v63,v64,v65,v66,v68,v69,v72,v74,v75,v78,v80,v81,v82,v87,v88,v89,v90,v95,v96,v99,v101,v102,v103,v104,v105,v106,v108,v109,v112,v114,v115,v118,v120,v121,v122,v127,v128,v129,v130,v135,v136,v139,v141,v142,v143,v144,v145,v147,v152,v153,v154,v156,v157,v158,v159,v161,v162,v165,v167,v168,v169,v170,v172,v173,v176,v178,v179,v184,v185,v186,v187,v188,v189,v190,v191,v192,v194,v195,v200,v201,v202,v203,v205,v208,v210,v212,v213,v214,v215,v216,v217,v218,v220,v221,v224,v226,v227,v230,v232,v233,v234,v235,v236,v241,v242,v245,v247,v248,v249,v250,v255,v256,v261,v262,v263,v264,v265,v266,v268,v269,v272,v274,v275,v276,v277,v278,v283,v284,v285,v286,v291,v292,v297,v298,v299,v300,v301,v302,v303,v305,v306,v307,v310,v312,v315,v317,v318,v319,v320,v325,v326,v327,v328,v329,v334,v337,v339,v340,v341,v342,v343,v344,v346,v347,v350,v352,v353,v354,v355,v360,v361,v362,v363,v368,v369,v374,v375,v376,v377,v379,v380,v382,v383,v384,v385,v387,v388,v391,v393,v394,v395,v396,v398,v399,v402,v404,v405,v406,v407,v408,v409,v411,v412,v417,v419,v420,v422,v423,v424,v425,v427,v428,v431,v433,v434,v435,v436,v438,v439,v442,v444,v445,v446,v447,v448,v449,v450,v452,v453,v456,v458,v459,v460,v461,v462,v467,v468,v469,v470,v475,v476,v481,v482,v483,v484,v485,v486,v487,v489,v490,v493,v495,v496,v497,v498,v499,v504,v505,v506,v507,v512,v513,v518,v519,v520,v521,v522,v523,v525,v526,v527,v530,v532,v533,v536,v538,v539,v540,v541,v542,v547,v548,v549,v550,v551,v556,v557,v558,v563,v564,v565,v566,v567,v568,v570,v571,v572,v575,v577,v578,v581,v583,v584,v585,v586,v587,v592,v593,v594,v597,v599,v600,v601,v602,v607,v608,v613,v614,v615,v616,v617,v618,v619,v621,v622,v625,v627,v628,v629,v630,v635,v636,v637,v638,v643,v644,v645,v646,v647,v648,v649,v651,v652,v655,v657,v658,v659,v660,v665,v666,v667,v668,v673,v674,v675,v676,v677,v678,v680,v681,v682,v685,v687,v688,v691,v693,v694,v695,v696,v701,v702,v703,v704,v705,v710,v711,v714,v716,v717,v718,v719,v720,v721,v723,v724,v725,v728,v730,v731,v734,v736,v737,v738,v739,v744,v745,v746,v747,v748,v753,v754,v757,v759,v760,v761,v766,v767,v768,v769,v770,v771,v772,v773,v775,v776,v781,v782,v783,v784,v785,v786,v788,v789,v792,v794,v795,v796,v797,v798,v803,v804,v805,v806,v811,v812,v817,v818,v819,v820,v821,v822,v824,v825,v828,v830,v831,v832,v833,v838,v839,v840,v841,v846;
queue<double> q2_1;

int main(){
double logs[MAX+1]; for(int i = 0; i <= MAX; i++) logs[i] = log(i);
	double v1_arr[MAX];
	C_i_Old_i=0;
	for(int i_Old_i=0;i_Old_i<=6;i_Old_i++){
		if(i_Old_i==0){
				double v4_arr[MAX];
				C_i_Female_i=0;
				for(int i_Female_i=0;i_Female_i<=6;i_Female_i++){
					if(i_Female_i==0){
						v4_arr[i_Female_i]=1.20000301*30+(0.6931471805*30+0.6931471805*5);
					}
					else if(i_Female_i!=6){
						v11=1.20000301*((i_Female_i)*(1))+(0.6931471805*((i_Female_i)*(1)));
						v17=1.20000301*1;
						v14=sum(0.0+0,0.0+v17);
						v13=v14*(i_Female_i);
						v10=sum(0.0+v11,0.0+v13);
						v9=v10*(5);
						v8=1.20000301*((6-i_Female_i)*(5))+v9+(0.6931471805*((6-i_Female_i)*(5)));
						v4_arr[i_Female_i]=C_i_Female_i+v8;
					}
					else{
						v22=1.20000301*6+(0.6931471805*6);
						v28=1.20000301*1;
						v25=sum(0.0+0,0.0+v28);
						v24=v25*(6);
						v21=sum(0.0+v22,0.0+v24);
						v4_arr[i_Female_i]=v21*(5);
					}
					C_i_Female_i=(C_i_Female_i-logs[i_Female_i+1])+logs[(6)-i_Female_i];
				}
				v4=sum_arr(v4_arr, 6);
			v1_arr[i_Old_i]=1.0*30+1.2*30+1.0*6+v4+(0.6931471805*30+0.6931471805*5+0.6931471805*6);
		}
		else if(i_Old_i==1){
				double v33_arr[MAX];
				C_i_Female2_i=0;
				for(int i_Female2_i=0;i_Female2_i<=6-1;i_Female2_i++){
					if(i_Female2_i==0){
						v40=1.20000301*1+(0.6931471805*1);
						v45=1.20000301*1;
						v42=sum(0.0+0,0.0+v45);
						v39=sum(0.0+v40,0.0+v42);
						v38=1.2*1+v39;
						v49=sum(1.2+0,0.0+0);
						v48=1.20000301*1+v49;
						v55=1.20000301*1;
						v54=sum(1.2+v55,0.0+0);
						v47=sum(0.0+v48,0.0+v54);
						v37=sum(0.0+v38,0.0+v47);
						v36=v37*(5);
						v33_arr[i_Female2_i]=1.20000301*((6-1)*(5))+v36+(0.6931471805*((6-1)*(5)));
					}
					else if(i_Female2_i!=6-1){
						v66=1.20000301*1+1.20000301*((i_Female2_i)*(1))+(0.6931471805*1+0.6931471805*((i_Female2_i)*(1)));
						v72=1.20000301*1;
						v69=sum(0.0+0,0.0+v72);
						v78=1.20000301*1;
						v75=sum(0.0+0,0.0+v78);
						v74=v75*(i_Female2_i);
						v68=v69+v74;
						v65=sum(0.0+v66,0.0+v68);
						v64=1.2*1+v65;
						v82=sum(1.2+0,0.0+0);
						v81=1.20000301*1+1.20000301*((i_Female2_i)*(1))+v82+(0.6931471805*((i_Female2_i)*(1)));
						v89=1.20000301*1;
						v88=sum(1.2+v89,0.0+0);
						v99=1.20000301*1;
						v96=sum(0.0+0,0.0+v99);
						v95=v96*(i_Female2_i);
						v87=v88+v95;
						v80=sum(0.0+v81,0.0+v87);
						v63=sum(0.0+v64,0.0+v80);
						v62=v63*(5);
						v61=1.20000301*((6-1-i_Female2_i)*(5))+v62+(0.6931471805*((6-1-i_Female2_i)*(5)));
						v33_arr[i_Female2_i]=C_i_Female2_i+v61;
					}
					else{
						v106=1.20000301*1+1.20000301*((6-1)*(1))+(0.6931471805*1+0.6931471805*((6-1)*(1)));
						v112=1.20000301*1;
						v109=sum(0.0+0,0.0+v112);
						v118=1.20000301*1;
						v115=sum(0.0+0,0.0+v118);
						v114=v115*(6-1);
						v108=v109+v114;
						v105=sum(0.0+v106,0.0+v108);
						v104=1.2*1+v105;
						v122=sum(1.2+0,0.0+0);
						v121=1.20000301*1+1.20000301*((6-1)*(1))+v122+(0.6931471805*((6-1)*(1)));
						v129=1.20000301*1;
						v128=sum(1.2+v129,0.0+0);
						v139=1.20000301*1;
						v136=sum(0.0+0,0.0+v139);
						v135=v136*(6-1);
						v127=v128+v135;
						v120=sum(0.0+v121,0.0+v127);
						v103=sum(0.0+v104,0.0+v120);
						v33_arr[i_Female2_i]=v103*(5);
					}
					C_i_Female2_i=(C_i_Female2_i-logs[i_Female2_i+1])+logs[(6-1)-i_Female2_i];
				}
				v33=sum_arr(v33_arr, 6-1);
			v145=1.2*1+(0.6931471805*1);
			v147=sum(1.2+0,0.0+0);
			v144=sum(0.0+v145,0.0+v147);
			v143=v144*(5);
				double v152_arr[MAX];
				C_i_Female2_i=0;
				for(int i_Female2_i=0;i_Female2_i<=6-1;i_Female2_i++){
					if(i_Female2_i==0){
						v152_arr[i_Female2_i]=1.20000301*((6-1)*(5))+(0.6931471805*((6-1)*(5))+0.6931471805*5);
					}
					else if(i_Female2_i!=6-1){
						v159=1.20000301*((i_Female2_i)*(1))+(0.6931471805*((i_Female2_i)*(1)));
						v165=1.20000301*1;
						v162=sum(0.0+0,0.0+v165);
						v161=v162*(i_Female2_i);
						v158=sum(0.0+v159,0.0+v161);
						v157=v158*(5);
						v156=1.20000301*((6-1-i_Female2_i)*(5))+v157+(0.6931471805*((6-1-i_Female2_i)*(5)));
						v152_arr[i_Female2_i]=C_i_Female2_i+v156;
					}
					else{
						v170=1.20000301*((6-1)*(1))+(0.6931471805*((6-1)*(1)));
						v176=1.20000301*1;
						v173=sum(0.0+0,0.0+v176);
						v172=v173*(6-1);
						v169=sum(0.0+v170,0.0+v172);
						v152_arr[i_Female2_i]=v169*(5);
					}
					C_i_Female2_i=(C_i_Female2_i-logs[i_Female2_i+1])+logs[(6-1)-i_Female2_i];
				}
				v152=sum_arr(v152_arr, 6-1);
			v142=v143+v152;
			v141=1.20000301*5+v142;
			v32=sum(0.0+v33,0.0+v141);
			v179=sum(1.0+0,0.0+0);
			v178=v179*(6-1);
			v31=v32+v178;
			v30=1.2*((6-1)*(5))+1.0*((6-1))+1.0*1+1.0*((6-1)*(1))+1.0*((6-1)*(6-1-1))+v31+(0.6931471805*1+0.6931471805*((6-1))+0.6931471805*((6-1)*(1))+0.6931471805*((6-1)*(6-1-1)));
			v1_arr[i_Old_i]=C_i_Old_i+v30+(sum(1.0, 0.0)*((i_Old_i)*(i_Old_i-1))+0.6931471805*((i_Old_i)*(i_Old_i-1)));
		}
		else if(i_Old_i==5){
				double v186_arr[MAX];
				C_i_Female1_i=0;
				for(int i_Female1_i=0;i_Female1_i<=5;i_Female1_i++){
					if(i_Female1_i==0){
						v192=1.2*5+(0.6931471805*5);
						v195=sum(1.2+0,0.0+0);
						v194=v195*(5);
						v191=sum(0.0+v192,0.0+v194);
						v190=v191*(5);
						v203=1.20000301*1+(0.6931471805*1);
						v208=1.20000301*1;
						v205=sum(0.0+0,0.0+v208);
						v202=sum(0.0+v203,0.0+v205);
						v201=v202*(5);
						v210=1.20000301*5+(0.6931471805*5+0.6931471805*5);
						v200=sum(0.0+v201,0.0+v210);
						v189=v190+v200;
						v186_arr[i_Female1_i]=1.20000301*25+v189;
					}
					else if(i_Female1_i!=5){
						v218=1.20000301*1+1.20000301*((i_Female1_i)*(1))+(0.6931471805*1+0.6931471805*((i_Female1_i)*(1)));
						v224=1.20000301*1;
						v221=sum(0.0+0,0.0+v224);
						v230=1.20000301*1;
						v227=sum(0.0+0,0.0+v230);
						v226=v227*(i_Female1_i);
						v220=v221+v226;
						v217=sum(0.0+v218,0.0+v220);
						v216=1.2*((i_Female1_i)*(1))+1.2*((5-i_Female1_i)*(1))+v217+(0.6931471805*((5-i_Female1_i)*(1)));
						v236=sum(1.2+0,0.0+0);
						v235=v236*(i_Female1_i);
						v234=1.20000301*1+1.20000301*((i_Female1_i)*(1))+v235+(0.6931471805*1);
						v245=1.20000301*1;
						v242=sum(0.0+0,0.0+v245);
						v249=1.20000301*1;
						v248=sum(1.2+v249,0.0+0);
						v247=v248*(i_Female1_i);
						v241=v242+v247;
						v233=sum(0.0+v234,0.0+v241);
						v256=sum(1.2+0,0.0+0);
						v255=v256*(5-i_Female1_i);
						v232=v233+v255;
						v215=sum(0.0+v216,0.0+v232);
						v214=v215*(5);
						v266=1.20000301*((i_Female1_i)*(1))+(0.6931471805*((i_Female1_i)*(1)));
						v272=1.20000301*1;
						v269=sum(0.0+0,0.0+v272);
						v268=v269*(i_Female1_i);
						v265=sum(0.0+v266,0.0+v268);
						v264=1.2*((i_Female1_i)*(1))+1.2*((5-i_Female1_i)*(1))+v265+(0.6931471805*((5-i_Female1_i)*(1)));
						v278=sum(1.2+0,0.0+0);
						v277=v278*(i_Female1_i);
						v276=1.20000301*((i_Female1_i)*(1))+v277;
						v285=1.20000301*1;
						v284=sum(1.2+v285,0.0+0);
						v283=v284*(i_Female1_i);
						v275=sum(0.0+v276,0.0+v283);
						v292=sum(1.2+0,0.0+0);
						v291=v292*(5-i_Female1_i);
						v274=v275+v291;
						v263=sum(0.0+v264,0.0+v274);
						v262=v263*(5);
						v261=1.20000301*5+v262+(0.6931471805*5);
						v213=sum(0.0+v214,0.0+v261);
						v212=1.20000301*((5-i_Female1_i)*(5))+v213;
						v186_arr[i_Female1_i]=C_i_Female1_i+v212;
					}
					else{
						v303=1.20000301*5+1.20000301*1+(0.6931471805*5+0.6931471805*1);
						v310=1.20000301*1;
						v307=sum(0.0+0,0.0+v310);
						v306=v307*(5);
						v315=1.20000301*1;
						v312=sum(0.0+0,0.0+v315);
						v305=v306+v312;
						v302=sum(0.0+v303,0.0+v305);
						v301=1.2*5+v302;
						v320=sum(1.2+0,0.0+0);
						v319=v320*(5);
						v318=1.20000301*5+1.20000301*1+v319+(0.6931471805*1);
						v328=1.20000301*1;
						v327=sum(1.2+v328,0.0+0);
						v326=v327*(5);
						v337=1.20000301*1;
						v334=sum(0.0+0,0.0+v337);
						v325=v326+v334;
						v317=sum(0.0+v318,0.0+v325);
						v300=sum(0.0+v301,0.0+v317);
						v299=v300*(5);
						v344=1.20000301*5+(0.6931471805*5);
						v350=1.20000301*1;
						v347=sum(0.0+0,0.0+v350);
						v346=v347*(5);
						v343=sum(0.0+v344,0.0+v346);
						v342=1.2*5+v343;
						v355=sum(1.2+0,0.0+0);
						v354=v355*(5);
						v353=1.20000301*5+v354;
						v362=1.20000301*1;
						v361=sum(1.2+v362,0.0+0);
						v360=v361*(5);
						v352=sum(0.0+v353,0.0+v360);
						v341=sum(0.0+v342,0.0+v352);
						v340=v341*(5);
						v339=1.20000301*5+v340+(0.6931471805*5);
						v186_arr[i_Female1_i]=sum(0.0+v299,0.0+v339);
					}
					C_i_Female1_i=(C_i_Female1_i-logs[i_Female1_i+1])+logs[(5)-i_Female1_i];
				}
				v186=sum_arr(v186_arr, 5);
			v369=sum(1.0+0,0.0+0);
			v368=v369*(5);
			v185=v186+v368;
			v184=1.2*5+1.0*1+1.0*5+1.0*5+1.0*20+v185+(0.6931471805*5+0.6931471805*1+0.6931471805*20+0.6931471805*5);
			v1_arr[i_Old_i]=C_i_Old_i+v184+(sum(1.0, 0.0)*((6-i_Old_i)*(6-i_Old_i-1))+0.6931471805*((6-i_Old_i)*(6-i_Old_i-1)));
		}
		else if(i_Old_i!=6){
			if(i_Old_i==0){
				if(6-i_Old_i==0){
					v377=0;
				}
				else{
					double v377_arr[MAX];
					C_i_Female2_i=0;
					for(int i_Female2_i=0;i_Female2_i<=6-i_Old_i;i_Female2_i++){
						if(i_Female2_i==0){
							v377_arr[i_Female2_i]=1.20000301*((6-i_Old_i)*(5))+(0.6931471805*((6-i_Old_i)*(5))+0.6931471805*5);
						}
						else if(i_Female2_i!=6-i_Old_i){
							v385=1.20000301*((i_Female2_i)*(1))+(0.6931471805*((i_Female2_i)*(1)));
							v391=1.20000301*1;
							v388=sum(0.0+0,0.0+v391);
							v387=v388*(i_Female2_i);
							v384=sum(0.0+v385,0.0+v387);
							v383=v384*(5);
							v382=1.20000301*((6-i_Old_i-i_Female2_i)*(5))+v383+(0.6931471805*((6-i_Old_i-i_Female2_i)*(5)));
							v377_arr[i_Female2_i]=C_i_Female2_i+v382;
						}
						else{
							v396=1.20000301*((6-i_Old_i)*(1))+(0.6931471805*((6-i_Old_i)*(1)));
							v402=1.20000301*1;
							v399=sum(0.0+0,0.0+v402);
							v398=v399*(6-i_Old_i);
							v395=sum(0.0+v396,0.0+v398);
							v377_arr[i_Female2_i]=v395*(5);
						}
						C_i_Female2_i=(C_i_Female2_i-logs[i_Female2_i+1])+logs[(6-i_Old_i)-i_Female2_i];
					}
					v377=sum_arr(v377_arr, 6-i_Old_i);
				}
				v376=v377;
			}
			else{
				double v376_arr[MAX];
				C_i_Female1_i=0;
				for(int i_Female1_i=0;i_Female1_i<=i_Old_i;i_Female1_i++){
					if(i_Female1_i==0){
						v409=1.2*((i_Old_i)*(1))+(0.6931471805*((i_Old_i)*(1)));
						v412=sum(1.2+0,0.0+0);
						v411=v412*(i_Old_i);
						v408=sum(0.0+v409,0.0+v411);
						v407=v408*(5);
						if(6-i_Old_i==0){
							v417=0;
						}
						else{
							double v417_arr[MAX];
							C_i_Female2_i=0;
							for(int i_Female2_i=0;i_Female2_i<=6-i_Old_i;i_Female2_i++){
								if(i_Female2_i==0){
									v417_arr[i_Female2_i]=1.20000301*((6-i_Old_i)*(5))+(0.6931471805*((6-i_Old_i)*(5))+0.6931471805*5);
								}
								else if(i_Female2_i!=6-i_Old_i){
									v425=1.20000301*((i_Female2_i)*(1))+(0.6931471805*((i_Female2_i)*(1)));
									v431=1.20000301*1;
									v428=sum(0.0+0,0.0+v431);
									v427=v428*(i_Female2_i);
									v424=sum(0.0+v425,0.0+v427);
									v423=v424*(5);
									v422=1.20000301*((6-i_Old_i-i_Female2_i)*(5))+v423+(0.6931471805*((6-i_Old_i-i_Female2_i)*(5)));
									v417_arr[i_Female2_i]=C_i_Female2_i+v422;
								}
								else{
									v436=1.20000301*((6-i_Old_i)*(1))+(0.6931471805*((6-i_Old_i)*(1)));
									v442=1.20000301*1;
									v439=sum(0.0+0,0.0+v442);
									v438=v439*(6-i_Old_i);
									v435=sum(0.0+v436,0.0+v438);
									v417_arr[i_Female2_i]=v435*(5);
								}
								C_i_Female2_i=(C_i_Female2_i-logs[i_Female2_i+1])+logs[(6-i_Old_i)-i_Female2_i];
							}
							v417=sum_arr(v417_arr, 6-i_Old_i);
						}
						v406=v407+v417;
						v376_arr[i_Female1_i]=1.20000301*((i_Old_i)*(5))+v406;
					}
					else if(i_Female1_i!=i_Old_i){
						if(6-i_Old_i==0){
							v450=1.20000301*((i_Female1_i)*(1))+(0.6931471805*((i_Female1_i)*(1)));
							v456=1.20000301*1;
							v453=sum(0.0+0,0.0+v456);
							v452=v453*(i_Female1_i);
							v449=sum(0.0+v450,0.0+v452);
							v448=1.2*((i_Female1_i)*(1))+1.2*((i_Old_i-i_Female1_i)*(1))+v449+(0.6931471805*((i_Old_i-i_Female1_i)*(1)));
							v462=sum(1.2+0,0.0+0);
							v461=v462*(i_Female1_i);
							v460=1.20000301*((i_Female1_i)*(1))+v461;
							v469=1.20000301*1;
							v468=sum(1.2+v469,0.0+0);
							v467=v468*(i_Female1_i);
							v459=sum(0.0+v460,0.0+v467);
							v476=sum(1.2+0,0.0+0);
							v475=v476*(i_Old_i-i_Female1_i);
							v458=v459+v475;
							v447=sum(0.0+v448,0.0+v458);
							v446=v447*(5);
							v445=v446;
						}
						else{
							double v445_arr[MAX];
							C_i_Female2_i=0;
							for(int i_Female2_i=0;i_Female2_i<=6-i_Old_i;i_Female2_i++){
								if(i_Female2_i==0){
									v487=1.20000301*((i_Female1_i)*(1))+(0.6931471805*((i_Female1_i)*(1)));
									v493=1.20000301*1;
									v490=sum(0.0+0,0.0+v493);
									v489=v490*(i_Female1_i);
									v486=sum(0.0+v487,0.0+v489);
									v485=1.2*((i_Female1_i)*(1))+1.2*((i_Old_i-i_Female1_i)*(1))+v486+(0.6931471805*((i_Old_i-i_Female1_i)*(1)));
									v499=sum(1.2+0,0.0+0);
									v498=v499*(i_Female1_i);
									v497=1.20000301*((i_Female1_i)*(1))+v498;
									v506=1.20000301*1;
									v505=sum(1.2+v506,0.0+0);
									v504=v505*(i_Female1_i);
									v496=sum(0.0+v497,0.0+v504);
									v513=sum(1.2+0,0.0+0);
									v512=v513*(i_Old_i-i_Female1_i);
									v495=v496+v512;
									v484=sum(0.0+v485,0.0+v495);
									v483=v484*(5);
									v445_arr[i_Female2_i]=1.20000301*((6-i_Old_i)*(5))+v483+(0.6931471805*((6-i_Old_i)*(5)));
								}
								else if(i_Female2_i!=6-i_Old_i){
									v523=1.20000301*((i_Female1_i)*(1))+1.20000301*((i_Female2_i)*(1))+(0.6931471805*((i_Female1_i)*(1))+0.6931471805*((i_Female2_i)*(1)));
									v530=1.20000301*1;
									v527=sum(0.0+0,0.0+v530);
									v526=v527*(i_Female1_i);
									v536=1.20000301*1;
									v533=sum(0.0+0,0.0+v536);
									v532=v533*(i_Female2_i);
									q2_1.push(v532);
									v525=v526+v532;
									v522=sum(0.0+v523,0.0+v525);
									v521=1.2*((i_Female1_i)*(1))+1.2*((i_Old_i-i_Female1_i)*(1))+v522+(0.6931471805*((i_Old_i-i_Female1_i)*(1)));
									v542=sum(1.2+0,0.0+0);
									v541=v542*(i_Female1_i);
									v540=1.20000301*((i_Female1_i)*(1))+1.20000301*((i_Female2_i)*(1))+v541+(0.6931471805*((i_Female2_i)*(1)));
									v550=1.20000301*1;
									v549=sum(1.2+v550,0.0+0);
									v548=v549*(i_Female1_i);
									v556=q2_1.front(); q2_1.pop();
									v547=v548+v556;
									v539=sum(0.0+v540,0.0+v547);
									v558=sum(1.2+0,0.0+0);
									v557=v558*(i_Old_i-i_Female1_i);
									v538=v539+v557;
									v520=sum(0.0+v521,0.0+v538);
									v519=v520*(5);
									v518=1.20000301*((6-i_Old_i-i_Female2_i)*(5))+v519+(0.6931471805*((6-i_Old_i-i_Female2_i)*(5)));
									v445_arr[i_Female2_i]=C_i_Female2_i+v518;
								}
								else{
									v568=1.20000301*((6-i_Old_i)*(1))+1.20000301*((i_Female1_i)*(1))+(0.6931471805*((6-i_Old_i)*(1))+0.6931471805*((i_Female1_i)*(1)));
									v575=1.20000301*1;
									v572=sum(0.0+0,0.0+v575);
									v571=v572*(6-i_Old_i);
									v581=1.20000301*1;
									v578=sum(0.0+0,0.0+v581);
									v577=v578*(i_Female1_i);
									v570=v571+v577;
									v567=sum(0.0+v568,0.0+v570);
									v566=1.2*((i_Female1_i)*(1))+1.2*((i_Old_i-i_Female1_i)*(1))+v567+(0.6931471805*((i_Old_i-i_Female1_i)*(1)));
									v587=sum(1.2+0,0.0+0);
									v586=v587*(i_Female1_i);
									v585=1.20000301*((6-i_Old_i)*(1))+1.20000301*((i_Female1_i)*(1))+v586+(0.6931471805*((6-i_Old_i)*(1)));
									v597=1.20000301*1;
									v594=sum(0.0+0,0.0+v597);
									v593=v594*(6-i_Old_i);
									v601=1.20000301*1;
									v600=sum(1.2+v601,0.0+0);
									v599=v600*(i_Female1_i);
									v592=v593+v599;
									v584=sum(0.0+v585,0.0+v592);
									v608=sum(1.2+0,0.0+0);
									v607=v608*(i_Old_i-i_Female1_i);
									v583=v584+v607;
									v565=sum(0.0+v566,0.0+v583);
									v445_arr[i_Female2_i]=v565*(5);
								}
								C_i_Female2_i=(C_i_Female2_i-logs[i_Female2_i+1])+logs[(6-i_Old_i)-i_Female2_i];
							}
							v445=sum_arr(v445_arr, 6-i_Old_i);
						}
						v444=1.20000301*((i_Old_i-i_Female1_i)*(5))+v445;
						v376_arr[i_Female1_i]=C_i_Female1_i+v444;
					}
					else{
						if(6-i_Old_i==0){
							v619=1.20000301*((i_Old_i)*(1))+(0.6931471805*((i_Old_i)*(1)));
							v625=1.20000301*1;
							v622=sum(0.0+0,0.0+v625);
							v621=v622*(i_Old_i);
							v618=sum(0.0+v619,0.0+v621);
							v617=1.2*((i_Old_i)*(1))+v618;
							v630=sum(1.2+0,0.0+0);
							v629=v630*(i_Old_i);
							v628=1.20000301*((i_Old_i)*(1))+v629;
							v637=1.20000301*1;
							v636=sum(1.2+v637,0.0+0);
							v635=v636*(i_Old_i);
							v627=sum(0.0+v628,0.0+v635);
							v616=sum(0.0+v617,0.0+v627);
							v615=v616*(5);
							v376_arr[i_Female1_i]=v615;
						}
						else{
							double v614_arr[MAX];
							C_i_Female2_i=0;
							for(int i_Female2_i=0;i_Female2_i<=6-i_Old_i;i_Female2_i++){
								if(i_Female2_i==0){
									v649=1.20000301*((i_Old_i)*(1))+(0.6931471805*((i_Old_i)*(1)));
									v655=1.20000301*1;
									v652=sum(0.0+0,0.0+v655);
									v651=v652*(i_Old_i);
									v648=sum(0.0+v649,0.0+v651);
									v647=1.2*((i_Old_i)*(1))+v648;
									v660=sum(1.2+0,0.0+0);
									v659=v660*(i_Old_i);
									v658=1.20000301*((i_Old_i)*(1))+v659;
									v667=1.20000301*1;
									v666=sum(1.2+v667,0.0+0);
									v665=v666*(i_Old_i);
									v657=sum(0.0+v658,0.0+v665);
									v646=sum(0.0+v647,0.0+v657);
									v645=v646*(5);
									v614_arr[i_Female2_i]=1.20000301*((6-i_Old_i)*(5))+v645+(0.6931471805*((6-i_Old_i)*(5)));
								}
								else if(i_Female2_i!=6-i_Old_i){
									v678=1.20000301*((i_Old_i)*(1))+1.20000301*((i_Female2_i)*(1))+(0.6931471805*((i_Old_i)*(1))+0.6931471805*((i_Female2_i)*(1)));
									v685=1.20000301*1;
									v682=sum(0.0+0,0.0+v685);
									v681=v682*(i_Old_i);
									v691=1.20000301*1;
									v688=sum(0.0+0,0.0+v691);
									v687=v688*(i_Female2_i);
									v680=v681+v687;
									v677=sum(0.0+v678,0.0+v680);
									v676=1.2*((i_Old_i)*(1))+v677;
									v696=sum(1.2+0,0.0+0);
									v695=v696*(i_Old_i);
									v694=1.20000301*((i_Old_i)*(1))+1.20000301*((i_Female2_i)*(1))+v695+(0.6931471805*((i_Female2_i)*(1)));
									v704=1.20000301*1;
									v703=sum(1.2+v704,0.0+0);
									v702=v703*(i_Old_i);
									v714=1.20000301*1;
									v711=sum(0.0+0,0.0+v714);
									v710=v711*(i_Female2_i);
									v701=v702+v710;
									v693=sum(0.0+v694,0.0+v701);
									v675=sum(0.0+v676,0.0+v693);
									v674=v675*(5);
									v673=1.20000301*((6-i_Old_i-i_Female2_i)*(5))+v674+(0.6931471805*((6-i_Old_i-i_Female2_i)*(5)));
									v614_arr[i_Female2_i]=C_i_Female2_i+v673;
								}
								else{
									v721=1.20000301*((i_Old_i)*(1))+1.20000301*((6-i_Old_i)*(1))+(0.6931471805*((i_Old_i)*(1))+0.6931471805*((6-i_Old_i)*(1)));
									v728=1.20000301*1;
									v725=sum(0.0+0,0.0+v728);
									v724=v725*(i_Old_i);
									v734=1.20000301*1;
									v731=sum(0.0+0,0.0+v734);
									v730=v731*(6-i_Old_i);
									v723=v724+v730;
									v720=sum(0.0+v721,0.0+v723);
									v719=1.2*((i_Old_i)*(1))+v720;
									v739=sum(1.2+0,0.0+0);
									v738=v739*(i_Old_i);
									v737=1.20000301*((i_Old_i)*(1))+1.20000301*((6-i_Old_i)*(1))+v738+(0.6931471805*((6-i_Old_i)*(1)));
									v747=1.20000301*1;
									v746=sum(1.2+v747,0.0+0);
									v745=v746*(i_Old_i);
									v757=1.20000301*1;
									v754=sum(0.0+0,0.0+v757);
									v753=v754*(6-i_Old_i);
									v744=v745+v753;
									v736=sum(0.0+v737,0.0+v744);
									v718=sum(0.0+v719,0.0+v736);
									v614_arr[i_Female2_i]=v718*(5);
								}
								C_i_Female2_i=(C_i_Female2_i-logs[i_Female2_i+1])+logs[(6-i_Old_i)-i_Female2_i];
							}
							v376_arr[i_Female1_i]=sum_arr(v614_arr, 6-i_Old_i);
						}
					}
					C_i_Female1_i=(C_i_Female1_i-logs[i_Female1_i+1])+logs[(i_Old_i)-i_Female1_i];
				}
				v376=sum_arr(v376_arr, i_Old_i);
			}
			v761=sum(1.0+0,0.0+0);
			v760=v761*(6-i_Old_i);
			v759=v760*(i_Old_i);
			v375=v376+v759;
			v374=1.2*((6-i_Old_i)*(5))+1.0*((6-i_Old_i))+1.0*((i_Old_i))+1.0*((6-i_Old_i)*(i_Old_i))+1.0*((6-i_Old_i)*(6-i_Old_i-1))+1.0*((i_Old_i)*(i_Old_i-1))+v375+(0.6931471805*((i_Old_i))+0.6931471805*((6-i_Old_i))+0.6931471805*((i_Old_i)*(i_Old_i-1))+0.6931471805*((6-i_Old_i)*(i_Old_i))+0.6931471805*((6-i_Old_i)*(6-i_Old_i-1)));
			v1_arr[i_Old_i]=C_i_Old_i+v374;
		}
		else{
				double v768_arr[MAX];
				C_i_Female_i=0;
				for(int i_Female_i=0;i_Female_i<=6;i_Female_i++){
					if(i_Female_i==0){
						v773=1.2*6+(0.6931471805*6);
						v776=sum(1.2+0,0.0+0);
						v775=v776*(6);
						v772=sum(0.0+v773,0.0+v775);
						v771=v772*(5);
						v768_arr[i_Female_i]=1.20000301*30+v771+(0.6931471805*5);
					}
					else if(i_Female_i!=6){
						v786=1.20000301*((i_Female_i)*(1))+(0.6931471805*((i_Female_i)*(1)));
						v792=1.20000301*1;
						v789=sum(0.0+0,0.0+v792);
						v788=v789*(i_Female_i);
						v785=sum(0.0+v786,0.0+v788);
						v784=1.2*((i_Female_i)*(1))+1.2*((6-i_Female_i)*(1))+v785+(0.6931471805*((6-i_Female_i)*(1)));
						v798=sum(1.2+0,0.0+0);
						v797=v798*(i_Female_i);
						v796=1.20000301*((i_Female_i)*(1))+v797;
						v805=1.20000301*1;
						v804=sum(1.2+v805,0.0+0);
						v803=v804*(i_Female_i);
						v795=sum(0.0+v796,0.0+v803);
						v812=sum(1.2+0,0.0+0);
						v811=v812*(6-i_Female_i);
						v794=v795+v811;
						v783=sum(0.0+v784,0.0+v794);
						v782=v783*(5);
						v781=1.20000301*((6-i_Female_i)*(5))+v782;
						v768_arr[i_Female_i]=C_i_Female_i+v781;
					}
					else{
						v822=1.20000301*6+(0.6931471805*6);
						v828=1.20000301*1;
						v825=sum(0.0+0,0.0+v828);
						v824=v825*(6);
						v821=sum(0.0+v822,0.0+v824);
						v820=1.2*6+v821;
						v833=sum(1.2+0,0.0+0);
						v832=v833*(6);
						v831=1.20000301*6+v832;
						v840=1.20000301*1;
						v839=sum(1.2+v840,0.0+0);
						v838=v839*(6);
						v830=sum(0.0+v831,0.0+v838);
						v819=sum(0.0+v820,0.0+v830);
						v768_arr[i_Female_i]=v819*(5);
					}
					C_i_Female_i=(C_i_Female_i-logs[i_Female_i+1])+logs[(6)-i_Female_i];
				}
				v768=sum_arr(v768_arr, 6);
			v1_arr[i_Old_i]=1.0*30+1.0*6+v768+(0.6931471805*30+0.6931471805*6);
		}
		C_i_Old_i=(C_i_Old_i-logs[i_Old_i+1])+logs[(6)-i_Old_i];
	}
	v1=sum_arr(v1_arr, 6);

cout << "exp(" << v1 << ")= " << exp(v1) << endl;
return 0;}