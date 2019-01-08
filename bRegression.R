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

## ----fig.height=2.8------------------------------------------------------
log.y=log(madeup$y) 
ggplot(madeup,aes(x=x,y=log.y))+geom_point()+
  geom_smooth()

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
lgtime=with(visits,log(timedrs+1))
visits.3=lm(lgtime~phyheal+menheal+stress,
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
## boxcox(timedrs+1~phyheal+menheal+stress,data=visitsp)

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
visits.5=lm(lgtime~phyheal+menheal+stress,data=visits)
visits.6=lm(lgtime~stress,data=visits)
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

