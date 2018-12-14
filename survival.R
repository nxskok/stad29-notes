library(survival)
dance=read.table("dancing.txt",header=T)
dance
attach(dance)
mth=Surv(Months,Quit)
mth
summary(Age)
dance.1=coxph(mth~Treatment+Age)
summary(dance.1)
dance.new=expand.grid(Treatment=c(0,1),Age=c(20,40))
dance.new
line.types=c("dashed","solid")
colours=c("red","blue")
draw.new=expand.grid(colour=colours,linetype=line.types,stringsAsFactors=F)
cbind(dance.new,draw.new)

s=survfit(dance.1,newdata=dance.new)
summary(s)
t(dance.new)
plot(s)
plot(s,col=draw.new$colour,lty=draw.new$linetype) # this is good
legend(x=10.5,y=1,legend=c(20,40),title="Age",lty=line.types)
legend(x=10.5,y=0.8,legend=0:1,title="Treatment",fill=colours)

draw.new$linetype

library(survival)
head(lung)
summary(lung)
attach(lung)
resp=Surv(time,status==2)
lung.1=coxph(resp~age+sex+ph.ecog+ph.karno+pat.karno+meal.cal+wt.loss)
summary(lung.1)
lung.2=coxph(resp~sex+ph.ecog+ph.karno+wt.loss)
summary(lung.2)
lung.3=coxph(resp~sex+ph.ecog)
summary(lung.3)
summary(ph.ecog)
table(ph.ecog)
lung.new=expand.grid(sex=c(1,2),ph.ecog=0:3)
s=survfit(lung.3,newdata=lung.new)
plot(s)
# make a plot like before

lung.new=expand.grid(sex=c(1,2),ph.ecog=0:3)
colours=c("blue","red","green","black")
line.types=c("solid","dashed")
plot.new=expand.grid(lty=line.types,col=colours,stringsAsFactors=F)
cbind(lung.new,plot.new)
plot(s,col=plot.new$col,lty=plot.new$lty,log=T)
plot(s,col=plot.new$col,lty=plot.new$lty)
# legend("topright"),legend=1:2,lty=line.types,title="Sex")
legend(x=900,y=0.8,legend=0:3,fill=colours,title="ph.ecog")
legend(x=900,y=1,legend=1:2,lty=line.types,title="Sex")
