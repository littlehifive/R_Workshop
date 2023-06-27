# simulate example RCT dataset
library(tidyverse)
library(simstudy)

def <- defData(varname = "age", dist = "normal", formula = 10,
               variance = 2)
def <- defData(def, varname = "female", dist = "binary",
               formula = "-2 + age * 0.1", link = "logit")
def <- defData(def, varname = "std_scores", dist = "normal",
               formula = "1.5 - 0.2 * age + 0.5 * female", link = "log")

set.seed(1234)

dd <- genData(1000, def)

dat <- trtAssign(dd, n = 2, balanced = TRUE, strata = c("female"),
                 grpName = "treated")

dat <- dat |> 
  mutate(age = round(age, 0)) |> 
  mutate(sch_id = rep(c(1:10), each = 100),
         .before = id) |> 
  rename(st_id = id) |> 
  select(sch_id, st_id, treated, age, female, std_scores)

write_csv(dat, here::here("data/RCT.csv"))
