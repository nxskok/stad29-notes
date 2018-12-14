x=c(10,11,13,14,17,18,22,24,27,41)
x
z=5:37
summary(x)
mean(x)
median(x)
sd(x)
IQR(x)
hist(x)
boxplot(x)

my.data=read.table("mydata.txt",header=T)
my.data
my.data$xx
my.data$group
yy
attach(my.data)
yy
group
detach(my.data)

my.data
my.data[3,2]
my.data[3,]
my.data[,2]
my.data[,-2]
my.data[1:3,]
my.data[c(3,5),]

drp=read.table("drp.txt",header=T)
drp
head(drp)
attach(drp)
score
group
boxplot(score~group)
t.test(score~group)
var.test(score~group)
t.test(score~group,var.equal=T)

# logistic regression

rats=read.table("rat.txt",header=T)
rats
attach(rats)
rats.1=glm(status~dose,family="binomial")
summary(rats.1)
my.dose=c(1.5,2.5)
new=data.frame(dose=my.dose)
p=predict(rats.1,new,type="response")
p
cbind(new,p)
detach(rats)


rat2=read.table("rat2.txt",header=T)
rat2
attach(rat2)
lived
died
response=cbind(lived,died)
response
rat2.1=glm(response~dose,family="binomial")
summary(rat2.1)
p=predict(rat2.1,type="response")
p
cbind(dose,p)
detach(rat2)


sepsis=read.table("sepsis.txt",header=T)
head(sepsis)
attach(sepsis)
sepsis.1=glm(death~shock+malnut+alcohol+age+
               bowelinf,family="binomial")
summary(sepsis.1)
sepsis.2=glm(death~shock+alcohol+age+
               bowelinf,family="binomial")
summary(sepsis.2)$coefficients
sepsis.pred=predict(sepsis.2,type="response")
myrows=c(4,1,2,11,32)
cbind(sepsis[myrows,],p=sepsis.pred[myrows])
plot(sepsis.2)



freqs=read.table("miners-tab.txt",header=T)
freqs
?prop.table
prop.table(as.matrix(freqs[,-1]),1)


# brands

brandpref=read.csv("mlogit.csv",header=T)
head(brandpref)
brandpref$sex=factor(brandpref$sex)
brandpref$brand=factor(brandpref$brand)

attach(brandpref)
b=aggregate(1~brand+age+sex,data=brandpref,length)
head(b)
tb=table(brand,age,sex)
tb
as.data.frame(tb)

detach(brandpref)

