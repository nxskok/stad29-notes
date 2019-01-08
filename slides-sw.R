## ----outline,child="bOutline.Rnw"----------------------------------------



## ----Regression, child="bRegression.Rnw"---------------------------------

## ------------------------------------------------------------------------
library(MASS) # for Box-Cox, later
library(tidyverse)
library(broom)

## ------------------------------------------------------------------------
my_url="http://www.utsc.utoronto.ca/~butler/d29/sleep.txt"
sleep=read_delim(my_url," ")

## ----size="footnotesize"-------------------------------------------------
sleep

## ----suggo, fig.height=4-------------------------------------------------
ggplot(sleep,aes(x=age,y=atst))+geom_point()

## ------------------------------------------------------------------------
with(sleep,cor(atst,age))

## ------------------------------------------------------------------------
cor(sleep)

## ----icko,fig.height=3---------------------------------------------------
ggplot(sleep,aes(x=age,y=atst))+geom_point()+
  geom_smooth()

## ----echo=-1-------------------------------------------------------------
options(width=60)
sleep.1=lm(atst~age,data=sleep) ; summary(sleep.1)

## ----size="footnotesize"-------------------------------------------------
tidy(sleep.1)
glance(sleep.1)

## ----size="footnotesize",warning=F---------------------------------------
sleep.1 %>% augment(sleep) %>% slice(1:8)

## ------------------------------------------------------------------------
my.age=c(10,5)
ages.new=tibble(age=my.age)
ages.new

## ------------------------------------------------------------------------
pc=predict(sleep.1,ages.new,interval="c")
pp=predict(sleep.1,ages.new,interval="p")

## ------------------------------------------------------------------------
cbind(ages.new,pc)

## ------------------------------------------------------------------------
cbind(ages.new,pp)

## ----fig.height=2.8------------------------------------------------------
ggplot(sleep,aes(x=age,y=atst))+geom_point()+
  geom_smooth(method="lm")+
  scale_y_continuous(breaks=seq(420,600,20)) 

## ----akjhkadjfhjahnkkk,fig.height=3.5------------------------------------
ggplot(sleep.1,aes(x=.fitted,y=.resid))+geom_point()

## ----curvy---------------------------------------------------------------
my_url="http://www.utsc.utoronto.ca/~butler/d29/curvy.txt"
curvy=read_delim(my_url," ")

## ----fig.height=4--------------------------------------------------------
ggplot(curvy,aes(x=xx,y=yy))+geom_point()

## ------------------------------------------------------------------------
curvy.1=lm(yy~xx,data=curvy) ; summary(curvy.1)

## ----altoadige,fig.height=4----------------------------------------------
ggplot(curvy.1,aes(x=.fitted,y=.resid))+geom_point()

## ------------------------------------------------------------------------
curvy.2=lm(yy~xx+I(xx^2),data=curvy)

## ------------------------------------------------------------------------
curvy.2a=update(curvy.1,.~.+I(xx^2))

## ------------------------------------------------------------------------
summary(curvy.2)

## ----size="small", fig.height=3------------------------------------------
ggplot(curvy.2,aes(x=.fitted,y=.resid))+geom_point()

## ----message=F-----------------------------------------------------------
my_url="http://www.utsc.utoronto.ca/~butler/d29/madeup.csv"
madeup=read_csv(my_url)
madeup

## ----dsljhsdjlhf,fig.height=2.75-----------------------------------------
ggplot(madeup,aes(x=x,y=y))+geom_point()+
  geom_smooth()

## ----eval=F--------------------------------------------------------------
## boxcox(y~x,data=madeup)

## ----trento,echo=F, fig.height=4-----------------------------------------
boxcox(y~x,data=madeup)

## ----fig.height=2.8, size="footnotesize"---------------------------------
madeup %>% mutate(log_y=log(y)) %>% 
  ggplot(aes(x=x,y=log_y))+geom_point()+
  geom_smooth()

## ----size="footnotesize"-------------------------------------------------
madeup.1=lm(log(y)~x, data=madeup)
glance(madeup.1)
tidy(madeup.1)

## ------------------------------------------------------------------------
my_url="http://www.utsc.utoronto.ca/~butler/d29/regressx.txt"
visits=read_delim(my_url," ")

## ----size="small"--------------------------------------------------------
visits
visits.1=lm(timedrs~phyheal+menheal+stress,
  data=visits)

## ------------------------------------------------------------------------
summary(visits.1)

## ------------------------------------------------------------------------
tidy(visits.1)

## ------------------------------------------------------------------------
visits.2=lm(timedrs~menheal,data=visits) ; summary(visits.2)

## ------------------------------------------------------------------------
visits %>% select(-subjno) %>% cor()

## ----iffy8,fig.height=3,size="small"-------------------------------------
ggplot(visits.1,aes(x=.fitted,y=.resid))+geom_point()

## ----fig.height=3.5------------------------------------------------------
ggplot(visits.1, aes(sample=.resid))+stat_qq()+stat_qq_line()

## ----fig.height=2.5------------------------------------------------------
ggplot(visits.1,aes(x=.fitted,y=abs(.resid)))+
  geom_point()+geom_smooth()

## ------------------------------------------------------------------------
visits.3=lm(log(timedrs+1)~phyheal+menheal+stress, 
            data=visits)

## ------------------------------------------------------------------------
summary(visits.3)

## ----fig.height=3.5------------------------------------------------------
ggplot(visits.3,aes(x=.fitted,y=.resid))+
  geom_point()

## ----fig.height=4--------------------------------------------------------
ggplot(visits.3, aes(sample=.resid))+stat_qq()+stat_qq_line()

## ----fig.height=3--------------------------------------------------------
ggplot(visits.3,aes(x=.fitted,y=abs(.resid)))+
  geom_point()+geom_smooth()

## ----eval=F--------------------------------------------------------------
## boxcox(timedrs+1~phyheal+menheal+stress,data=visits)

## ----echo=F,fig.height=4.5-----------------------------------------------
visits %>% mutate(tp=timedrs+1) %>% 
  boxcox(timedrs+1~phyheal+menheal+stress,data=.)

## ----size="footnotesize"-------------------------------------------------
my.lambda=seq(-0.3,0.1,0.01)
my.lambda

## ----fig.height=3.5------------------------------------------------------
boxcox(timedrs+1~phyheal+menheal+stress,lambda=my.lambda,
  data=visits)

## ------------------------------------------------------------------------
visits.5=lm(log(timedrs+1)~phyheal+menheal+stress,data=visits)
visits.6=lm(log(timedrs+1)~stress,data=visits)
anova(visits.6,visits.5)

## ------------------------------------------------------------------------
my_url="http://www.utsc.utoronto.ca/~butler/d29/punting.txt"
punting=read_table(my_url)

## ----size="small"--------------------------------------------------------
punting

## ----size="footnotesize"-------------------------------------------------
punting.1=lm(punt~left+right+fred,data=punting)
summary(punting.1)

## ------------------------------------------------------------------------
cor(punting)

## ------------------------------------------------------------------------
punting.2=lm(punt~right,data=punting)
anova(punting.2,punting.1)

## ------------------------------------------------------------------------
summary(punting.1)$r.squared
summary(punting.2)$r.squared

## ------------------------------------------------------------------------
summary(punting.2)

## ----size="footnotesize"-------------------------------------------------
punting.2 %>% augment(punting) -> punting.2.aug
punting.2.aug %>% slice(1:8)

## ----basingstoke,fig.height=3.5------------------------------------------
ggplot(punting.2.aug,aes(x=left,y=.resid))+
  geom_point()

## ------------------------------------------------------------------------
punting.3=lm(punt~left+I(left^2)+right,
  data=punting)

## ----size="scriptsize"---------------------------------------------------
summary(punting.3)

## ----echo=F,warning=F----------------------------------------------------
pkgs = names(sessionInfo()$otherPkgs) 
pkgs=paste('package:', pkgs, sep = "")
x=lapply(pkgs, detach, character.only = TRUE, unload = TRUE)


## ----bLogistic, child="bLogistic.Rnw"------------------------------------

## ------------------------------------------------------------------------
library(MASS)
library(tidyverse)
library(broom)
library(nnet)

## ----size="small"--------------------------------------------------------
my_url="http://www.utsc.utoronto.ca/~butler/d29/rat.txt"
rats=read_delim(my_url," ")

## ----size="small"--------------------------------------------------------
rats

## ----size="small"--------------------------------------------------------
rats2 = rats %>% mutate(status=factor(status))

## ----size="small"--------------------------------------------------------
status.1 = 
  glm(status~dose,family="binomial",data=rats2)

## ------------------------------------------------------------------------

## ----size="scriptsize"---------------------------------------------------
summary(status.1)

## ------------------------------------------------------------------------
p=predict(status.1,type="response")
cbind(rats,p)

## ----size="footnotesize"-------------------------------------------------
my_url="http://www.utsc.utoronto.ca/~butler/d29/rat2.txt"
rat2=read_delim(my_url," ")
rat2

## ------------------------------------------------------------------------
response=with(rat2,cbind(lived,died))
rat2.1=glm(response~dose,family="binomial",
  data=rat2)

## ------------------------------------------------------------------------
class(response)

## ----size="scriptsize"---------------------------------------------------
summary(rat2.1)

## ------------------------------------------------------------------------
p=predict(rat2.1,type="response")
cbind(rat2,p)

## ----size="footnotesize"-------------------------------------------------
my_url="http://www.utsc.utoronto.ca/~butler/d29/sepsis.txt"
sepsis=read_delim(my_url," ")

## ----size="footnotesize"-------------------------------------------------
sepsis

## ------------------------------------------------------------------------
sepsis.1=glm(death~shock+malnut+alcohol+age+
              bowelinf,family="binomial",
	      data=sepsis)

## ----size="footnotesize"-------------------------------------------------
tidy(sepsis.1)

## ----size="footnotesize"-------------------------------------------------
sepsis.2=update(sepsis.1,.~.-malnut)
tidy(sepsis.2)

## ----size="footnotesize"-------------------------------------------------
sepsis.pred=predict(sepsis.2,type="response")
d=data.frame(sepsis,sepsis.pred)
myrows=c(4,1,2,11,32) ; slice(d,myrows)

## ----virtusentella,fig.height=3.4, warning=F-----------------------------
ggplot(augment(sepsis.2),aes(x=age,y=.resid))+
  geom_point()

## ----size="small"--------------------------------------------------------
sepsis.2.tidy=tidy(sepsis.2)
sepsis.2.tidy

## ----size="small"--------------------------------------------------------
cc=exp(sepsis.2.tidy$estimate)
data.frame(sepsis.2.tidy$term,expcoeff=round(cc,2))

## ------------------------------------------------------------------------
(od1=0.02/0.98)
(od2=0.01/0.99)

## ------------------------------------------------------------------------
od1/od2 

## ------------------------------------------------------------------------
my_url="http://www.utsc.utoronto.ca/~butler/d29/miners-tab.txt"
freqs=read_table(my_url)

## ------------------------------------------------------------------------
freqs

## ------------------------------------------------------------------------
freqs %>% gather(Severity, Freq, None:Severe) %>%
    group_by(Exposure) %>%
    mutate(proportion=Freq/sum(Freq)) -> miners

## ------------------------------------------------------------------------
miners

