data(Rohwer, package="heplots")
attach(Rohwer)
rohwer.mod <- lm(cbind(SAT, PPVT, Raven) ~ n + s + ns + na + ss,data=Rohwer) 
