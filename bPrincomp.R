
## ----testt,fig=TRUE,include=FALSE----------------------------------------
test12=read.table("test12.txt",header=T,as.is=3)
test12
attach(test12)
plot(first,second)
text(first,second,id,pos=4)


## ----plot12,fig=TRUE, include=FALSE--------------------------------------
cor(first,second)
test12.pc=princomp(test12[,1:2],cor=T)
summary(test12.pc)
plot(test12.pc,type="l")


## ------------------------------------------------------------------------
test12.pc$loadings


## ------------------------------------------------------------------------
data.frame(test12,scores=test12.pc$scores)


## ----score-plot,fig=TRUE,include=FALSE-----------------------------------
plot(test12.pc$scores,type="n")
text(test12.pc$scores,id)


## ----eqsc,fig=TRUE,include=FALSE-----------------------------------------
library(MASS)
eqscplot(test12.pc$scores,type="n",xlab="Comp.1",
  ylab="Comp.2")
text(test12.pc$scores,id)


## ----test-biplot,fig=TRUE,include=FALSE----------------------------------
biplot(test12.pc,xlabs=id)
test12

## ------------------------------------------------------------------------
track=read.table("men_track_field.txt",header=T)
track[c(1:8,52:55),]


## ----echo=FALSE----------------------------------------------------------
options(width=50)


## ----scree-a,fig=TRUE,include=FALSE--------------------------------------
track.pc=princomp(track[,1:8],cor=T)
plot(track.pc,type="l")
summary(track.pc)


## ----scree-b,fig=TRUE,include=FALSE--------------------------------------
plot(track.pc$sdev^2,type="b",ylab="Eigenvalue")


## ------------------------------------------------------------------------
track.pc$loadings


## ----pc-plot,fig=TRUE,include=FALSE--------------------------------------
plot(track.pc$scores[,1:2],type="n")
text(track.pc$scores[,1:2],as.character(track[,9]))


## ----biplot,fig=TRUE,include=FALSE---------------------------------------
biplot(track.pc,xlabs=track[,9])


## ------------------------------------------------------------------------
mat=read.table("cov.txt",header=F)
mat


## ----pc-cov,fig=TRUE,include=FALSE---------------------------------------
matmat=as.matrix(mat)
matmat
class(mat)
class(matmat)
mat.pc=princomp(covmat=matmat)
plot(mat.pc,type="l")

#plot(mat.pc$sdev^2,type="b")


## ------------------------------------------------------------------------
mat

## ------------------------------------------------------------------------
mat.pc$loadings


### change correlation matrix

matmat

# make V2 less correlated with others

matmat[2,1]=0.2
matmat[1,2]=0.2
matmat[2,3]=-0.1
matmat[3,2]=-0.1
matmat

mat.pc=princomp(covmat=matmat)
plot(mat.pc,type="l")
mat.pc
mat.pc$loadings
summary(mat.pc)
