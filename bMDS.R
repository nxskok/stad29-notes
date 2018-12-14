### R code from vignette source '/home/ken/teaching/d29/notes/bMDS.Rnw'

###################################################
### code chunk number 1: bMDS.Rnw:31-35
###################################################
europe=read.csv("europe.csv",header=T)
europe
europe.d=as.dist(europe[,-1])
europe.scale=cmdscale(europe.d)
europe.scale
cities=as.character(europe[,1])

library(MASS)
europe.sh=Shepard(europe.d,europe.scale)
plot(europe.sh)
abline(a=0,b=1)

###################################################
### code chunk number 2: piaacenza
###################################################
plot(europe.scale)


###################################################
### code chunk number 3: udinese
###################################################
plot(europe.scale)
text(europe.scale,cities,pos=4)

#### RGL
europe.scale
library(rgl)
es.2=cbind(europe.scale,1)
plot3d(es.2,zlim=c(-1000,1000))
text3d(es.2,text=cities)




###################################################
### code chunk number 4: ontario
###################################################
ontario=read.csv("ontario-road-distances.csv",header=T)
ontario
ontario.d=as.dist(ontario)
ontario.scale=cmdscale(ontario.d)


###################################################
### code chunk number 5: atalanta (eval = FALSE)
###################################################
## plot(ontario.scale)
## cities=colnames(ontario)
## text(ontario.scale,cities,pos=4)


###################################################
### code chunk number 6: flimby
###################################################
plot(ontario.scale)
cities=colnames(ontario)
text(ontario.scale,cities,pos=4)


###################################################
### code chunk number 7: bMDS.Rnw:128-133
###################################################
cities
ontario2=ontario[c(-17,-19),c(-17,-19)]
cities=colnames(ontario2)
ontario2.d=as.dist(ontario2)
ontario2.scale=cmdscale(ontario2.d)


###################################################
### code chunk number 8: plot-two (eval = FALSE)
###################################################
## plot(ontario2.scale,xlim=c(-400,500))
## text(ontario2.scale,cities,pos=4)


###################################################
### code chunk number 9: bMDS.Rnw:149-151
###################################################
plot(ontario2.scale,xlim=c(-400,500))
text(ontario2.scale,cities,pos=4)


###################################################
### code chunk number 10: zoom (eval = FALSE)
###################################################
## plot(ontario2.scale,xlim=c(-200,0),ylim=c(-50,0))
## text(ontario2.scale,cities,pos=4)


###################################################
### code chunk number 11: spal
###################################################
plot(ontario2.scale,xlim=c(-200,0),ylim=c(-50,0))
text(ontario2.scale,cities,pos=4)

# Shepard

ontario2.sh=Shepard(ontario2.d,ontario2.scale)
plot(ontario2.sh)
View(ontario2.sh)

###################################################
### code chunk number 12: boxx
###################################################
ontario2.pred=dist(ontario2.scale)
residual=ontario2.d-ontario2.pred


###################################################
### code chunk number 13: bMDS.Rnw:198-199 (eval = FALSE)
###################################################
## boxplot(residual)


###################################################
### code chunk number 14: napoli
###################################################
boxplot(residual)


###################################################
### code chunk number 15: bMDS.Rnw:223-227
###################################################
options(width=55)
rm=as.matrix(residual)
big=rm>50
apply(big,1,sum)


###################################################
### code chunk number 16: bMDS.Rnw:244-248
###################################################
ontario2a=cmdscale(ontario2,eig=T)
names(ontario2a)
ontario2a$GOF
cmdscale(ontario2,3,eig=T)$GOF


###################################################
### code chunk number 17: bMDS.Rnw:266-267
###################################################
ontario.3=cmdscale(ontario2.d,3)
plot3d(ontario.3)
text3d(ontario.3,text=cities)

###################################################
### code chunk number 18: ont-proc
###################################################
library(shapes) 
ontario.ll=read.csv("ontario-ll.csv",header=F)
ll=cbind(ontario.ll[,5],ontario.ll[,4])
cities=as.character(ontario.ll[,1])
ontario.pro=procOPA(ll,ontario2.scale)


