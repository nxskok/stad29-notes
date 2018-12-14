## ------------------------------------------------------------------------
prepost=read.table("ancova.txt",header=T)
str(prepost)
attach(prepost)

## ----kajskjsa,eval=F,fig.fig.height=5------------------------------------
## mycols=c("blue","red")
## mych=c(1,3)
## plot(after~before,col=mycols[drug],pch=mych[drug])
## legend("topleft",levels(drug),col=mycols,pch=mych)

plot(after~before,col=drug,pch=drug)
plot(after~before,col=drug,pch=as.character(drug))
plot(after~before,col=drug,pch=as.numeric(drug))
legend("topleft",levels(drug),col=1:2,pch=1:2) 

library(ggplot2)
ggplot(prepost,aes(x=before,y=after,
  colour=drug))+geom_point()+
  geom_smooth(method="lm")


## ----spizzo,echo=F,fig.height=5.5----------------------------------------
mycols=c("blue","red")
mych=c(1,3)
plot(after~before,col=mycols[drug],pch=mych[drug])
legend("topleft",levels(drug),col=mycols,pch=mych)

## ------------------------------------------------------------------------
aggregate(before~drug,prepost,mean)
aggregate(after~drug,prepost,mean)

## ------------------------------------------------------------------------
prepost.1=lm(after~before*drug)
anova(prepost.1)
summary(prepost.1)

## ------------------------------------------------------------------------
new=expand.grid(
  before=c(5,15,25),
  drug=c("a","b"))
new

## ------------------------------------------------------------------------
pred=predict(prepost.1,new)
preds=data.frame(new,pred)
preds

## ----AJHSA,fig.height=5,eval=F-------------------------------------------
## library(ggplot2)
## ggplot(prepost,
##   aes(x=before,y=after,colour=drug,group=drug))+
##   geom_point()+
##   geom_line(data=preds,aes(x=before,y=pred))

## ----nachwazzo,echo=F,fig.height=4.5-------------------------------------
library(ggplot2)
ggplot(prepost,aes(x=before,y=after,colour=drug))+
  geom_point()+geom_line(data=preds,aes(x=before,y=pred))

## or (for this)

ggplot(prepost,aes(x=before,y=after,colour=drug))+
  geom_point()+geom_smooth(method="lm")

## ------------------------------------------------------------------------
prepost.2=lm(after~before+drug)
anova(prepost.2)

## ------------------------------------------------------------------------
pred=predict(prepost.2,new)
preds=data.frame(new,pred)
preds

## ----eval=F--------------------------------------------------------------
## ggplot(prepost,
##   aes(x=before,y=after,colour=drug))+
##   geom_point()+
##   geom_line(data=preds,aes(x=before,y=pred))

## ----cabazzo,echo=F,fig.height=5-----------------------------------------
ggplot(prepost,
  aes(x=before,y=after,colour=drug,group=drug))+
  geom_point()+
  geom_line(data=preds,aes(x=before,y=pred))

