## Create datasets for sessions on basic statistics
##################################################################################

library(tidyverse)

set.seed(22)


##### Data sets for session 1/3 #################################################

## Data set for t-test 

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
     file = "6_basic_statistics/data/data_statistics_1.RData")




##### Data sets for session 2/3 #################################################

## Modify the Nouragues data in biomass

library(BIOMASS)
data("NouraguesHD")
dt_nou <- as_tibble(NouraguesHD)
rm(NouraguesHD)

taxo <- correctTaxo(genus = dt_nou$genus, species = dt_nou$species)
table(taxo$nameModified)

# look at how many species per correction => would loose a lot of species...
taxo %>% distinct() %>% count(nameModified)
# look at how many indiv per correction => we would loose a lot of trees...
taxo %>% count(nameModified)
# look at which are not found => only indet
taxo %>% 
  filter(nameModified == "SpNotFound") %>% 
  select(speciesCorrected, nameModified) %>% 
  count(speciesCorrected)

taxo %>% 
  filter(nameModified == "TaxaNotFound") %>% 
  select(speciesCorrected, nameModified) %>% 
  count(speciesCorrected)

# keep only the corrected and not corrected
taxo <- taxo %>% filter(nameModified %in% c("FALSE", "TRUE"))

# add familly
dt_fam <- getWoodDensity(genus = taxo$genusCorrected, 
                         species = taxo$speciesCorrected) %>% 
  select(family, genus, species) %>% 
  distinct()

# add to data (I loose the corrected sp but nevermind, just 2 indiv)
dt_nou <- dt_nou %>% 
  inner_join(dt_fam, by = c("genus" = "genus", "species" = "species"))
# dt_nou %>% select(genus, species) %>% distinct()


# # remove some point that are problematic with the lm
dt_nou <- dt_nou %>% slice(-c(406, 123, 26))


# count per family
dt_nou %>% count(family) %>% arrange(desc(n))


# # select the 3 more represented fam
fam3 <- dt_nou %>% count(family) %>%
  arrange(desc(n)) %>%
  slice_head(n = 3) %>%
  select(family)

dt_nou_sub <- dt_nou %>% filter(family %in% fam3$family)

dt_nou_sub %>% count(family) # OK

  
## Save in a single .Rdata
save(dt_nou,
     file = "6_basic_statistics/data/data_statistics_2.RData")
