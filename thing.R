
## ----bLogistic, child="bLogistic.Rnw"------------------------------------

## ----size="small"--------------------------------------------------------
rats=read_delim("rat.txt"," ")

## ----size="small"--------------------------------------------------------
rats

## ----size="small"--------------------------------------------------------
rats2 = rats %>% mutate(status=factor(status))

## ----size="small"--------------------------------------------------------
status.1 = 
  glm(status~dose,family="binomial",data=rats2)

## ------------------------------------------------------------------------

## ------------------------------------------------------------------------
summary(status.1)

## ------------------------------------------------------------------------
p=predict(status.1,type="response")
cbind(rats,p)

## ----size="footnotesize"-------------------------------------------------
rat2=read_delim("rat2.txt"," ")
rat2

## ------------------------------------------------------------------------
response=with(rat2,cbind(lived,died))
rat2.1=glm(response~dose,family="binomial",
  data=rat2)

## ------------------------------------------------------------------------
summary(rat2.1)

## ------------------------------------------------------------------------
p=predict(rat2.1,type="response")
cbind(rat2,p)

## ----size="footnotesize"-------------------------------------------------
sepsis=read_delim("sepsis.txt"," ")

## ----size="footnotesize"-------------------------------------------------
sepsis

## ------------------------------------------------------------------------
sepsis.1=glm(death~shock+malnut+alcohol+age+
              bowelinf,family="binomial",
	      data=sepsis)

## ----size="footnotesize"-------------------------------------------------
library(broom)
tidy(sepsis.1)

## ----size="footnotesize"-------------------------------------------------
sepsis.2=update(sepsis.1,.~.-malnut)
tidy(sepsis.2)

## ----size="footnotesize"-------------------------------------------------
sepsis.pred=predict(sepsis.2,type="response")
d=data.frame(sepsis,sepsis.pred)
myrows=c(4,1,2,11,32) ; slice(d,myrows)

## ----virtusentella,fig.height=3.5, warning=F-----------------------------
ggplot(augment(sepsis.2),aes(x=age,y=.resid))+
  geom_point()

## ----size="footnotesize"-------------------------------------------------
sepsis.2.tidy=tidy(sepsis.2)
sepsis.2.tidy

## ----size="small"--------------------------------------------------------
cc=exp(sepsis.2.tidy$estimate)
data.frame(sepsis.2.tidy$term,expcoeff=round(cc,2))

## ----size="small"--------------------------------------------------------
(od1=0.02/0.98)
(od2=0.01/0.99)

## ----size="small"--------------------------------------------------------
od1/od2 # very close to 2

## ------------------------------------------------------------------------
freqs=read_table("miners-tab.txt")

## ------------------------------------------------------------------------
freqs

## ------------------------------------------------------------------------
freqs %>% 
  gather(Severity,Freq,None:Severe) %>%
  group_by(Exposure) %>%
  mutate(proportion=prop.table(Freq)) -> miners

## ------------------------------------------------------------------------
miners

## ----fig.height=3.5,size="small"-----------------------------------------
ggplot(miners,aes(x=Exposure,y=proportion,
    colour=Severity))+geom_point()+geom_line()

## ------------------------------------------------------------------------
miners

## ------------------------------------------------------------------------
v=unique(miners$Severity)
v

## ----size="small"--------------------------------------------------------
miners = miners %>% 
    mutate(sev_ord=ordered(Severity,v))

## ------------------------------------------------------------------------
miners

## ----fig.height=3.5,size="small"-----------------------------------------
ggplot(miners,aes(x=Exposure,y=proportion,
    colour=sev_ord))+geom_point()+geom_line()

## ------------------------------------------------------------------------
library(MASS)
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

## ------------------------------------------------------------------------
sev.new=data.frame(Exposure=freqs$Exposure)
pr=predict(sev.1,sev.new,type="p")
miners.pred=cbind(sev.new,pr)
miners.pred

## ------------------------------------------------------------------------
miners.pred %>% 
  gather(Severity,probability,None:Severe) -> 
    preds
head(preds)

## ------------------------------------------------------------------------
g=ggplot(preds,aes(x=Exposure,y=probability,
    colour=Severity)) + geom_line() +
  geom_point(data=miners,aes(y=proportion))

## ----fig.height=3.6------------------------------------------------------
g

## ----echo=F--------------------------------------------------------------
detach("package:MASS",unload=T)

## ------------------------------------------------------------------------
brandpref=read.csv("mlogit.csv",header=T)
head(brandpref)

## ------------------------------------------------------------------------
brandpref = brandpref %>% 
    mutate(sex=factor(sex)) %>%
    mutate(brand=factor(brand))

## ------------------------------------------------------------------------
library(nnet)
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
probs %>% gather(brand,probability,
  -(age:sex)) -> probs.long
sample_n(probs.long,7) # 7 random rows

## ----fig.height=3.3------------------------------------------------------
ggplot(probs.long,aes(x=age,y=probability,
  colour=brand,shape=sex))+
  geom_point()+geom_line(aes(linetype=sex))

## ------------------------------------------------------------------------
b = brandpref %>%
      group_by(age,sex,brand) %>%
      summarize(Freq=n())
head(b)  

## ----size="footnotesize"-------------------------------------------------
bf = b %>% ungroup() %>%
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
brands = b %>%  
  group_by(age,sex) %>%
  mutate(proportion=prop.table(Freq)) 

## ------------------------------------------------------------------------
brands %>% filter(age==32)

## ----fig.height=3.2------------------------------------------------------
g=ggplot(probs.long,aes(x=age,y=probability,
  colour=brand,shape=sex))+
  geom_line(aes(linetype=sex))+
  geom_point(data=brands,aes(y=proportion))


## ----fig.height=4--------------------------------------------------------
g

## ----echo=F--------------------------------------------------------------
options(width=60)

## ------------------------------------------------------------------------
b.4=update(b.1,.~.+age:sex)
anova(b.1,b.4)


