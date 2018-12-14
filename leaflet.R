library(leaflet)
leaflet() %>% addTiles() -> m
cities <- read.csv(textConnection("
City,Lat,Long,Pop
Boston,42.3601,-71.0589,645966
Hartford,41.7627,-72.6743,125017
New York City,40.7127,-74.0059,8406000
Philadelphia,39.9500,-75.1667,1553000
Pittsburgh,40.4397,-79.9764,305841
Providence,41.8236,-71.4222,177994
"))
cities
leaflet(cities) %>% addTiles() %>% 
  addCircles(lng=~Long,lat=~Lat,radius=~sqrt(Pop)*30,popup=~City)

# or ggmap and stat_ellipse

library(ggmap)
m=get_map("nebraska",zoom=4)
z1=data.frame(x=rnorm(100,-100,10),y=rnorm(100,30,5))
z1
ggmap(m)+stat_ellipse(aes(x,y),data=z)

# multiv normal

library(MASS)
mu=c(-90,45)
sigma=matrix(c(10,8,8,10),nrow=2)
mu
sigma
z=mvrnorm(100,mu,sigma)
zz=data.frame(x=z[,1],y=z[,2])

ggmap(m)+stat_ellipse(aes(x,y),data=zz,col="red")+
  stat_ellipse(aes(x,y),data=z1,col="blue")
