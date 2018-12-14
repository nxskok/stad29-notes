### R code from vignette source '/home/ken/teaching/d29/notes/bDiscrim.Rnw'

###################################################
### code chunk number 1: berzani
###################################################
hilo=read.table("manova1.txt",header=T)
attach(hilo)
fno=as.integer(fertilizer)
plot(yield,weight,pch=fno,col=fno)


###################################################
### code chunk number 2: bDiscrim.Rnw:50-52
###################################################
library(MASS)
hilo.lda=lda(fertilizer~yield+weight)


###################################################
### code chunk number 3: bDiscrim.Rnw:67-68
###################################################
hilo.lda
names(hilo.lda)
hilo.lda$svd

###################################################
### code chunk number 4: workington
###################################################
plot(hilo.lda)


###################################################
### code chunk number 5: bDiscrim.Rnw:113-116
###################################################
hilo.pred=predict(hilo.lda)
hilo.pred$class

cbind(hilo,predicted=hilo.pred$class)
table(fertilizer,predicted=hilo.pred$class)


###################################################
### code chunk number 6: bDiscrim.Rnw:127-129
###################################################
pp=round(hilo.pred$posterior,4)
cbind(hilo,hilo.pred$x,pp)


###################################################
### code chunk number 7: bDiscrim.Rnw:142-146
###################################################
yy=seq(29,38,0.5)
ww=seq(10,14,0.5)
hilo.new=expand.grid(yield=yy,weight=ww)
hilo.pred=predict(hilo.lda,hilo.new)


###################################################
### code chunk number 8: santini
###################################################
plot(yield,weight,col=fno,pch=fno)
z=matrix(hilo.pred$x,length(yy),
  length(ww),byrow=F)
contour(yy,ww,z,add=T)


###################################################
### code chunk number 9: bDiscrim.Rnw:173-174
###################################################
detach(hilo)


###################################################
### code chunk number 10: bDiscrim.Rnw:181-184
###################################################
peanuts=read.table("peanuts.txt",header=T)
head(peanuts)
attach(peanuts)


###################################################
### code chunk number 11: combos
###################################################
combo=paste(variety,location,sep="-")
combo=factor(combo)
combo

library(rgl)
plot3d(y,smk,w,col=as.numeric(combo),size = 100)


###################################################
### code chunk number 12: bDiscrim.Rnw:206-209
###################################################
library(MASS)
peanuts.lda=lda(combo~y+smk+w)
peanuts.lda$scaling
peanuts.lda$svd


###################################################
### code chunk number 13: bDiscrim.Rnw:224-225
###################################################
peanuts.lda$means


###################################################
### code chunk number 14: mancini
###################################################
plot(peanuts.lda)

names(peanuts.lda)

###################################################
### code chunk number 15: vierchowod
###################################################
plot(peanuts.lda,dimen=2)


###################################################
### code chunk number 16: bDiscrim.Rnw:269-271
###################################################
mycol=as.integer(combo)
mycol



###################################################
### code chunk number 17: delpiero
###################################################
plot(peanuts.lda,dimen=2,col=mycol)


###################################################
### code chunk number 18: bDiscrim.Rnw:301-303
###################################################
peanuts.pred=predict(peanuts.lda)

names(peanuts.pred)

library(rgl)
plot3d(peanuts.pred$x,col=as.numeric(combo),size=10)


table(combo,pred.combo=peanuts.pred$class)



###################################################
### code chunk number 19: bDiscrim.Rnw:314-316
###################################################
pp=round(peanuts.pred$posterior,2)
data.frame(combo,pred=peanuts.pred$class,pp)


###################################################
### code chunk number 20: bDiscrim.Rnw:328-331
###################################################
peanuts.lda$scaling
mm=cbind(y,smk,w,peanuts.pred$x)
head(mm)


###################################################
### code chunk number 21: bDiscrim.Rnw:360-363
###################################################
peanuts.cv=lda(combo~y+smk+w,CV=T)
pc=peanuts.cv$class
table(combo,pc)


###################################################
### code chunk number 22: graziani
###################################################
plot(peanuts.lda,dimen=2,col=mycol)


###################################################
### code chunk number 23: bDiscrim.Rnw:381-383
###################################################
pp=round(peanuts.cv$posterior,3)
data.frame(combo,pc,pp)