## ----fig.height=3.5,size="small"-----------------------------------------
ggplot(miners,aes(x=Exposure,y=proportion,
                  colour=Severity))+geom_point()+geom_line()

## ------------------------------------------------------------------------
miners

## ------------------------------------------------------------------------
miners %>% 
    mutate(sev_ord=fct_inorder(Severity)) -> miners

## ------------------------------------------------------------------------
levels(miners$sev_ord)

## ------------------------------------------------------------------------
miners

## ----fig.height=3.5,size="small"-----------------------------------------
ggplot(miners,aes(x=Exposure,y=proportion,
    colour=sev_ord))+geom_point()+geom_line()

## ------------------------------------------------------------------------
sev.1=polr(sev_ord~Exposure,weights=Freq,
              data=miners)

## ----size="small"--------------------------------------------------------
summary(sev.1)

## ----echo=F--------------------------------------------------------------
w=getOption("width")
options(width=w-20)

## ----size="footnotesize"-------------------------------------------------
sev.0=polr(sev_ord~1,weights=Freq,data=miners)
anova(sev.0,sev.1)

## ------------------------------------------------------------------------
drop1(sev.1,test="Chisq")

## ----echo=F--------------------------------------------------------------
options(width=70)

## ----size="small"--------------------------------------------------------
sev.new=tibble(Exposure=freqs$Exposure)
pr=predict(sev.1,sev.new,type="p")
miners.pred=cbind(sev.new,pr)
miners.pred

## ----size="small"--------------------------------------------------------
miners.pred %>% 
  gather(Severity,probability,-Exposure) %>%
  mutate(sev_ord=fct_inorder(Severity)) -> preds

## ----size="small"--------------------------------------------------------
preds %>% slice(1:15)

## ------------------------------------------------------------------------
g=ggplot(preds,aes(x=Exposure,y=probability,
    colour=sev_ord)) + geom_line() +
  geom_point(data=miners,aes(y=proportion))

## ----fig.height=3.6------------------------------------------------------
g

## ------------------------------------------------------------------------
my_url="http://www.utsc.utoronto.ca/~butler/d29/mlogit.csv"
brandpref=read_csv(my_url)

## ------------------------------------------------------------------------
brandpref

## ------------------------------------------------------------------------
brandpref = brandpref %>% 
    mutate(sex=factor(sex)) %>%
    mutate(brand=factor(brand))

## ------------------------------------------------------------------------
brands.1=multinom(brand~age+sex,data=brandpref)

## ------------------------------------------------------------------------
drop1(brands.1,test="Chisq",trace=0)

## ------------------------------------------------------------------------
brands.2=multinom(brand~age,data=brandpref)
brands.3=multinom(brand~sex,data=brandpref)

## ----size="scriptsize"---------------------------------------------------
anova(brands.2,brands.1)
anova(brands.3,brands.1)

## ------------------------------------------------------------------------
step(brands.1,trace=0)

## ----size="footnotesize"-------------------------------------------------
ages=c(24,28,32,35,38)
sexes=factor(0:1)
new=crossing(age=ages,sex=sexes)
new

## ------------------------------------------------------------------------
p=predict(brands.1,new,type="probs")
probs=cbind(new,p)

## ------------------------------------------------------------------------
probs

## ------------------------------------------------------------------------
probs.long = probs %>% 
    gather(brand,probability,-(age:sex))
sample_n(probs.long,7) # 7 random rows

## ----fig.height=3--------------------------------------------------------
ggplot(probs.long,aes(x=age,y=probability,
  colour=brand,shape=sex))+
  geom_point()+geom_line(aes(linetype=sex))

## ------------------------------------------------------------------------
brandpref %>%
      group_by(age,sex,brand) %>%
      summarize(Freq=n()) %>%
      ungroup() -> b
b %>% slice(1:6)

## ----size="scriptsize"---------------------------------------------------
bf = b %>%
      mutate(sex=factor(sex)) %>%
      mutate(brand=factor(brand)) 
b.1=multinom(brand~age+sex,data=bf,weights=Freq)
b.2=multinom(brand~age,data=bf,weights=Freq)

## ----size="footnotesize"-------------------------------------------------
anova(b.2,b.1)

## ----size="scriptsize"---------------------------------------------------
b %>% group_by(age) %>%
  summarize(total=sum(Freq)) 

## ----spal-b--------------------------------------------------------------
b %>%  
  group_by(age,sex) %>%
  mutate(proportion=Freq/sum(Freq)) -> brands

## ------------------------------------------------------------------------
brands %>% filter(age==32)

## ----fig.height=3.2------------------------------------------------------
g=ggplot(probs.long,aes(x=age,y=probability,
  colour=brand,shape=sex))+
  geom_line(aes(linetype=sex))+
  geom_point(data=brands,aes(y=proportion))


## ----fig.height=3.5------------------------------------------------------
g

## ------------------------------------------------------------------------
g=ggplot(probs.long,aes(x=age,y=probability,
  colour=brand,shape=sex))+
  geom_line(aes(linetype=sex))+
  geom_point(data=brands,
             aes(y=proportion,size=Freq))

## ----fig.height=3.5------------------------------------------------------
g

## ----echo=F--------------------------------------------------------------
options(width=60)

## ------------------------------------------------------------------------
b.4=update(b.1,.~.+age:sex)
anova(b.1,b.4)


## ----bSurvival, child="bSurvival.Rnw"------------------------------------

## ----message=F-----------------------------------------------------------
library(tidyverse)
library(survival)
library(survminer)
library(broom)
my_url="http://www.utsc.utoronto.ca/~butler/d29/dancing.txt"
dance=read_table(my_url)

## ----size="small"--------------------------------------------------------
dance

## ----size="footnotesize"-------------------------------------------------
mth=with(dance,Surv(Months,Quit))
mth

## ------------------------------------------------------------------------
dance.1=coxph(mth~Treatment+Age,data=dance)

## ----size="scriptsize"---------------------------------------------------
summary(dance.1)

## ----fig.height=3--------------------------------------------------------
ggcoxdiagnostics(dance.1)+geom_smooth(se=F)

## ----size="small"--------------------------------------------------------
treatments=c(0,1)
ages=c(20,40)
dance.new=crossing(Treatment=treatments,Age=ages)
dance.new

## ----echo=F--------------------------------------------------------------
options(width=80)

## ----size="footnotesize"-------------------------------------------------
s=survfit(dance.1,newdata=dance.new,data=dance)
summary(s)

## ----size="scriptsize"---------------------------------------------------
t(dance.new)

## ------------------------------------------------------------------------
g=ggsurvplot(s,conf.int=F)

## ----fig.height=2.5------------------------------------------------------
g

## ----size="tiny"---------------------------------------------------------
lung %>% slice(1:16)

## ----echo=F--------------------------------------------------------------
options(width=90)

## ----size="tiny"---------------------------------------------------------
summary(lung)

## ----size="small"--------------------------------------------------------
cc=complete.cases(lung)
lung %>% filter(cc) -> lung.complete
lung.complete %>% 
  select(meal.cal:wt.loss) %>% head(10)

## ----size="tiny"---------------------------------------------------------
summary(lung.complete)

## ----size="footnotesize"-------------------------------------------------
str(lung.complete)

## ------------------------------------------------------------------------
resp=with(lung.complete,Surv(time,status==2))
lung.1=coxph(resp~.-inst-time-status,
  data=lung.complete)

## ----size="tiny"---------------------------------------------------------
summary(lung.1)

## ----size="small"--------------------------------------------------------
glance(lung.1)[c(4,6,8)]

## ------------------------------------------------------------------------
tidy(lung.1) %>% select(term, p.value) %>% arrange(p.value)

## ----size="footnotesize"-------------------------------------------------
lung.2=update(lung.1,.~.-age-pat.karno-meal.cal)
tidy(lung.2) %>% select(term,p.value)

## ----size="footnotesize"-------------------------------------------------
anova(lung.2,lung.1)

## ----size="footnotesize"-------------------------------------------------
lung.3=update(lung.2,.~.-ph.karno-wt.loss)
tidy(lung.3) %>% select(term,estimate,p.value)
anova(lung.3, lung.2)

## ----size="footnotesize"-------------------------------------------------
sexes=c(1,2)
ph.ecogs=0:3
lung.new=crossing(sex=sexes,ph.ecog=ph.ecogs)
lung.new
s=survfit(lung.3,data=lung.complete,newdata=lung.new)

## ----fig.height=4--------------------------------------------------------
ggsurvplot(s,conf.int=F)

## ----fig.height=2.25-----------------------------------------------------
ggcoxdiagnostics(lung.3)+geom_smooth(se=F)

## ------------------------------------------------------------------------
age=seq(20,60,5)
survtime=c(10,12,11,21,15,20,8,9,11)
stat=c(1,1,1,1,0,1,1,1,1)
d=tibble(age,survtime,stat)
y=with(d,Surv(survtime,stat))

## ------------------------------------------------------------------------
y.1=coxph(y~age,data=d)
summary(y.1)

## ----fig.height=2.25-----------------------------------------------------
ggcoxdiagnostics(y.1)+geom_smooth(se=F)

## ----size="scriptsize"---------------------------------------------------
y.2=coxph(y~age+I(age^2),data=d)
summary(y.2)

## ----fig.height=2.5------------------------------------------------------
ggcoxdiagnostics(y.2)+geom_smooth(se=F)


## ----bAnova, child="bAnova.Rnw"------------------------------------------

## ------------------------------------------------------------------------
library(tidyverse)
library(broom)

## ----size="footnotesize"-------------------------------------------------
my_url="http://www.utsc.utoronto.ca/~butler/d29/hairpain.txt"
hairpain=read_delim(my_url," ")
hairpain %>% group_by(hair) %>%
  summarize( n=n(),
             xbar=mean(pain),
	     s=sd(pain))

## ----tartuffo,fig.height=3.5---------------------------------------------
ggplot(hairpain,aes(x=hair,y=pain))+geom_boxplot()

## ----size="small"--------------------------------------------------------
car::leveneTest(pain~hair,data=hairpain)

## ----size="small"--------------------------------------------------------
hairpain.1=aov(pain~hair,data=hairpain)
summary(hairpain.1)

## ----size="scriptsize"---------------------------------------------------
TukeyHSD(hairpain.1)

## ------------------------------------------------------------------------
attach(hairpain)
pairwise.t.test(pain,hair,p.adj="none")
pairwise.t.test(pain,hair,p.adj="holm")

## ------------------------------------------------------------------------
pairwise.t.test(pain,hair,p.adj="fdr")
pairwise.t.test(pain,hair,p.adj="bon")

## ------------------------------------------------------------------------
my_url="http://www.utsc.utoronto.ca/~butler/d29/vitaminb.txt"
vitaminb=read_delim(my_url," ")

## ------------------------------------------------------------------------
vitaminb

## ----fig.height=3.25-----------------------------------------------------
ggplot(vitaminb,aes(x=ratsize,y=kidneyweight,
                    fill=diet))+geom_boxplot()

## ------------------------------------------------------------------------
summary = vitaminb %>% group_by(ratsize,diet) %>%
  summarize(mean=mean(kidneyweight))
summary  

## ------------------------------------------------------------------------
vitaminb.1=aov(kidneyweight~ratsize*diet,
  data=vitaminb)
