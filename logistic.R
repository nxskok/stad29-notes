rats=read.table("rat.txt",header=T)
rats
attach(rats)
rats.1=glm(status~dose,family="binomial")
summary(rats.1)
dose.new=data.frame(dose=seq(0.5,5.5,1))
dose.new
p=predict(rats.1,dose.new,type="response")
cbind(dose.new,p)
p

detach(rats)

rat2=read.table("rat2.txt",header=T)
rat2
attach(rat2)
response=cbind(lived,died)
rat2.1=glm(response~dose,family="binomial")
summary(rat2.1)
p=predict(rat2.1,type="response")
cbind(rat2,p)
survrate=lived/(lived+died)
survrate
plot(dose,survrate)
lines(dose,p)

detach(rat2)


sepsis=read.table("sepsis.txt",header=T)
head(sepsis)
attach(sepsis)
sepsis.1=glm(death~shock+malnut+alcohol+age+bowelinf,family="binomial")
summary(sepsis.1)
sepsis.2=glm(death~shock+alcohol+age+bowelinf,family="binomial")
summary(sepsis.2)

anova(sepsis.2,sepsis.1,test="Chi")

sepsis.new=expand.grid(shock=c(0,1),
                      alcohol=c(0,1),
                      age=c(25,50,75),
                      bowelinf=c(0,1))
sepsis.new
sepsis.new2=data.frame(shock=0,alcohol=1,bowelinf=0,age=48)                      
sepsis.new2
sepsis.pred2=predict(sepsis.2,sepsis.new2,type="response")
head(cbind(sepsis.new2,sepsis.pred2),n=2)
sepsis.pred=predict(sepsis.2,sepsis.new,type="response")
myrows=c(4,1,2,11,32)
cbind(sepsis[myrows,],p=sepsis.pred[myrows])

cc=exp(coef(sepsis.2)[-1])
format(cc,digits=3,scientific=F)

plot(sepsis$age,residuals(sepsis.2))

ex=c(5.8,15,21.5,27.5,33.5,39.5,46,51.5)
sl=c("None","Moderate","Severe")
sev=ordered(sl,levels=sl)
miners=expand.grid(severity=sev,exposure=ex)

# skip this bit

freq=scan("minersx.txt")
freq
miners=cbind(miners,freq)
head(miners,n=10)

# here is good

freqs=read.table("miners-tab.txt",header=T)
freqs

# reshape; don't need "melt" any more

miners.long=reshape(freqs,varying=c("None","Moderate","Severe"),v.names="Frequency",timevar="Severity",direction="long")
miners.long

total=apply(freqs[,-1],1,sum)
obsprop=freqs[,-1]/total
obsprop

total
obsprop

ex=freqs[,1] # exposures
sev=c("None","Moderate","Severe") # severities

plot(ex,obsprop[,1],type="n",xlab="Exposure",
     ylab="Observed proportion", ylim=c(0,1))
lines(ex,obsprop[,1],type="b",col=1,pch=1)
lines(ex,obsprop[,2],type="b",col=2,pch=2)
lines(ex,obsprop[,3],type="b",col=3,pch=3)
legend("topright",sev,col=1:3,pch=1:3)

# get one obs per line

library(reshape)
?melt

freqs
as.data.frame(freqs)
miners=melt(freqs,1,2:4,"severity")
head(miners,n=10)

library(MASS)
miners.lr=polr(severity~Exposure,weights=value,data=miners)
miners.new=data.frame(Exposure=ex)
p1=predict(miners.lr,miners.new)
data.frame(ex,p1)
p=predict(miners.lr,miners.new,type="p")
cbind(miners.new,p)

miners.0=polr(severity~1,weights=value,data=miners)
anova(miners.0,miners.lr)

plot(ex,obsprop[,1],type="n",ylim=c(0,1),xlab="Exposure",ylab="Probability")
points(ex,obsprop[,1],col=1,pch="x")
points(ex,obsprop[,2],col=2,pch=2)
points(ex,obsprop[,3],col=3,pch=3)
lines(ex,p[,1],col=1,lty="solid")
lines(ex,p[,2],col=2,lty="dashed")
lines(ex,p[,3],col="blue,lty="dotted")
legend("topright",sev,col=1:3,pch=1:3)



brandpref=read.csv("mlogit.csv")
head(brandpref)
brandpref$sex=factor(brandpref$sex)
brandpref$brand=factor(brandpref$brand)
library(nnet)
brands.both=multinom(brand~age+sex,data=brandpref)
brands.0=multinom(brand~1,data=brandpref)
anova(brands.0,brands.both)
brands.age=multinom(brand~age,data=brandpref)
brands.sex=multinom(brand~sex,data=brandpref)
anova(brands.age,brands.both)
anova(brands.sex,brands.both)


new=expand.grid(age=c(24,28,32,35,38),sex=factor(0:1))
p=predict(brands.both,new,type="probs")
cbind(new,p)


plot(new$age,p[,1],type="n",xlab="age",ylab="predicted probability")
mycol=ifelse(new$sex==1,"red","blue")
for (i in 1:3)
{
  text(new$age,p[,i],i,col=mycol)
}
legend("topright",legend=levels(new$sex),fill=c("blue","red"))

dim(brandpref)
attach(brandpref)
b=aggregate(brandpref,list(brand,age,sex),length)
detach(brandpref)
head(b)

dimnames(b)[[2]]=c("brand","age","sex","freq","junk1","junk2")

b$sex=factor(b$sex)
b$brand=factor(b$brand)
b.both=multinom(brand~age+sex,data=b,weights=freq)
b.age=multinom(brand~age,data=b,weights=freq)
anova(b.age,b.both)

