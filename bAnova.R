## ------------------------------------------------------------------------
hairpain=read.table("hairpain.txt",header=T)
str(hairpain)
## ------------------------------------------------------------------------
aggregate(pain~hair,hairpain,mean)

## ------------------------------------------------------------------------
library(dplyr)
suppressMessages(library(dplyr)) 
hairpain %>% group_by(hair) %>%
  summarize( n=n(),
             xbar=mean(pain),
      	     s=sd(pain))

## ----tartuffo,fig.height=5-----------------------------------------------
boxplot(pain~hair,data=hairpain)

## ------------------------------------------------------------------------
bartlett.test(pain~hair,data=hairpain)
?bartlett.test
## ------------------------------------------------------------------------
hairpain.1=aov(pain~hair,data=hairpain)
summary(hairpain.1)

## ------------------------------------------------------------------------
TukeyHSD(hairpain.1)

## ------------------------------------------------------------------------
attach(hairpain)
pairwise.t.test(pain,hair,p.adj="none")
pairwise.t.test(pain,hair,p.adj="holm")

## ------------------------------------------------------------------------
pairwise.t.test(pain,hair,p.adj="fdr")
pairwise.t.test(pain,hair,p.adj="bon")

## ------------------------------------------------------------------------
vitaminb=read.table("vitaminb.txt",header=T)
str(vitaminb)
with(vitaminb,
table(ratsize,diet)
)
aggregate(kidneyweight~ratsize+diet,vitaminb,mean)
boxplot(kidneyweight~ratsize+diet,vitaminb)
## ------------------------------------------------------------------------
vitaminb.1=aov(kidneyweight~ratsize*diet,data=vitaminb)
summary(vitaminb.1)
drop1(vitaminb.1,test="F")
vitamin2=update(vitaminb.1,.~.-ratsize:diet)
summary(vitamin2)
drop1(vitamin2,test="F")
## ----udinese,fig.height=5------------------------------------------------
attach(vitaminb)
interaction.plot(ratsize,diet,kidneyweight)
detach(vitaminb)

## ------------------------------------------------------------------------
vitaminb.2=aov(kidneyweight~ratsize+diet,data=vitaminb)
summary(vitaminb.2)

## ------------------------------------------------------------------------
autonoise=read.table("autonoise.txt",header=T)
str(autonoise)

## ----chippenham,fig.height=5---------------------------------------------
boxplot(noise~type+size,data=autonoise,ylab="Noise")
autonoise %>% group_by(type,size) %>% 
  summarize( n=n(),xbar=mean(noise),s=sd(noise))

## ------------------------------------------------------------------------
autonoise.1=aov(noise~size*type,data=autonoise)
summary(autonoise.1)

## ------------------------------------------------------------------------
autonoise.2=TukeyHSD(autonoise.1)
autonoise.2$`size:type`

## ----st-erth,fig.height=4------------------------------------------------
attach(autonoise)
interaction.plot(size,type,noise)
detach(autonoise)

## ------------------------------------------------------------------------
suppressMessages(library(dplyr))
autonoise %>% filter(size=="S") %>% 
  aov(noise~type,data=.) %>% 
  summary()

## ------------------------------------------------------------------------
autonoise %>% filter(size=="M") %>%
  aov(noise~type,data=.) %>% summary()

## ------------------------------------------------------------------------
autonoise %>% filter(size=="M") %>%
  group_by(type) %>% summarize(m=mean(noise))

## ------------------------------------------------------------------------
autonoise %>% filter(size=="L") %>%
  aov(noise~type,data=.) %>% summary()

## ------------------------------------------------------------------------
p.values=c(8.49e-6,0.428,0.476)
p.values[1]*3 ; p.values[2]*2 ; p.values[3]*1

## ------------------------------------------------------------------------
autonoise %>% filter(size=="S") %>%
  t.test(noise~type,data=.) %>% .[["conf.int"]]

## ------------------------------------------------------------------------
autonoise %>% filter(size=="M") %>%
  t.test(noise~type,data=.) %>% .[["conf.int"]]

## ------------------------------------------------------------------------
autonoise %>% filter(size=="L") %>%
  t.test(noise~type,data=.) %>% .[["conf.int"]]

## ------------------------------------------------------------------------
c.home=c(1,0,0,-1)
sum(c.home)
## ------------------------------------------------------------------------
c.home
c.industrial=c(0,1,-1,0)
c.industrial
c.home*c.industrial
## ------------------------------------------------------------------------
c.home.ind=c(0.5,-0.5,-0.5,0.5)
c.home.ind
c.home
c.home*c.home.ind
## ------------------------------------------------------------------------
c.home*c.industrial
c.home*c.home.ind
c.industrial*c.home.ind

## ------------------------------------------------------------------------
c1=c(1,-1,0)
c1
c2=c(0,1,-1)
c2
c1*c2

## ------------------------------------------------------------------------
chain.wide=read.table("chainsaw.txt",header=T)
chain.wide

## ------------------------------------------------------------------------
library(tidyr)
chain=gather(chain.wide,model,kickback,A:D,
  factor_key=T)

## ------------------------------------------------------------------------
chain[1:10,]

## ------------------------------------------------------------------------
chain[11:20,]

## ------------------------------------------------------------------------
attach(chain)
m=cbind(c.home,c.industrial,c.home.ind)
m
contrasts(model)=m
?contrasts
contrasts(model)=contr.treatment
## ------------------------------------------------------------------------
chain.1=lm(kickback~model)
summary(chain.1)

## ------------------------------------------------------------------------
aggregate(kickback~model,chain,mean)