summary(vitaminb.1)

## ------------------------------------------------------------------------
g=ggplot(summary,aes(x=ratsize,y=mean,
     colour=diet,group=diet))+
  geom_point()+geom_line()

## ----fig.height=3--------------------------------------------------------
g

## ----size="small"--------------------------------------------------------
vitaminb.2=update(vitaminb.1,.~.-ratsize:diet)
summary(vitaminb.2)

## ------------------------------------------------------------------------
my_url="http://www.utsc.utoronto.ca/~butler/d29/autonoise.txt"
autonoise=read_table(my_url)

## ------------------------------------------------------------------------
autonoise

## ------------------------------------------------------------------------
g = autonoise %>% 
    ggplot(aes(x=size,y=noise,fill=type))+
    geom_boxplot() 


## ----fig.height=2.7------------------------------------------------------
g

## ----size="small"--------------------------------------------------------
autonoise.1=aov(noise~size*type,data=autonoise)
summary(autonoise.1)

## ----size="scriptsize"---------------------------------------------------
autonoise.2=TukeyHSD(autonoise.1)
autonoise.2$`size:type`

## ------------------------------------------------------------------------
g=ggplot(autonoise,aes(x=size,y=noise,
    colour=type,group=type))+
  stat_summary(fun.y=mean,geom="point")+
  stat_summary(fun.y=mean,geom="line")

## ----fig.height=3--------------------------------------------------------
g

## ----fig.height=3, size="small"------------------------------------------
autonoise %>% group_by(size,type) %>%
  summarize(mean_noise=mean(noise)) %>%
  ggplot(aes(x=size,y=mean_noise,group=type,
      colour=type))+geom_point()+geom_line() 

## ------------------------------------------------------------------------
autonoise %>% filter(size=="S") %>%
  aov(noise~type,data=.) %>% summary()

## ------------------------------------------------------------------------
autonoise %>% filter(size=="M") %>%
  aov(noise~type,data=.) %>% summary()

## ------------------------------------------------------------------------
autonoise %>% filter(size=="M") %>%
  group_by(type) %>% summarize(m=mean(noise))

## ------------------------------------------------------------------------
autonoise %>% filter(size=="L") %>%
  aov(noise~type,data=.) %>% summary()

## ----size="footnotesize"-------------------------------------------------
autonoise %>% filter(size=="L") %>%
  aov(noise~type,data=.) %>% glance()

## ------------------------------------------------------------------------
autonoise %>% group_by(size) %>%
    nest()

## ------------------------------------------------------------------------
aov_pval=function(x) {
    noise.1=aov(noise~type,data=x)
    gg=glance(noise.1)
    gg$p.value
}

## ------------------------------------------------------------------------
autonoise %>% filter(size=="L") %>%
  aov_pval()

## ------------------------------------------------------------------------
autonoise %>% group_by(size) %>%
    nest() %>%
    mutate(p_val=map_dbl(data,~aov_pval(.)))

## ----size="small"--------------------------------------------------------
simple_effects = autonoise %>% group_by(size) %>%
    nest() %>%
    mutate(p_val=map_dbl(data,~aov_pval(.))) %>%
    select(-data)
simple_effects

## ----size="small"--------------------------------------------------------
simple_effects %>%
    arrange(p_val) %>%
    mutate(multiplier=4-row_number()) %>%
    mutate(p_val_adj=p_val*multiplier)

## ------------------------------------------------------------------------
autonoise %>% filter(size=="S") %>%
  t.test(noise~type,data=.) %>% .[["conf.int"]]

## ------------------------------------------------------------------------
autonoise %>% filter(size=="M") %>%
  t.test(noise~type,data=.) %>% .[["conf.int"]]

## ------------------------------------------------------------------------
autonoise %>% filter(size=="L") %>%
  t.test(noise~type,data=.) %>% .[["conf.int"]]

## ----size="scriptsize"---------------------------------------------------
ci_func=function(x) {
    tt=t.test(noise~type,data=x)
    tt$conf.int
}
cis = autonoise %>%
    group_by(size) %>% nest() %>%
    mutate(ci=map(data,~ci_func(.))) %>%
    unnest(ci)

## ----size="footnotesize"-------------------------------------------------
cis

## ----size="small"--------------------------------------------------------
cis %>% mutate(hilo=rep(c("lower","upper"),3)) %>%
    spread(hilo,ci)

## ------------------------------------------------------------------------
c.home=c(1,0,0,-1)

## ------------------------------------------------------------------------
c.industrial=c(0,1,-1,0)

## ------------------------------------------------------------------------
c.home.ind=c(0.5,-0.5,-0.5,0.5)

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

## ----size="footnotesize"-------------------------------------------------
my_url="http://www.utsc.utoronto.ca/~butler/d29/chainsaw.txt"
chain.wide=read_table(my_url)
chain.wide

## ------------------------------------------------------------------------
chain=gather(chain.wide,model,kickback,A:D,
  factor_key=T)

## ------------------------------------------------------------------------
chain %>% slice(1:10)

## ------------------------------------------------------------------------
chain %>% slice(11:20)

## ------------------------------------------------------------------------
m=cbind(c.home,c.industrial,c.home.ind)
m
contrasts(chain$model)=m

## ------------------------------------------------------------------------
chain.1=lm(kickback~model,data=chain)
summary(chain.1)

## ------------------------------------------------------------------------
tidy(chain.1) %>% select(term,p.value)

## ------------------------------------------------------------------------
chain %>% group_by(model) %>%
  summarize(mean.kick=mean(kickback)) %>%
    arrange(desc(mean.kick))

## ----echo=F,warning=F----------------------------------------------------
pkgs = names(sessionInfo()$otherPkgs) 
pkgs=paste('package:', pkgs, sep = "")
x=lapply(pkgs, detach, character.only = TRUE, unload = TRUE)


## ----ancova, child="bAncova.Rnw"-----------------------------------------

## ------------------------------------------------------------------------
library(tidyverse)
library(broom)

## ----size="small"--------------------------------------------------------
my_url="http://www.utsc.utoronto.ca/~butler/d29/ancova.txt"
prepost=read_delim(my_url," ")
glimpse(prepost)
g=ggplot(prepost,aes(x=before,y=after,colour=drug))+
  geom_point()

## ----spizzo,fig.height=3.5-----------------------------------------------
g

## ----fig.height=2.5------------------------------------------------------
g

## ------------------------------------------------------------------------
prepost %>% group_by(drug) %>%
  summarize(before_mean=mean(before), 
            after_mean=mean(after) 
	   )

## ------------------------------------------------------------------------
prepost.1=lm(after~before*drug,data=prepost)
anova(prepost.1)

## ------------------------------------------------------------------------
new=crossing( 
      before=c(5,15,25),
      drug=c("a","b"))
new

## ----size="small"--------------------------------------------------------
pred=predict(prepost.1,new)
preds=bind_cols(new,pred=pred)
preds

## ----AJHSA---------------------------------------------------------------
g=ggplot(prepost,
  aes(x=before,y=after,colour=drug))+
  geom_point()+
  geom_line(data=preds,aes(y=pred))

## ----eval=F--------------------------------------------------------------
## geom_smooth(method="lm",se=F)

## ----nachwazzo,fig.height=3.5--------------------------------------------
g

## ------------------------------------------------------------------------
prepost.2=update(prepost.1,.~.-before:drug)
anova(prepost.2)

## ------------------------------------------------------------------------
pred=predict(prepost.2,new)
preds=bind_cols(new,pred=pred)
preds

## ------------------------------------------------------------------------
g=ggplot(prepost,
  aes(x=before,y=after,colour=drug))+
  geom_point()+
  geom_line(data=preds,aes(y=pred))

## ----cabazzo,fig.height=3------------------------------------------------
g

## ------------------------------------------------------------------------
summary(prepost.2)

## ----size="footnotesize"-------------------------------------------------
tidy(prepost.2)

## ----echo=F, warning=F---------------------------------------------------
pkgs = names(sessionInfo()$otherPkgs) 
pkgs=paste('package:', pkgs, sep = "")
x=lapply(pkgs, detach, character.only = TRUE, unload = TRUE)


## ----bManova, child="bManova.Rnw"----------------------------------------

## ------------------------------------------------------------------------
library(car)
library(tidyverse)

## ------------------------------------------------------------------------
my_url="http://www.utsc.utoronto.ca/~butler/d29/manova1.txt"
hilo=read_delim(my_url," ")

## ------------------------------------------------------------------------
hilo

## ----ferto,size="small",fig.height=3-------------------------------------
ggplot(hilo,aes(x=fertilizer,y=yield))+geom_boxplot()

## ----casteldisangro,size="small",fig.height=3----------------------------
ggplot(hilo,aes(x=fertilizer,y=weight))+geom_boxplot()

## ------------------------------------------------------------------------
hilo.y=aov(yield~fertilizer,data=hilo)
summary(hilo.y)
hilo.w=aov(weight~fertilizer,data=hilo)
summary(hilo.w)

## ------------------------------------------------------------------------
g=ggplot(hilo,aes(x=yield,y=weight,
    colour=fertilizer))+geom_point()

## ----size="footnotesize"-------------------------------------------------
d=tribble(
    ~line_x, ~line_y,
    31, 14,
    38, 10)
g=g+geom_line(data=d,aes(x=line_x,y=line_y,
  colour=NULL))

## ----charlecombe,fig.height=3.5------------------------------------------
g

## ----fig.height=2.5------------------------------------------------------
g

## ----size="footnotesize"-------------------------------------------------
response=with(hilo,cbind(yield,weight))
hilo.1=manova(response~fertilizer,data=hilo)
summary(hilo.1)

## ----eval=F--------------------------------------------------------------
## library(car)

## ----size="footnotesize"-------------------------------------------------
hilo.2.lm=lm(response~fertilizer,data=hilo)
hilo.2=Manova(hilo.2.lm)
hilo.2

## ----message=F,size="footnotesize"---------------------------------------
my_url="http://www.utsc.utoronto.ca/~butler/d29/peanuts.txt"
(peanuts.orig=read_delim(my_url," "))

## ------------------------------------------------------------------------
peanuts = peanuts.orig %>%
  mutate(location=factor(location),
         variety=factor(variety)) 
response=with(peanuts,cbind(y,smk,w))
head(response)

## ----size="scriptsize"---------------------------------------------------
peanuts.1=lm(response~location*variety,data=peanuts)
peanuts.2=Manova(peanuts.1)
peanuts.2

## ----echo=F, warning=F---------------------------------------------------
pkgs = names(sessionInfo()$otherPkgs) 
pkgs=paste('package:', pkgs, sep = "")
x=lapply(pkgs, detach, character.only = TRUE, unload = TRUE)


## ----bProfile, child="bProfile.Rnw"--------------------------------------

## ------------------------------------------------------------------------
library(car)
library(tidyverse)

## ------------------------------------------------------------------------
my_url="http://www.utsc.utoronto.ca/~butler/d29/dogs.txt"
dogs=read_table(my_url)

## ----size="small"--------------------------------------------------------
dogs
response=with(dogs,cbind(lh0,lh1,lh3,lh5))
dogs.lm=lm(response~drug,data=dogs)

## ------------------------------------------------------------------------
times=colnames(response)
times.df=data.frame(times)
dogs.manova=Manova(dogs.lm,idata=times.df,
     idesign=~times)