###################################################
### code chunk number 19: bMDS.Rnw:316-320 (eval = FALSE)
###################################################
## plot(ontario.pro$Ahat,col="red",xlim=c(-4,5),ylim=c(-2,3))
## text(ontario.pro$Ahat,cities,col="red",pos=4)
## points(ontario.pro$Bhat,col="blue")
## text(ontario.pro$Bhat,cities,col="blue",pos=4)


###################################################
### code chunk number 20: prosesto
###################################################
plot(ontario.pro$Ahat,col="red",xlim=c(-4,5),ylim=c(-2,3))
text(ontario.pro$Ahat,cities,col="red",pos=4)
points(ontario.pro$Bhat,col="blue")
text(ontario.pro$Bhat,cities,col="blue",pos=4)


###################################################
### code chunk number 21: bMDS.Rnw:354-355
###################################################
ontario.pro$R


###################################################
### code chunk number 22: f
###################################################
cube=read.table("cube.txt",header=T)
cube


###################################################
### code chunk number 23: cuby
###################################################
cube.d=as.dist(cube)
cube.d


###################################################
### code chunk number 24: bMDS.Rnw:406-407
###################################################
cube.2=cmdscale(cube.d,eig=T)


###################################################
### code chunk number 25: bMDS.Rnw:410-412 (eval = FALSE)
###################################################
## plot(cube.2$points,type="n")
## text(cube.2$points,colnames(cube))


###################################################
### code chunk number 26: bianconeri
###################################################
plot(cube.2$points,type="n")
text(cube.2$points,colnames(cube))


###################################################
### code chunk number 27: bMDS.Rnw:433-436
###################################################
cube.3=cmdscale(cube.d,3,eig=T)
cube.2$GOF
cube.3$GOF

library(rgl)
plot3d(cube.3$points)
text3d(cube.3$points,texts=colnames(cube))

v=data.frame(cube.3$points,names=colnames(cube))
v
lines3d(v[c(1,2),1:3])
lines3d(v[c(1,3),1:3])
lines3d(v[c(1,5),1:3])
lines3d(v[c(2,4),1:3])
lines3d(v[c(2,6),1:3])
lines3d(v[c(3,4),1:3])
lines3d(v[c(3,7),1:3])
lines3d(v[c(4,8),1:3])
lines3d(v[c(5,6),1:3])
lines3d(v[c(5,7),1:3])
lines3d(v[c(6,8),1:3])
lines3d(v[c(7,8),1:3])

###################################################
### code chunk number 28: bMDS.Rnw:466-468
###################################################
number.d=read.table("languages.txt",header=T)
number.d


###################################################
### code chunk number 29: bMDS.Rnw:484-488
###################################################
d=as.dist(number.d)
d
library(MASS)
number.nm=isoMDS(d)
names(number.nm)


###################################################
### code chunk number 30: lang-map
###################################################
number.nm$stress
number.nm$points
lang.names=colnames(number.d)


###################################################
### code chunk number 31: bMDS.Rnw:505-507 (eval = FALSE)
###################################################
## plot(number.nm$points,type="n")
## text(number.nm$points,lang.names)


###################################################
### code chunk number 32: padova
###################################################
lang.names
plot(number.nm$points,type="n")
text(number.nm$points,lang.names)


###################################################
### code chunk number 33: parma
###################################################
lang.sh=Shepard(d,number.nm$points)
plot(lang.sh)


###################################################
### code chunk number 34: bMDS.Rnw:570-572
###################################################
fitdist=dist(number.nm$points)
round(d-fitdist,1)


###################################################
### code chunk number 35: bMDS.Rnw:587-591
###################################################
cube=read.table("cube.txt",header=T)
cube.d=as.dist(cube)
isoMDS(cube.d,trace=F)$stress
isoMDS(cube.d,k=3,trace=F)$stress