###################################################
### code chunk number 24: bDiscrim.Rnw:429-434
###################################################
active=read.table("profile.txt",header=T)
attach(active)
active.lda=lda(job~reading+dance+tv+ski)
active.lda$svd
active.lda$scaling


###################################################
### code chunk number 25: totti
###################################################
plot(active.lda)


###################################################
### code chunk number 26: bDiscrim.Rnw:468-471
###################################################
active.pred=predict(active.lda)
pj=active.pred$class
table(job,pj)


###################################################
### code chunk number 27: bDiscrim.Rnw:481-484
###################################################
pp=round(active.pred$posterior,3)
dd=data.frame(job,pj,pp)
dd[c(5,6,9,15),]


###################################################
### code chunk number 28: bDiscrim.Rnw:496-499
###################################################
active.cv=lda(job~reading+dance+tv+ski,CV=T)
pj=active.cv$class
table(job,pj)


###################################################
### code chunk number 29: bDiscrim.Rnw:510-513
###################################################
pp=round(active.cv$posterior,3)
rows=c(5,6,7,9,15)
data.frame(job,pj,pp)[rows,]


###################################################
### code chunk number 30: nesta
###################################################
plot(active.lda,abbrev=3,cex=1.5)


###################################################
### code chunk number 31: bDiscrim.Rnw:557-561
###################################################
crops=read.table("remote-sensing.txt",header=T)
str(crops)
head(crops)

x1
rm(x1)
rm(x2)
attach(crops)
detach(crops)
library(MASS)
crops.lda=lda(crop~x1+x2+x3+x4)
crops.lda$svd


###################################################
### code chunk number 32: bDiscrim.Rnw:574-576
###################################################
crops.lda$means
round(crops.lda$scaling,3)


###################################################
### code chunk number 33: bDiscrim.Rnw:586-587
###################################################
round(crops.lda$scaling,3)


###################################################
### code chunk number 34: bDiscrim.Rnw:599-600
###################################################
options(width=55)


###################################################
### code chunk number 35: bDiscrim.Rnw:605-607
###################################################
crop.i=as.integer(crop)
crop.i


###################################################
### code chunk number 36: piacentini
###################################################
plot(crops.lda,dimen=2,abbrev=2,col=crop.i,cex=1.5)


###################################################
### code chunk number 37: bDiscrim.Rnw:635-639
###################################################

# or dplyr

library(dplyr)
crops %>% filter(crop!="Clover") -> crops2

str(crops2)

crops2=crops[crop!="Clover",]
detach(crops)
attach(crops2)
crops2.lda=lda(crop~x1+x2+x3+x4)


###################################################
### code chunk number 38: bDiscrim.Rnw:653-656
###################################################
crops2.lda$means
crops2.lda$svd
crops2.lda$scaling


###################################################
### code chunk number 39: nedved
###################################################
plot(crops2.lda,dimen=2,col=as.numeric(crop),abbrev=2,cex=1)


###################################################
### code chunk number 40: bDiscrim.Rnw:674-677
###################################################
crops2.pred=predict(crops2.lda)
pc=crops2.pred$class
tab=table(Crop=crop,Pred=pc)
tab
row(tab)
col(tab)
is.diag=(row(tab)==col(tab))
is.diag

tab
tab[is.diag]
tab[!is.diag]

miscl=sum(tab[!is.diag])/sum(tab)
miscl


library(rgl)
crops2.pred$x

plot3d(crops2.pred$x,col=as.numeric(crop))
text3d(crops2.pred$x,text=abbreviate(crop,3),col=as.numeric(crop))

# is it really only LD1 that helps?

plot(crops2.lda,dimen=1) # might need the par(mar) thing for this


###################################################
### code chunk number 41: bDiscrim.Rnw:686-687
###################################################
options(width=60)


###################################################
### code chunk number 42: bDiscrim.Rnw:692-695
###################################################
post=round(crops2.pred$posterior,3)
rows=c(2,4,5,9,10,11,16,17,24,25)
data.frame(crop,pc,post)[rows,]


###################################################
### code chunk number 43: bDiscrim.Rnw:708-710
###################################################
crops2.manova=manova(cbind(x1,x2,x3,x4)~crop)
summary(crops2.manova)


