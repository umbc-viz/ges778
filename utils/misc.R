# counties that make up Baltimore metro area
# metropolitan statistical areas come from census bureau's TIGER database via the tigris package
# returns an sf object with geometries
msa_sf <- tigris::core_based_statistical_areas(year = 2023, progress = FALSE, refresh = FALSE) |>
  janitor::clean_names() |>
  dplyr::select(name, geoid)
# md county geos also from TIGER
# if we don't actually need the county shapes, intersecting with their centroids is easier
county_cents <- tigris::counties(state = "MD", progress = FALSE, refresh = FALSE) |>
  janitor::clean_names() |>
  sf::st_centroid()

# filter msa for just the one that has Baltimore in the name, 
# get intersection with counties
# pull out the full names column into a vector
balt_metro <- sf::st_intersects(county_cents, msa_sf$geometry[grepl("Baltimore", msa_sf$name)])
balt_metro <- county_cents$namelsad[lengths(balt_metro) > 0]

# delete the county centroids since we don't need them
rm(county_cents)

# get states
states_sf <- tigris::states(cb = TRUE)


saveRDS(states_sf, "utils/states_sf.rds")
saveRDS(balt_metro, "utils/balt_metro.rds")


