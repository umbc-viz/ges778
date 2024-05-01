tenure <- readRDS("inputs/tenure_by_block.rds") |>
  dplyr::mutate(dplyr::across(owned:total_hh, \(x) as.integer(round(x)))) |>
  dplyr::filter(total_hh > 0) |>
  rmapshaper::ms_simplify() |>
  as.data.frame() |>
  sf::st_as_sf()
row.names(tenure) <- tenure$geoid
tenure$geoid <- NULL

scale <- 5L

tictoc::tic()
tenure_dot <- dots::dots_points(tenure, c(total_hh, owned, rented), divisor = scale, min_point = 1)
tictoc::toc()

saveRDS(tenure_dot, "inputs/tenure_dot_density.rds")
