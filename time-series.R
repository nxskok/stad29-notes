library(forecast)
?auto.arima

ser=rnorm(100)
plot(ser,type="b")
ser.aa=auto.arima(ser)
ser.aa
x.ar=arima.sim(list(ar=c(0.6,0.2)),100)
plot(x.ar)
auto.arima(x.ar,trace=T)
y.d=(1:100)+rnorm(100,0,0.5)
y.d
plot(y.d)
auto.arima(y.d,trace=T)
plot(forecast(y.d))
?diff
y.dd=diff(y.d)
plot(y.dd,type="b")
acf(y.dd)
pacf(y.dd)


# kings of england

kings=read.table("kings.txt",header=F)
?ts
kings.ts=ts(kings)
kings.1.ts=lag(kings.ts)
head(kings.ts)
head(kings.1.ts)
cor(kings.ts,kings.1.ts)
plot(kings.ts)
library(tseries)
adf.test(kings.ts)

acf(kings.ts)
pacf(kings.ts)
library(forecast)
kings.aa=auto.arima(kings.ts)
names(kings.aa)
auto.arima(kings.aa$residuals)
plot(diff(kings.ts))
kings.ts.diff=diff(kings.ts)
acf(kings.ts.diff)
pacf(kings.ts.diff)
adf.test(kings.ts.diff)
PP.test(kings.ts)
PP.test(kings.ts.diff)
PP.test(kings[,1])
acf(kings.ts.diff)
pacf(kings.ts.diff)
auto.arima(kings.ts.diff,trace=T)


# new york births

ny=read.table("nybirths.txt",header=F)
ny.ts=ts(ny,freq=12,start=c(1946,1))
ny.ts
plot(ny.ts)
?ts
?diffinv
adf.test(ny.ts,k=2)

ny.d=decompose(ny.ts)
plot(ny.d)
ny.d$seasonal
plot(stl(ny.ts[,1],s.window="periodic"))
auto.arima(ny.d$random,trace=T)
auto.arima(ny.ts,trace=T)
?Box.test
Box.test(ny.d$random)

# souvenirs

souv=read.table("souvenir.txt",header=F)
souv.ts=ts(souv,frequency=12,start=1987)
souv.ts
souv.diff.ts=diff(souv.ts)
plot(souv.diff.ts)
souv.log.ts=log(souv.ts)
plot(souv.log.ts)
souv.log.diff.ts=diff(souv.log.ts)
plot(souv.log.diff.ts)
souv.d=decompose(souv.log.ts)
plot(souv.d)

PP.test(log(souv.ts))

souv.log.ts=log(souv.ts)
plot(souv.log.ts)
acf(souv.log.ts)
library(forecast)
auto.arima(souv.log.ts)
plot(souv.log.ts)
souv.log.diff.ts=diff(souv.log.ts)
plot(souv.log.diff.ts)
acf(souv.log.diff.ts)
souv.dec=decompose(souv.log.diff.ts)
plot(souv.dec)
auto.arima(souv.dec$random)

# rainfall in london

rain <- scan("http://robjhyndman.com/tsdldata/hurst/precip1.dat",skip=1)
rain.ts <- ts(rain,start=c(1813))
plot(rain.ts)
auto.arima()

# global temperature averages by year

temp=read.table("globaltemp.txt",header=T)
head(temp)
o=order(temp$Year)
o
temp.ts=ts(temp$Temperature[o],start=1880)
temp.ts
plot(temp.ts)
auto.arima(temp.ts)
plot(diff(temp.ts))
plot(forecast(auto.arima(temp.ts),h=50))
?forecast
??Holt


# whitehorse mean temperatures, daily

whitehorse=read.csv('http://www.quandl.com/api/v1/datasets/ENVCAN/WEATHER_MEANTEMPERATUREC_WHITEHORSEYUKON.csv?&trim_start=1945-01-01&trim_end=2013-03-05&sort_order=desc', colClasses=c('Date'='Date'))
head(whitehorse)
o=order(whitehorse[,1])
whitehorse.ts=ts(whitehorse[o,2],freq=365,start=c(1945,1))
plot(whitehorse.ts)
w=decompose(whitehorse.ts)
plot(w$seasonal[1:365])
names(w)
plot(w)
auto.arima(w$random,trace=T)
PP.test(whitehorse.ts)

# regina snow on ground

regina=read.csv('http://www.quandl.com/api/v1/datasets/ENVCAN/WEATHER_SNOWONGROUNDCM_REGINASASKATCHEWAN.csv?&trim_start=2003-01-01&trim_end=2013-03-12&sort_order=asc', colClasses=c('Date'='Date'))
head(regina)

