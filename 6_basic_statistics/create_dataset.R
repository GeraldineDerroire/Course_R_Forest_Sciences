## Create datasets for sessions on basic statistics
##################################################################################

library(tidyverse)

set.seed(22)


## Data set for t-test ##################################################

# tree growth before and after thinning

dt_thin <- tibble(treeID = as.factor(1:100),
                  before =  rnorm(100, mean = 0.15, sd = 0.08),
                  after = rnorm(100, mean = 0.4, sd = 0.15))

summary(dt_thin)

dt_thin <- dt_thin %>% pivot_longer(c("before", "after"),
                                    names_to = "treat",
                                    values_to = "growth")

dt_thin <- dt_thin %>% 
  mutate(treat = as.factor(treat),
         treat = fct_relevel(dt_thin$treat, "before", "after"))

summary(dt_thin)
str(dt_thin)

ggplot(dt_thin, aes(x=treat, y=growth)) + geom_boxplot()


## Save in a single .Rdata
save(dt_thin,
     file = "6_basic_statistics/data/data_statistics.RData")
