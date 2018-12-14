### R code from vignette source '/home/ken/teaching/d29/notes/bRscript.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: bRscript.Rnw:139-141
###################################################
scores=read.table("scores.txt",header=T)
scores


###################################################
### code chunk number 2: bRscript.Rnw:155-157
###################################################
library(tidyr)
scores2=gather(scores,assessment,score,assgt.1:test.2) ; scores2


###################################################
### code chunk number 3: bRscript.Rnw:188-190
###################################################
separate(scores2,assessment,into=c("assess.type","assess.num"),
         sep="\\.")


###################################################
### code chunk number 4: bRscript.Rnw:204-205
###################################################
library(dplyr)


###################################################
### code chunk number 5: bRscript.Rnw:208-211
###################################################
scores %>% 
    gather(assessment,score,assgt.1:test.2) %>%
    separate(assessment,into=c("assess.type","assess.num"), sep="\\.")


###################################################
### code chunk number 6: bRscript.Rnw:243-246
###################################################
scores %>% 
   gather(assessment,score,assgt.1:test.2) %>% 
   head(5)


###################################################
### code chunk number 7: bRscript.Rnw:258-260
###################################################
weather=read.table("weather.txt",header=T)
weather


###################################################
### code chunk number 8: bRscript.Rnw:273-274
###################################################
weather %>% spread(type,temperature)


###################################################
### code chunk number 9: bRscript.Rnw:301-302
###################################################
library(dplyr)


###################################################
### code chunk number 10: bRscript.Rnw:312-313
###################################################
scores2


###################################################
### code chunk number 11: bRscript.Rnw:316-317
###################################################
library(dplyr)


###################################################
### code chunk number 12: bRscript.Rnw:327-328
###################################################
filter(scores2,name=="Angela")


###################################################
### code chunk number 13: bRscript.Rnw:333-334
###################################################
filter(scores2,name=="Angela",assessment=="test.1")


###################################################
### code chunk number 14: bRscript.Rnw:343-345
###################################################
filter(scores2, 
    assessment=="assgt.1" | assessment=="test.1")


###################################################
### code chunk number 15: bRscript.Rnw:354-355
###################################################
filter(scores2,score>40)


###################################################
### code chunk number 16: bRscript.Rnw:365-366
###################################################
arrange(scores2,name)


###################################################
### code chunk number 17: bRscript.Rnw:377-378
###################################################
arrange(scores2,desc(score))


###################################################
### code chunk number 18: bRscript.Rnw:390-391
###################################################
arrange(scores2,name,desc(score))


###################################################
### code chunk number 19: bRscript.Rnw:404-405
###################################################
select(scores2,score)


###################################################
### code chunk number 20: bRscript.Rnw:414-415
###################################################
select(scores2,-name)


###################################################
### code chunk number 21: bRscript.Rnw:424-425
###################################################
select(scores2,assessment:score)


###################################################
### code chunk number 22: bRscript.Rnw:437-438
###################################################
scores2 %>% select(-name) %>% head(5)


###################################################
### code chunk number 23: bRscript.Rnw:448-449
###################################################
scores2 %>% select(assessment) %>% distinct() 


###################################################
### code chunk number 24: bRscript.Rnw:456-457
###################################################
scores2 %>% select(-name) %>% head(5) %>% distinct()


###################################################
### code chunk number 25: bRscript.Rnw:474-476
###################################################
mutate(scores2,out.of=c(rep(10,4),rep(50,8)),
               percent=score/out.of*100)


###################################################
### code chunk number 26: bRscript.Rnw:486-487
###################################################
summarise(scores2,mean.score=mean(score))


###################################################
### code chunk number 27: bRscript.Rnw:496-497
###################################################
set.seed(457299)


###################################################
### code chunk number 28: bRscript.Rnw:502-503
###################################################
sample_n(scores2,5)


###################################################
### code chunk number 29: bRscript.Rnw:508-509
###################################################
sample_frac(scores2,0.25)


###################################################
### code chunk number 30: bRscript.Rnw:522-526
###################################################
scores2 %>% group_by(assessment) %>% 
   summarise( assess.mean=mean(score),
              assess.sd=sd(score)
            )


###################################################
### code chunk number 31: bRscript.Rnw:533-535
###################################################
scores2 %>% group_by(name) %>%
   summarize(how.many=n())


