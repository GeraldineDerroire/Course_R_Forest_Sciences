# This script transform existing dataset ou create new ones to be used in the sessions on the tidyverse

library(tidyverse)


### Data set of traits from rcontroll
rcontroll::data(TROLLv3_species)

# separate the names in two columns
traits <- TROLLv3_species %>% 
  separate(s_name, c("genus", "species"),
           sep = "_")

write_csv(traits, "4_tidyverse/data/func_traits.csv")



# Small datasets for the second session with messy data
###########################################################

# for tidyr ex 1
dt1 <- tibble(
  tree = c("tree1", "tree2", "tree3"),
  `2015` = c(25, 35, 43),
  `2020` = c(26, 37, 43),
  `2025` = c(26.5, 38.5, 43),
)

# for tidyr ex 2
dt2 <- tibble(
  taxo = c("Anacardiaceae_Myracrodruon_urundeuva", # Aroeira
          "Fabaceae_Hymenaea_martiana", # Jatoba-da-mata
          "Fabaceae_Piptadenia_macradenia"), # Pau-jacaré
  DBH = c("10, 12, 21" , "13", "24, 18")
)

# for janitor
dt3 <- tibble(
  `#sítio` = c("A", NA, NA),
  `% cobertura` = c(0.25, NA, NA),
  numParcela = c(1, NA, NA))

# seondary forest
dt4 <- tibble(
  past_landuse = sample(c("Soybeans", "Sugarcane", "Pasture"), 25, replace = TRUE),
  age = sample(5:15, 25, replace = TRUE)) %>% 
  bind_rows(tibble(past_landuse= c("Tomatoes", "Corn"), 
                   age = c(5, 12))) %>% 
  mutate(past_landuse = as.factor(past_landuse))



## Save in a single .Rdata
save(dt1,
     dt2,
     dt3,
     dt4,
     file = "4_tidyverse/data/data_tidyverse_2.RData")
