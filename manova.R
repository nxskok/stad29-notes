?Sweave
?MASS::lda

hilo=read.table("manova1.txt",header=T)
hilo
attach(hilo)
boxplot(yield~fertilizer,ylab="yield")
boxplot(weight~fertilizer,ylab="weight")

tapply(yield,fertilizer,mean)
tapply(weight,fertilizer,mean)

yield.aov=aov(yield~fertilizer)
summary(yield.aov)
weight.aov=aov(weight~fertilizer)
summary(weight.aov)

plot(yield,weight,col=fertilizer)
lv=levels(fertilizer)

legend("topright",legend=lv,fill=c(1,2))

library(car)
hilo.y=lm(yield~fertilizer)
anova(hilo.y)
hilo.w=lm(weight~fertilizer)
anova(hilo.w)
response=cbind(yield,weight)
response
rtype=colnames(response)
# this is not repeated measures because the responses are not on the same scale
rtype
rtype.df=data.frame(rtype)
##########
hilo.1=manova(response~fertilizer)
summary(hilo.1)
rm(fertilizer)
library(car)
hilo.2.lm=lm(response~fertilizer)
hilo.2=Manova(hilo.2.lm)
hilo.2

hilo.cv=lda(fertilizer~yield+weight,CV=T)
pf=hilo.cv$class
table(fertilizer,pf)
pp=round(hilo.cv$posterior,3)
data.frame(fertilizer,yield,weight,pf,pp)

rm(y)
library(car)
peanuts=read.table("peanuts.txt",header=T)
peanuts
attach(peanuts)
loc.fac=factor(location)
var.fac=factor(variety)
response=cbind(y,smk,w)
peanuts.1=lm(response~loc.fac*var.fac)
peanuts.2=Manova(peanuts.1)
peanuts.2
peanuts.3=lm(response~loc.fac+var.fac)
peanuts.4=Manova(peanuts.3)
peanuts.4

summary.aov(peanuts.1)

tapply(y,var.fac,mean)
tapply(smk,var.fac,mean)
tapply(w,var.fac,mean)

anova(peanuts.3)

library(MASS)

combo=paste(variety,location,sep=".")
combo=factor(combo)
peanuts.lda=lda(combo~y+smk+w)
peanuts.lda
names(peanuts.lda)
peanuts.lda$scaling
peanuts.lda$svd
peanuts.lda$means
scale(peanuts.lda$means)
peanuts.lda$scaling
?lda
plot(peanuts.lda,dimen=2,col=mycol)
mycol=as.integer(combo)
mycol
peanuts.pred=predict(peanuts.lda)
peanuts.pred

peanuts.cv=lda(combo~y+smk+w,CV=T)
pc=peanuts.cv$class
table(combo,pc)
pp=round(peanuts.cv$posterior,3)
data.frame(combo,pc,pp)

plot(peanuts.pred$x[,1],peanuts.pred$x[,2],type="n")
text(peanuts.pred$x[,1],peanuts.pred$x[,2],combo)

table(combo,peanuts.pred$class)
pp=round(peanuts.pred$posterior,3)
pp
data.frame(combo,y,smk,w,pp)
peanuts.lda$scaling
cbind(y,smk,w,peanuts.pred$x)
pairs(cbind(y,smk,w))
detach(hilo)
active=read.table("profile.txt",header=T)
active
rm(dance)
attach(active)

# this does reproduce SAS

install.packages("car")
library(car)
response=cbind(reading,dance,tv,ski)
response=c("reading","dance","tv","ski")
response
colnames(response)
active.1=lm(response~job)
activity=colnames(response)
activity.df=data.frame(activity)

active.2=Manova(active.1,idata=activity.df,idesign=~activity)
active.2
summary(active.2)

# discrim

library(MASS)
active.lda=lda(job~reading+dance+tv+ski)
active.lda
plot(active.lda)
active.lda$scaling
active.lda$svd
active.pred=predict(active.lda)
pj=active.pred$class
table(job,pj)
pp=round(active.pred$posterior,3)
dd=data.frame(job,pj,pp)
dd[c(5,6,9,15),]