dogs.manova

## ----size="scriptsize"---------------------------------------------------
dogs %>% print(n=5)

## ----size="footnotesize"-------------------------------------------------
dogs %>% gather(time,lh,lh0:lh5) %>% print(n=12) 

## ----size="footnotesize"-------------------------------------------------
dogs %>% gather(timex,lh,lh0:lh5) %>% 
    mutate(time=parse_number(timex)) %>% print(n=10)


## ------------------------------------------------------------------------
dogs.long = dogs %>% gather(timex,lh,lh0:lh5) %>% 
    mutate(time=parse_number(timex))

## ----fig.height=4,size="small"-------------------------------------------
ggplot(dogs.long,aes(x=time,y=lh,
                     colour=drug,group=drug))+
  stat_summary(fun.y=mean,geom="point")+
  stat_summary(fun.y=mean,geom="line")

## ----size="footnotesize"-------------------------------------------------
response=with(dogs,cbind(lh1,lh3,lh5)) # excluding time zero
dogs.lm=lm(response~drug,data=dogs)
times=colnames(response)
times.df=data.frame(times)
dogs.manova=Manova(dogs.lm,idata=times.df,
                   idesign=~times)

## ----size="footnotesize"-------------------------------------------------
dogs.manova

## ----platanias-----------------------------------------------------------
g=ggplot(dogs.long,aes(x=time,y=lh,
    colour=drug,group=dog)) +
  geom_point()+geom_line()

## ----hoverla,fig.height=3.5----------------------------------------------
g

## ------------------------------------------------------------------------
my_url="http://www.utsc.utoronto.ca/~butler/d29/exercise.txt"
exercise.long=read_tsv(my_url)

## ----size="small"--------------------------------------------------------
exercise.long %>% print(n=8)

## ----size="footnotesize"-------------------------------------------------
exercise.wide=spread(exercise.long,time,pulse)
exercise.wide %>% print(n=6)

## ------------------------------------------------------------------------
response=with(exercise.wide,
           cbind(min01, min15, min30))

## ------------------------------------------------------------------------
exercise.1=lm(response~diet*exertype,
  data=exercise.wide)

## ------------------------------------------------------------------------
times=colnames(response)
times.df=data.frame(times)
exercise.2=Manova(exercise.1,idata=times.df,
                  idesign=~times)

## ------------------------------------------------------------------------
exercise.2

## ------------------------------------------------------------------------
g=ggplot(exercise.long,aes(x=time,y=pulse,
  group=id))+geom_point()+geom_line()+
  facet_grid(diet~exertype)

## ----fig.height=3.5------------------------------------------------------
g

## ------------------------------------------------------------------------
runners.wide = exercise.wide %>%
  filter(exertype=="running")

## ----size="footnotesize"-------------------------------------------------
response=with(runners.wide,cbind(min01,min15,min30))
runners.1=lm(response~diet,data=runners.wide)
times=colnames(response)
times.df=data.frame(times)
runners.2=Manova(runners.1,idata=times.df,
                 idesign=~times)

## ------------------------------------------------------------------------
runners.2

## ------------------------------------------------------------------------
summ = runners.wide %>%
  gather(time,pulse,min01:min30) %>%
  group_by(time,diet) %>%
  summarize(mean=mean(pulse), 
    sd=sd(pulse)) 

## ----size="small"--------------------------------------------------------
summ

## ----fig.height=2.5------------------------------------------------------
ggplot(summ,aes(x=time,y=mean,colour=diet,
  group=diet))+geom_point()+geom_line()

## ----echo=F, warning=F---------------------------------------------------
pkgs = names(sessionInfo()$otherPkgs) 
pkgs=paste('package:', pkgs, sep = "")
x=lapply(pkgs, detach, character.only = TRUE, unload = TRUE)


## ----bDiscrim, child="bDiscrim.Rnw"--------------------------------------

## ----size="small"--------------------------------------------------------
library(MASS)
library(tidyverse)
library(ggrepel)
library(ggbiplot)

## ----size="small",message=F----------------------------------------------
my_url="http://www.utsc.utoronto.ca/~butler/d29/manova1.txt"
hilo=read_delim(my_url," ")
g=ggplot(hilo,aes(x=yield,y=weight,
  colour=fertilizer))+geom_point(size=4)

## ----berzani, fig.height=4-----------------------------------------------
g

## ------------------------------------------------------------------------
hilo.1=lda(fertilizer~yield+weight,data=hilo)

## ----size="small"--------------------------------------------------------
hilo.1

## ------------------------------------------------------------------------
hilo.pred=predict(hilo.1)

## ----size="small"--------------------------------------------------------
d = cbind(hilo,hilo.pred$x) %>% arrange(desc(LD1))
d

## ----fig.height=3--------------------------------------------------------
ggplot(d,aes(x=fertilizer,y=LD1))+geom_boxplot()

## ----size="small"--------------------------------------------------------
hilo.1$scaling

## ----size="footnotesize"-------------------------------------------------
summary(hilo)

## ----size="small"--------------------------------------------------------
names(hilo.pred)

## ----size="small"--------------------------------------------------------
cbind(hilo,predicted=hilo.pred$class)
table(obs=hilo$fertilizer,pred=hilo.pred$class)

## ----size="small"--------------------------------------------------------
pp=round(hilo.pred$posterior,4)
d=cbind(hilo,hilo.pred$x,pp)
d

## ----message=F,size="footnotesize"---------------------------------------
my_url="http://www.utsc.utoronto.ca/~butler/d29/peanuts.txt"
peanuts=read_delim(my_url," ")
peanuts 

## ----combos,size="small"-------------------------------------------------
peanuts %>% unite(combo,c(variety,location)) -> 
  peanuts.combo
peanuts.combo

## ----size="small"--------------------------------------------------------
peanuts.1=lda(combo~y+smk+w,data=peanuts.combo)
peanuts.1$scaling
peanuts.1$svd

## ------------------------------------------------------------------------
peanuts.1$means

## ------------------------------------------------------------------------
peanuts.pred=predict(peanuts.1)
table(obs=peanuts.combo$combo,
      pred=peanuts.pred$class)

## ----size="footnotesize"-------------------------------------------------
pp=round(peanuts.pred$posterior,2)
peanuts.combo %>% select(-c(y,smk,w)) %>%
   cbind(.,pred=peanuts.pred$class,pp)

## ----size="small"--------------------------------------------------------
peanuts.1$scaling
lds=round(peanuts.pred$x,2)
mm=with(peanuts.combo,
  data.frame(combo,y,smk,w,lds))

## ----size="footnotesize"-------------------------------------------------
mm

## ------------------------------------------------------------------------
quartiles = peanuts %>% select(y:w) %>%
  map_df(quantile, c(0.25,0.75))
quartiles
new=with(quartiles,crossing(y,smk,w))

## ------------------------------------------------------------------------
new
pp=predict(peanuts.1,new)

## ----size="footnotesize"-------------------------------------------------
cbind(new,pp$x) %>% arrange(LD1)

## ----fig.height=3.5------------------------------------------------------
g=ggplot(mm,aes(x=LD1,y=LD2,colour=combo,
  label=combo))+geom_point()+
  geom_text_repel()+guides(colour=F) ; g

## ----fig.height=3.5------------------------------------------------------
ggbiplot(peanuts.1,
  groups=factor(peanuts.combo$combo))

## ----eval=F--------------------------------------------------------------
## install.packages("devtools")

## ----eval=F--------------------------------------------------------------
## library(devtools)
## install_github("vqv/ggbiplot")

## ------------------------------------------------------------------------
peanuts.cv=lda(combo~y+smk+w,
  data=peanuts.combo,CV=T)
table(obs=peanuts.combo$combo,
      pred=peanuts.cv$class)

## ----graziani,fig.height=3.5---------------------------------------------
g

## ----size="footnotesize"-------------------------------------------------
pp=round(peanuts.cv$posterior,3)
data.frame(obs=peanuts.combo$combo,
           pred=peanuts.cv$class,pp)

## ----message=F-----------------------------------------------------------
my_url="http://www.utsc.utoronto.ca/~butler/d29/profile.txt"
active=read_delim(my_url," ")
active.1=lda(job~reading+dance+tv+ski,data=active)
active.1$svd
active.1$scaling

## ------------------------------------------------------------------------
active.pred=predict(active.1)
table(obs=active$job,pred=active.pred$class)

## ----fig.height=3,size="small"-------------------------------------------
mm=data.frame(job=active$job,active.pred$x,person=1:15)
g=ggplot(mm,aes(x=LD1,y=LD2,
    colour=job,label=job))+geom_point()+
    geom_text_repel()+guides(colour=F) ; g

## ----fig.height=4.5------------------------------------------------------
ggbiplot(active.1,groups=active$job)

## ----fig.height=2.8------------------------------------------------------
ggplot(mm,aes(x=LD1,y=LD2,
    colour=job,label=person))+geom_point()+
    geom_text_repel()

## ----size="footnotesize"-------------------------------------------------
pp=round(active.pred$posterior,3)
data.frame(obs=active$job,pred=active.pred$class,pp)

## ------------------------------------------------------------------------
active.cv=lda(job~reading+dance+tv+ski,
  data=active,CV=T)
table(obs=active$job,pred=active.cv$class)

## ----size="footnotesize"-------------------------------------------------
pp=round(active.cv$posterior,3)
data.frame(obs=active$job,pred=active.cv$class,pp) %>%
  mutate(max=pmax(admin,bellydancer,politician)) %>%
  filter(max<0.9995)

## ----nesta, fig.height=4.5, echo=F---------------------------------------
g

## ------------------------------------------------------------------------
my_url="http://www.utsc.utoronto.ca/~butler/d29/remote-sensing.txt"
crops=read_table(my_url)

## ------------------------------------------------------------------------
crops.lda=lda(crop~x1+x2+x3+x4,data=crops)
crops.lda$svd

## ------------------------------------------------------------------------
crops.lda$means
round(crops.lda$scaling,3)

## ------------------------------------------------------------------------
round(crops.lda$scaling,3)

## ----size="footnotesize"-------------------------------------------------
crops.pred=predict(crops.lda)
table(obs=crops$crop,pred=crops.pred$class)

## ------------------------------------------------------------------------
mm=data.frame(crop=crops$crop,crops.pred$x)

## ----piacentini,fig.height=3.1-------------------------------------------
ggplot(mm,aes(x=LD1,y=LD2,colour=crop))+
  geom_point()

## ----fig.height=3.5------------------------------------------------------
ggbiplot(crops.lda,groups=crops$crop)

## ------------------------------------------------------------------------
crops %>% filter(crop!="Clover") -> crops2
crops2.lda=lda(crop~x1+x2+x3+x4,data=crops2)

## ------------------------------------------------------------------------
crops2.pred=predict(crops2.lda)
mm=data.frame(crop=crops2$crop,crops2.pred$x)

## ----size="footnotesize"-------------------------------------------------
crops2.lda$means
crops2.lda$svd
crops2.lda$scaling

## ----nedved,fig.height=3.1-----------------------------------------------
ggplot(mm,aes(x=LD1,y=LD2,colour=crop))+
  geom_point()

