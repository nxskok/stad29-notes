brandpref=read.csv("mlogit.csv",header=T)
head(brandpref)
brandpref$sex=factor(brandpref$sex)
brandpref$brand=factor(brandpref$brand)
library(nnet)
brands.both=multinom(brand~age+sex,data=brandpref)
brands.age=multinom(brand~age,data=brandpref)
brands.sex=multinom(brand~sex,data=brandpref)
anova(brands.age,brands.both)
anova(brands.sex,brands.both)
new=expand.grid(age=c(24,28,32,35,38),sex=factor(0:1))
new
p=predict(brands.both,new,type="probs")
p
cbind(new,p)
plot(new$age,p[,1],type="n",xlab="age",
     ylab="predicted probability")
new$sex
mycol=ifelse(new$sex==1,"red","blue")
mycol

for (i in 1:3)
{
  text(new$age,p[,i],i,col=mycol)
}
legend("topright",legend=levels(new$sex),
       fill=c("blue","red"))

attach(brandpref)
tb=table(brand,age,sex)
tb
b=as.data.frame(tb)
b[21:30,]
detach(brandpref)
b$sex=factor(b$sex)
b$brand=factor(b$brand)
b.both=multinom(brand~age+sex,data=b,weights=Freq)
b.age=multinom(brand~age,data=b,weights=Freq)
anova(b.age,b.both)


# survival

library(survival)
dance=read.table("dancing.txt",header=T)
attach(dance)
mth=Surv(Months,Quit)
mth
dance.1=coxph(mth~Treatment+Age)

summary(dance.1)
  dance.new=expand.grid(Treatment=c(0,1),Age=c(20,40))
dance.new
  s=survfit(dance.1,newdata=dance.new)
   summary(s)
 t(dance.new)
  plot(s)
  line.types=c("dashed","solid")
colours=c("red","blue")
dance.new=expand.grid(Treatment=c(0,1),Age=c(20,40))
draw.new=expand.grid(colour=colours,
                     linetype=line.types,stringsAsFactors=F)
cbind(dance.new,draw.new)
  plot(s,col=draw.new$colour,lty=draw.new$linetype) 
legend(x=10.5,y=1,legend=c(20,40),title="Age",
       lty=line.types)
legend(x=10.5,y=0.8,legend=0:1,title="Treatment",
       fill=colours)
  plot(s,col=draw.new$colour,lty=draw.new$linetype) 
legend(x=10.5,y=1,legend=c(20,40),title="Age",
       lty=line.types)
legend(x=10.5,y=0.8,legend=0:1,title="Treatment",
       fill=colours)


head(lung)
 attach(lung)
 resp=Surv(time,status==2)
 lung.1=coxph(resp~age+sex+ph.ecog+ph.karno+pat.karno+
                meal.cal+wt.loss)
   #names(summary(lung.1))
   summary(lung.1)

s=summary(lung.1)
rbind(s$logtest,s$waldtest,s$sctest)
   s$coefficients
   lung.2=coxph(resp~sex+ph.ecog+ph.karno+wt.loss)
 summary(lung.2)$coefficients
   lung.3=coxph(resp~sex+ph.ecog)
 summary(lung.3)$coefficients
   lung.new=expand.grid(sex=c(1,2),ph.ecog=0:3)
 colours=c("blue","red","green","black")
 line.types=c("solid","dashed")
 plot.new=expand.grid(lty=line.types,col=colours,stringsAsFactors=F)
 cbind(lung.new,plot.new)
 s=survfit(lung.3,newdata=lung.new)
  plot(s,col=plot.new$col,lty=plot.new$lty)
legend(x=900,y=0.8,legend=0:3,fill=colours,
       title="ph.ecog")
legend(x=900,y=1,legend=1:2,lty=line.types,
       title="Sex")
  plot(s,col=plot.new$col,lty=plot.new$lty)
legend(x=900,y=0.8,legend=0:3,fill=colours,
       title="ph.ecog")
legend(x=900,y=1,legend=1:2,lty=line.types,
       title="Sex")
