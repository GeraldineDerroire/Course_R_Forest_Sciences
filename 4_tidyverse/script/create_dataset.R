# This script transform existing dataset ou create new ones to be used in the sessions on the tidyverse


### Data set of traits from rcontroll
rcontroll::data(TROLLv3_species)

# separate the names in two columns
traits <- TROLLv3_species %>% 
  separate(s_name, c("genus", "species"),
           sep = "_")

write_csv(traits, "4_tidyverse/data/func_traits.csv")

