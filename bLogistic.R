### R code from vignette source '/home/ken/teaching/d29/notes/bLogistic.Rnw'

###################################################
### code chunk number 1: bLogistic.Rnw:41-45
###################################################
rats=read.table("rat.txt",header=T)
rats
attach(rats)
rats.1=glm(status~dose,family="binomial")


###################################################
### code chunk number 2: bLogistic.Rnw:62-63
###################################################
summary(rats.1)


###################################################
### code chunk number 3: bLogistic.Rnw:85-87
###################################################
p=predict(rats.1,type="response")
p=predict(rats.1)
cbind(rats,p)

# separation

rats$status=factor(c("lived","lived","died","died","died","died"))
rats
str(rats)
rats.1x=glm(status~dose,family="binomial",data=rats)
summary(rats.1x)
p=predict(rats.1x,type="response")
cbind(rats,p)

###################################################
### code chunk number 4: bLogistic.Rnw:123-129
###################################################
detach(rats)
rat2=read.table("rat2.txt",header=T)
rat2
attach(rat2)
response=cbind(lived,died)
response2=cbind(died,lived)
response
rat2.1=glm(response~dose,family="binomial")
summary(rat2.1)

###################################################
### code chunk number 5: bLogistic.Rnw:145-146
###################################################
summary(rat2.1)


###################################################
### code chunk number 6: bLogistic.Rnw:156-158
###################################################
pred=predict(rat2.1,type="response")
pred
cbind(rat2,pred)


###################################################
### code chunk number 7: bLogistic.Rnw:201-207
###################################################
detach(rat2)
sepsis=read.table("sepsis.txt",header=T)
sepsis
dim(sepsis)
str(sepsis)
head(sepsis)
attach(sepsis)
sepsis.1=glm(death~shock+malnut+alcohol+age+
              bowelinf,family="binomial")
summary(sepsis.1)

###################################################
### code chunk number 8: bLogistic.Rnw:216-217
###################################################
summary(sepsis.1)$coefficients


###################################################
### code chunk number 9: bLogistic.Rnw:232-235
###################################################
sepsis.2=update(sepsis.1,.~.-malnut)
sepsis.2=glm(death~shock+alcohol+age+
              bowelinf,family="binomial")
summary(sepsis.2)

detach(sepsis)
###################################################
### code chunk number 10: bLogistic.Rnw:268-271
###################################################
sepsis.pred=predict(sepsis.2,type="response")
myrows=c(4,1,2,11,32)
cbind(sepsis[myrows,],p=sepsis.pred[myrows])


###################################################
### code chunk number 11: seppo (eval = FALSE)
###################################################
## r=residuals(sepsis.2)
## plot(r~age)


###################################################
### code chunk number 12: virtusentella
###################################################
r=residuals(sepsis.2)
plot(r~age)


###################################################
### code chunk number 13: bLogistic.Rnw:362-364
###################################################
cc=exp(coef(sepsis.2)[-1])
round(cc,2)


###################################################
### code chunk number 14: bLogistic.Rnw:375-376
###################################################
detach(sepsis)


###################################################
### code chunk number 15: bLogistic.Rnw:395-397
###################################################
(od1=0.02/0.98)
(od2=0.01/0.99)


###################################################
### code chunk number 16: bLogistic.Rnw:402-403
###################################################
od1/od2 # very close to 2


###################################################
### code chunk number 17: bLogistic.Rnw:456-458
###################################################
freqs=read.table("miners-tab.txt",header=T)
freqs


###################################################
### code chunk number 18: bLogistic.Rnw:470-473
###################################################
total=apply(freqs[,-1],1,sum)
total

obsprop=freqs[,-1]/total
obsprop
cbind(exposure=freqs[,1],obsprop)


###################################################
### code chunk number 19: bLogistic.Rnw:486-488
###################################################
prop.table(freqs[-1],1) # error
m=as.matrix(freqs[,-1])           
prop.table(m,1) # 1 for rows, like apply


###################################################
### code chunk number 20: bLogistic.Rnw:525-533
###################################################
freqs
ex=freqs[,1] # exposures
sev=c("None","Moderate","Severe") # severities
names(freqs)
sev=names(freqs)[-1]
sev
obsprop
plot(ex,obsprop[,1],type="n",xlab="Exposure",
     ylab="Observed proportion", ylim=c(0,1))
lines(ex,obsprop[,1],type="b",col=1,pch=1)
lines(ex,obsprop[,2],type="b",col=2,pch=2)
lines(ex,obsprop[,3],type="b",col=3,pch=3)
legend("topright",sev,col=1:3,pch=1:3)  


###################################################
### code chunk number 21: bLogistic.Rnw:543-544
###################################################
freqs


###################################################
### code chunk number 22: dartmiff
###################################################

#library(dplyr)
library(tidyr)

suppressMessages(library(dplyr))
###################################################
### code chunk number 23: kingswear
###################################################
freqs
library(dplyr)
library(tidyr)
miners=freqs %>% gather(severity,frequency,None:Severe) 
head(miners,n=10)
str(miners)
factor(miners$severity)
severity.ordered=ordered(miners$severity,c("None","Moderate","Severe"))
severity.ordered
###################################################
### code chunk number 24: bLogistic.Rnw:628-630
###################################################
library(MASS)
miners.1=polr(severity.ordered~Exposure,weights=frequency,data=miners)


