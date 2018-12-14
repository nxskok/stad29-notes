### R code from vignette source '/home/ken/teaching/d29/notes/gflr.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: gflr.Rnw:16-18
###################################################
d=data.frame(x=1:5,early=c(10,11,11,13,15),late=c(12,12,11,14,16))
d


###################################################
### code chunk number 2: gflr.Rnw:28-31
###################################################
library(tidyr)
d2=gather(d,timepoint,y,early:late)
d2

str
###################################################
### code chunk number 3: gflr.Rnw:38-39
###################################################
str(d2)


###################################################
### code chunk number 4: gflr.Rnw:52-53
###################################################
aggregate(y~timepoint,d2,mean)


###################################################
### code chunk number 5: gflr.Rnw:66-67
###################################################
timepoint.1=glm(timepoint~x+y,d2,family="binomial")


###################################################
### code chunk number 6: gflr.Rnw:79-81
###################################################
d2=gather(d,timepoint,y,early:late,factor_key=T)
str(d2)


###################################################
### code chunk number 7: gflr.Rnw:87-89
###################################################
timepoint.1=glm(timepoint~x+y,d2,family="binomial")
summary(timepoint.1)


###################################################
### code chunk number 8: gflr.Rnw:102-105
###################################################
ord.wide=data.frame(exposure=1:4,low=c(10,9,7,5),med=c(0,1,1,2),
  high=c(3,4,6,8))
ord.wide


###################################################
### code chunk number 9: gflr.Rnw:112-114
###################################################
ord=gather(ord.wide,severity,frequency,low:high)
ord


###################################################
### code chunk number 10: gflr.Rnw:119-120
###################################################
str(ord)


###################################################
### code chunk number 11: gflr.Rnw:125-127
###################################################
library(MASS)
severity.1=polr(severity~exposure,data=ord,weights=frequency)


###################################################
### code chunk number 12: gflr.Rnw:134-136
###################################################
ord=gather(ord.wide,severity,frequency,low:high,factor_key=T)
str(ord)


###################################################
### code chunk number 13: gflr.Rnw:149-150
###################################################
severity.1=polr(severity~exposure,data=ord,weights=frequency)


###################################################
### code chunk number 14: gflr.Rnw:155-157
###################################################
severity.0=update(severity.1,.~.-exposure)
anova(severity.0,severity.1)


###################################################
### code chunk number 15: gflr.Rnw:170-174
###################################################
food=data.frame(age=c(12,14,16,21,22),meat=c(1,2,4,4,5),
  fish=c(0,0,1,1,1),ketchup=c(20,12,5,2,1),
  chicken.nuggets=c(10,8,2,1,1))
food


###################################################
### code chunk number 16: gflr.Rnw:180-182
###################################################
food2=gather(food,favourite,frequency,meat:chicken.nuggets,
             factor_key=T)
food2
str(food2)

###################################################
### code chunk number 17: gflr.Rnw:188-189
###################################################
str(food2)


###################################################
### code chunk number 18: gflr.Rnw:194-196
###################################################
library(nnet)
favourite.1=multinom(favourite~age,data=food2,weight=frequency)


###################################################
### code chunk number 19: gflr.Rnw:202-206
###################################################
ages=c(12,15,18,21)
ages
new=expand.grid(age=ages)
new


###################################################
### code chunk number 20: gflr.Rnw:215-217
###################################################
pp=predict(favourite.1,new,type="p")
cbind(new,pp)


