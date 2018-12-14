filepath<-"http://bit.ly/wBBTQO"
#read in the tab delimited text file using the url() function
myData<-read.table(file=url(filepath),header=T,sep="\t")
head(myData)
summary(myData)

# histogram

qplot(data=myData,BM)

# scatterplot (with legend)

qplot(data=myData,BM,var1,color=Tribe)
qplot(data=myData,BM,var1,log="xy",color=Tribe)

# boxplot by tribe

qplot(data=myData,x=Hab,y=var1) # dots
qplot(data=myData,x=Hab,y=var1,geom="boxplot")
qplot(data=myData,x=Hab,y=var1,geom="jitter")

# scatterplot separately by groups

qplot(data=myData,x=BM,y=var1,log="xy",color=Tribe,facets=Hab~Tribe)
qplot(data=myData,x=BM,y=var1,log="xy",color=Tribe,facets=~Tribe)
mygg=qplot(data=myData,x=BM,y=var1,log="xy",color=Tribe,facets=~Tribe)
mygg=mygg+stat_smooth(method="lm")
mygg
mygg=mygg+stat_smooth(method="loess")
mygg
mygg=mygg+stat_smooth()
mygg