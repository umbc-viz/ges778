# education by state for cartograms, etc
# I have helper functions for this in my work packages but don't want to install here
edu_vars <- tidycensus::load_variables(2022, "acs5") |>
  dplyr::filter(
    grepl("^B06009_\\d+$", name),
    grepl("^Estimate", label)
  ) |>
  dplyr::mutate(label = label |>
    stringr::str_remove("^Estimate") |>
    stringr::str_remove_all("\\!")) |>
  tidyr::separate_wider_delim(label,
    delim = ":", names = c("total", "pob", "edu"),
    too_few = "align_end"
  ) |>
  dplyr::mutate(pob = forcats::as_factor(pob) |>
    forcats::fct_recode(
      same_state = "Born in state of residence",
      diff_state = "Born in other state in the United States",
      other_us = "Native; born outside the United States",
      total = ""
    ) |>
    forcats::fct_relabel(snakecase::to_snake_case)) |>
  dplyr::mutate(edu = forcats::as_factor(edu) |>
    forcats::fct_recode(
      less_than_high_school = "Less than high school graduate",
      high_school_grad = "High school graduate (includes equivalency)",
      some_college_or_aa = "Some college or associate's degree",
      bachelors = "Bachelor's degree",
      grad_degree = "Graduate or professional degree",
      total = ""
    )) |>
  dplyr::mutate(label = paste(as.character(pob), as.character(edu), sep = "X")) |>
  dplyr::select(label, variable = name)

pop_by_state <- tidycensus::get_acs("state",
  variables = c(total_pop = "B01003_001"),
  year = 2022, cache_table = TRUE
) |>
  janitor::clean_names() |>
  tidyr::pivot_wider(id_cols = c(geoid, name), names_from = variable, values_from = estimate)

edu_by_state <- tidycensus::get_acs("state",
  table = "B06009",
  year = 2022, cache_table = TRUE
) |>
  janitor::clean_names() |>
  dplyr::left_join(edu_vars, by = "variable") |>
  dplyr::filter(name != "Puerto Rico") |>
  tidyr::separate_wider_delim(label, delim = "X", names = c("place_of_birth", "edu")) |>
  dplyr::mutate(dplyr::across(c(place_of_birth, edu), forcats::as_factor)) |>
  dplyr::mutate(place_of_birth = forcats::fct_collapse(place_of_birth, other_us = c("other_us", "diff_state"))) |>
  dplyr::filter(edu != "total") |>
  dplyr::group_by(geoid, name, place_of_birth, edu) |>
  dplyr::summarise(estimate = sum(estimate)) |>
  dplyr::mutate(share = estimate / sum(estimate)) |>
  dplyr::ungroup() |>
  dplyr::left_join(pop_by_state, by = c("geoid", "name"))

saveRDS(edu_by_state, "inputs/edu_by_state.rds")


# population by block
# tidycensus::load_variables(2020, "dhc") |>
#   dplyr::filter(grepl("^H4_", name))
tenure_block <- tidycensus::get_decennial("block",
  year = 2020, cache_table = TRUE, output = "wide", sumfile = "dhc",
  state = "24", county = "510", geometry = TRUE,
  variables = c(
    total_hh = "H4_001N",
    owned_mortgage = "H4_002N",
    owned_full = "H4_003N",
    rented = "H4_004N"
  )
) |>
  janitor::clean_names() |>
  dplyr::mutate(owned = owned_mortgage + owned_full) |>
  dplyr::select(geoid, total_hh, owned, rented)

saveRDS(tenure_block, "inputs/tenure_by_block.rds")


# means of commuting
commute <- tidycensus::get_acs("county",
  year = 2022, cache_table = TRUE, output = "wide", state = "24",
  variables = c(
    bus = "B08301_011",
    subway = "B08301_012",
    commuter_rail = "B08301_013",
    light_rail = "B08301_014",
    ferry = "B08301_015"
  )
) |>
  janitor::clean_names() |>
  dplyr::select(-tidyselect::matches("_m$"), -geoid) |>
  dplyr::rename_with(\(x) stringr::str_remove(x, "_e$")) |>
  dplyr::mutate(name = stringr::str_remove(name, ", Maryland")) |>
  tidyr::pivot_longer(-name, names_to = "type", values_to = "count") |>
  dplyr::group_by(name) |>
  dplyr::mutate(share = count / sum(count)) |>
  dplyr::ungroup()

saveRDS(commute, "inputs/public_transit_commutes.rds")


# businesses by neighborhood
# from city open data portal
nb_business <- arcgislayers::arc_read("https://services1.arcgis.com/mVFRs7NF4iFitgbY/arcgis/rest/services/Neibus/FeatureServer/0") |>
  janitor::clean_names() |>
  dplyr::select(name = csa2020, dplyr::matches("neibus\\d+")) |>
  tidyr::pivot_longer(c(-name, -geometry), names_to = c(NA, "year"), names_pattern = "([a-z]+)(\\d+)") |>
  dplyr::mutate(year = as.numeric(paste0("20", year)))

saveRDS(nb_business, "inputs/business_by_nhood.rds")
