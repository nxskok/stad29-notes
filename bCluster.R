
## ------------------------------------------------------------------------
number.d=read.table("languages.txt",header=T)
number.d


## ------------------------------------------------------------------------
d=as.dist(number.d)
d


## ------------------------------------------------------------------------
print.default(d)


## ------------------------------------------------------------------------
d.hc=hclust(d,method="single")  


## ----fig=TRUE------------------------------------------------------------
plot(d.hc)


## ------------------------------------------------------------------------
d.hc$labels
d.hc$merge


## ----fig=TRUE------------------------------------------------------------
d.hc=hclust(d,method="complete")
plot(d.hc)


## ----fig=TRUE------------------------------------------------------------
d.hc=hclust(d,method="ward.D")
plot(d.hc)


## ------------------------------------------------------------------------
cutree(d.hc,3)


## ----fig=TRUE------------------------------------------------------------
plot(d.hc)
rect.hclust(d.hc,3)


## ------------------------------------------------------------------------
lang=read.table("one-ten.txt",header=T,as.is=1:11)
lang


## ------------------------------------------------------------------------
lang
e=lang[,1]
e
substr(e,1,3)
substr(e,2,4)
substr(e,1,1)

apply(lang,2,sort)
lang
lang.init=apply(lang,2,substr,1,1)
lang.init
lang.names=colnames(lang.init)
lang.names
abbreviate(lang.names,1)
abbreviate(lang.names,1)
colnames(lang.init)=abbreviate(lang.names,2)
lang.init


## ------------------------------------------------------------------------
rbind(lang.init[,1],lang.init[,2])
diff=(lang.init[,1]!=lang.init[,2])
diff[1:5]
diff[6:10]
sum(diff)


## ------------------------------------------------------------------------
dd=matrix(0,11,11)
for (i in 1:11)
{
  for (j in 1:11)
    {
      diff=(lang.init[,i]!=lang.init[,j])
      dd[i,j]=sum(diff)
    }
}
dd



## ------------------------------------------------------------------------
vital=read.table("birthrate.txt",header=T,as.is=4)
head(vital,n=5)
summary(vital)


## ------------------------------------------------------------------------
vital.s=scale(vital[,1:3])
head(vital.s)

d=dist(vital.s)
d3=hclust(d,method="ward.D")
plot(d3,labels=vital[,4])



## ----echo=FALSE----------------------------------------------------------
set.seed(457299)


## ------------------------------------------------------------------------
vital.km3=kmeans(vital.s,3)
vital.km3


## ----echo=FALSE----------------------------------------------------------
options(width=60)


## ------------------------------------------------------------------------
country=vital[,4]
clist=split(country,vital.km3$cluster)
substr(clist[[2]],1,10)


## ------------------------------------------------------------------------
clist[[3]]


## ------------------------------------------------------------------------
clist[[1]]


## ----echo=FALSE----------------------------------------------------------
set.seed(457298)


## ------------------------------------------------------------------------
vital.km3a=kmeans(vital.s,3)
table(first=vital.km3$cluster,
      second=vital.km3a$cluster)


## ----eval=FALSE----------------------------------------------------------
## vital.km3b=kmeans(vital.s,3,nstart=20)


## ------------------------------------------------------------------------
clus=2:20
wss=numeric(0)
for (i in clus)
{
  wss[i]=kmeans(vital.s,i,nstart=10)$tot.withinss
}
wss


## ----fig=TRUE------------------------------------------------------------
plot(clus,wss[clus],type="b")
grid(col="black")


## ------------------------------------------------------------------------
vital.km6=kmeans(vital.s,6,nstart=10)
vital.km6$size
vital.km6$centers

library(dplyr)

apply(vital[,1:3],2,quantile)
vital %>% mutate(cluster=vital.km6$cluster) %>% filter(cluster==1)
vital %>% mutate(cluster=vital.km6$cluster) %>% filter(cluster==2)
vital %>% mutate(cluster=vital.km6$cluster) %>% filter(cluster==3)
vital %>% mutate(cluster=vital.km6$cluster) %>% filter(cluster==4)
vital %>% mutate(cluster=vital.km6$cluster) %>% filter(cluster==5)
vital %>% mutate(cluster=vital.km6$cluster) %>% filter(cluster==6)



clus=split(country,vital.km6$cluster)


## ------------------------------------------------------------------------
clus[[1]]


## ------------------------------------------------------------------------
clus[[2]]


## ------------------------------------------------------------------------
clus[[3]]


## ------------------------------------------------------------------------
clus[[4]]


## ------------------------------------------------------------------------
clus[[5]]


## ------------------------------------------------------------------------
clus[[6]]


## ------------------------------------------------------------------------
table(three=vital.km3$cluster,six=vital.km6$cluster)

head(vital.s)

d=dist(vital.s)
vital.ward=hclust(d,method="ward")
plot(vital.ward)
tt=cutree(vital.ward,5)
cbind(vital[,4],tt)
cs=split(vital[,4],tt)
cs
plot(vital.ward)

## ------------------------------------------------------------------------
ontario=read.csv("ontario-road-distances.csv",header=T)
ontario.d=dist(ontario)
ontario.hc=hclust(ontario.d,method="ward")
cutree(ontario.hc,4)


## ----fig=TRUE------------------------------------------------------------
plot(ontario.hc)
rect.hclust(ontario.hc,4)


## ----fig=TRUE------------------------------------------------------------
plot(ontario.hc)
rect.hclust(ontario.hc,7)


v=c("vdd","dsg","sdsdg")

v
for (i in v)
{
  print(nchar(i))
}
length(v)
