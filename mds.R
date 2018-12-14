europe=read.csv("europe.csv",header=T)
europe.d=as.dist(europe[,-1])
europe.d
?cmdscale
europe.scale=cmdscale(europe.d)
plot(europe.scale,xlim=c(-1500,3000))
cities=as.character(europe[,1])
text(europe.scale,cities,pos=4)

# cube

cube=read.table("cube.txt",header=T)
cube
cube.d=as.dist(cube)
cube.d

cube.2=cmdscale(cube.d,eig=T)
cube.2$GOF
plot(cube.2$points)

cube.3=cmdscale(cube.d,3,eig=T)
cube.3$GOF
persp(cube.3$points)
round(cube.3$points,3)


# ontario road distances




ontario=read.csv("ontario-road-distances.csv",header=T)
ontario
ontario.d=dist(ontario)
ontario.scale=cmdscale(ontario.d)
plot(ontario.scale)
cities=colnames(ontario)
text(ontario.scale,cities,pos=4)

plot(ontario.scale,xlim=c(-700,500))
text(ontario.scale,cities,pos=4)

plot(ontario.scale,xlim=c(-750,-150),ylim=c(0,600))
text(ontario.scale,cities,pos=4)

# idea: remove SaultSteMarie and ThunderBay (#17 and #19)

cities

ontario
ontario2=ontario[c(-17,-19),c(-17,-19)]
cities=colnames(ontario2)
cities
ontario2.d=as.dist(ontario2)
ontario2.scale=cmdscale(ontario2.d)
plot(ontario2.scale)
text(ontario2.scale,cities,pos=4)

eqscplot(ontario2.scale) # in MASS
text(ontario2.scale,cities,pos=4)

plot(ontario2.scale,xlim=c(-150,0),ylim=c(-50,0))
text(ontario2.scale,cities,pos=4)

ontario2.pred=dist(ontario2.scale)
residual=ontario2.d-ontario2.pred
residual
sort(residual)
boxplot(residual)
rm=as.matrix(residual)
big=rm>50
apply(big,1,sum)
big

ontario.2a=cmdscale(ontario2.d,eig=T)
ontario.3=cmdscale(ontario2.d,3,eig=T)
ontario.3$points

library(MASS)

europe.nm=isoMDS(europe.d)
europe.nm
plot(europe.nm$points)
text(europe.nm$points,cities,pos=4)
?options
lang
ls(pattern="lang*")
options()
options(width=50)
lang.init

?cmdscale
# languages data

number.d
d=as.dist(number.d)
number.nm=isoMDS(d)
names(number.nm)
number.nm$stress
str(number.nm)
plot(number.nm$points,type="n")
lang.names=colnames(number.d)
text(number.nm$points,lang.names)

library(MASS)
?isoMDS

dist(number.nm$points)
d
residuals=d-dist(number.nm$points)
residuals
boxplot(residuals)
as.matrix(residuals)<(-1)
summary(residuals)
number.sh=Shepard(d,number.nm$points)
plot(number.sh$x,number.sh$y)
resid=number.sh$x-number.sh$y
summary(resid)
boxplot(resid)

# or try it without Shepard

names(number.nm)
fitdist=dist(number.nm$points)
fitdist
d
d-fitdist

# go back to Ontario distances

ontario2.d
ontario.nm=isoMDS(ontario2.d)
ontario.nm
plot(ontario.nm$points)
cities=colnames(ontario2)
text(ontario.nm$points,cities,pos=4)
ontario.sh=Shepard(ontario2.d,ontario.nm$points)
ontario.sh
resid=ontario.sh$x-ontario.sh$y
summary(resid)
boxplot(resid)

# and without Shepard

ontario2.d # observed
ontario2.p=dist(ontario.nm$points)
ontario2.p
resid=ontario2.d-ontario2.p
resid.m=as.matrix(resid)
resid.m
apply(resid.m>100,1,sum)

plot(ontario.nm$points)
text(ontario.nm$points,cities)

plot(ontario.nm$points,xlim=c(-200,0),ylim=c(-50,0))
text(ontario.nm$points,cities)

# 3 dimensions

?isoMDS
ontario.nm3=isoMDS(ontario2.d,k=3)
ontario.nm3$points

# cube

cube=read.table("cube.txt",header=T)

cube
cube.d=as.dist(cube)
cube.d
cube.nm=isoMDS(cube.d)
cube.nm3=isoMDS(cube.d,k=3)

# procrustes

library(shapes)
gen2.mat=as.matrix(gen2[,-1])
proc=procOPA(gen2.mat,gen.mds)
plot(proc$Ahat,col="red")
text(proc$Ahat,subp,col="red",pos=4)
points(proc$Bhat,col="blue")
text(proc$Bhat,subp,col="blue",pos=4)
proc$Bhat

ontario2.scale # map points
ontario.ll=read.csv("ontario-ll.csv",header=F)
ontario.ll
ll=cbind(ontario.ll[,5],ontario.ll[,4])
cities=as.character(ontario.ll[,1])
cities
ontario.pro=procOPA(ll,ontario2.scale)
ontario.pro
plot(ontario.pro$Ahat,col="red",xlim=c(-3,5))
text(ontario.pro$Ahat,cities,col="red",pos=4)
points(ontario.pro$Bhat,col="blue")
text(ontario.pro$Bhat,cities,col="blue",pos=4)

ontario.pro$R


# europe also

europe[,1]
europe.ll=read.csv("europe-ll.csv",header=T)
europe.ll
cities=as.character(europe.ll[,1])
ll=cbind(europe.ll[,3],europe.ll[,2])
library(shapes)

europe.proc=procOPA(ll,europe.scale)
plot(europe.proc$Ahat,col="red")
text(europe.proc$Ahat,cities,col="red",pos=4)
points(europe.proc$Bhat,col="blue")
text(europe.proc$Bhat,cities,col="blue",pos=4)

europe.proc$Bhat

plot(europe.proc$Ahat,col="red",xlim=c(-15,20),ylim=c(-10,10))
text(europe.proc$Ahat,cities,col="red",pos=4)
points(europe.proc$Bhat,col="blue")
text(europe.proc$Bhat,cities,col="blue",pos=4)

europe.proc$R

plot(ll)
text(ll,cities,pos=4)