tenure <- tidycensus::get_acs(
    geography = "county",
    state = "MD",
    year = 2024,
    variables = c(total_hh = "B25003_001", owner_hh = "B25003_002")
) |>
    janitor::clean_names() |>
    dplyr::mutate(name = stringr::str_remove(name, ", .+$")) |>
    dplyr::select(-geoid) |>
    tidyr::pivot_wider(
        id_cols = name,
        names_from = variable,
        values_from = c(estimate, moe),
        names_vary = "slowest",
        names_glue = "{variable}_{.value}"
    ) |>
    dplyr::mutate(homeownership_rate = owner_hh_estimate / total_hh_estimate) |>
    dplyr::mutate(
        homeownership_rate_moe = tidycensus::moe_prop(
            num = owner_hh_estimate,
            denom = total_hh_estimate,
            moe_num = owner_hh_moe,
            moe_denom = total_hh_moe
        )
    )
readr::write_csv(tenure, "assets/tenure_with_moe.csv")
