list.files(pattern = "^bFac.*\\.pdf$") %>% enframe() %>% 
  separate(value, into = c("base", "ext"), sep = "\\.", remove = FALSE) %>% 
  mutate(file2 = str_c(base, ".png")) %>% 
  { walk2(.$value, .$file2, ~system2("convert", c(.x, .y))) }

# this idea from https://hackernoon.com/silly-r-errors-and-the-silly-reasons-im-probably-getting-them-c6bd9ada59c    

tibble(a = 1:5, b = 6:10) %>% 
{  walk2(.$a, .$b, ~print(.x*.y))}
    
system2("ls", c("-l", "*.png")) 


df = tibble(
  g = rep(letters[1:3], 20),
  a = 1:60,
  b = rnorm(60))
df
