#R: kNN

#IMPORT DATAFILE
grad_student.data<- read.csv(file="/Users/noppakansirikul/Desktop/STAT 574/PROJECT/DATA/Graduate Student Data_VAR.csv", header=TRUE, sep=",")

grad_student.data<-na.omit(grad_student.data)

#SPLITTING DATA INTO 80% TRAINING AND 20% TESTING SETS 
set.seed(902847)
sample <- sample(c(TRUE, FALSE), nrow(grad_student.data), replace=TRUE, prob=c(0.8,0.2))
train<- grad_student.data[sample,]
test<- grad_student.data[!sample,]

train.x<- data.matrix(train[-28])
train.y<- data.matrix(train[28])
test.x<- data.matrix(test[-28])
test.y<- data.matrix(test[28])

#TRAINING K-NEAREST NEIGHBOR REGRESSION 
#install.packages("caret") 
#Classification and Regression Training
library(caret)
print(train(YEARS_TO_DEGREE ~ TERM + TERM_PANDEMIC + MAJOR_CAT + RACE_ETHNICITY_CAT + DOMESTIC_INTERNATIONAL + FIRST_GEN_CAT + AGE + INDEP_INCOME + INDEP_FAMILY_SIZE + GENDER 
            + SEXUAL_ORIENTATION + TUITION_TYPE + MILITARY_STATUS + ACAD_STAND_01 + ACAD_STAND_02 + ADMISSION_GPA + CULMINATING_ACTIVITY + GPA_CUR_01 + GPA_CUR_02 + BACH_SCHOOL, data=train, method="knn"))

#FITTING OPTIMAL KNN REGRESSION (K=9)
knn.reg<- knnreg(train.x, train.y, k=9)

#COMPUTING PREDICTION ACCURACY FOR TESTING DATA 
pred.y<- predict(knn.reg, test.x)

#accuracy within 10%
accuracy10<- ifelse(abs(test.y-pred.y)<0.10*test.y,1,0) 
print(mean(accuracy10))

#accuracy within 15%
accuracy15<- ifelse(abs(test.y-pred.y)<0.15*test.y,1,0) 
print(mean(accuracy15))

#accuracy within 20%
accuracy20<- ifelse(abs(test.y-pred.y)<0.20*test.y,1,0) 
print(mean(accuracy20))

#PLOTTING ACTUAL AND PREDICTED VALUES FOR TESTING DATA
x<- 1:length(test.y)
plot(x, test.y, type="l", lwd=2, col="magenta", main="KNN Regression", 
     panel.first=grid())
lines(x, pred.y, lwd=2, col="dodgerblue")
legend("topright", c("actual", "predicted"), lty=1, lwd=2,
       col=c("magenta","dodgerblue"))

