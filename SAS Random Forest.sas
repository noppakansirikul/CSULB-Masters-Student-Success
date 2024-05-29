
/*SAS: RANDOM FOREST*/

/*IMPORT DATAFILE*/
proc import out=graddata
datafile="//vdi-fileshare02/UEMprofiles/032283262/Desktop/STAT 574/Project/Graduate Student Data_VAR.csv"
dbms=csv replace;
run;

/*SPLIT DATA INTO 80% TRAINING AND 20% TESTING*/
proc surveyselect 
data=graddata
rate=0.8 
seed=902847
out=graddata 
outall method=srs; 
run;

/*BUILDING RANDOM FOREST REGRESSION*/
proc hpforest
data=graddata 
seed=902847 
maxtrees=60 
vars_to_try=4 
trainfraction=0.7
maxdepth=50;
target years_to_degree/level=interval;
input term term_pandemic major_cat race_ethnicity_cat domestic_international first_gen_cat gender sexual_orientation tuition_type military_status 
acad_stand_01 acad_stand_02 culminating_activity bach_school/level=nominal;
input age indep_family_size admission_gpa gpa_cur_01 gpa_cur_02 units_taken_01 units_taken_02 units_passed_01 units_passed_02 pass_rate_01 pass_rate_02/level=interval;
partition rolevar=selected(train='1');
save file='C:/Users/032283262/Desktop/random_forest.bin';
run;

/*COMPUTE PREDICTED VALUES FOR TESTING DATA*/
data test;
set graddata;
if(selected='0');
run;

proc hp4score data=test;
id years_to_degree;
score file='C:/Users/032283262/Desktop/random_forest.bin'
out=predicted;
run;

proc print;
run;

/*DETERMINE 10%, 15%, AND 20% ACCURACY*/
data accuracy;
set predicted;
if(abs(years_to_degree-P_years_to_degree)<0.10*years_to_degree) then ind10=1; else ind10=0;
if(abs(years_to_degree-P_years_to_degree)<0.15*years_to_degree) then ind15=1; else ind15=0; 
if(abs(years_to_degree-P_years_to_degree)<0.20*years_to_degree) then ind20=1; else ind20=0;
run;

proc sql;
select (sum(ind10)/count(*))*100 as accuracy10, (sum(ind15)/count(*))*100 as accuracy15, (sum(ind20)/count(*))*100 as accuracy20
from accuracy;
quit;
