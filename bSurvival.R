## ------------------------------------------------------------------------
library(survival)
library(survminer)
dance=read.table("dancing.txt",header=T)
attach(dance)
mth=Surv(Months,Quit)
mth

## ------------------------------------------------------------------------
dance.1=coxph(mth~Treatment+Age)

ggcoxdiagnostics(dance.1)+geom_smooth(se=F)

## ------------------------------------------------------------------------
summary(dance.1)



## ------------------------------------------------------------------------
dance.new=expand.grid(Treatment=c(0,1),Age=c(20,40))
dance.new

## ------------------------------------------------------------------------
s=survfit(dance.1,newdata=dance.new)

## ------------------------------------------------------------------------
summary(s)
t(dance.new)

## ------------------------------------------------------------------------
library(survminer)
g=ggsurvplot(s)

## ----fig.height=3.5------------------------------------------------------
g

## ------------------------------------------------------------------------
head(lung,12)

## ----echo=F,results="hide"-----------------------------------------------
suppressMessages(library(tidyverse))

## ------------------------------------------------------------------------
lung %>% na.omit() -> lung.complete
lung.complete %>% select(meal.cal:wt.loss) %>% head(12)

## ------------------------------------------------------------------------
head(lung.complete)

## ------------------------------------------------------------------------
resp=with(lung.complete,Surv(time,status==2))
lung.1=coxph(resp~age+sex+ph.ecog+ph.karno+pat.karno+
               meal.cal+wt.loss,data=lung.complete)

## ------------------------------------------------------------------------
summary(lung.1)

## ------------------------------------------------------------------------
s=summary(lung.1)
rbind(s$logtest,s$waldtest,s$sctest)

## ------------------------------------------------------------------------
s$coefficients

## ------------------------------------------------------------------------
lung.2=update(lung.1,.~.-age-pat.karno-meal.cal)
summary(lung.2)$coefficients

## ------------------------------------------------------------------------
lung.3=update(lung.2,.~.-ph.karno-wt.loss)
summary(lung.3)$coefficients

## ------------------------------------------------------------------------
anova(lung.3,lung.1)

ggcoxdiagnostics(lung.3)+geom_smooth()

## ------------------------------------------------------------------------
lung.new=expand.grid(sex=c(1,2),ph.ecog=0:3)
lung.new
s=survfit(lung.3,newdata=lung.new)

## ----fig.height=4.2------------------------------------------------------
ggsurvplot(s)

