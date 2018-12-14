airlines=read.table("airlines.txt",header=T)
airlines
library(tidyr)
library(dplyr)
airlines %>% gather(line.status,frequency,aa.ontime:aw.delayed) %>%
    separate(line.status,c("airline","status"),sep="\\.") -> air
air
