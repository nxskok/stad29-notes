jumping=read.table("jumping.txt",header=T)
head(jumping)
attach(jumping)
tapply(density,group,mean)
tapply(density,group,sd)
jumping.1=aov(density~group)
summary(jumping.1)
jumping.t=TukeyHSD(jumping.1)
jumping.t
plot(jumping.t)
pairwise.t.test(density,group,p.adj="bon")
pairwise.t.test(density,group,p.adj="holm")
pairwise.t.test(density,group,p.adj="fdr")
pairwise.t.test(density,group,p.adj="none")


scaffold=read.table("scaffold.txt",header=T)
scaffold[c(1:7,51:54),]
detach(scaffold)
attach(scaffold)
days=factor(days)
scaffold.1=aov(gpi~material*days)
summary(scaffold.1)
interaction.plot(days,material,gpi)
tapply(gpi,list(days,material),mean)
scaffold.t=TukeyHSD(scaffold.1)
scaffold.t
plot(scaffold.t)

detach(scaffold)
rows=grep("ecm",scaffold$material)
rows
ecms=scaffold[rows,]
tail(ecms)
attach(ecms)

ecms.1=aov(gpi~material*days)
summary(ecms.1)
ecms.2=aov(gpi~material)
summary(ecms.2)
interaction.plot(days,material,gpi)
ecms.2.t=TukeyHSD(ecms.2)
ecms.2.t
plot(ecms.2.t)

pvals=c(0.005,0.015,0.03,0.06)
p.adjust(pvals,method="none")
p.adjust(pvals,method="bon")
p.adjust(pvals,method="holm")
p.adjust(pvals,method="fdr")

# ancova data

prepost=read.table("ancova.txt",header=T)
head(prepost)
attach(prepost)
diff=after-before
prepost.0=aov(diff~drug)
summary(prepost.0)
mycols=c("blue","red")
mych=c(1,3)
plot(before,after,col=mycols[drug],pch=mych[drug])
legend("topleft",levels(drug),col=mycols,pch=mych)

tapply(before,drug,mean)
tapply(after,drug,mean)


prepost.1=lm(after~before*drug)
anova(prepost.1)

prepost.a=expand.grid(before=c(5,15,25),drug="a")
prepost.b=expand.grid(before=c(5,15,25),drug="b")
prepost.a.pred=predict(prepost.1,prepost.a)
prepost.b.pred=predict(prepost.1,prepost.b)
cbind(prepost.a,prepost.a.pred)
cbind(prepost.b,prepost.b.pred)
plot(before,after,col=mycols[drug],pch=mych[drug])
legend("topleft",levels(drug),col=mycols,pch=mych)
lines(prepost.a$before,prepost.a.pred,col="blue")
lines(prepost.b$before,prepost.b.pred,col="red")
summary(prepost.1)
prepost.2=lm(after~before+drug)
anova(prepost.2)
prepost.a.pred=predict(prepost.2,prepost.a)
prepost.b.pred=predict(prepost.2,prepost.b)
cbind(prepost.a,prepost.a.pred)
cbind(prepost.b,prepost.b.pred)
plot(before,after,col=mycols[drug],pch=mych[drug])
legend("topleft",levels(drug),col=mycols,pch=mych)
lines(prepost.a$before,prepost.a.pred,col="blue")
lines(prepost.b$before,prepost.b.pred,col="red")
drop1(prepost.2,test="F")

# latin square

# boxplot 
plot(y~f1+f2+f3) 
# from http://statistic-on-air.blogspot.ca/2010/01/latin-squares-design-in-r.html

install.packages

# 3 factors

