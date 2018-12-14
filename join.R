library(dplyr)

id=1:3
part=c("hammer","pliers","screwdriver")
parts=data.frame(id=id,part=part)
parts
bought=data.frame(id=c(1,1,2,2,1,4))
bought
inner_join(parts,bought)
inner_join(bought,parts)
left_join(parts,bought)
semi_join(parts,bought)
anti_join(parts,bought)

table(inner_join(parts,bought)$part)
parts
parts %>% filter(id==2) %>% select(part)
mtcars
?separate
library(tidyr)
