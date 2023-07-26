# load library and data
library(tidyverse)
dat <- read_csv(here::here("data/RCT.csv"))

# After R version 4.1 you can use |> and %>% interchangeably.
# I prefer the former because it does not depend on the installation of tidyverse
# Go to Tools - Global Options - Code - Toggle on Use native pipe operator

# What is the average age for boys and girls?
dat |> 
  group_by(female) |> 
  summarise(avg_age = mean(age, na.rm = T),
            sd_age = sd(age, na.rm = T)) |> 
  mutate(female = ifelse(female == 1, "Girls", "Boys"))

# Which st_id is the oldest students in school 8?
dat %>%
  filter(sch_id == 8) |> 
  slice_max(order_by = age) |> 
  pull(st_id)

# OR
dat |> 
  filter(sch_id == 8) |> 
  arrange(desc(age)) |> 
  slice(1)

# Which age group has the most number of students?
dat |> 
  count(age) |> 
  slice_max(order_by = n)

# OR
dat |> 
  group_by(age) |> 
  summarise(n = n()) |> 
  arrange(desc(n)) |> 
  slice(1)

# What is the average std_scores for girls aged 7 or 8 in the treatment group?
dat |> 
  filter(female == 1 & age %in% c(7, 8) & treated == 1) |> 
  summarise(ave_std_scores = mean(std_scores, na.rm = T))

# Create a data.frame with the name dat_s with the following rules:
# Deselect st_id
# Filter out students younger than 10 years old
# Create a new variable called transformed_scores and assign it the value of 99 times the std_scores if age >= 10, 
# else assign it the value 101 times the std_scores
dat_s <- dat |> 
  select(-st_id) |> 
  filter(age >= 10) |> 
  mutate(transformed_scores = ifelse(age >= 10, std_scores * 99, std_scores * 101))
