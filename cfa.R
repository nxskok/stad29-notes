# confirmatory factor analysis using lavaan

library(lavaan)

kids=read.table("rex2.txt",header=T)
km=as.matrix(kids)
km

# children and tests

corr.mat='
1
0.722 1
0.714 0.685 1
0.203 0.246 0.170 1
0.095 0.181 0.113 0.585 1
'

test.names=c("para","sent","words","add","dots")
tests.corr=getCov(corr.mat,names=test.names)

test.model.1='
fac1=~para+sent+words+add+dots
'

 
fit1=cfa(test.model.1,sample.cov=tests.corr,sample.nobs=145)
show(fit1)

test.model.2='
fac1=~para+sent+words
fac2=~add+dots
'

fit2=cfa(test.model.2,sample.cov=tests.corr,sample.nobs=145)
summary(fit1)
summary(fit2)
anova(fit1,fit2)

?cfa

show(fit1)


# track data

track=read.table("men_track_field.txt",header=T)
track.model='
#good=~m100+m200+m400+m800+m1500+m5000+m10000+marathon
sprint=~m100+m200+m400
distance=~m800+m1500+m5000+m10000+marathon
'
track.1=cfa(track.model,data=track[,-9],std.ov=T)
track.1
show(track.1)
summary(track.1)
?factanal
track.1
