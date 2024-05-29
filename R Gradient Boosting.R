#R: GRADIENT BOOSTING (XG BOOST)

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

#INSTALL PACKAGES
#install.packages("xgboost")
library(xgboost)

#FITTING EXTREME GRADIENT BOOSTED REGRESSION TREE
xgb.reg<- xgboost(data=train.x, label=train.y, 
                  max.depth=6, eta=0.01, subsample=0.8, colsample_bytree=0.5, 
                  nrounds=1000, objective="reg:linear")
#eta=learning rate
#colsample_bytree defines what percentage of features (columns) 
#will be used for building each tree

#DISPLAYING FEATURE IMPORTANCE
print(xgb.importance(colnames(train.x), model=xgb.reg))

#COMPUTING PREDICTION ACCURACY FOR TESTING DATA 
pred.y<- predict(xgb.reg, test.x)

#accuracy within 10%
accuracy10<- ifelse(abs(test.y-pred.y)<0.10*test.y,1,0) 
accuracy10_round=(round((mean(accuracy10)*100),2))
cat("accuracy10=",accuracy10_round,"%")

#accuracy within 15%
accuracy15<- ifelse(abs(test.y-pred.y)<0.15*test.y,1,0) 
accuracy15_round=(round((mean(accuracy15)*100),2))
cat("accuracy15=",accuracy15_round,"%")

#accuracy within 20%
accuracy20<- ifelse(abs(test.y-pred.y)<0.20*test.y,1,0) 
accuracy20_round=(round((mean(accuracy20)*100),2))
cat("accuracy20=",accuracy20_round,"%")



