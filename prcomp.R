# test12

test12=read.table("test12.txt",header=T,as.is=3)
attach(test12)
plot(first,second)
text(first,second,id,pos=4)

cor(first,second)

test12.pc=princomp(test12[,1:2],cor=T)
test12.pc
plot(test12.pc)
plot(test12.pc$sdev^2,type="b")

test12.pc$loadings
test12.pc$scores
plot(test12.pc$scores)
text(test12.pc$scores,id,pos=4)
data.frame(test12,scores=test12.pc$scores)
library(MASS)
eqscplot(test12.pc$scores,type="n")
text(test12.pc$scores,id)
biplot(test12.pc,xlabs=id)
 summary(test12.pc)
detach(test12)

?princomp

track=read.table("men_track_field.txt",header=T)
head(track)
dim(track)
track[c(1:8,52:55),]
track.pc=princomp(track[,1:8],cor=T)
summary(track.pc)
plot(track.pc)
plot(track.pc$sdev^2,type="b")
track.pc$loadings
summary(track.pc)
str(track.pc)
plot(track.pc)
biplot(track.pc,xlabs=track[,9])
track.pc$scores
plot(track.pc$scores[,1:2],type="n")
track[,9]
text(track.pc$scores[,1:2],as.character(track[,9]))

# look at good

plot(track.pc$scores[,1:2],type="n",xlim=c(-1,4))
text(track.pc$scores[,1:2],as.character(track[,9]))

# prcomp works, but I don't like it as much

cc=cor(track[,1:8])
cc
print.default(cc)
cov.wt(track[,1:8],cor=T)

# from correlation matrix

mat=read.table("cov.txt",header=F)

mat.pc=princomp(covmat=as.matrix(mat))
mat.pc
plot(mat.pc$sdev^2,type="b")
summary(mat.pc)
mat.pc$loadings

# factor analysis

rex=read.table("rex2.txt",header=T)


bem=read.table("factor.txt",header=T)
head(bem)
bem[1:10,1:9]
round(cor(bem),2)
bem.pc=princomp(bem[,-1],cor=T)
bem.pc
plot(bem.pc)
summary(bem.pc)
plot(bem.pc$sdev^2,type="b")
plot(bem.pc$sdev^2,type="b",xlim=c(0,10))
summary(bem.pc)
names(bem.pc)

biplot(bem.pc)
biplot(bem.pc,cex=c(0.25,0.5))
?biplot

bem.2=factanal(bem[,-1],factors=2)
bem.2
sort(bem.2$uniquenesses)
min(bem.2$uniquenesses)
bem.2$loadings
print.default(bem.2$loadings)
bem.2$loadings[,1]
hist(bem.2$loadings[,1])
hist(bem.2$loadings[,2])
big=abs(bem.2$loadings[,1])>0.4
bem.2$loadings[big,1]
names(bem.2)
bem.2$PVAL

bem.2a=factanal(bem[,-1],factors=2,scores="r")
biplot(bem.2a$scores,bem.2a$loadings,cex=c(0.75,0.5))
max1=which.max(bem.2a$scores[,1])
max1

want=c(311,214,359,258)
big1=abs(bem.2$loadings[,1])>0.4
big1
big2=abs(bem.2$loadings[,2])>0.4
big2
names(bem)
bem[want,big1]
bem[want,big2]

bem[214,]
dim(bem)
bem[,1]
bem.15=factanal(bem,factors=15)
bem.15$PVAL
bem.15
bem.15$loadings
\begin{frame}[fragile]{
  
  \end{frame}
  for (i in 1:15)
{
  v=sort(bem.15$loadings[,i])
  mylist[[i]]=v
}

mylist


# correlation matrix. these data from Lattin et al.

kids=read.table("rex2.txt",header=T)
kids

# scree plot

km=as.matrix(kids)
kids.pc=princomp(covmat=km)
plot(kids.pc$sdev^2,type="b")
plot(kids.pc)
kids.pc$loadings
print.default(kids.pc$loadings)

kmat$cov=km
kmat$n.obs=145
kmat
kids.f1=factanal(factors=1,covmat=kmat)
kids.f2=factanal(factors=2,covmat=kmat)
kids.f1
kids.f2
kids.f2$uniquenesses
kids.f2$loadings
names(kids.f2)

print.default(kids.f2)

?factanal




# track data again

track=read.table("men_track_field.txt",header=T)
track.pc=princomp(track[,-9],cor=T)
biplot(track.pc)
track.pc$loadings

track.f=factanal(track[,-9],2)
track.f
track.f=factanal(track[,-9],2,scores="r")
track.f$scores
biplot(track.f$scores,track.f$loadings,xlabs=track[,9])
# shows rotation

# good sprinting countries, factor2<-1

good.sprint=track.f$scores[,2]<(-1)
track[good.sprint,9]

# good distance countries, factor1 < -1

good.distance=track.f$scores[,1]<(-0.8)
good.distance
track[good.distance,9]