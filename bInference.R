### R code from vignette source '/home/ken/teaching/d29/notes/bInference.Rnw'

###################################################
### code chunk number 1: setup
###################################################
opts_chunk$set(dev = 'pdf')
opts_chunk$set(comment=NA, fig.width=5, fig.height=3.5)
options(width=45)
par(mar=c(0.1,0.1,0.1,0.1))


###################################################
### code chunk number 2: bInference.Rnw:62-63
###################################################
t.star=qt(1-0.05/2,9) ; t.star


###################################################
### code chunk number 3: bInference.Rnw:67-69
###################################################
m=t.star*2.5/sqrt(10) ; m
c(15-m,15+m)


###################################################
### code chunk number 4: bInference.Rnw:100-101
###################################################
t.stat=(15-17)/(2.5/sqrt(10)) ; t.stat


###################################################
### code chunk number 5: bInference.Rnw:108-109
###################################################
2*pt(t.stat,9)


###################################################
### code chunk number 6: bInference.Rnw:129-132
###################################################
data=rnorm(10)
data=(data-mean(data))/sd(data)
mydata=15+2.5*data


###################################################
### code chunk number 7: bInference.Rnw:137-138
###################################################
mydata


###################################################
### code chunk number 8: bInference.Rnw:142-143
###################################################
t.test(mydata,mu=17)


###################################################
### code chunk number 9: readtable
###################################################
f=file.choose()
f
temp=read.table(f,header=T)
head(temp)
drp=read.table("drp.txt",header=T)
head(drp)
drp
str(drp)
###################################################
### code chunk number 10: attach
###################################################
#options(width=45)
attach(drp)
score
group


###################################################
### code chunk number 11: boxplot
###################################################
boxplot(score~group)


###################################################
### code chunk number 12: ttest
###################################################
t.test(score~group)


