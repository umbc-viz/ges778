scale <- 5L

blocks_sf <- tigris::blocks(state = "MD", county = "510", year = 2020) |>
    dplyr::select(geoid = GEOID20) |>
    rmapshaper::ms_simplify(keep = 0.2)
# helper functions from ct-data-haven/cwi
pop_fetch <- tidycensus::get_decennial(
    "block",
    table = "P12",
    state = "MD",
    year = 2020,
    sumfile = "dhc"
)


pop_by_age <- pop_fetch |>
    janitor::clean_names() |>
    dplyr::filter(grepl("^24510", geoid)) |>
    cwi::label_decennial() |>
    cwi::separate_acs(label, into = c("sex", "age"), drop_total = TRUE) |>
    dplyr::filter(!is.na(age)) |>
    cwi::show_uniq(age) |>
    dplyr::group_by(geoid) |>
    cwi::add_grps(
        list(
            total_pop = 1:23,
            ages00_17 = 1:4,
            ages18_34 = 5:10,
            ages35_64 = 11:17,
            ages65plus = 18:23
        ),
        group = age,
        value = value
    ) |>
    dplyr::ungroup() |>
    dplyr::mutate(value = as.integer(round(value))) |>
    tidyr::pivot_wider(id_cols = geoid, names_from = age) |>
    as.data.frame()

age_sf <- blocks_sf |>
    dplyr::inner_join(pop_by_age, by = "geoid") |>
    dplyr::filter(total_pop > 0)

row.names(age_sf) <- age_sf$geoid
# age_sf_to_dens <- age_sf[, c("ages00_17", "ages65plus")]

age_dot <- dots::dots_points(
    age_sf,
    c(ages00_17, ages65plus),
    divisor = scale,
    min_point = 1
)

saveRDS(age_dot, "assets/pop_age_dot_density.rds")
