par(mar=rep(2,4))


library(rgl)
ontario=read.csv("ontario-road-distances.csv")
head(ontario)
library(dplyr)
# need to select on row.name
ontario %>% 
  mutate(cityname=row.names(ontario)) %>% 
  filter(!(cityname %in% c("ThunderBay","SaultSteMarie"))) %>% 
  select(-c(ThunderBay,SaultSteMarie,cityname)) -> ontario2

# or 
ontario.2=ontario[c(-17,-19),c(-17,-19)]

ontario.2.2=cmdscale(ontario.2)
ontario.2.2=cbind(ontario.2.2,1)
ontario.2.2

plot3d(ontario.2.2,zlim=c(-100,100))
text3d(ontario.2.2,text=cities)

cities=colnames(ontario2)
ontario2.d=as.dist(ontario2)
ontario2.scale.3=cmdscale(ontario2.d,3)
head(ontario2.scale.3)
plot3d(ontario2.scale.3)
text3d(ontario2.scale.3,text=cities,adj=c(0,0))

cube=read.table("cube.txt",header=T)
cube
cube.d=as.dist(cube)
cube.d

cube.3=cmdscale(cube.d,3)
cube.3
point.names=row.names(cube)
point.names
plot3d(cube.3,col=rainbow(8))
text3d(cube.3,text=point.names)

number.d=read.table("languages.txt",header=T)
number.d
d=as.dist(number.d)
d
langs=names(number.d)
library(MASS)
number.1=isoMDS(d,k=3)
number.1
plot3d(number.1$points)
text3d(number.1$points,text=langs)

# or plot a two-dimensional one in 3d!

library(dplyr)
number.1=isoMDS(d,k=2)
number.1
number.2=cbind(number.1$points,1)
number.2
plot3d(cbind(number.2),zlim=c(-5,5))
text3d(number.2,text=langs,adj=c(0,0))


#######################################
?t.test

x=data.frame(y=rnorm(20),g=rep(c("a","b"),10))
x
t.test(y~g,data=x)$conf.int

### ggplot

drp=read.table("drp.txt",header = T)
drp
library(ggplot2)
ggplot(drp,aes(x=1,y=score))+geom_boxplot()

ggplot(drp,aes(x=score))+geom_histogram()
ggplot(drp,aes(x=score))+geom_histogram()+facet_grid(.~group)
ggplot(drp,aes(x=score))+geom_histogram(binwidth=10)+facet_grid(group~.)

###############################################
# leaflet
##############################################

install.packages("leaflet")

europe=read.csv("europe.csv",header=T)
europe
cities=as.character(europe[,1])
cities

library(ggmap)
geocodeQueryCheck()
ll=geocode(cities,source="google")
ll
euro=data.frame(cities,lon=ll[,1],lat=ll[,2])
library(leaflet)
library(dplyr)
m=leaflet(euro)
m %>% addProviderTiles("Esri.NatGeoWorldMap") %>% 
  addCircles(lng=~lon,lat=~lat,popup=cities,color="red")
?leaflet
?addTiles

############################################################################################

library(foreign)
db=file.choose()
m255=read.spss(db)
library(haven)
#install.packages("haven")
m255=read_spss(db)
m255=read_sas(db)
db

#########################################

f=file.choose()
cities=read.table("cities2.txt",header=T)
cities
head(cities)
names(cities)
cities.1=princomp(cities[,2:10],cor=T)
cities.1=princomp(~Climate+HousingCost+HlthCare,data=cities,cor=T)
cities.1
summary(cities.1)
biplot(cities.1)
plot(cities.1,type="l")
cities.1$loadings

apply(cities[,-1],2,summary)

track=read.table("men_track_field.txt",header=T)
str(track)
track.1=princomp(track[,1:8])
plot3d(track.1$scores[,1:3])
text3d(track.1$scores[,1:3],texts=track$country,adj=c(0,0))
?text3d

###############################################################

knitr::knit("bInference.Rnw",tangle=T)
knitr::knit("bRegression.Rnw",tangle=T)

#############################################################
# rio
#############################################################

library(rio)
x=import("factor.sas7bdat")
head(x)
install.packages("Lock5Data")
library(Lock5Data)
data("StressedMice")
StressedMice
