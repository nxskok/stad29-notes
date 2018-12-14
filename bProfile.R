## ------------------------------------------------------------------------
dogs=read.table("dogs.txt",header=T)
dogs
attach(dogs)

detach(dogs)
rm(x)
detach(prepost)

response=cbind(lh0,lh1,lh3,lh5)
response
dogs.lm=lm(response~drug)

## ------------------------------------------------------------------------
library(car)
times=colnames(response)
times
times.df=data.frame(times)
times.df
dogs.manova=Manova(dogs.lm,idata=times.df,
     idesign=~times)
dogs.manova

## ------------------------------------------------------------------------
head(dogs,n=5)

## ------------------------------------------------------------------------
library(dplyr) ; library(tidyr)

## ------------------------------------------------------------------------
dogs %>% gather(time,lh,lh0:lh5) %>% head(12) 

## ------------------------------------------------------------------------
dogs %>% gather(timex,lh,lh0:lh5) %>% 
    mutate(time=extract_numeric(timex)) %>% head(10)


## ------------------------------------------------------------------------
dogs.long=dogs %>% gather(timex,lh,lh0:lh5) %>% 
    mutate(time=extract_numeric(timex)) 


## ------------------------------------------------------------------------
dogs %>% gather(timex,lh,lh0:lh5) %>% 
    mutate(time=extract_numeric(timex))  -> dogs.long

## ------------------------------------------------------------------------
detach(dogs) 
attach(dogs.long)

## ----eval=F--------------------------------------------------------------
## interaction.plot(time,drug,lh)

## ----ibrahimovic,echo=F,fig.height=5-------------------------------------
interaction.plot(time,drug,lh)

## ------------------------------------------------------------------------
detach(dogs.long)
attach(dogs)
response=cbind(lh1,lh3,lh5) # excluding time zero
dogs.lm=lm(response~drug)
times=colnames(response)
times.df=data.frame(times)
dogs.manova=Manova(dogs.lm,idata=times.df,
                   idesign=~times)

## ------------------------------------------------------------------------
dogs.manova

## ------------------------------------------------------------------------
detach(dogs)
attach(dogs.long)

## ----platanias,eval=F----------------------------------------------------
## library(ggplot2)
## ggplot(dogs.long,aes(x=time,y=lh,colour=drug,group=dog)) +
##   geom_point()+geom_line()

## ----hoverla,fig.height=5,echo=F-----------------------------------------
library(ggplot2)
ggplot(dogs.long,aes(x=time,y=lh,colour=drug,group=dog)) +
  geom_point()+geom_line()

## ------------------------------------------------------------------------
  
exercise.long=read.table("exercise.txt",header=T)
str(exercise.long)
head(exercise.long,8)

## ------------------------------------------------------------------------
library(tidyr)
exercise.wide=spread(exercise.long,time,pulse)
head(exercise.wide)

## ------------------------------------------------------------------------
attach(exercise.wide)
response=cbind(min01, min15, min30)

## ------------------------------------------------------------------------
exercise.1=lm(response~diet*exertype)

## ------------------------------------------------------------------------
library(car)
times=colnames(response)
times.df=data.frame(times)
exercise.2=Manova(exercise.1,idata=times.df,
                  idesign=~times)

## ------------------------------------------------------------------------
exercise.2

## ----eval=F--------------------------------------------------------------
## ggplot(exercise.long,aes(x=time,y=pulse,group=id)) +
##   geom_point()+geom_line()+facet_grid(diet~exertype)

## ----echo=F,fig.height=5-------------------------------------------------
library(ggplot2)
ggplot(exercise.long,aes(x=time,y=pulse,group=id)) +
geom_line()+
facet_grid(.~diet)

## ------------------------------------------------------------------------
runners.wide=filter(exercise.wide,exertype=="running")

## ------------------------------------------------------------------------
detach(exercise.wide)
attach(runners.wide)
response=cbind(min01,min15,min30)
runners.1=lm(response~diet)
times=colnames(response)
times.df=data.frame(times)
runners.2=Manova(runners.1,idata=times.df,
                 idesign=~times)

## ------------------------------------------------------------------------
runners.2

## ------------------------------------------------------------------------
runners.long=gather(runners.wide,time,pulse,
                    min01:min30)
aggregate(pulse~diet+time,runners.long,mean)

## ------------------------------------------------------------------------
aggregate(pulse~diet+time,runners.long,mean)