###################################################
### code chunk number 25: bLogistic.Rnw:638-639
###################################################
summary(miners.1)

miners
###################################################
### code chunk number 26: bLogistic.Rnw:650-652
###################################################
miners.0=polr(severity~1,weights=frequency,data=miners)
anova(miners.0,miners.1)


###################################################
### code chunk number 27: bLogistic.Rnw:668-671
###################################################
freqs$Exposure
miners.new=data.frame(Exposure=freqs$Exposure)
miners.new
p=predict(miners.1,miners.new,type="p")
p
cbind(miners.new,p)


###################################################
### code chunk number 28: bLogistic.Rnw:680-682 (eval = FALSE)
###################################################
## plot(ex,obsprop[,1],type="n",ylim=c(0,1),
##      xlab="Exposure",ylab="Probability")


###################################################
### code chunk number 29: bLogistic.Rnw:688-691 (eval = FALSE)
###################################################
## points(ex,obsprop[,1],col=1,pch=1)
## points(ex,obsprop[,2],col=2,pch=2)
## points(ex,obsprop[,3],col=3,pch=3)


###################################################
### code chunk number 30: bLogistic.Rnw:697-700 (eval = FALSE)
###################################################
## lines(ex,p[,1],col=1)
## lines(ex,p[,2],col=2)
## lines(ex,p[,3],col=3)


###################################################
### code chunk number 31: bLogistic.Rnw:706-707 (eval = FALSE)
###################################################
## legend("topright",sev,col=1:3,pch=1:3)


###################################################
### code chunk number 32: bLogistic.Rnw:733-742
###################################################
plot(ex,obsprop[,1],type="n",ylim=c(0,1),
     xlab="Exposure",ylab="Probability")
points(ex,obsprop[,1],col=1,pch=1)
points(ex,obsprop[,2],col=2,pch=2)
points(ex,obsprop[,3],col=3,pch=3)
lines(ex,p[,1],col=1)
lines(ex,p[,2],col=2)
lines(ex,p[,3],col=3)
legend("topright",sev,col=1:3,pch=1:3)


###################################################
### code chunk number 33: bLogistic.Rnw:764-766
###################################################
brandpref=read.csv("mlogit.csv",header=T)
head(brandpref)


##################################################
### code chunk number 34: bLogistic.Rnw:780-782
###################################################
attach(brandpref)
class(sex)
class(factor(sex))
brandpref$sex=factor(brandpref$sex)
brandpref$brand=factor(brandpref$brand)


###################################################
### code chunk number 35: bLogistic.Rnw:790-792
###################################################
library(nnet)
brands.both=multinom(brand~age+sex,data=brandpref)


###################################################
### code chunk number 36: bLogistic.Rnw:802-804
###################################################
brands.age=multinom(brand~age,data=brandpref)
brands.sex=multinom(brand~sex,data=brandpref)


###################################################
### code chunk number 37: bLogistic.Rnw:815-817
###################################################
anova(brands.age,brands.both)
anova(brands.sex,brands.both)

brands.int=update(brands.both,.~.+sex*age)
anova(brands.both,brands.int) # not significant
###################################################
### code chunk number 38: bLogistic.Rnw:836-839
###################################################
summary(brandpref)
new=expand.grid(age=c(24,28,32,35,38),sex=factor(0:1))
p=predict(brands.both,new,type="probs")
cbind(new,p)


###################################################
### code chunk number 39: bLogistic.Rnw:860-863 (eval = FALSE)
###################################################
## plot(new$age,p[,1],type="n",xlab="age",
##      ylab="predicted probability")
## mycol=ifelse(new$sex==1,"red","blue")


###################################################
### code chunk number 40: bLogistic.Rnw:867-871 (eval = FALSE)
###################################################
## for (i in 1:3)
## {
##   text(new$age,p[,i],i,col=mycol)
## }


###################################################
### code chunk number 41: bLogistic.Rnw:875-877 (eval = FALSE)
###################################################
## legend("topright",legend=levels(new$sex),
##        fill=c("blue","red"))


###################################################
### code chunk number 42: bLogistic.Rnw:900-907
###################################################
plot(new$age,p[,1],type="n",xlab="age",ylab="predicted probability")
mycol=ifelse(new$sex==1,"red","blue")
for (i in 1:3)
{
  text(new$age,p[,i],i,col=mycol)
}
legend("topright",legend=levels(new$sex),fill=c("blue","red"))


###################################################
### code chunk number 43: bLogistic.Rnw:954-957
###################################################
attach(brandpref)
tb=table(brand,age,sex)
tb


###################################################
### code chunk number 44: bLogistic.Rnw:972-975
###################################################
b=as.data.frame(tb)
b
b[21:30,]
detach(brandpref)


###################################################
### code chunk number 45: bLogistic.Rnw:993-997
###################################################
b$sex=factor(b$sex)
b$brand=factor(b$brand)
b.both=multinom(brand~age+sex,data=b,weights=Freq)
b.age=multinom(brand~age,data=b,weights=Freq)


###################################################
### code chunk number 46: bLogistic.Rnw:1010-1011
###################################################
anova(b.age,b.both)


str(b)
str(brandpref)
  