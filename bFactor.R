## ----kids-scree----------------------------------------------------------
kids=read.table("rex2.txt",header=T)
kids
class(kids)
km=as.matrix(kids)
kids.pc=princomp(covmat=km)

## ----fig.height=5--------------------------------------------------------
plot(kids.pc,type="l")
plot(kids.pc$sdev^2,type="b",ylab="Eigenvalue")

## ------------------------------------------------------------------------
kids.pc$loadings

## ------------------------------------------------------------------------
km2=list(cov=km,n.obs=145)
km2
kids.f2=factanal(factors=2,covmat=km2)

## ------------------------------------------------------------------------
kids.f2$uniquenesses

## ------------------------------------------------------------------------
kids.f2$loadings

## ------------------------------------------------------------------------
kids.f2$STATISTIC
kids.f2$dof
kids.f2$PVAL

## ------------------------------------------------------------------------
kids.f1=factanal(factors=1,covmat=km2)
kids.f1$STATISTIC
kids.f1$dof
kids.f1$PVAL

## ----track-factor-biplot,fig.height=5------------------------------------
track=read.table("men_track_field.txt",header=T)
track.f=factanal(track[,-9],2,scores="r")

## ----siracusa,fig.height=5-----------------------------------------------
biplot(track.f$scores,track.f$loadings,xlabs=track[,9])
dim(track)
xx=rep("*",55)
biplot(track.f$scores,track.f$loadings,xlabs=xx)
?biplot
## ------------------------------------------------------------------------
track.f$loadings

## ------------------------------------------------------------------------
good.sprint=track.f$scores[,2]<(-1)
track[good.sprint,9]
good.distance=track.f$scores[,1]<(-0.8)
good.distance
track[good.distance,9]

## ----bem-scree,fig.height=5----------------------------------------------
bem=read.table("factor.txt",header=T)
bem[1:10,1:9]
bem.pc=princomp(bem[,-1],cor=T)

## ----eval=F--------------------------------------------------------------
## plot(bem.pc$sdev^2,type="b")
## abline(h=1,lty="dashed")

## ----genoa,echo=F,fig.height=4.8-----------------------------------------
#plot(bem.pc$sdev^2,type="b")
plot(bem.pc,type="l")
#abline(h=1,lty="dashed")

## ----bem-scree-two,fig.height=4.5----------------------------------------
#plot(bem.pc$sdev^2,type="b",xlim=c(0,10))
#abline(h=1,lty="dashed")

## ------------------------------------------------------------------------
summary(bem.pc)

## ----bem-biplot,fig.height=5---------------------------------------------
biplot(bem.pc)

## ----bem-biplot-two,fig.height=4.5---------------------------------------
biplot(bem.pc,cex=c(0.25,0.5))

## ------------------------------------------------------------------------
bem.2=factanal(bem[,-1],factors=2)

## ----echo=-1-------------------------------------------------------------
options(width=70)
sort(bem.2$uniquenesses)

## ------------------------------------------------------------------------
bem.2$loadings
bem.2$loadings[,1]

## ----echo=FALSE----------------------------------------------------------
options(width=60)

## ------------------------------------------------------------------------
big=abs(bem.2$loadings[,1])>0.4
bem.2$loadings[big,1]

## ------------------------------------------------------------------------
big=abs(bem.2$loadings[,2])>0.4
bem.2$loadings[big,2]

## ----biplot-two-again,fig.height=5,eval=F--------------------------------
## bem.2a=factanal(bem[,-1],factors=2,scores="r")
## biplot(bem.2a$scores,bem.2a$loadings,cex=c(0.75,0.5))

## ----biplot-two-ag,fig.height=5.5,echo=F---------------------------------
bem.2a=factanal(bem[,-1],factors=2,scores="r")
biplot(bem.2a$scores,bem.2a$loadings,cex=c(0.75,0.5))

## ------------------------------------------------------------------------
big1=abs(bem.2$loadings[,1])>0.4
big1=c(FALSE,big1)
big2=abs(bem.2$loadings[,2])>0.4
big2=c(FALSE,big2)

## ----echo=FALSE----------------------------------------------------------
options(width=55)

## ------------------------------------------------------------------------
bem[c(359,258,230),big1]

## ------------------------------------------------------------------------
bem[c(311,214,366),big2]

## ------------------------------------------------------------------------
bem.2$PVAL

## ------------------------------------------------------------------------
bem.15=factanal(bem[,-1],factors=15)
bem.15$PVAL

## ------------------------------------------------------------------------
mylist=list(list())
for (i in 1:15)
{
  v=sort(bem.15$loadings[,i])
  mylist[[i]]=round(v,2)
}

## ------------------------------------------------------------------------
mylist[[1]]

## ------------------------------------------------------------------------
mylist[[2]]

## ------------------------------------------------------------------------
mylist[[3]]

## ------------------------------------------------------------------------
mylist[[4]]

## ------------------------------------------------------------------------
mylist[[5]]

## ------------------------------------------------------------------------
mylist[[6]]

## ------------------------------------------------------------------------
mylist[[7]]

## ------------------------------------------------------------------------
mylist[[8]]

## ------------------------------------------------------------------------
mylist[[9]]

## ------------------------------------------------------------------------
mylist[[10]]

## ------------------------------------------------------------------------
mylist[[11]]

## ------------------------------------------------------------------------
mylist[[12]]

## ------------------------------------------------------------------------
mylist[[13]]

## ------------------------------------------------------------------------
mylist[[14]]

## ------------------------------------------------------------------------
mylist[[15]]

## ------------------------------------------------------------------------
r=round(bem.15$uniquenesses,2)
sort(r)

## ------------------------------------------------------------------------
km

## ------------------------------------------------------------------------
library(lavaan)

## ------------------------------------------------------------------------
test.model.1='ability=~para+sent+word+add+dots'

## ------------------------------------------------------------------------
test.model.2='
    verbal=~para+sent+word
    math=~add+dots'

## ------------------------------------------------------------------------
fit1=cfa(test.model.1,sample.cov=km,
    sample.nobs=145)

## ------------------------------------------------------------------------
fit1

## ------------------------------------------------------------------------
fit2=cfa(test.model.2,sample.cov=km,sample.nobs=145)
fit2

## ------------------------------------------------------------------------
anova(fit1,fit2)

## ------------------------------------------------------------------------
head(track[,-9])

## ------------------------------------------------------------------------
track.model='
sprint=~m100+m200+m400+m800
distance=~m1500+m5000+m10000+marathon'

## ------------------------------------------------------------------------
track.1=cfa(track.model,data=track[,-9],std.ov=T)
track.1

## ------------------------------------------------------------------------
track.model.2='
sprint=~m100+m200+m400
middle=~m800+m1500
distance=~m5000+m10000+marathon'

## ------------------------------------------------------------------------
track.2=cfa(track.model.2,data=track[,-9],std.ov=T)
track.2

## ------------------------------------------------------------------------
anova(track.1,track.2)

