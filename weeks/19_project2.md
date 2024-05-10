# 19. Project 2 troubleshooting
Camille Seaberry

- [Spatial joins](#spatial-joins)

``` r
library(dplyr)
library(sf)
library(ggplot2)
library(justviz)
```

## Spatial joins

Here’s how you can join sf points with sf polygons in order to find, for
example, the number of points in each polygon. This example is
brownfields per county. Like with other joins, it matters which is on
the left & which is on the right. `sf::st_join` has an argument to
change from a left join to an inner join by setting `left = TRUE` (the
default) to `left = FALSE`, respectively. The geometry after the join
will follow the type of object on the left.

``` r
counties_sf <- tigris::counties(state = "24", cb = TRUE) |>
  select(county = NAMELSAD)

# need to get into same crs
brownfields_transform <- st_transform(brownfields_sf, st_crs(counties_sf)) |>
  # selecting just a subset of columns to make it easier to see what's going on
  select(site = name, is_archived)

st_join(counties_sf, brownfields_transform) |>
  head() # polygon join point = polygon
```

|      | county           | site                                             | is_archived | geometry                     |
|:-----|:-----------------|:-------------------------------------------------|:------------|:-----------------------------|
| 60   | Baltimore County | Sauer Dump                                       | FALSE       | MULTIPOLYGON (((-76.3257 39… |
| 60.1 | Baltimore County | Aviation Station                                 | FALSE       | MULTIPOLYGON (((-76.3257 39… |
| 60.2 | Baltimore County | 68th Street Dump/ East Baltimore Dumping Complex | FALSE       | MULTIPOLYGON (((-76.3257 39… |
| 60.3 | Baltimore County | Industrial Enterprises                           | FALSE       | MULTIPOLYGON (((-76.3257 39… |
| 60.4 | Baltimore County | Bear Creek Sediments                             | FALSE       | MULTIPOLYGON (((-76.3257 39… |
| 61   | Worcester County | Campbell Soup Property                           | TRUE        | MULTIPOLYGON (((-75.66061 3… |

``` r
st_join(brownfields_transform, counties_sf) |>
  head() # point join polygon = point
```

| site                                             | is_archived | geometry                 | county                 |
|:-------------------------------------------------|:------------|:-------------------------|:-----------------------|
| FNT Realty Cherry Hill                           | FALSE       | POINT (-76.6335 39.2574) | Baltimore city         |
| Bush Valley Landfill                             | FALSE       | POINT (-76.2619 39.4671) | Harford County         |
| 101 Garrett Street                               | FALSE       | POINT (-76.6143 39.2376) | Baltimore city         |
| Northhampton, City of Largo                      | TRUE        | POINT (-76.8279 38.8806) | Prince George’s County |
| Shellfish Seafood, Ltd.                          | FALSE       | POINT (-75.688 38.2008)  | Somerset County        |
| Former PPG - Works No. 7 (Pittsburg Plate Glass) | TRUE        | POINT (-78.7479 39.5914) | Allegany County        |

There are 150 rows in the brownfields data, but the first join, the
dataframe with points joined onto polygons, has 153 rows. That’s because
there are 3 counties with no brownfields. To deal with that, I’ll redo
the join with `left = FALSE` to make it an inner join, so I don’t have
any counties without brownfields.

``` r
sites_per_county <- st_join(counties_sf, brownfields_transform, left = FALSE) |>
  # drop geometry---just want data frame for now
  st_drop_geometry() |>
  group_by(county) |>
  summarise(n_total_sites = n(),
            # throwing in another example aggregation
            n_open_sites = sum(!is_archived))

# join back onto counties shape, so every county has a polygon with a count
# that makes sure we get a true 0 observation for counties without sites
sites_per_county_sf <- counties_sf |>
  left_join(sites_per_county, by = "county") |>
  # fill in 0 for counties with no observations
  mutate(across(n_total_sites:n_open_sites, \(x) tidyr::replace_na(x, 0)))

ggplot(sites_per_county_sf) +
  geom_sf(aes(fill = n_open_sites), color = "black", linewidth = 0.2) +
  scale_fill_distiller(palette = "BuPu", direction = 1) +
  labs(title = "Number of current brownfields by county")
```

![](19_project2_files/figure-commonmark/unnamed-chunk-3-1.png)

Maybe a more meaningful thing to do would be a rate, such as brownfields
per 100,000 residents or brownfields per square mile, using data from
the ACS dataset.

``` r
sites_per_county_sf |>
  left_join(acs |> select(name, total_pop, area_sqmi), by = c("county" = "name")) |>
  mutate(open_sites_per_100k = (n_open_sites / total_pop) * 100000) |>
  ggplot() +
    geom_sf(aes(fill = open_sites_per_100k), color = "black", linewidth = 0.2) +
    scale_fill_distiller(palette = "BuPu", direction = 1) +
    labs(title = "Current brownfields per 100k residents by county")
```

![](19_project2_files/figure-commonmark/unnamed-chunk-4-1.png)

If instead we were interested in the points themselves but wanted to
know what counties they were each in, a join with brownfields on the
left would be helpful. For this example it wouldn’t be super useful, but
for other project ideas (such as finding points within buffers) it could
be.
