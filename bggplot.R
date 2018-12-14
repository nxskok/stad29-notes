### R code from vignette source '/home/ken/teaching/d29/notes/bggplot.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: bggplot.Rnw:17-18
###################################################
library(ggplot2)


###################################################
### code chunk number 2: bggplot.Rnw:61-63
###################################################
drp=read.table("drp.txt",header=T)
head(drp)


###################################################
### code chunk number 3: bggplot.Rnw:73-75
###################################################
ggplot(drp,aes(x=score))+
  geom_histogram()


###################################################
### code chunk number 4: bggplot.Rnw:84-85
###################################################
ggplot(drp,aes(x=score))+geom_histogram(binwidth=10)


###################################################
### code chunk number 5: bggplot.Rnw:94-96
###################################################
ggplot(drp,aes(x=score))+geom_histogram(binwidth=10)+
  facet_grid(.~group)


###################################################
### code chunk number 6: bggplot.Rnw:125-126
###################################################
ggplot(drp,aes(y=group,x=score))+geom_boxplot()


###################################################
### code chunk number 7: cateloupe
###################################################
ggplot(drp,aes(x=factor(1),y=score))+geom_boxplot()


###################################################
### code chunk number 8: bggplot.Rnw:146-148
###################################################
prepost=read.table("ancova.txt",header=T)
str(prepost)


###################################################
### code chunk number 9: bggplot.Rnw:165-166
###################################################
ggplot(prepost,aes(x=before,y=after))+geom_point()


###################################################
### code chunk number 10: bggplot.Rnw:175-177
###################################################
ggplot(prepost,aes(x=before,y=after,colour=drug))+
  geom_point()


###################################################
### code chunk number 11: bggplot.Rnw:184-186
###################################################
ggplot(prepost,aes(x=before,y=after))+
  geom_point()+geom_smooth()


###################################################
### code chunk number 12: bggplot.Rnw:193-195
###################################################
ggplot(prepost,aes(x=before,y=after,colour=drug))+
  geom_point()+geom_smooth()


###################################################
### code chunk number 13: bggplot.Rnw:202-204
###################################################
ggplot(prepost,aes(x=before,y=after))+
  geom_point()+geom_smooth(method="lm")


###################################################
### code chunk number 14: kalloni
###################################################
ggplot(prepost,aes(x=before,y=after,colour=drug))+
  geom_point()+geom_smooth(method="lm")


###################################################
### code chunk number 15: bggplot.Rnw:224-228
###################################################
x=0:5
y=c(2.0,4.1,8.2,15.8,31.6,65.0)
grow=data.frame(x,y)
grow


###################################################
### code chunk number 16: bggplot.Rnw:239-241
###################################################
ggplot(grow,aes(x=x,y=y))+
  geom_point()+geom_smooth(method="lm")


###################################################
### code chunk number 17: bggplot.Rnw:248-250
###################################################
ggplot(grow,aes(x=x,y=y))+
  geom_point()+coord_trans(y="log10")


###################################################
### code chunk number 18: bggplot.Rnw:258-263
###################################################
library(dplyr)
search() # here
detach(package:dplyr,unload=T)
search() # gone
suppressMessages(library(dplyr))
search() # back

library(tidyr)
suppressMessages(library(dplyr))
prepost %>% mutate(subject=row_number()) %>%
  gather(time,score,before:after) -> prepost.long
prepost.long %>% sample_n(10) # 10 random rows


###################################################
### code chunk number 19: bggplot.Rnw:270-272
###################################################
ggplot(prepost.long,aes(x=time,y=score,colour=drug,
  group=subject))+geom_point()+geom_line()


