sepsis=read.table("sepsis.txt",header=T)
head(sepsis)
attach(sepsis)
sepsis.1=glm(death~shock+malnut+alcohol+age+
               bowelinf,family="binomial")
s=summary(sepsis.1)
s$coefficients
names(s)
s$deviance

# miners

freqs=read.table("miners-tab.txt",header=T)
freqs
reshape(freqs,varying=2:4,v.names="frequency",timevar="level",direction="long")
?factor

