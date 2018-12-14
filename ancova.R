prepost=read.table("ancova.txt",header=T)
prepost
attach(prepost)
diff=after-before
prepost.0=aov(diff~drug)
summary(prepost.0)

mycols=c("red","blue")
mych=c(1,3)
plot(before,after,col=mycols[drug],pch=mych[drug])
legend("topleft",levels(drug),col=mycols,pch=mych)
prepost.1=lm(after~before*drug)
summary(prepost.1)
anova(prepost.1)
prepost.new=expand.grid(before=c(5,15,25),drug=c("a","b"))
prepost.pred=predict(prepost.1,prepost.new)
prepost.pred
preds=data.frame(prepost.new,prepost.pred)
preds
library(ggplot2)
ggplot(prepost,aes(x=before,y=after,colour=drug,group=drug))+
  geom_point()+geom_line(data=preds,aes(x=before,y=prepost.pred))


prepost.1=lm(after~before*drug)
prepost.a=expand.grid(before=c(5,15,25),drug="a")
prepost.b=expand.grid(before=c(5,15,25),drug="b")
prepost.a.pred=predict(prepost.1,prepost.a)
prepost.b.pred=predict(prepost.1,prepost.b)
cbind(prepost.a,prepost.a.pred)
cbind(prepost.b,prepost.b.pred)

plot(before,after,col=mycols[drug],pch=mych[drug])
lines(prepost.a$before,prepost.a.pred,col="blue")
lines(prepost.b$before,prepost.b.pred,col="red")

prepost.a.pred=predict(prepost.2,prepost.a)
prepost.b.pred=predict(prepost.2,prepost.b)
cbind(prepost.a,prepost.a.pred)
cbind(prepost.b,prepost.b.pred)


prepost.1.pred=predict(prepost.1,prepost.new)
cbind(prepost.new,prepost.1.pred)
lines(prepost.new[1:3,"before"],prepost.1.pred[1:3],col=mycols[1])
lines(prepost.new[4:6,"before"],prepost.1.pred[4:6],col=mycols[2])

prepost.2=lm(after~before+drug)
anova(prepost.2,prepost.1)
prepost.3=lm(after~drug)
prepost.4=lm(after~before)
anova(prepost.3,prepost.2)
anova(prepost.4,prepost.2)
drop1(prepost.2,test="F")
drop1(prepost.1,test="F")

prepost.2.pred=predict(prepost.2,prepost.new)
cbind(prepost.new,prepost.2.pred)

plot(before,after,col=mycols[drug],pch=mych[drug])
legend("topleft",levels(drug),col=mycols,pch=mych)
lines(prepost.new[1:3,"before"],prepost.2.pred[1:3],col=mycols[1])
lines(prepost.new[4:6,"before"],prepost.2.pred[4:6],col=mycols[2])
summary(prepost.2)