## ----fig.height=3.6------------------------------------------------------
ggbiplot(crops2.lda,groups=crops2$crop)

## ----size="small"--------------------------------------------------------
table(obs=crops2$crop,pred=crops2.pred$class)

## ----echo=F--------------------------------------------------------------
options(width=60)

## ------------------------------------------------------------------------
post=round(crops2.pred$posterior,3)
data.frame(obs=crops2$crop,pred=crops2.pred$class,post) %>%
  filter(obs!=pred)

## ------------------------------------------------------------------------
response=with(crops2,cbind(x1,x2,x3,x4))
crops2.manova=manova(response~crop,data=crops2)
summary(crops2.manova)

## ----echo=F, warning=F---------------------------------------------------
pkgs = names(sessionInfo()$otherPkgs) 
pkgs=paste('package:', pkgs, sep = "")
x=lapply(pkgs, detach, character.only = TRUE, unload = TRUE)


## ----bCluster, child="bCluster.Rnw"--------------------------------------

## ------------------------------------------------------------------------
library(MASS) # for lda later
library(tidyverse)
library(ggrepel)

## ----echo=F, fig.height=4------------------------------------------------
set.seed(457299)
a=data.frame(x=runif(5,0,20),y=runif(5,0,20))
b=data.frame(x=runif(5,20,40),y=runif(5,20,40))
ddd=bind_rows(a=a,b=b,.id="cluster")
g=ggplot(ddd,aes(x=x,y=y,colour=cluster))+geom_point()+
  coord_fixed(xlim=c(0,40),ylim=c(0,40))
g

## ----echo=F,fig.height=3.1-----------------------------------------------
distance=function(p1,p2) {
  sqrt((p1[1]-p2[1])^2+(p1[2]-p2[2])^2)
}
distances=matrix(0,nrow(a),nrow(b))
for (i in 1:nrow(a)) {
  for (j in 1:nrow(b)) {
    dd=distance(a[i,],b[j,])
    distances[i,j]=dd
  }
}
wm1=which.min(apply(distances,1,min))
wm2=which.min(apply(distances,2,min))
closest=bind_rows(a=a[wm1,],b=b[wm2,],.id="cluster")
# single linkage distance
g+geom_segment(data=closest,aes(x=x[1],y=y[1],xend=x[2],yend=y[2]),colour="blue")

## ----echo=F,fig.height=3.4-----------------------------------------------
wm1=which.max(apply(distances,1,max))
wm2=which.max(apply(distances,2,max))
closest=bind_rows(a[wm1,],b[wm2,],.id="cluster")
g+geom_segment(data=closest,aes(x=x[1],y=y[1],xend=x[2],yend=y[2]),colour="blue")

## ----fig.height=3.2,echo=F-----------------------------------------------
xm=aggregate(x~cluster,ddd,mean)
ym=aggregate(y~cluster,ddd,mean)
dm=cbind(xm,y=ym[,2])
# loop through data frame and create grp that links to cluster's mean
new=data.frame(x=double(),y=double(),cluster=character(),grp=integer(),
  stringsAsFactors = F)
count=0;
for (i in 1:5) {
  count=count+1
  new[2*count-1,]=c(a[i,],cluster="a",grp=count)
  new[2*count,]=c(dm[1,-1],cluster="a",grp=count)
  count=count+1
  new[2*count-1,]=c(b[i,],cluster="b",grp=count)
  new[2*count,]=c(dm[2,-1],cluster="b",grp=count)
}
ggplot(ddd,aes(x=x,y=y,colour=cluster))+
  coord_fixed(xlim=c(0,40),ylim=c(0,40))+
  geom_point()+
  geom_point(data=dm,shape=3)+
  geom_line(data=new,aes(group=grp),alpha=0.5)

## ----echo=F,fig.height=3.0-----------------------------------------------
ddd %>% summarize(x=mean(x),y=mean(y)) -> dm
# loop through data frame and create grp that links to cluster's mean
new=data.frame(x=double(),y=double(),cluster=character(),grp=integer(),
  stringsAsFactors = F)
count=0;
for (i in 1:5) {
  count=count+1
  new[2*count-1,]=c(a[i,],cluster="a",grp=count)
  new[2*count,]=c(dm[1,],cluster="a",grp=count)
  count=count+1
  new[2*count-1,]=c(b[i,],cluster="b",grp=count)
  new[2*count,]=c(dm[1,],cluster="b",grp=count)
}
ggplot(ddd,aes(x=x,y=y,colour=cluster))+
  coord_fixed(xlim=c(0,40),ylim=c(0,40))+
  geom_point()+
  geom_point(data=dm,aes(colour=NULL),shape=3)+
  geom_line(data=new,aes(group=grp),alpha=0.5)

## ----include=F-----------------------------------------------------------
options(width=60)

## ----size="scriptsize",message=F-----------------------------------------
my_url="http://www.utsc.utoronto.ca/~butler/d29/languages.txt"
number.d=read_table(my_url)
number.d

## ----size="footnotesize"-------------------------------------------------
d = number.d %>% 
    select(-la) %>%
    as.dist()
d
class(d)

## ----fig.height=4--------------------------------------------------------
d.hc=hclust(d,method="single")
plot(d.hc)

## ----echo=F--------------------------------------------------------------
options(width=25)

## ------------------------------------------------------------------------
d.hc$labels
d.hc$merge

## ----fig.height=4--------------------------------------------------------
d.hc=hclust(d,method="complete")
plot(d.hc)

## ----wardo,fig.height=4--------------------------------------------------
d.hc=hclust(d,method="ward.D")
plot(d.hc)

## ------------------------------------------------------------------------
cutree(d.hc,3)

## ----asfsagd,fig.height=4------------------------------------------------
plot(d.hc)
rect.hclust(d.hc,3)

## ----echo=F--------------------------------------------------------------
options(width=60)

## ----message=F, size="footnotesize"--------------------------------------
my_url="http://www.utsc.utoronto.ca/~butler/d29/one-ten.txt"
lang=read_delim(my_url," ")
lang 

## ----size="footnotesize"-------------------------------------------------
lang.long = lang %>% mutate(number=row_number()) %>%
    gather(language,name,-number) %>%
    mutate(first=str_sub(name,1,1))
lang.long %>% print(n=12)

## ----size="footnotesize"-------------------------------------------------
english = lang.long %>% filter(language=="en")
english

## ----size="footnotesize"-------------------------------------------------
norwegian = lang.long %>% filter(language=="no")
norwegian

## ----include=F-----------------------------------------------------------
options(width=70)

## ----size="scriptsize"---------------------------------------------------
english %>% left_join(norwegian, by="number")

## ------------------------------------------------------------------------
english %>% left_join(norwegian, by="number") %>%
  mutate(different=(first.x!=first.y)) %>%
  summarize(diff=sum(different))

## ------------------------------------------------------------------------
countdiff=function(lang.1,lang.2,d) {
    lang1d=d %>% filter(language==lang.1)
    lang2d=d %>% filter(language==lang.2)
    lang1d %>% left_join(lang2d, by="number") %>%
        mutate(different=(first.x!=first.y)) %>%
        summarize(diff=sum(different)) %>% 
        pull(diff)
}

## ------------------------------------------------------------------------
countdiff("en","no",lang.long)

## ----include=F-----------------------------------------------------------
options(width=50)

## ----size="footnotesize"-------------------------------------------------
languages=names(lang)
languages

## ----size="scriptsize"---------------------------------------------------
pairs=crossing(lang=languages, lang2=languages) %>% print(n=12)

## ----size="footnotesize"-------------------------------------------------
thediffs = pairs %>% 
    mutate(diff=map2_int(lang,lang2,countdiff,lang.long)) %>% 
    print(n=12)

## ----echo=F--------------------------------------------------------------
options(width=60)

## ----size="scriptsize"---------------------------------------------------
thediffs %>% spread(lang2,diff)

## ------------------------------------------------------------------------
my_url="http://www.utsc.utoronto.ca/~butler/d29/birthrate.txt"
vital=read_table(my_url)

## ------------------------------------------------------------------------
vital

## ----size="footnotesize"-------------------------------------------------
vital.s = vital %>% mutate_if(is.numeric,scale) 

## ----echo=FALSE----------------------------------------------------------
set.seed(457299)

## ------------------------------------------------------------------------
vital.km3 = vital.s %>% select(-4) %>% kmeans(3)
names(vital.km3)

## ------------------------------------------------------------------------
vital.km3$size

## ------------------------------------------------------------------------
vital.km3$centers

## ------------------------------------------------------------------------
vital.km3$withinss

## ----size="scriptsize"---------------------------------------------------
vital.km3$cluster

## ------------------------------------------------------------------------
vital.3=tibble(country=vital.s$country,
               cluster=vital.km3$cluster)

## ------------------------------------------------------------------------
get_countries=function(i,d) {
    d %>% filter(cluster==i) %>% pull(country)
}

## ----size="scriptsize"---------------------------------------------------
get_countries(2,vital.3)

## ----size="footnotesize"-------------------------------------------------
get_countries(3,vital.3)

## ----size="footnotesize"-------------------------------------------------
get_countries(1,vital.3)

## ----echo=FALSE----------------------------------------------------------
set.seed(457298)

## ----size="small"--------------------------------------------------------
vital.km3a=vital.s %>% select(-4) %>% kmeans(3)
table(first=vital.km3$cluster,
      second=vital.km3a$cluster)

## ----eval=FALSE,size="small"---------------------------------------------
## vital.km3b = vital.s %>% select(-4) %>%
##     kmeans(3,nstart=20)

## ------------------------------------------------------------------------
ss=function(i,d) {
    km = d %>% select_if(is.numeric) %>%
        kmeans(i,nstart=20)
    km$tot.withinss
}

## ----size="footnotesize"-------------------------------------------------
ssd = tibble(clusters=2:20) %>%
    mutate(wss=map_dbl(clusters,ss,vital.s)) %>% 
    print(n=10)

## ----favalli,fig.height=3.3----------------------------------------------
ggplot(ssd,aes(x=clusters,y=wss))+geom_point()+
  geom_line()

## ------------------------------------------------------------------------
vital.km6 = vital.s %>% select(-4) %>% 
    kmeans(6,nstart=20)
vital.km6$size
vital.km6$centers
vital.6=tibble(country=vital.s$country,
               cluster=vital.km6$cluster)

## ------------------------------------------------------------------------
get_countries(1,vital.6)

## ----size="small",echo=2-------------------------------------------------
options(width=60)
get_countries(2,vital.6)
options(width=50)

## ----size="footnotesize"-------------------------------------------------
get_countries(3,vital.6)

## ----size="small"--------------------------------------------------------
get_countries(4,vital.6)

## ------------------------------------------------------------------------
get_countries(5,vital.6)

## ------------------------------------------------------------------------
get_countries(6,vital.6)

## ------------------------------------------------------------------------
table(three=vital.km3$cluster,six=vital.km6$cluster)

## ----size="small"--------------------------------------------------------
v = vital.s %>% select(-4) %>% as.matrix()
cf = as.factor(vital.km6$cluster)
vital.manova=manova(v~cf)
summary(vital.manova)

## ------------------------------------------------------------------------
vital.lda=lda(cf~birth+death+infant,data=vital.s)
vital.lda$svd
vital.lda$scaling

