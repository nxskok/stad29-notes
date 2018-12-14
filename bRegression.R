## ----setup,echo=F--------------------------------------------------------
library(knitr)
opts_chunk$set(dev = 'pdf')
opts_chunk$set(comment=NA, fig.width=5, fig.height=3.5)
options(width=45)
suppressMessages(library(tidyverse))

## ------------------------------------------------------------------------
sleep=read.table("sleep.txt",header=T)
head(sleep)

## ----suggo---------------------------------------------------------------
ggplot(sleep,aes(x=age,y=atst))+geom_point()

## ------------------------------------------------------------------------
with(sleep,cor(atst,age))

## ------------------------------------------------------------------------
cor(sleep)

## ----icko,fig.height=3---------------------------------------------------
ggplot(sleep,aes(x=age,y=atst))+geom_point()+
  geom_smooth()

## ----echo=-1-------------------------------------------------------------
options(width=60)
sleep.1=lm(atst~age,data=sleep) ; summary(sleep.1)

## ------------------------------------------------------------------------
my.age=c(10,5)
ages.new=data.frame(age=my.age)
ages.new
pc=predict(sleep.1,ages.new,interval="c")
pp=predict(sleep.1,ages.new,interval="p")

## ------------------------------------------------------------------------
cbind(ages.new,pc)

## ------------------------------------------------------------------------
cbind(ages.new,pp)

## ----fig.height=2.8------------------------------------------------------
ggplot(sleep,aes(x=age,y=atst))+geom_point()+
  geom_smooth(method="lm")+
  scale_y_continuous(breaks=seq(420,600,20))

## ----akjhkadjfhjahnkkk---------------------------------------------------
ggplot(sleep.1,aes(x=.fitted,y=.resid))+geom_point()

## ----curvy,fig.height=3--------------------------------------------------
curvy=read.table("curvy.txt",header=T)
ggplot(curvy,aes(x=xx,y=yy))+geom_point()

## ------------------------------------------------------------------------
curvy.1=lm(yy~xx,data=curvy) ; summary(curvy.1)

## ----altoadige-----------------------------------------------------------
ggplot(curvy.1,aes(x=.fitted,y=.resid))+geom_point()

## ------------------------------------------------------------------------
curvy.2=lm(yy~xx+I(xx^2),data=curvy)

## ------------------------------------------------------------------------
summary(curvy.2)

## ------------------------------------------------------------------------
ggplot(curvy.2,aes(x=.fitted,y=.resid))+geom_point()

## ----eval=F--------------------------------------------------------------
## install.packages("MASS")

## ------------------------------------------------------------------------
library(MASS)

## ------------------------------------------------------------------------
madeup=read.csv("madeup.csv")
madeup

## ----dsljhsdjlhf,fig.height=3--------------------------------------------
ggplot(madeup,aes(x=x,y=y))+geom_point()+
  geom_smooth()

## ----eval=F--------------------------------------------------------------
## boxcox(y~x,data=madeup)

## ----trento,echo=F-------------------------------------------------------
boxcox(y~x,data=madeup)

## ----fig.height=3--------------------------------------------------------
log.y=log(madeup$y) 
ggplot(madeup,aes(x=x,y=log.y))+geom_point()+
  geom_smooth()

## ------------------------------------------------------------------------
visits=read.table("regressx.txt",header=T)
head(visits)
attach(visits)
visits.1=lm(timedrs~phyheal+menheal+stress)

## ------------------------------------------------------------------------
summary(visits.1)

## ------------------------------------------------------------------------
summary(visits.1)$coefficients

## ------------------------------------------------------------------------
visits.2=lm(timedrs~menheal) ; summary(visits.2)

## ------------------------------------------------------------------------
cor(visits[,-1])

## ----iffy8,fig.height=3--------------------------------------------------
ggplot(visits.1,aes(x=.fitted,y=.resid))+geom_point()

## ----dawlish,fig.height=4------------------------------------------------
par(mfrow=c(2,2)) ; plot(visits.1)

## ------------------------------------------------------------------------
lgtime=log(timedrs+1)
visits.3=lm(lgtime~phyheal+menheal+stress)

## ------------------------------------------------------------------------
summary(visits.3)

## ----asljsakjhd,fig.height=4---------------------------------------------
par(mfrow=c(2,2)) ; plot(visits.3)

## ------------------------------------------------------------------------
tp=timedrs+1
library(MASS)

## ----eval=F--------------------------------------------------------------
## boxcox(tp~phyheal+menheal+stress)

## ----echo=F,fig.height=4.5-----------------------------------------------
boxcox(tp~phyheal+menheal+stress)

## ------------------------------------------------------------------------
my.lambda=seq(-0.3,0.1,0.01)
my.lambda

## ------------------------------------------------------------------------
boxcox(tp~phyheal+menheal+stress,lambda=my.lambda)

## ------------------------------------------------------------------------
visits.5=lm(lgtime~phyheal+menheal+stress)
visits.6=lm(lgtime~stress)
anova(visits.6,visits.5)

## ------------------------------------------------------------------------
punting=read.table("punting.txt",header=T)
head(punting)
attach(punting)
punting.1=lm(punt~left+right+fred)

## ------------------------------------------------------------------------
summary(punting.1)

## ------------------------------------------------------------------------
cor(punting)

## ------------------------------------------------------------------------
punting.2=lm(punt~right)
anova(punting.2,punting.1)

## ------------------------------------------------------------------------
summary(punting.1)$r.squared
summary(punting.2)$r.squared

## ------------------------------------------------------------------------
summary(punting.2)

## ----basingstoke,fig.height=3--------------------------------------------
r=resid(punting.2)
ggplot(punting,aes(x=left,y=r))+geom_point()+geom_smooth()

## ------------------------------------------------------------------------
leftsq=left*left
punting.3=lm(punt~left+leftsq+right)

## ------------------------------------------------------------------------
summary(punting.3)

