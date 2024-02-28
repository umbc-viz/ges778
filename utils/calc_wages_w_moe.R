# same data as used for justviz::wages, but redoing it to keep standard errors
library(dplyr)
wages_read <- readRDS("inputs/income_tbls.rds")

wages_occ <- bind_rows(wages_read[c("full_time.sex_x_occ", "full_time.sex_x_edu_x_occ")], .id = "id") |>
  tidyr::separate_wider_delim(id, delim = ".", names = c("time", "dimension")) |>
  mutate(edu = forcats::fct_na_value_to_level(edu, "Total")) |>
  filter(name == "Maryland") |>
  select(time, dimension, name, sex, occ_group, edu, count, sample_n, earn_q50, se = earn_q50_se) |>
  mutate(moe_90 = se * qnorm(p = 0.95),
         moe_95 = se * qnorm(p = 0.975)) |>
  mutate(across(moe_90:moe_95, round)) |>
  mutate(sex = forcats::as_factor(sex) |>
           forcats::fct_recode(Men = "Male", Women = "Female"))

saveRDS(wages_occ, "inputs/wages_sex_edu_occ.rds")