## ----size="small"--------------------------------------------------------
vital.pred=predict(vital.lda)
d=data.frame(country=vital.s$country,
  cluster=vital.km6$cluster,vital.pred$x)
glimpse(d)

## ----size="small"--------------------------------------------------------
g=ggplot(d,aes(x=LD1,y=LD2,colour=factor(cluster),
    label=country))+geom_point()+
    geom_text_repel(size=2)+guides(colour=F)

## ----fig.height=3.5------------------------------------------------------
g

## ----message=F-----------------------------------------------------------
my_url="http://www.utsc.utoronto.ca/~butler/d29/ontario-road-distances.csv"
ontario=read_csv(my_url)
ontario.d = ontario %>% select(-1) %>% as.dist()
ontario.hc=hclust(ontario.d,method="ward.D")

## ----fig.height=4--------------------------------------------------------
plot(ontario.hc)
rect.hclust(ontario.hc,4)

## ----fig.height=4--------------------------------------------------------
plot(ontario.hc)
rect.hclust(ontario.hc,7)

## ----echo=F, warning=F---------------------------------------------------
pkgs = names(sessionInfo()$otherPkgs) 
pkgs=paste('package:', pkgs, sep = "")
x=lapply(pkgs, detach, character.only = TRUE, unload = TRUE)


## ----bMDS, child="bMDS.Rnw"----------------------------------------------

## ----size="footnotesize", message=F--------------------------------------
library(MASS)
library(tidyverse)
library(ggrepel)
library(ggmap)
library(shapes)

## ----include=F-----------------------------------------------------------
options(width=65)

## ----size="scriptsize"---------------------------------------------------
my_url="http://www.utsc.utoronto.ca/~butler/d29/europe.csv"
europe=read_csv(my_url)

## ----size="scriptsize"---------------------------------------------------
europe

## ------------------------------------------------------------------------
europe.d = europe %>% select(-1) %>% as.dist()
europe.scale=cmdscale(europe.d)
head(europe.scale)

## ----size="scriptsize"---------------------------------------------------
europe_coord = europe.scale %>% as_tibble() %>%
    mutate(city=europe$City) %>% print(n=12)
g = ggplot(europe_coord, aes(x=V1,y=V2,label=city))+
    geom_point() + geom_text_repel() 

## ----fig.height=3.6------------------------------------------------------
g

## ----size="footnotesize"-------------------------------------------------
mds_map=function(filename) {
    x=read_csv(filename)
    dist = x %>% select_if(is.numeric) %>% 
        as.dist()
    x.scale=cmdscale(dist) # this is a matrix
    x_coord = x.scale %>% 
        as_tibble() %>%
        mutate(place=row.names(x.scale))
    ggplot(x_coord, aes(x=V1,y=V2,label=place))+
        geom_point()+geom_text_repel()+
        coord_fixed()
}

## ----fig.height=4, message=F---------------------------------------------
mds_map("europe.csv")

## ----message=F,fig.height=3,fig.width=3----------------------------------
mds_map("square.csv")

## ----cache=T,size="small",message=F, eval=F------------------------------
## latlong = geocode(europe$City)
## latlong = bind_cols(city=europe$City, latlong)
## latlong %>% print(n=6)

## ----echo=F,size="small"-------------------------------------------------
latlong = readRDS("euro_latlong.rds")
latlong %>% print(n=6)

## ----eval=F--------------------------------------------------------------
## map=get_map("Memmingen DE",zoom=5)

## ----echo=F--------------------------------------------------------------
map=readRDS("memmingen.rds")

## ------------------------------------------------------------------------
g2=ggmap(map)+
  geom_point(data=latlong,aes(x=lon,y=lat),
  shape=3,colour="red")

## ----fig.height=3.6------------------------------------------------------
g2

## ----fig.height=4,echo=F-------------------------------------------------
g

## ----eval=F--------------------------------------------------------------
## library(rgl)
## es.2=cbind(europe.scale,1)
## plot3d(es.2,zlim=c(-1000,1000))
## text3d(es.2,text=d$city)

## ----message=F,fig.height=4----------------------------------------------
g=mds_map("ontario-road-distances.csv") ; g

## ----message=F-----------------------------------------------------------
my_url="http://www.utsc.utoronto.ca/~butler/d29/square.csv"
square=read_csv(my_url)
square

## ----size="footnotesize"-------------------------------------------------
square %>% gather(point,distance,-1)

## ------------------------------------------------------------------------
square %>% gather(point,distance,-1) %>%
  filter(x != "C", point != "C")

## ------------------------------------------------------------------------
noc = square %>% gather(point,distance,-1) %>%
  filter(x != "C", point != "C") %>%
  spread(point, distance)
noc
noc %>% write_csv("no-c.csv")

## ----message=F,fig.height=4----------------------------------------------
mds_map("no-c.csv")

## ----fig.height=4--------------------------------------------------------
g

## ----message=F,size="footnotesize"---------------------------------------
my_url="http://www.utsc.utoronto.ca/~butler/d29/ontario-road-distances.csv"
ontario2 = read_csv(my_url) %>%
    gather(place,distance,-1) %>%
    filter(x != "Thunder Bay", 
           place != "Thunder Bay",
           x != "Sault Ste Marie", 
           place != "Sault Ste Marie") %>%
    spread(place, distance) %>%
    write_csv("southern-ontario.csv")

## ----fig.height=4, message=F---------------------------------------------
g = mds_map("southern-ontario.csv") ; g

## ----zoom, size="small"--------------------------------------------------
g2 = g + coord_fixed(xlim=c(-150,-100),ylim=c(-50,0))

## ----spal,fig.height=3.5-------------------------------------------------
g2

## ----message=F, size="footnotesize",cache=T, eval=F----------------------
## cities=c("Kitchener ON", "Hamilton ON","Niagara Falls ON",
##          "St Catharines ON", "Brantford ON")
## latlong=geocode(cities)
## latlong = bind_cols(city=cities,latlong) %>% print()

## ----echo=F--------------------------------------------------------------
latlong=readRDS("ontario_trouble.rds")
latlong %>% print()

## ----message=F, eval=F---------------------------------------------------
## map=get_map("Hamilton ON", zoom=8)

## ----echo=F--------------------------------------------------------------
map=readRDS("hamilton_map.rds")

## ------------------------------------------------------------------------
gmap = ggmap(map)+
       geom_point(data=latlong,
                  aes(x=lon,y=lat),
                  shape=3,colour="red")+
       geom_text_repel(data=latlong,
                       aes(label=city))

## ----fig.height=5.5------------------------------------------------------
g2

## ----fig.height=5.5, warning=F-------------------------------------------
gmap

## ----message=F-----------------------------------------------------------
my_url="http://www.utsc.utoronto.ca/~butler/d29/southern-ontario.csv"
ontario2=read_csv(my_url)

## ----size="footnotesize"-------------------------------------------------
ontario2.2 = ontario2 %>% select_if(is.numeric) %>% 
    cmdscale(eig=T)
names(ontario2.2)
ontario2.2$GOF
ontario2.3 = ontario2 %>% select_if(is.numeric) %>% 
    cmdscale(3,eig=T)
ontario2.3$GOF

## ----size="scriptsize"---------------------------------------------------
ontario2.3$points %>% as_tibble() %>%
    mutate(city=ontario2$x)

## ----eval=F--------------------------------------------------------------
## library(rgl)
## plot3d(ontario.3)
## text3d(ontario.3,text=d2$city)

## ----size="footnotesize", message=F, cache=T, eval=F---------------------
## lookup=str_c(ontario2$x," ON")
## latlong=geocode(lookup)
## latlong = bind_cols(city=ontario2$x,latlong) %>% print(n=4)

## ----echo=F, size="footnotesize"-----------------------------------------
latlong=readRDS("ontario_all.rds")
latlong %>% print(n=4)

## ------------------------------------------------------------------------
m=mean(latlong$lat); m

## ------------------------------------------------------------------------
mult=cos(m*pi/180); mult

## ----size="footnotesize"-------------------------------------------------
truecoord=with(latlong,cbind(V1=lon*mult,V2=lat))

## ----message=F,size="footnotesize"---------------------------------------
ontario.pro=procOPA(truecoord,
                    ontario2.2$points)
names(ontario.pro)

## ----size="scriptsize"---------------------------------------------------
A = ontario.pro$Ahat %>% as_tibble() %>% 
    mutate(which="actual", city=ontario2$x)
B = ontario.pro$Bhat %>% as_tibble() %>% 
    mutate(which="MDS", city=ontario2$x)
dp=bind_rows(A,B)
dp %>% sample_n(6)

## ----size="footnotesize"-------------------------------------------------
g_opa = ggplot(dp,aes(x=V1,y=V2,colour=which,
                      label=city))+geom_point()+
    geom_line(aes(group=city),colour="green")+
    geom_text_repel(size=2)

## ----prosesto,echo=F,fig.height=4----------------------------------------
g_opa

## ------------------------------------------------------------------------
ontario.pro$R

## ----fig.height=4--------------------------------------------------------
g

## ----f, message=F, size="footnotesize"-----------------------------------
my_url="http://www.utsc.utoronto.ca/~butler/d29/cube.txt"
cube=read_delim(my_url," ")
cube

## ----cuby----------------------------------------------------------------
cube.d=cube %>% select(-1) %>% as.dist()
cube.d

## ------------------------------------------------------------------------
cube.2 = cube.d %>% cmdscale(eig=T)

## ------------------------------------------------------------------------
d = cube.2$points %>% as_tibble() %>%
    mutate(corners=cube$x) 

## ------------------------------------------------------------------------
g=ggplot(d,aes(x=V1,y=V2,label=corners))+
  geom_point()+geom_text_repel()

## ----bianconeri,echo=F,fig.height=4--------------------------------------
g

## ------------------------------------------------------------------------
cube.3 = cube.d %>% cmdscale(3,eig=T)
cube.2$GOF
cube.3$GOF

## ----include=F-----------------------------------------------------------
options(width=55)

## ----message=F, size="scriptsize"----------------------------------------
my_url="http://www.utsc.utoronto.ca/~butler/d29/languages.txt"
number.d=read_table(my_url)
number.d

## ----size="small"--------------------------------------------------------
d = number.d %>% select_if(is.numeric) %>% 
    as.dist()
number.nm = d %>% isoMDS()
names(number.nm)

## ------------------------------------------------------------------------
number.nm$stress

## ------------------------------------------------------------------------
dd = number.nm$points %>% as_tibble() %>%
    mutate(lang=number.d$la) 

## ------------------------------------------------------------------------
g=ggplot(dd,aes(x=V1,y=V2,label=lang))+
  geom_point()+geom_text_repel()

## ----padova,echo=F,fig.height=4------------------------------------------
g

## ----parma,fig.height=3.5------------------------------------------------
Shepard(d,number.nm$points) %>% as_tibble() %>%
  ggplot(aes(x=x,y=y))+geom_point()

## ----size="small"--------------------------------------------------------
cube.d = cube %>% select(-x) %>% as.dist(cube)
cube.2=isoMDS(cube.d,trace=F) ; cube.2$stress
cube.3=isoMDS(cube.d,k=3,trace=F) ; cube.3$stress

## ----size="footnotesize"-------------------------------------------------
cube2.sh=Shepard(cube.d,cube.2$points)
g2=ggplot(as.data.frame(cube2.sh),aes(x=x,y=y))+
  geom_point()
