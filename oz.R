oz=read.csv("oz-walkscore.csv",header=T)
oz
head(oz)

attach(oz)
plot(Walk.Score~Population,log="x")
lines(lowess(Walk.Score~Population),lty="dashed")
cor.test(Walk.Score,Population,method="k")
logpop=log(Population)
oz.lm=lm(Walk.Score~logpop)
summary(oz.lm)
plot(oz.lm)
quantile(Population)
mypop=c(10000,15000,20000,50000,200000,1000000,4000000)
mypred=data.frame(logpop=log(mypop))
oz.pred=predict(oz.lm,mypred)
oz.pred


?cor.test

?par