regina.ts=ts(regina[,2],frequency=365,start=2003)
regina.ts
plot(regina.ts)
regina.ts=ts(sqrt(regina[,2]),frequency=365,start=c(2003,1))
regina.ts
plot(regina.ts)


# playing with decompose

x=decompose(co2)
names(x)
x$seasonal

?arima.sim

oneone=arima.sim(list(ar=0.7,ma=0.7),100)
plot(oneone)
acf(oneone)
pacf(oneone)
auto.arima(oneone,trace=T)

ma1=arima.sim(list(ma=0.7),100)
plot(ma1)
ar1=arima.sim(list(ar=0.8),100)
plot(ar1)

# constructing an AR(1) series

e=rnorm(100)
x=numeric(0)
x[1]=0
alpha=0.7
for (i in 2:100)
{
  x[i]=alpha*x[i-1]+e[i]
}
x
plot.ts(x)
acf(x)
pacf(x)

# generating an MA(1) series

e=rnorm(100)
y=numeric(0)
y[1]=0
beta=1
for (i in 2:100)
{
  y[i]=e[i]+beta*e[i-1]
}
y
plot.ts(y)
acf(y)

acf(x)
acf(y)
pacf(x)
pacf(y)

xx=c(NA,x)
x=c(x,NA)
plot(xx,x)

yy=c(NA,y)
y=c(y,NA)
plot(yy,y)

z=rnorm(100)
zz=c(NA,z)
z=c(z,NA)
plot(zz,z)

library(forecast)
arima.sim(list(ar=1),100)

# Toronto mean temperatures (daily)

to=read.csv('http://www.quandl.com/api/v1/datasets/ENVCAN/WEATHER_MEANTEMPERATUREC_TORONTOONTARIO.csv?&trim_start=1980-01-02&trim_end=2013-03-27&sort_order=asc', colClasses=c('Date'='Date'))

to.ts=ts(to[,2],freq=365,start=c(1980,1))
to.ts
plot(to.ts)
plot(decompose(to.ts))
head(to)
library(forecast)
auto.arima(to.ts,trace=T)

# toronto annual average

to=read.csv('http://www.quandl.com/api/v1/datasets/ENVCAN/WEATHER_MEANTEMPERATUREC_TORONTOONTARIO.csv?&trim_start=1940-01-02&trim_end=2013-03-27&collapse=annual&sort_order=asc', colClasses=c('Date'='Date'))
write.csv(to,"toronto-dec31.csv")

to=read.csv("toronto-dec31.csv",sep=";")

head(to)
attach(to)
plot(year,temp,type="b")
lines(lowess(year,temp))
to.lm=lm(temp~year)
summary(to.lm)
library(zyp)
to.zs=zyp.sen(temp~year,data=to)
to.zs

zyp.trend.vector(temp)
acf(temp)

length(temp)
cor.test(temp,year,method="pearson")

library(Kendall)
MannKendall(temp)



to.ts=ts(temp,start=1940)
to.ts
to.aa=auto.arima(to.ts)
to.aa
to.f=forecast(to.aa)
plot(to.f)

## Holt-Winters?



# global temperatures

temp=read.csv('http://www.quandl.com/api/v1/datasets/EPI/74.csv?&trim_start=1880-12-31&trim_end=2010-12-31&sort_order=asc', colClasses=c('Year'='Date'))
write.csv(temp,"temperature.csv")

temp=read.csv("temperature.csv")
head(temp)
attach(temp)
plot(temperature~year,type="b")
lines(lowess(temperature~year))

cor.test(year,temperature)
cor.test(year,temperature,method="kendall")
MannKendall(temperature)

temp.lm=lm(temperature~year)
summary(temp.lm)

temp.zs=zyp.sen(temperature~year,data=temp)
temp.zs
zyp.trend.vector(temperature)


library(forecast)
temp.aa=auto.arima(temperature,trace=T)
temp.f=forecast(temp.aa)
temp.f
plot(temp.f)

ffed=read.csv('http://www.quandl.com/api/v1/datasets/BUNDESBANK/BBK01_WT5511.csv?&trim_start=1968-04-01&trim_end=2013-04-02&sort_order=asc', colClasses=c('Date'='Date'))


y=c(3,4,5,5,6,7,8,9)
g=c(1,1,1,1,2,2,3,3)
t.test(y~g)
gg=factor(g)
y.aov=aov(y~gg)
summary(y.aov)
TukeyHSD(y.aov)

y=c(3,4,5,5,6,7,8,9)
g=c(1,1,1,1,2,2,3,3)
y1=y[1:4]
y2=y[5:6]
t.test(y1,y2)

y1=y[g==1]
y2=y[g==2]

?cor.test
?curve

kings.ts