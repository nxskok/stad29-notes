cube=read.table("cube.txt",header=T)
cube
cube.d=as.dist(cube)
cube.d
cube.2=cmdscale(cube.d,eig=T)
cube.2$points
plot(cube.2$points,type="n")
text(cube.2$points,colnames(cube))
plot(cube.2$points,type="n")
text(cube.2$points,colnames(cube))
cube.3=cmdscale(cube.d,3,eig=T)
round(cube.3$points,1)
cube.2$GOF
cube.3$GOF
library(scatterplot3d)
scatterplot3d(cube.3$points,type="h")
pts=cube.3$points
pts
abcd=lm(pts[1:4,3]~pts[1:4,1]+pts[1:4,2])
abcd
s3d$plane3d(abcd)

install.packages("onion")
library(onion)
p3d(cube.3$points,d0=1)
install.packages("R.basic")
?plot3d

source("http://www.braju.com/R/hbLite.R")
hbLite()

library(R.basic)
?lines3d
pts
plot3d(pts)
lines3d(pts[c(1,2),],lty="dashed")
lines3d(pts[c(1,3),],lty="dashed")
lines3d(pts[c(4,2),],lty="dashed")
lines3d(pts[c(4,3),],lty="dashed")
lines3d(pts[c(5,6),],lty="dashed")
lines3d(pts[c(5,7),],lty="dashed")
lines3d(pts[c(6,8),],lty="dashed")
lines3d(pts[c(7,8),],lty="dashed")
lines3d(pts[c(1,5),],lty="dashed")
lines3d(pts[c(2,6),],lty="dashed")
lines3d(pts[c(3,7),],lty="dashed")
lines3d(pts[c(4,8),],lty="dashed")



lines3d(pts[1:2,])
lines3d(pts[1:3,])
lines3d(pts[3:4,])
lines3d(pts[c(1,4),])