
/*SAS: KNN*/

/*IMPORT DATAFILE*/
proc import out=sasuser.graddata_var
datafile="//vdi-fileshare02/UEMprofiles/032283262/Desktop/STAT 574/Project/Graduate Student Data_VAR.csv"
dbms=csv replace;
run;

/*Running Memory Based Reasoning (MBR)(or kNN regression) in Enterprise Miner*/

/*COMPUTING ACCURACY WITHIN 10%, 15%, AND 20%*/
data accuracy;
set tmp1.em_save_test;
ind10=(abs(R_years_to_degree)<0.10*years_to_degree);
ind15=(abs(R_years_to_degree)<0.15*years_to_degree);
ind20=(abs(R_years_to_degree)<0.20*years_to_degree);
obs_n=_N_;
run;

proc sql;
select mean(ind10) as accuracy10, mean(ind15) as accuracy15, mean(ind20) as accuracy20
from accuracy;
quit;

/*PLOTTING ACTUAL AND PREDICTED VALUES FOR TESTING DATA*/;
goptions reset=all border;
title1 "k-Nearest Neighbor (KNN) Regression";
symbol1 interpol=join value=dot color=limegreen;
symbol2 interpol=join value=dot color=hotpink;
legend1 value=("actual" "predicted")
position=(top right inside) label=none;
proc gplot data=accuracy;
plot years_to_degree*obs_n
EM_PREDICTION*obs_n/ overlay legend=legend1;
run;


