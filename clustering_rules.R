library(tidyverse)

# generate some random points
set.seed(457299)
a=data.frame(x=runif(5,0,20),y=runif(5,0,20))
b=data.frame(x=runif(5,20,40),y=runif(5,20,40))
d=bind_rows(a=a,b=b,.id="cluster")
d
g=ggplot(d,aes(x=x,y=y,colour=cluster))+geom_point()+
  coord_fixed(xlim=c(0,40),ylim=c(0,40))
g

distance=function(p1,p2) {
  sqrt((p1[1]-p2[1])^2+(p1[2]-p2[2])^2)
}

distances=matrix(0,nrow(a),nrow(b))
for (i in 1:nrow(a)) {
  for (j in 1:nrow(b)) {
    dd=distance(a[i,],b[j,])
    distances[i,j]=dd
  }
}
distances
wm1=which.min(apply(distances,1,min))
wm2=which.min(apply(distances,2,min))
distances[wm1,wm2]
a[wm1,]
b[wm2,]
closest=bind_rows(a=a[wm1,],b=b[wm2,],.id="cluster")
closest

# single linkage distance

g+geom_segment(data=closest,aes(x=x[1],y=y[1],xend=x[2],yend=y[2]),colour="blue")

# complete linkage

wm1=which.max(apply(distances,1,max))
wm2=which.max(apply(distances,2,max))
distances[wm1,wm2]
a[wm1,]
b[wm2,]
closest=bind_rows(a[wm1,],b[wm2,],.id="cluster")
closest
g+geom_segment(data=closest,aes(x=x[1],y=y[1],xend=x[2],yend=y[2]),colour="blue")

# idea is: repeat data keying on group, then use geom_line

new=data.frame(x=double(),y=double(),cluster=character(),grp=integer(),stringsAsFactors = F)
new
count=0;
for (i in 1:5) {
  for (j in 1:5) {
    count=count+1
    new[2*count-1,]=c(a[i,],cluster="a",grp=count)
    new[2*count,]=c(b[j,],cluster="b",grp=count)
  }
}
new

# all possible pairs of points
ggplot(new,aes(x=x,y=y,group=grp))+geom_point(aes(colour=cluster))+geom_line(alpha=0.2)+  coord_fixed(xlim=c(0,40),ylim=c(0,40))

# ward

d %>% group_by(cluster) %>% summarize(x=mean(x),y=mean(y)) -> dm
dm

# loop through data frame and create grp that links to cluster's mean

new=data.frame(x=double(),y=double(),cluster=character(),grp=integer(),stringsAsFactors = F)
count=0;
for (i in 1:5) {
  count=count+1
  new[2*count-1,]=c(a[i,],cluster="a",grp=count)
  new[2*count,]=c(dm[1,-1],cluster="a",grp=count)
  count=count+1
  new[2*count-1,]=c(b[i,],cluster="b",grp=count)
  new[2*count,]=c(dm[2,-1],cluster="b",grp=count)
}

new

ggplot(d,aes(x=x,y=y,colour=cluster))+
  coord_fixed(xlim=c(0,40),ylim=c(0,40))+
  geom_point()+
  geom_point(data=dm,shape=3)+
  geom_line(data=new,aes(group=grp),alpha=0.5)

# now repeat but for grand mean

d %>% summarize(x=mean(x),y=mean(y)) -> dm
dm

# loop through data frame and create grp that links to cluster's mean

new=data.frame(x=double(),y=double(),cluster=character(),grp=integer(),stringsAsFactors = F)
count=0;
for (i in 1:5) {
  count=count+1
  new[2*count-1,]=c(a[i,],cluster="a",grp=count)
  new[2*count,]=c(dm[1,],cluster="a",grp=count)
  count=count+1
  new[2*count-1,]=c(b[i,],cluster="b",grp=count)
  new[2*count,]=c(dm[1,],cluster="b",grp=count)
}

new
d
g
ggplot(d,aes(x=x,y=y,colour=cluster))+
  coord_fixed()+
#  coord_fixed(xlim=c(0,40),ylim=c(0,40))+
  geom_point()+
  geom_point(data=dm,aes(colour=NULL),shape=3)+
  geom_line(data=new,aes(group=grp),alpha=0.5)


# ward's method distance between two clusters: work out mean of combined cluster, sum of distance of all points to combined mean

# next: three clusters, single- and complete-linkage distances between each pair of clusters, think about which clusters to join

# ward's method: repeat mean n times, each with different grp
