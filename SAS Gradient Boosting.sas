
/*SAS: GRADIENT BOOSTING (XG BOOST)*/

/*IMPORT DATAFILE*/
proc import out=sasuser.graddata_var
datafile="//vdi-fileshare02/UEMprofiles/032283262/Desktop/STAT 574/Project/Graduate Student Data_VAR.csv"
dbms=csv replace;
run;

/*DETERMINE 10%, 15%, AND 20% ACCURACY*/
data accuracy;
set tmp1.em_save_test;
ind10=(abs(R_years_to_degree)<0.10*(years_to_degree));
ind15=(abs(R_years_to_degree)<0.15*(years_to_degree));
ind20=(abs(R_years_to_degree)<0.20*(years_to_degree));
run;

proc sql;
select sum(ind10)/count(*) as accuracy10, sum(ind15)/count(*) as accuracy15, sum(ind20)/count(*) as accuracy20
from accuracy;
quit;