active.cv=lda(job~reading+dance+tv+ski,CV=T)
active.cv$class
table(job,active.cv$class)
pp=round(active.cv$posterior,3)
cbind(active,pp)
plot(active.lda)
head(active)
activity.list=c("reading","dance","tv","ski")
active.long=reshape(active,varying=activity.list,
                    v.names="score",timevar="activity",
                    direction="long")
active.long[c(1:7,12:18),]

detach(active)
rm(activity)
detach(active.long)
attach(active.long)
af=factor(activity,labels=activity.list)
interaction.plot(af,job,score)

active.cv=lda(job~reading+dance+tv+ski,CV=T)
active.cv
pj=active.cv$class
table(job,pj)
pp=round(active.cv$posterior,3)
data.frame(job,pj,pp)

detach(prepost)
dogs=read.table("dogs.txt",header=T)
dogs
attach(dogs)
response=cbind(lh0,lh1,lh3,lh5)
dogs.lm=lm(response~drug)
times=colnames(response)
times.df=data.frame(times)
library(car)
dogs.manova=Manova(dogs.lm,idata=times.df,idesign=~times)
dogs.manova

# analysis without first time
rm(lh)
rm(drug)

response=cbind(lh1,lh3,lh5)
dogs.lm=lm(response~drug)
times=colnames(response)
times.df=data.frame(times)
dogs.manova=Manova(dogs.lm,idata=times.df,idesign=~times)
dogs.manova

detach(dogs)
times
d2=reshape(dogs,varying=times,sep="",direction="long")
d2=reshape(dogs,varying=c("lh2","lh3","lh4"),sep="",direction="long")
d2
detach(dogs)
attach(d2)
interaction.plot(time,drug,lh)
interaction.plot(drug,time,lh)
plot(time,lh,col=drug)

dogs
d3=reshape(d2,direction="wide")
d3
detach(d2)

## remote sensing

detach(active)

crops=read.table("remote-sensing.txt",header=T)
attach(crops)

names(crops)
crops.lda=lda(crop~x1+x2+x3+x4)
crops.lda$means
crops.lda$svd
sc=round(crops.lda$scaling,3)
sc*1000
plot(crops.lda)
crops.pred=predict(crops.lda)
names(crops.pred)

crop.i=as.integer(crop)
attach(crops.pred)
plot(x[,1],x[,2],type="n")
text(x[,1],x[,2],abbreviate(crop,2),col=crop.i)
detach(crops.pred)

with(crops.pred,
{
  plot(x[,1],x[,2],type="n")
  crop.i=as.integer(crop)
  text(x[,1],x[,2],abbreviate(crop,2),col=crop.i)
}
      )
table(crop,crops.pred$class)

cbind(crops,crops.pred$x)
tapply(crops.pred$x[,1],crops,mean)
crops.pred$x[,1]
crops.manova=manova(cbind(x1,x2,x3,x4)~crop)
summary(crops.manova)

crops.qda=qda(crop~x1+x2+x3+x4)
crops.qda
crops.qda=qda(crop~x1+x2+x3+x4,CV=T)
table(Crop=crop,Pred=crops.qda$class)
names(crops.qda)

detach(crops)
crops2=crops[crops$crop!="Clover",]
crops2
attach(crops2)
crops2.lda=lda(crop~x1+x2+x3+x4)
crop.i=as.integer(crop)
plot(crops2.lda,dimen=2,col=crop.i,abbrev=2,cex=1)
crops2.manova=manova(cbind(x1,x2,x3,x4)~crop)
summary(crops2.manova)
crops2.pred=predict(crops2.lda)
pc=crops2.pred$class
table(Crop=crop,Pred=pc)

post=round(crops2.pred$posterior,3)
rows=c(2,4,5,9,10,11,16,17,24,25)
data.frame(crop,pc,post)[rows,]
