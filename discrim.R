
fertilizer=read.table("fertilizer.txt",header=T)
fertilizer

library(car)
f.manova=manova(cbind(yield,weight)~fert,data=fertilizer)
summary.aov(f.manova)
summary(f.manova)
f.lm=lm(cbind(yield,weight)~fert,data=fertilizer)
Manova(f.lm,idesign=~fert)

fno=as.integer(fertilizer$fert)
plot(fertilizer$yield,fertilizer$weight,col=fno,pch=fno)
library(MASS)
f.lda=lda(fert~yield+weight,data=fertilizer)
f.lda
f.lda$svd
f.lda$scaling
f.lda$means
f.lda$svd**2
f.lda=lda(fert~yield+weight,data=fertilizer,CV=T)
cbind(fertilizer,f.lda$posterior)

fsc=scale(fertilizer[,2:3])
fsc
dfc=f.lda$scaling

plot(f.lda)

yy=seq(29,38,1)
ww=seq(10,14,1)
f.new=expand.grid(yield=yy,weight=ww)
head(f.new)
f.pred=predict(f.lda,f.new)
zz=f.pred$x
zz
cbind(f.new,zz)
z=matrix(zz,length(yy),length(ww),byrow=F)
z
plot(fertilizer$yield,fertilizer$weight,col=fno,pch=fno)
contour(yy,ww,z,add=T)

# plot predicted group memberships

yy=seq(29,38,0.5)
ww=seq(10,14,0.5)
f.new=expand.grid(yield=yy,weight=ww)
head(f.new)
f.pred=predict(f.lda,f.new)

plot(fertilizer$yield,fertilizer$weight,col=fno+2,pch=fno)
g=abbreviate(f.pred$class,1)
points(f.new$yield,f.new$weight,col=f.pred$class,cex=0.3)

#manova

library(MASS)
f.pred.old=predict(f.lda)
f.pred.old
response=cbind(fertilizer$yield,fertilizer$weight)
f.manova.ld1=manova(response~f.pred.old$x[,1])

# contours of P(low)

plot(fertilizer$yield,fertilizer$weight,col=fno,pch=fno)
p=f.pred$posterior[,1]
p
pp=matrix(p,length(yy),length(ww),byrow=F)
pp
contour(yy,ww,pp,add=T)

# or

plot(fertilizer$yield,fertilizer$weight,col=fno,pch=fno)
contour(yy,ww,pp,add=T,levels=c(0.01,0.05,0.1,0.5,0.9,0.95,0.99))


outer(yy,ww,paste)

library(lattice)
#o=order(fertilizer[,2],fertilizer[,3])
#contour(fertilizer[o,2],fertilizer[o,3],f.pred$x[o],add=T)
f.pred$class
table(fertilizer$fert,f.pred$class)
round(f.pred$posterior,4)
f.pred$x
cbind(fertilizer,round(f.pred$posterior,4),f.pred$x)


fpost=round(f.lda$posterior,4)
cbind(fertilizer,fpost)

# jobs 

library(MASS)
jobs=read.table("profile.txt",header=T)
jobs
jobs.lda=lda(job~reading+dance+tv+ski,data=jobs)
jobs.lda
plot(jobs.lda)
jobs.pred=predict(jobs.lda)
jobs.pred
jobs.manova=manova(cbind(reading,dance,tv,ski)~job,data=jobs)
summary(jobs.manova,test="W")
summary.aov(jobs.manova)
summary.aov(manova(jobs.pred$x~job,data=jobs))

# remote sensing

detach(remote)
library(MASS)
remote=read.table("remote-sensing.txt",header=T)
remote
head(remote)
attach(remote)
remote.lda=lda(crop~x1+x2+x3+x4,data=remote)
remote.lda
str(remote.lda)
plot(remote.lda,dimen=2)
plot(remote.lda,dimen=2,xlim=c(-2,2),ylim=c(-1,1))

crp=abbreviate(remote$crop,2)
crp=factor(crp)
mycol=as.integer(crp)
remote.lda=lda(crp~x1+x2+x3+x4,data=remote)
plot(remote.lda,dimen=2,xlim=c(-2,2),ylim=c(-1,1.5),col=mycol)
detach(remote)
remote.2=remote[crp!="Cl",]
remote.2
attach(remote.2)
remote.2.lda=lda(crop~x1+x2+x3+x4)
plot(remote.2.lda,dimen=2,col=mycol)
remote.2.pred=predict(remote.2.lda)
pcrop=remote.2.pred$class
tb=table(crop,pcrop)
tb
sum(diag(tb))/sum(tb)


remote.pred=predict(remote.lda)
table(crp,remote.pred$class)
remote.pred$posterior
remote.lda

detach(remote.2)  

# contours

x=seq(-0.5,3,0.5)
y=seq(-2,2,0.5)
bana=function(xx,yy)
{
  (1-yy)^2+100(xx-yy^2)^2
}
z=outer(x,y,FUN="bana")
z
persp(x,y,z)
