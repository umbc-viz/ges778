edu <- tidycensus::get_acs("state", table = "B06009", year = 2024) |>
    cwi::label_acs(year = 2024) |>
    dplyr::filter(!grepl("(B|b)orn", label)) |>
    dplyr::group_by(name = NAME) |>
    cwi::add_grps(
        list(
            ages25plus = 1,
            less_than_high_school = 2,
            high_school_grad = 3,
            some_college_or_aa = 4,
            bachelors = 5,
            grad_degree = 6
        ),
        group = label
    ) |>
    cwi::calc_shares(group = label, denom = "ages25plus", digits = 2) |>
    dplyr::rename(group = label) |>
    dplyr::ungroup() |>
    dplyr::left_join(
        dplyr::distinct(tidycensus::fips_codes, code = state, state_name),
        by = c("name" = "state_name")
    ) |>
    dplyr::relocate(code)

saveRDS(edu, "assets/edu_by_state.rds")
