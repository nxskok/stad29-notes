# library(cluster)
# flower
# dd=dist(scale(flower[,7:8]))
# flower.hcw=hclust(dd,method="ward")
# flower.hcs=hclust(dd,method="single")
# flower.hcc=hclust(dd,method="complete")
# plot(flower.hcw)
# plot(flower.hcs)
# plot(flower.hcc)
# flower.km3=kmeans(flower[,7:8],3)
# flower.km2=kmeans(flower[,7:8],2)
# flower.km2$cluster
# flower.km3$cluster


# Determine number of clusters,
# from http://www.statmethods.net/advstats/cluster.html
# accessed 2012-12-19

# scree.plot=function(mydata)
# {
#   wss=numeric(0)
#   n=min(dim(mydata)[1],10)
#   print(n)
#   for (i in 2:(n-1)) 
#   {
#     wss[i] <- sum(kmeans(mydata,centers=i)$withinss)
#     print(c(i,wss[i]))
#   } 
#   plot(1:length(wss), wss, type="b", xlab="Number of Clusters",
#        ylab="Within groups sum of squares") 
# }
# 
# scree.plot(flower[,7:8])
# 
# cutree(flower.hcc,2) # gets clustering out of hclust
# 
# compare.cluster=function(cl1,cl2)
# {
#   p1=outer(cl1,cl1,"==")
#   p2=outer(cl2,cl2,"==")
#   n=length(cl1)
#   z=numeric(0)
#   for (i in 1:n)
#   {
#     for (j in 1:i)
#     {
#       if (p1[i,j]!=p2[i,j]) z=cbind(z,c(i,j))
#     }
#   }
#   z
# }
# 
# 
# 
# m=compare.cluster(cutree(flower.hcc,4),cutree(flower.hcc,2))
# plot(flower.hcc)
# rect.hclust(flower.hcc,4)
# plot(flower.hcs)
# rect.hclust(flower.hcc,2)
# m
# table(m)
# 
# 
# 
# m=compare.cluster(flower.km3$cluster,flower.km2$cluster)
# m
# table(m)
# g=rbind(flower.km3$cluster,flower.km2$cluster)
# dimnames(g)[[2]]=1:18
# g
# 
# c1=c(1,1,1,1,2,1,2,2,2,2)
# c2=c(2,2,2,2,2,1,1,1,1,1)
# m=compare.cluster(c1,c2)
# m
# table(m)
# 
# p1=outer(c1,c1,"==")
# 
# compare.cluster2=function(cl1,cl2)
# {
#   p1=outer(cl1,cl1,"==")
#   p2=outer(cl2,cl2,"==")
#   p1==p2
# }


number.names=read.table("one-ten.txt",header=T)
number.names

number.d=read.table("languages.txt",header=T)
number.d
d=as.dist(number.d)
d
print.default(d)

d.hc=hclust(d,method="single")
plot(d.hc)
d.hc=hclust(d,method="complete")
plot(d.hc)
d.hc=hclust(d,method="ward")
plot(d.hc)
ct=cutree(d.hc,3)
ct
ct[names(ct)=="fr"]
ct[ct==2]
split(names(ct),ct)

rect.hclust(d.hc,3)

names(d.hc)
print.default(d.hc)

## format conversion

lang=read.table("one-ten.txt",header=T,as.is=1:11)
lang
str(lang)

v=c("alpha","beta","gamma")
substr(v,1,2)
substr(v,3,3)

lang[,1]
substr(lang[,1],1,1)
lang.init=apply(lang,2,substr,1,1)
lang.init
colnames(lang.init)=abbreviate(colnames(lang.init),2)
lang.init
rbind(lang.init[,1],lang.init[,2])
diff=(lang.init[,1]!=lang.init[,2])
diff
sum(diff)

count.diff=function(i,j)
{
    diff=(lang.init[,i]!=lang.init[,j])  
    sum(diff)
}

count.diff(1,2)
count.diff(9,10)
dd=matrix(0,11,11)
dd
for (i in 1:11)
{
  for (j in 1:11)
  {
    dd[i,j]=count.diff(i,j)
  }
}
dd


## birth, death and infant mortality

vital=read.table("birthrate.txt",header=T,as.is=4)
head(vital)
summary(vital)
vital.s=scale(vital[,1:3])
vital.km3=kmeans(vital.s,3)
vital.km3
names(vital.km3)
country=vital[,4]
split(country,vital.km3$cluster)

# try 3 clusters twice: how much fiddling to get them to be different?

vital.km3a=kmeans(vital.s,3)
table(vital.km3$cluster,vital.km3a$cluster)
vital.km3b=kmeans(vital.s,3,nstart=20)

# scree plot

clus=2:20
wss=numeric(0)
for (i in clus)
{
  wss[i]=kmeans(vital.s,i)$tot.withinss
}
plot(clus,wss[clus],type="b")
grid(col="black")

# try 6 clusters twice

vital.km6=kmeans(vital.s,6,nstart=10)
vital.km6$size
vital.km6$centers
clus=split(country,vital.km6$cluster)
clus

table(three=vital.km3$cluster,six=vital.km6$cluster)


# discrim analysis on clusters?
# also part of MDS

# ontario road distances

ontario=read.csv("ontario-road-distances.csv",header=T)
ontario
ontario.d=dist(ontario)
ontario.hc=hclust(ontario.d,method="ward")
plot(ontario.hc)
rect.hclust(ontario.hc,4)
on.1=cutree(ontario.hc,4)
split(cities,on.1)
cities=colnames(ontario)
cities
split()

plot(ontario.hc)
rect.hclust(ontario.hc,7)

