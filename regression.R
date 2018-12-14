sleep=read.table("sleep.txt",header=T)
sleep
attach(sleep)
plot(age,atst)
cor(age,atst)
sleep.1=lm(atst~age)
summary(sleep.1)
ages.new=data.frame(age=c(10,3))
ages.new
pc=predict(sleep.1,ages.new,interval="c")
pp=predict(sleep.1,ages.new,interval="p")
cbind(ages.new,pp)

plot(sleep.1)

detach(sleep)

curvy=read.table("curvy.txt",header=T)
head(curvy)
attach(curvy)
plot(xx,yy)
curvy.1=lm(yy~xx)
summary(curvy.1)
plot(curvy.1)


xxsq=xx^2
curvy.2=lm(yy~xx+xxsq)
summary(curvy.2)

plot(xx,yy)
fitted.values(curvy.1)
fitted.values(curvy.2)
lines(xx,fitted.values(curvy.2))


plot(curvy.2)


detach(curvy)

visits=read.table("regressx.txt",header=T)
head(visits)
attach(visits)
visits.1=lm(timedrs~phyheal+menheal+stress)
summary(visits.1)

visits.2=lm(timedrs~menheal)
summary(visits.2)

plot(visits.1)

lgtime=log(timedrs+1)

visits.3=lm(lgtime~phyheal+menheal+stress)
plot(visits.3)
summary(visits.3)
detach(visits)
plot(menheal,residuals(visits.3))
visits.4=lm(lgtime~phyheal+stress)
summary(visits.4)
summary(visits.3)

tp=timedrs+1
library(MASS)
boxcox(tp~phyheal+menheal+stress)
boxcox(tp~phyheal+menheal+stress,lambda=seq(-0.3,0.1,0.01))

visits.5=lm(lgtime~phyheal+menheal+stress)
visits.6=lm(lgtime~stress)
anova(visits.6,visits.5)
detach(visits)

punting=read.table("punting.txt",header=T)
punting
attach(punting)
head(punting)
punting.1=lm(punt~left+right+fred)
summary(punting.1)
cor(punting)
punting.2a=lm(left~right+fred)
punting.2b=lm(right~left+fred)
punting.2c=lm(fred~right+left)

summary(punting.2a)$r.squared
summary(punting.2b)$r.squared
summary(punting.2c)$r.squared

punting.2=lm(punt~right)
anova(punting.2,punting.1)

summary(punting.1)$r.squared
summary(punting.2)$r.squared


