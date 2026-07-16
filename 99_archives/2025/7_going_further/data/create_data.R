#### create data for sessions on getting further

library(tidyverse)

## Session 1 

# Poll data to recode
n = 6

dt_Likert <- tibble(
  id = LETTERS[1:n],
  Question1 = sample(1:5, n, replace = TRUE),
  Question2 = sample(1:5, n, replace = TRUE),
  Question3 = sample(1:5, n, replace = TRUE), 
  Question4 = sample(1:5, n, replace = TRUE)
)

save(dt_Likert, file = "7_going_further/data/data_session1.RData")

## Session 2