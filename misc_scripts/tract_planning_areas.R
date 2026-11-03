# server is down :-(
# library(sf)
# areas <- arcgislayers::arc_open(
#     "https://egis.baltimorecity.gov/egis/rest/services/Planning/Planning/FeatureServer/0"
# )
# areas_sf <- arcgislayers::arc_select(areas, fields = c("AREA_NAME")) |>
#     dplyr::rename(area = AREA_NAME) |>
#     sf::st_transform(st_crs(justviz::tracts_sf))
# tract_planning_area <- justviz::tracts_sf |>
#     dplyr::filter(county == "Baltimore city") |>
#     sf::st_join(areas_sf, left = FALSE, largest = TRUE) |>
#     sf::st_drop_geometry() |>
#     dplyr::select(-county)
# saveRDS(tract_planning_area, file.path("assets", "tract_planning_area.rds"))

areas_sf <- sf::st_read("assets/Planning_District.gdb.zip") |>
    dplyr::select(area = AREA_NAME)
tract_planning_area <- tigris::tracts(state = "MD", cb = TRUE) |>
    dplyr::select(geoid = GEOID) |>
    sf::st_transform(sf::st_crs(areas_sf)) |>
    sf::st_join(areas_sf, left = FALSE, largest = TRUE) |>
    sf::st_drop_geometry()
saveRDS(tract_planning_area, file.path("assets", "tract_planning_area.rds"))