cube3.sh=Shepard(cube.d,cube.3$points)
g3=ggplot(as.data.frame(cube3.sh),aes(x=x,y=y))+
  geom_point()

## ----fig.height=3.5------------------------------------------------------
g2

## ----fig.height=3.5------------------------------------------------------
g3


## ----bPrincomp, child="bPrincomp.Rnw"------------------------------------

## ----size="scriptsize",echo=F,message=F----------------------------------
library(plyr) # for annoying technical reasons (here)
library(ggbiplot)
library(tidyverse)
library(ggrepel)

## ----eval=F--------------------------------------------------------------
## library(ggbiplot) # see over
## library(tidyverse)
## library(ggrepel)

## ----eval=F--------------------------------------------------------------
## install.packages("devtools")

## ----eval=F--------------------------------------------------------------
## library(devtools)
## install_github("vqv/ggbiplot")

## ----testt,message=F,size="small"----------------------------------------
my_url="http://www.utsc.utoronto.ca/~butler/d29/test12.txt"
test12=read_table2(my_url)
test12

## ----ff1-----------------------------------------------------------------
g=ggplot(test12,aes(x=first,y=second,label=id))+
  geom_point()+geom_text_repel()

## ----ff2,fig.height=4----------------------------------------------------
g+geom_smooth(method="lm",se=F)

## ----size="small"--------------------------------------------------------
test12_numbers = test12 %>% select_if(is.numeric)

## ----size="small"--------------------------------------------------------
cor(test12_numbers)

## ----plot12,size="small"-------------------------------------------------
test12.pc = test12_numbers %>% princomp(cor=T)
summary(test12.pc)

## ----fig.height=3.5------------------------------------------------------
ggscreeplot(test12.pc)

## ------------------------------------------------------------------------
test12.pc$loadings

## ------------------------------------------------------------------------
d=data.frame(test12,test12.pc$scores) ; d

## ----score-plot,fig.height=3.5-------------------------------------------
ggplot(d,aes(x=Comp.1,y=Comp.2,label=id))+
  geom_point()+geom_text_repel()

## ----eqsc----------------------------------------------------------------
g=ggplot(d,aes(x=Comp.1,y=Comp.2,label=id))+
  geom_point()+geom_text_repel()+
  coord_fixed()

## ----eqsc2,fig.height=2--------------------------------------------------
g

## ------------------------------------------------------------------------
g=ggbiplot(test12.pc,labels=test12$id)

## ----ff3,fig.height=4,echo=F---------------------------------------------
g

## ----echo=F--------------------------------------------------------------
w=getOption("width")
options(width=w+10)

## ----size="scriptsize",message=F-----------------------------------------
my_url="http://www.utsc.utoronto.ca/~butler/d29/men-track-field.txt"
track=read_table2(my_url)
track %>% sample_n(12)

## ----message=F, size="small"---------------------------------------------
my_url="http://www.utsc.utoronto.ca/~butler/d29/isocodes.txt"
iso=read_csv(my_url)
iso

## ----echo=FALSE----------------------------------------------------------
options(width=50)

## ----scree-a,size="footnotesize"-----------------------------------------
track_num = track %>% select_if(is.numeric)
track.pc=princomp(track_num,cor=T)
summary(track.pc)

## ----scree-b,fig.height=3.5----------------------------------------------
ggscreeplot(track.pc)

## ----size="footnotesize",echo=2------------------------------------------
options(width=60)
track.pc$loadings

## ----pc-plot-------------------------------------------------------------
d=data.frame(track.pc$scores,
  country=track$country)
names(d)
g1=ggplot(d,aes(x=Comp.1,y=Comp.2,
  label=country))+
  geom_point()+geom_text_repel()+
    coord_fixed()

## ----biplot--------------------------------------------------------------
g2=ggbiplot(track.pc,labels=track$country)

## ----lecce,fig.height=3.9------------------------------------------------
g1

## ----biplot2,fig.height=3.5----------------------------------------------
g2

## ----size="footnotesize",warning=F---------------------------------------
d %>% arrange(desc(Comp.1)) %>%
    left_join(iso,by=c("country"="ISO2")) %>%
    select(Comp.1,country,Country) %>%
    slice(1:8)

## ----size="footnotesize",warning=F---------------------------------------
d %>% arrange(Comp.1) %>%
    left_join(iso,by=c("country"="ISO2")) %>%
    select(Comp.1,country,Country) %>%
    slice(1:8)

## ----"footnotesize", warning=F-------------------------------------------
d %>% arrange(desc(Comp.1)) %>%
    left_join(iso,by=c("country"="ISO2")) %>%
    select(Comp.1,country,Country) %>%
    slice(1:8)

## ----size="footnotesize",warning=F---------------------------------------
d %>% arrange(desc(Comp.2)) %>%
    left_join(iso,by=c("country"="ISO2")) %>%
    select(Comp.2,country,Country) %>%
    slice(1:8)

## ----size="footnotesize",warning=F---------------------------------------
d %>% arrange(Comp.2) %>%
    left_join(iso,by=c("country"="ISO2")) %>%
    select(Comp.2,country,Country) %>%
    slice(1:10)

## ------------------------------------------------------------------------
g = d %>% left_join(iso,by=c("country"="ISO2")) %>%
    select(Comp.1,Comp.2,Country) %>%
    ggplot(aes(x=Comp.1,y=Comp.2,label=Country))+
      geom_point()+geom_text_repel(size=1)+
      coord_fixed()


## ----fig.height=5.5, warning=F-------------------------------------------
g

## ----message=F-----------------------------------------------------------
my_url="http://www.utsc.utoronto.ca/~butler/d29/cov.txt"
mat=read_table(my_url,col_names=F)
mat

## ----pc-cov,fig.height=4-------------------------------------------------
mat.pc = mat %>% as.matrix() %>%
    princomp(covmat=.)

## ----palermo,fig.height=3.5----------------------------------------------
ggscreeplot(mat.pc)

## ----size="scriptsize"---------------------------------------------------
mat

## ----size="scriptsize"---------------------------------------------------
mat.pc$loadings

## ----echo=F, warning=F---------------------------------------------------
pkgs = names(sessionInfo()$otherPkgs) 
pkgs=paste('package:', pkgs, sep = "")
x=lapply(pkgs, detach, character.only = TRUE, unload = TRUE)


## ----bFactor, child="bFactor.Rnw"----------------------------------------

## ----warning=F, message=F------------------------------------------------
library(lavaan) # confirmatory factor analysis
library(ggbiplot)
library(tidyverse)

## ----kids-scree,message=F------------------------------------------------
my_url="http://www.utsc.utoronto.ca/~butler/d29/rex2.txt"
kids = read_delim(my_url," ") 
kids
kids.pc = kids %>%
    select_if(is.numeric) %>%
    as.matrix() %>%
    princomp(covmat=.)

## ----fig.height=3.5------------------------------------------------------
ggscreeplot(kids.pc)

## ----size="footnotesize"-------------------------------------------------
kids.pc$loadings

## ------------------------------------------------------------------------
km = kids %>%
    select_if(is.numeric) %>%
    as.matrix() 
km2=list(cov=km,n.obs=145)
kids.f2=factanal(factors=2,covmat=km2)

## ------------------------------------------------------------------------
kids.f2$uniquenesses

## ----size="footnotesize"-------------------------------------------------
kids.f2$loadings

## ------------------------------------------------------------------------
kids.f2$STATISTIC
kids.f2$dof
kids.f2$PVAL

## ------------------------------------------------------------------------
kids.f1=factanal(factors=1,covmat=km2)
kids.f1$STATISTIC
kids.f1$dof
kids.f1$PVAL

## ----fig.height=3.5------------------------------------------------------
g2 

## ----track-factor-biplot,size="footnotesize"-----------------------------
track
track.f = track %>% select_if(is.numeric) %>%
    factanal(2,scores="r")

## ----siracusa,fig.height=4-----------------------------------------------
biplot(track.f$scores,track.f$loadings,
xlabs=track$country)

## ------------------------------------------------------------------------
track.f$loadings

## ------------------------------------------------------------------------
scores=data.frame(country=track$country,
                  track.f$scores)
scores %>% slice(1:6)

## ----warning=F,size="footnotesize"---------------------------------------
scores %>% arrange(Factor2) %>% 
  left_join(iso,by=c("country"="ISO2")) %>%
  select(Country,Factor1,Factor2) %>%  
  slice(1:10)

## ----warning=F, size="footnotesize"--------------------------------------
scores %>% arrange(Factor1) %>% 
  left_join(iso,by=c("country"="ISO2")) %>%
  select(Country,Factor1,Factor2) %>%  
  slice(1:10)

## ----bem-scree,size="scriptsize",message=F-------------------------------
my_url="http://www.utsc.utoronto.ca/~butler/d29/factor.txt"
bem=read_tsv(my_url)
bem

## ------------------------------------------------------------------------
bem.pc = bem %>% select(-subno) %>%
  princomp(cor=T)

## ----genoa,fig.height=3.5------------------------------------------------
g=ggscreeplot(bem.pc) ; g

## ----bem-scree-two,fig.height=3.5,warning=F------------------------------
g+scale_x_continuous(limits=c(0,8))

## ------------------------------------------------------------------------
summary(bem.pc)

## ----bem-biplot,fig.height=3.5-------------------------------------------
ggbiplot(bem.pc,alpha=0.3)

## ------------------------------------------------------------------------
bem.2 = bem %>% select(-subno) %>%
    factanal(factors=2)

## ----echo=-1,size="scriptsize"-------------------------------------------
options(width=60)
bem.2$uniquenesses

## ----size="scriptsize"---------------------------------------------------
bem.2$loadings

## ----size="footnotesize"-------------------------------------------------
loadings = as.data.frame(unclass(bem.2$loadings)) %>%
  mutate(trait=rownames(bem.2$loadings))
loadings %>% slice(1:10)

## ----size="footnotesize"-------------------------------------------------
loadings %>% filter(abs(Factor1)>0.4)

## ----size="footnotesize"-------------------------------------------------
loadings %>% filter(abs(Factor2)>0.4)

## ----biplot-two-again,fig.height=5,eval=F--------------------------------
## bem.2a=factanal(bem[,-1],factors=2,scores="r")
## biplot(bem.2a$scores,bem.2a$loadings,cex=c(0.5,0.5))

## ----biplot-two-ag,fig.height=4,echo=F-----------------------------------
bem.2a=factanal(bem[,-1],factors=2,scores="r")
biplot(bem.2a$scores,bem.2a$loadings,cex=c(0.5,0.5))

## ----size="tiny"---------------------------------------------------------
bem %>% slice(366) %>% glimpse()

## ----size="scriptsize"---------------------------------------------------
bem_tidy = bem %>% mutate(row=row_number()) %>%
    gather(trait,score,c(-subno,-row))
bem_tidy

## ----size="footnotesize"-------------------------------------------------
loadings %>% slice(1:10)

## ----size="scriptsize"---------------------------------------------------
bem_tidy = bem_tidy %>% left_join(loadings) 
bem_tidy %>% sample_n(12)

## ----size="footnotesize"-------------------------------------------------
bem_tidy %>% filter(row==366, abs(Factor2)>0.4)

