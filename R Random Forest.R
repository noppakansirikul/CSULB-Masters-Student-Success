#R: RANDOM FOREST

#IMPORT DATAFILE
grad_student.data<- read.csv(file="/Users/noppakansirikul/Desktop/STAT 574/PROJECT/DATA/Graduate Student Data_VAR.csv", header=TRUE, sep=",")

#SPLITTING DATA INTO 80% TRAINING AND 20% TESTING SETS 
set.seed(902847)
sample <- sample(c(TRUE, FALSE), nrow(grad_student.data), replace=TRUE, prob=c(0.8,0.2))
train<- grad_student.data[sample,]
test<- grad_student.data[!sample,]

#INSTALL PACKAGES
#install.packages("randomForest")
library(randomForest)

#BUILDING RANDOM FOREST REGRESSION
rf.reg<- randomForest(YEARS_TO_DEGREE ~ TERM + TERM_PANDEMIC + MAJOR_CAT + RACE_ETHNICITY_CAT + DOMESTIC_INTERNATIONAL + FIRST_GEN_CAT + AGE + 
                        INDEP_INCOME + INDEP_FAMILY_SIZE + GENDER + SEXUAL_ORIENTATION + TUITION_TYPE + MILITARY_STATUS + ACAD_STAND_01 + ACAD_STAND_02 + 
                        ADMISSION_GPA + CULMINATING_ACTIVITY + GPA_CUR_01 + GPA_CUR_02 + PASS_RATE_01 + PASS_RATE_02 + BACH_SCHOOL, 
                      data=train, ntree=150, mtry=5, maxnodes=30, na.action = na.omit)

#DISPLAYING FEATURE IMPORTANCE
print(importance(rf.reg,type=2)) 

YEARS_TO_DEGREE<-na.omit(YEARS_TO_DEGREE)
P_YEARS_TO_DEGREE<-na.omit(P_YEARS_TO_DEGREE)

#accuracy within 10%
accuracy10<- ifelse(abs(test$YEARS_TO_DEGREE-P_YEARS_TO_DEGREE)<0.10*test$YEARS_TO_DEGREE,1,0) 
print(accuracy10<- mean(accuracy10))

#accuracy within 15%
accuracy15<- ifelse(abs(test$YEARS_TO_DEGREE-P_YEARS_TO_DEGREE)<0.15*test$YEARS_TO_DEGREE,1,0)
print(accuracy15<- mean(accuracy15))

#accuracy within 20%
accuracy20<- ifelse(abs(test$YEARS_TO_DEGREE-P_YEARS_TO_DEGREE)<0.20*test$YEARS_TO_DEGREE,1,0)
print(accuracy20<- mean(accuracy20))