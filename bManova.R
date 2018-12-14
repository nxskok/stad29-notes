## ------------------------------------------------------------------------
hilo=read.table("manova1.txt",header=T)
hilo
attach(hilo)

## ----ferto,fig.height=5--------------------------------------------------
boxplot(yield~fertilizer,ylab="yield")

## ----casteldisangro,fig.height=5-----------------------------------------
boxplot(weight~fertilizer,ylab="weight")

## ------------------------------------------------------------------------
hilo.y=aov(yield~fertilizer)
summary(hilo.y)
hilo.w=aov(weight~fertilizer)
summary(hilo.w)

## ----disparizzo,eval=F---------------------------------------------------
## plot(weight~yield,col=fertilizer,pch=19)
## lv=levels(fertilizer)
## legend("topright",legend=lv,fill=1:2)
## # figure out line through (33,13) and (38,11)
## x1=33
## y1=13
## x2=38
## y2=11
## slope=(y2-y1)/(x2-x1)
## intcpt=y1-slope*x1
## abline(a=intcpt,b=slope,lty="dashed",col="blue")

## ----charlecombe,echo=F,fig.height=5-------------------------------------
plot(yield,weight,col=fertilizer,pch=19)
lv=levels(fertilizer)
legend("topright",legend=lv,fill=c(1,2))
x1=33
y1=13
x2=38
y2=11
slope=(y2-y1)/(x2-x1)
intcpt=y1-slope*x1
abline(a=intcpt,b=slope,lty="dashed",col="blue")

## ggplot

ggplot(hilo,aes(x=yield,y=weight,
                col=fertilizer))+
  geom_point()+
  geom_abline(intercept=intcpt,
              slope=slope,
              colour="darkgreen",
              linetype="dashed")

## ------------------------------------------------------------------------
response=cbind(yield,weight)
response
hilo.1=manova(response~fertilizer)
summary(hilo.1)

## ------------------------------------------------------------------------
library(car)
hilo.2.lm=lm(response~fertilizer)
hilo.2=Manova(hilo.2.lm)
hilo.2

## ------------------------------------------------------------------------
peanuts.orig=read.table("peanuts.txt",header=T)
str(peanuts.orig)
head(peanuts.orig)

## ------------------------------------------------------------------------
suppressMessages(library(dplyr))
peanuts.orig %>%
  mutate(location=factor(location),
         variety=factor(variety)) -> peanuts
peanuts
str(peanuts)
attach(peanuts)
rm(y)
detach(peanuts)
response=cbind(y,smk,w)
head(response)

## ------------------------------------------------------------------------
peanuts.1=lm(response~location*variety)
peanuts.2=Manova(peanuts.1)
peanuts.2

## 3d plotting

library(rgl)
plot3d(y,smk,w)
text3d(y,smk,w,locvar)
locvar=paste(location,variety)
locvar