## ----size="footnotesize"-------------------------------------------------
bem_tidy %>% filter(row %in% c(366,311,214), 
                    abs(Factor2)>0.4)

## ----size="scriptsize"---------------------------------------------------
bem_tidy %>% filter(row %in% c(366,311,214), 
                    abs(Factor2)>0.4) %>%
    select(-subno,-Factor1,-Factor2) %>%
    spread(row,score) 

## ----size="scriptsize"---------------------------------------------------
bem_tidy %>% filter(row %in% c(359,258,230),abs(Factor1)>0.4) %>%
    select(-subno,-Factor1,-Factor2) %>% spread(row,score) 

## ------------------------------------------------------------------------
bem.2$PVAL

## ------------------------------------------------------------------------
bem.15 = bem %>% select(-subno) %>% 
    factanal(factors=15)
bem.15$PVAL

## ----size="small"--------------------------------------------------------
loadings = as.data.frame(unclass(bem.15$loadings)) %>%
  mutate(trait=rownames(bem.15$loadings))

## ----size="footnotesize"-------------------------------------------------
loadings %>% arrange(desc(abs(Factor1))) %>%
    select(Factor1, trait) %>% slice(1:10)

## ----size="footnotesize"-------------------------------------------------
loadings %>% arrange(desc(abs(Factor2))) %>%
    select(Factor2, trait) %>% slice(1:10)

## ----size="footnotesize"-------------------------------------------------
loadings %>% arrange(desc(abs(Factor3))) %>%
    select(Factor3, trait) %>% slice(1:10)

## ----size="footnotesize"-------------------------------------------------
loadings %>% arrange(desc(abs(Factor4))) %>%
    select(Factor4, trait) %>% slice(1:10)

## ----size="footnotesize"-------------------------------------------------
loadings %>% arrange(desc(abs(Factor5))) %>%
    select(Factor5, trait) %>% slice(1:10)

## ----size="footnotesize"-------------------------------------------------
loadings %>% arrange(desc(abs(Factor6))) %>%
    select(Factor6, trait) %>% slice(1:10)

## ----size="footnotesize"-------------------------------------------------
loadings %>% arrange(desc(abs(Factor7))) %>%
    select(Factor7, trait) %>% slice(1:10)

## ----size="footnotesize"-------------------------------------------------
loadings %>% arrange(desc(abs(Factor8))) %>%
    select(Factor8, trait) %>% slice(1:10)

## ----size="footnotesize"-------------------------------------------------
loadings %>% arrange(desc(abs(Factor9))) %>%
    select(Factor9, trait) %>% slice(1:10)

## ----size="footnotesize"-------------------------------------------------
loadings %>% arrange(desc(abs(Factor10))) %>%
    select(Factor10, trait) %>% slice(1:10)

## ----size="footnotesize"-------------------------------------------------
loadings %>% arrange(desc(abs(Factor11))) %>%
    select(Factor11, trait) %>% slice(1:10)

## ----size="footnotesize"-------------------------------------------------
loadings %>% arrange(desc(abs(Factor12))) %>%
    select(Factor12, trait) %>% slice(1:10)

## ----size="footnotesize"-------------------------------------------------
loadings %>% arrange(desc(abs(Factor13))) %>%
    select(Factor13, trait) %>% slice(1:10)

## ----size="footnotesize"-------------------------------------------------
loadings %>% arrange(desc(abs(Factor14))) %>%
    select(Factor14, trait) %>% slice(1:10)

## ----size="footnotesize"-------------------------------------------------
loadings %>% arrange(desc(abs(Factor15))) %>%
    select(Factor15, trait) %>% slice(1:10)

## ----size="scriptsize"---------------------------------------------------
data.frame(uniq=bem.15$uniquenesses) %>%
    rownames_to_column() %>%
    arrange(desc(uniq)) %>% slice(1:10)

## ------------------------------------------------------------------------
km

## ------------------------------------------------------------------------
test.model.1='ability=~para+sent+word+add+dots'

## ------------------------------------------------------------------------
test.model.2='
    verbal=~para+sent+word
    math=~add+dots'

## ------------------------------------------------------------------------
fit1=cfa(test.model.1,sample.cov=km,
    sample.nobs=145)

## ----size="scriptsize"---------------------------------------------------
fit1

## ----size="scriptsize"---------------------------------------------------
fit2=cfa(test.model.2,sample.cov=km,sample.nobs=145)
fit2

## ----size="scriptsize"---------------------------------------------------
anova(fit1,fit2)

## ----size="footnotesize"-------------------------------------------------
track %>% print(n=6)

## ----size="footnotesize"-------------------------------------------------
track.model='
sprint=~m100+m200+m400+m800
distance=~m1500+m5000+m10000+marathon'

## ----size="scriptsize"---------------------------------------------------
track.1 = track %>% select(-country) %>% 
  cfa(track.model,data=.,std.ov=T)
track.1

## ------------------------------------------------------------------------
track.model.2='
sprint=~m100+m200+m400
middle=~m800+m1500
distance=~m5000+m10000+marathon'

## ----size="scriptsize"---------------------------------------------------
track.2 = track %>% select(-country) %>%
  cfa(track.model.2,data=.,std.ov=T)
track.2

## ----size="footnotesize"-------------------------------------------------

anova(track.1,track.2)

## ----echo=F, warning=F---------------------------------------------------
pkgs = names(sessionInfo()$otherPkgs) 
pkgs=paste('package:', pkgs, sep = "")
x=lapply(pkgs, detach, character.only = TRUE, unload = TRUE)


## ----bMultiway, child="bMultiway.Rnw"------------------------------------

## ----size="footnotesize"-------------------------------------------------
library(tidyverse)

## ----message=F-----------------------------------------------------------
my_url="http://www.utsc.utoronto.ca/~butler/d29/eyewear.txt"
eyewear=read_delim(my_url," ")
eyewear

## ----size="footnotesize"-------------------------------------------------
eyes = eyewear %>% 
    gather(eyewear,frequency,contacts:none) 
eyes
xt=xtabs(frequency~gender+eyewear,data=eyes)
xt

## ------------------------------------------------------------------------
eyes.1=glm(frequency~gender*eyewear,data=eyes,
    family="poisson")

## ------------------------------------------------------------------------
drop1(eyes.1,test="Chisq")

## ------------------------------------------------------------------------
xt

## ------------------------------------------------------------------------
prop.table(xt,margin=1)

## ----size="scriptsize", message=F----------------------------------------
my_url="http://www.utsc.utoronto.ca/~butler/d29/eyewear2.txt"
eyewear2=read_table(my_url)
eyes2 = eyewear2 %>% gather(eyewear,frequency,contacts:none)
xt2=xtabs(frequency~gender+eyewear,data=eyes2)
xt2
prop.table(xt2,margin=1)

## ----size="footnotesize"-------------------------------------------------
eyes.2=glm(frequency~gender*eyewear,data=eyes2,
  family="poisson")
drop1(eyes.2,test="Chisq")

## ------------------------------------------------------------------------
eyes.3=update(eyes.2,.~.-gender:eyewear)
drop1(eyes.3,test="Chisq")

## ----size="small", message=F---------------------------------------------
my_url="http://www.utsc.utoronto.ca/~butler/d29/ecg.txt"
chest=read_delim(my_url," ")
chest.1=glm(count~ecg*bmi*smoke,data=chest,
            family="poisson")
drop1(chest.1,test="Chisq")

## ----size="small"--------------------------------------------------------
chest.2=update(chest.1,.~.-ecg:bmi:smoke)
drop1(chest.2,test="Chisq")

## ----size="small"--------------------------------------------------------
chest.3=update(chest.2,.~.-bmi:smoke)
drop1(chest.3,test="Chisq")

## ------------------------------------------------------------------------
xtabs(count~ecg+bmi,data=chest)

## ------------------------------------------------------------------------
xtabs(count~ecg+smoke,data=chest)

## ----message=F, size="small"---------------------------------------------
my_url="http://www.utsc.utoronto.ca/~butler/d29/airlines.txt"
airlines=read_table2(my_url)
punctual = airlines %>% 
    gather(line.status,freq, contains("_")) %>%
    separate(line.status,c("airline","status"))

## ----echo=F, size="scriptsize"-------------------------------------------
punctual

## ------------------------------------------------------------------------
xt=xtabs(freq~airline+status,data=punctual)
xt

## ------------------------------------------------------------------------
prop.table(xt,margin=1)

## ----size="footnotesize"-------------------------------------------------
xt=xtabs(freq~airline+status+airport,data=punctual)
xp=prop.table(xt,margin=c(1,3))
ftable(xp,row.vars=c("airport","airline"),
col.vars="status")

## ----size="footnotesize"-------------------------------------------------
punctual.1=glm(freq~airport*airline*status,
    data=punctual,family="poisson")
drop1(punctual.1,test="Chisq")

## ----size="footnotesize"-------------------------------------------------
punctual.2=update(punctual.1,~.-airport:airline:status)
drop1(punctual.2,test="Chisq")

## ------------------------------------------------------------------------
xt=xtabs(freq~airline+status,data=punctual)
prop.table(xt, margin=1)

## ------------------------------------------------------------------------
xt=xtabs(freq~airport+status,data=punctual)
prop.table(xt,margin=1)

## ------------------------------------------------------------------------
xt=xtabs(freq~airport+airline,data=punctual)
prop.table(xt,margin=2)

## ----message=F-----------------------------------------------------------
my_url="http://www.utsc.utoronto.ca/~butler/d29/cancer.txt"
cancer=read_delim(my_url," ")
cancer %>% print(n=6)
cancer.1=glm(freq~stage*operation*xray*survival,
    data=cancer,family="poisson")

## ----size="scriptsize"---------------------------------------------------
drop1(cancer.1,test="Chisq")

## ----size="scriptsize"---------------------------------------------------
cancer.2=update(cancer.1,~.
-stage:operation:xray:survival)
drop1(cancer.2,test="Chisq")

## ----size="scriptsize"---------------------------------------------------
cancer.3=update(cancer.2,.~.-stage:xray:survival)
drop1(cancer.3,test="Chisq")

## ----size="scriptsize"---------------------------------------------------
cancer.4=update(cancer.3,.~.-operation:xray:survival)
drop1(cancer.4,test="Chisq")

## ----size="scriptsize"---------------------------------------------------
cancer.5=update(cancer.4,.~.-xray:survival)
drop1(cancer.5,test="Chisq")

## ----size="scriptsize"---------------------------------------------------
cancer.6=update(cancer.5,.~.-stage:operation:survival)
drop1(cancer.6,test="Chisq")

## ----size="footnotesize"-------------------------------------------------
cancer.7=update(cancer.6,.~.-operation:survival)
drop1(cancer.7,test="Chisq")

## ------------------------------------------------------------------------
xt=xtabs(freq~stage+survival,data=cancer)
prop.table(xt,margin=1)

## ------------------------------------------------------------------------
xt=xtabs(freq~operation+xray+stage,data=cancer)
ftable(prop.table(xt,margin=3))

## ----echo=F, warning=F---------------------------------------------------
pkgs = names(sessionInfo()$otherPkgs) 
pkgs=paste('package:', pkgs, sep = "")
x=lapply(pkgs, detach, character.only = TRUE, unload = TRUE)


