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

st_join(counties_sf, brownfields_transform) # polygon join point = polygon
```

|         | county                 | site                                                        | is_archived | geometry                     |
|:--------|:-----------------------|:------------------------------------------------------------|:------------|:-----------------------------|
| 60      | Baltimore County       | Sauer Dump                                                  | FALSE       | MULTIPOLYGON (((-76.3257 39… |
| 60.1    | Baltimore County       | Aviation Station                                            | FALSE       | MULTIPOLYGON (((-76.3257 39… |
| 60.2    | Baltimore County       | 68th Street Dump/ East Baltimore Dumping Complex            | FALSE       | MULTIPOLYGON (((-76.3257 39… |
| 60.3    | Baltimore County       | Industrial Enterprises                                      | FALSE       | MULTIPOLYGON (((-76.3257 39… |
| 60.4    | Baltimore County       | Bear Creek Sediments                                        | FALSE       | MULTIPOLYGON (((-76.3257 39… |
| 61      | Worcester County       | Campbell Soup Property                                      | TRUE        | MULTIPOLYGON (((-75.66061 3… |
| 61.1    | Worcester County       | Tri-State Oil                                               | TRUE        | MULTIPOLYGON (((-75.66061 3… |
| 61.2    | Worcester County       | Byrd Park                                                   | FALSE       | MULTIPOLYGON (((-75.66061 3… |
| 61.3    | Worcester County       | Conectiv Ocean City District Office                         | TRUE        | MULTIPOLYGON (((-75.66061 3… |
| 62      | Montgomery County      | National Park Seminary (North of Linden Lane)               | FALSE       | MULTIPOLYGON (((-77.52728 3… |
| 404     | St. Mary’s County      | Leonardtown Wharf                                           | FALSE       | MULTIPOLYGON (((-76.74729 3… |
| 404.1   | St. Mary’s County      | Southern Maryland Wood Treating                             | TRUE        | MULTIPOLYGON (((-76.74729 3… |
| 404.2   | St. Mary’s County      | Patuxent River Naval Air Station                            | FALSE       | MULTIPOLYGON (((-76.74729 3… |
| 404.3   | St. Mary’s County      | Lexington Park Site                                         | FALSE       | MULTIPOLYGON (((-76.74729 3… |
| 405     | Charles County         | Naval Ordance Station - Indian Head                         | FALSE       | MULTIPOLYGON (((-77.2724 38… |
| 407     | Frederick County       | Frederick Parcel F                                          | FALSE       | MULTIPOLYGON (((-77.67716 3… |
| 407.1   | Frederick County       | Fort Detrick - USA                                          | FALSE       | MULTIPOLYGON (((-77.67716 3… |
| 407.2   | Frederick County       | Frederick Parcel G                                          | FALSE       | MULTIPOLYGON (((-77.67716 3… |
| 407.3   | Frederick County       | Frederick Parcels J and K                                   | FALSE       | MULTIPOLYGON (((-77.67716 3… |
| 407.4   | Frederick County       | Frederick Cooperative                                       | FALSE       | MULTIPOLYGON (((-77.67716 3… |
| 407.5   | Frederick County       | Middletown Fuel Depot                                       | FALSE       | MULTIPOLYGON (((-77.67716 3… |
| 407.6   | Frederick County       | McHenry Property                                            | FALSE       | MULTIPOLYGON (((-77.67716 3… |
| 407.7   | Frederick County       | Frederick Parcel D                                          | FALSE       | MULTIPOLYGON (((-77.67716 3… |
| 407.8   | Frederick County       | Property 3                                                  | FALSE       | MULTIPOLYGON (((-77.67716 3… |
| 408     | Washington County      | University of Maryland - Hagerstown Center                  | FALSE       | MULTIPOLYGON (((-78.36346 3… |
| 408.1   | Washington County      | Hagers Shoe (Cannon Shoe Factory)                           | FALSE       | MULTIPOLYGON (((-78.36346 3… |
| 408.2   | Washington County      | Central Chemical - Hagerstown (Site)                        | FALSE       | MULTIPOLYGON (((-78.36346 3… |
| 408.3   | Washington County      | MP Moller, Inc. (Blue Mountain Woodworks)                   | TRUE        | MULTIPOLYGON (((-78.36346 3… |
| 610     | Howard County          | NA                                                          | NA          | MULTIPOLYGON (((-77.18711 3… |
| 693     | Prince George’s County | Northhampton, City of Largo                                 | TRUE        | MULTIPOLYGON (((-77.07995 3… |
| 693.1   | Prince George’s County | Beltsville Agricultural Research Center                     | FALSE       | MULTIPOLYGON (((-77.07995 3… |
| 693.2   | Prince George’s County | Andrews Air Force Base                                      | FALSE       | MULTIPOLYGON (((-77.07995 3… |
| 693.3   | Prince George’s County | Wilson Farm                                                 | FALSE       | MULTIPOLYGON (((-77.07995 3… |
| 693.4   | Prince George’s County | Summerfield Extended Stay Hotel                             | FALSE       | MULTIPOLYGON (((-77.07995 3… |
| 693.5   | Prince George’s County | Brandywine DRMO Salvage Yard                                | FALSE       | MULTIPOLYGON (((-77.07995 3… |
| 693.6   | Prince George’s County | Hampton Business Park                                       | FALSE       | MULTIPOLYGON (((-77.07995 3… |
| 693.7   | Prince George’s County | Addison Road                                                | TRUE        | MULTIPOLYGON (((-77.07995 3… |
| 693.8   | Prince George’s County | Windsor Manor Road Site                                     | TRUE        | MULTIPOLYGON (((-77.07995 3… |
| 693.9   | Prince George’s County | Industrial Towel Supply, Inc.                               | TRUE        | MULTIPOLYGON (((-77.07995 3… |
| 693.10  | Prince George’s County | Litton Industries                                           | FALSE       | MULTIPOLYGON (((-77.07995 3… |
| 694     | Cecil County           | Hopkins Quarry                                              | FALSE       | MULTIPOLYGON (((-76.23326 3… |
| 694.1   | Cecil County           | Maryland Sand, Gravel and Stone                             | FALSE       | MULTIPOLYGON (((-76.23326 3… |
| 694.2   | Cecil County           | Ordnance Products                                           | FALSE       | MULTIPOLYGON (((-76.23326 3… |
| 694.3   | Cecil County           | Triumph Industrial Park/WL Gore                             | FALSE       | MULTIPOLYGON (((-76.23326 3… |
| 694.4   | Cecil County           | Spectron                                                    | FALSE       | MULTIPOLYGON (((-76.23326 3… |
| 694.5   | Cecil County           | Ionics, Incorporated                                        | TRUE        | MULTIPOLYGON (((-76.23326 3… |
| 694.6   | Cecil County           | Woodlawn Landfill                                           | FALSE       | MULTIPOLYGON (((-76.23326 3… |
| 694.7   | Cecil County           | Route 7 Chem Dump Site                                      | FALSE       | MULTIPOLYGON (((-76.23326 3… |
| 694.8   | Cecil County           | Trinco Industrial Park - 18 Lots                            | FALSE       | MULTIPOLYGON (((-76.23326 3… |
| 694.9   | Cecil County           | Dwyer Property                                              | FALSE       | MULTIPOLYGON (((-76.23326 3… |
| 694.10  | Cecil County           | Chesapeake Publishing Company Elkton                        | FALSE       | MULTIPOLYGON (((-76.23326 3… |
| 985     | Harford County         | Bush Valley Landfill                                        | FALSE       | MULTIPOLYGON (((-76.0921 39… |
| 985.1   | Harford County         | Aberdeen Proving Grounds - Edgewood Area                    | FALSE       | MULTIPOLYGON (((-76.0921 39… |
| 985.2   | Harford County         | Aberdeen Proving Grounds - Michaelsville Area               | FALSE       | MULTIPOLYGON (((-76.0921 39… |
| 985.3   | Harford County         | Havre de Grace Fireworks                                    | FALSE       | MULTIPOLYGON (((-76.0921 39… |
| 985.4   | Harford County         | Gilbert Property - 4 Parcels                                | FALSE       | MULTIPOLYGON (((-76.0921 39… |
| 985.5   | Harford County         | Penns Marina                                                | FALSE       | MULTIPOLYGON (((-76.0921 39… |
| 985.6   | Harford County         | Riegel Scrap Property                                       | FALSE       | MULTIPOLYGON (((-76.0921 39… |
| 999     | Queen Anne’s County    | Banjo Lane                                                  | FALSE       | MULTIPOLYGON (((-76.24918 3… |
| 999.1   | Queen Anne’s County    | Collins Electric/Johnson Property                           | TRUE        | MULTIPOLYGON (((-76.24918 3… |
| 1001    | Allegany County        | Former PPG - Works No. 7 (Pittsburg Plate Glass)            | TRUE        | MULTIPOLYGON (((-79.06756 3… |
| 1001.1  | Allegany County        | Highway Petroleum Inc                                       | FALSE       | MULTIPOLYGON (((-79.06756 3… |
| 1001.2  | Allegany County        | Brock Steel Company And Larry Brock DBA Brock Equipment Co. | FALSE       | MULTIPOLYGON (((-79.06756 3… |
| 1001.3  | Allegany County        | Footer’s Dye Works (Canal Place)                            | FALSE       | MULTIPOLYGON (((-79.06756 3… |
| 1001.4  | Allegany County        | Limestone Road Site                                         | FALSE       | MULTIPOLYGON (((-79.06756 3… |
| 1001.5  | Allegany County        | Former Sacred Heart Hospital                                | FALSE       | MULTIPOLYGON (((-79.06756 3… |
| 1136    | Dorchester County      | Cambridge Town Gas                                          | TRUE        | MULTIPOLYGON (((-76.06544 3… |
| 1136.1  | Dorchester County      | Phillips Packing                                            | FALSE       | MULTIPOLYGON (((-76.06544 3… |
| 1136.2  | Dorchester County      | Connelly Container                                          | FALSE       | MULTIPOLYGON (((-76.06544 3… |
| 1329    | Kent County            | 848 High Street                                             | TRUE        | MULTIPOLYGON (((-76.27737 3… |
| 1329.1  | Kent County            | Chestertown Gas Co.                                         | FALSE       | MULTIPOLYGON (((-76.27737 3… |
| 1329.2  | Kent County            | Former Crop Production Services                             | TRUE        | MULTIPOLYGON (((-76.27737 3… |
| 1383    | Calvert County         | NA                                                          | NA          | MULTIPOLYGON (((-76.70121 3… |
| 1478    | Garrett County         | NA                                                          | NA          | MULTIPOLYGON (((-79.48765 3… |
| 2048    | Talbot County          | Cordova Elementary School                                   | FALSE       | MULTIPOLYGON (((-76.34647 3… |
| 2048.1  | Talbot County          | Tidewater Tractor                                           | FALSE       | MULTIPOLYGON (((-76.34647 3… |
| 2048.2  | Talbot County          | D & B Products                                              | TRUE        | MULTIPOLYGON (((-76.34647 3… |
| 2048.3  | Talbot County          | Easton Gas & Light Co.                                      | TRUE        | MULTIPOLYGON (((-76.34647 3… |
| 2049    | Wicomico County        | Lester’s Garage                                             | FALSE       | MULTIPOLYGON (((-75.92033 3… |
| 2049.1  | Wicomico County        | Salisbury City Yard/North Prong                             | FALSE       | MULTIPOLYGON (((-75.92033 3… |
| 2049.2  | Wicomico County        | 407 Anne Street                                             | FALSE       | MULTIPOLYGON (((-75.92033 3… |
| 2050    | Anne Arundel County    | Mid-Atlantic Wood Preservers                                | TRUE        | MULTIPOLYGON (((-76.83849 3… |
| 2050.1  | Anne Arundel County    | USA Fort George G. Meade                                    | FALSE       | MULTIPOLYGON (((-76.83849 3… |
| 2050.2  | Anne Arundel County    | Honeywell Inc.                                              | FALSE       | MULTIPOLYGON (((-76.83849 3… |
| 2050.3  | Anne Arundel County    | Alliant Techsystems, Inc./Windermere Group, LLC             | TRUE        | MULTIPOLYGON (((-76.83849 3… |
| 2050.4  | Anne Arundel County    | U.S. Coast Guard - Curtis Bay                               | FALSE       | MULTIPOLYGON (((-76.83849 3… |
| 2050.5  | Anne Arundel County    | Anne Arundel County Landfill                                | TRUE        | MULTIPOLYGON (((-76.83849 3… |
| 2058    | Baltimore city         | FNT Realty Cherry Hill                                      | FALSE       | MULTIPOLYGON (((-76.71152 3… |
| 2058.1  | Baltimore city         | 101 Garrett Street                                          | FALSE       | MULTIPOLYGON (((-76.71152 3… |
| 2058.2  | Baltimore city         | Clipper Industrial Park                                     | FALSE       | MULTIPOLYGON (((-76.71152 3… |
| 2058.3  | Baltimore city         | Gunther Brewery                                             | FALSE       | MULTIPOLYGON (((-76.71152 3… |
| 2058.4  | Baltimore city         | Johns Hopkins University Bayview Research Center            | FALSE       | MULTIPOLYGON (((-76.71152 3… |
| 2058.5  | Baltimore city         | Baltimore Museum of Industry                                | FALSE       | MULTIPOLYGON (((-76.71152 3… |
| 2058.6  | Baltimore city         | Boston at Conkling (2 Parcels)                              | FALSE       | MULTIPOLYGON (((-76.71152 3… |
| 2058.7  | Baltimore city         | 1645 Warner Street                                          | FALSE       | MULTIPOLYGON (((-76.71152 3… |
| 2058.8  | Baltimore city         | Parkin Street                                               | FALSE       | MULTIPOLYGON (((-76.71152 3… |
| 2058.9  | Baltimore city         | Tolkoff Warehouse                                           | FALSE       | MULTIPOLYGON (((-76.71152 3… |
| 2058.10 | Baltimore city         | Cambrex Facility                                            | FALSE       | MULTIPOLYGON (((-76.71152 3… |
| 2058.11 | Baltimore city         | Center for Aquatic Life and Conservation (CALC)             | TRUE        | MULTIPOLYGON (((-76.71152 3… |
| 2058.12 | Baltimore city         | 5600 Lombard Street                                         | FALSE       | MULTIPOLYGON (((-76.71152 3… |
| 2058.13 | Baltimore city         | Carroll Camden Area                                         | FALSE       | MULTIPOLYGON (((-76.71152 3… |
| 2058.14 | Baltimore city         | 1301 Wicomico Street                                        | FALSE       | MULTIPOLYGON (((-76.71152 3… |
| 2058.15 | Baltimore city         | Fairfield Homes                                             | FALSE       | MULTIPOLYGON (((-76.71152 3… |
| 2058.16 | Baltimore city         | Chesapeake Machine                                          | FALSE       | MULTIPOLYGON (((-76.71152 3… |
| 2058.17 | Baltimore city         | Hiken Brothers                                              | FALSE       | MULTIPOLYGON (((-76.71152 3… |
| 2058.18 | Baltimore city         | Frankford Gardens Shopping Center                           | TRUE        | MULTIPOLYGON (((-76.71152 3… |
| 2058.19 | Baltimore city         | 3515 Dolfield Avenue                                        | TRUE        | MULTIPOLYGON (((-76.71152 3… |
| 2058.20 | Baltimore city         | Former Southern Can Company                                 | FALSE       | MULTIPOLYGON (((-76.71152 3… |
| 2058.21 | Baltimore city         | 3700 Potee Street                                           | FALSE       | MULTIPOLYGON (((-76.71152 3… |
| 2058.22 | Baltimore city         | 4400 Reisterstown Road                                      | FALSE       | MULTIPOLYGON (((-76.71152 3… |
| 2058.23 | Baltimore city         | CSX Chesapeake and Shell                                    | FALSE       | MULTIPOLYGON (((-76.71152 3… |
| 2058.24 | Baltimore city         | CSX Shell and Patapsco                                      | FALSE       | MULTIPOLYGON (((-76.71152 3… |
| 2058.25 | Baltimore city         | Fairfield Mixed Residential I                               | FALSE       | MULTIPOLYGON (((-76.71152 3… |
| 2058.26 | Baltimore city         | Fort McHenry Shipyard                                       | FALSE       | MULTIPOLYGON (((-76.71152 3… |
| 2058.27 | Baltimore city         | 806 North Haven Street                                      | FALSE       | MULTIPOLYGON (((-76.71152 3… |
| 2058.28 | Baltimore city         | Seton Business Park                                         | FALSE       | MULTIPOLYGON (((-76.71152 3… |
| 2058.29 | Baltimore city         | Malt Mill Building                                          | TRUE        | MULTIPOLYGON (((-76.71152 3… |
| 2058.30 | Baltimore city         | 921-925 Fort Avenue                                         | TRUE        | MULTIPOLYGON (((-76.71152 3… |
| 2058.31 | Baltimore city         | 1236 & 1240 West Pratt Street                               | FALSE       | MULTIPOLYGON (((-76.71152 3… |
| 2058.32 | Baltimore city         | American Brewery - Brewhouse Parcel                         | TRUE        | MULTIPOLYGON (((-76.71152 3… |
| 2058.33 | Baltimore city         | American Visionary Arts Museum                              | FALSE       | MULTIPOLYGON (((-76.71152 3… |
| 2058.34 | Baltimore city         | Phipps Construction                                         | FALSE       | MULTIPOLYGON (((-76.71152 3… |
| 2058.35 | Baltimore city         | Former Waterford Caseworks                                  | TRUE        | MULTIPOLYGON (((-76.71152 3… |
| 2058.36 | Baltimore city         | Acme Business Park - Rosemont                               | FALSE       | MULTIPOLYGON (((-76.71152 3… |
| 2058.37 | Baltimore city         | Fairfield Mixed Residential II                              | FALSE       | MULTIPOLYGON (((-76.71152 3… |
| 2058.38 | Baltimore city         | Shannon Drive                                               | FALSE       | MULTIPOLYGON (((-76.71152 3… |
| 2058.39 | Baltimore city         | Key Highway Shipyard                                        | TRUE        | MULTIPOLYGON (((-76.71152 3… |
| 2058.40 | Baltimore city         | Pat Blox Property                                           | FALSE       | MULTIPOLYGON (((-76.71152 3… |
| 2058.41 | Baltimore city         | Society Cleaners                                            | FALSE       | MULTIPOLYGON (((-76.71152 3… |
| 2058.42 | Baltimore city         | Ridgley Cove                                                | TRUE        | MULTIPOLYGON (((-76.71152 3… |
| 2058.43 | Baltimore city         | Kane Street                                                 | FALSE       | MULTIPOLYGON (((-76.71152 3… |
| 2058.44 | Baltimore city         | Waterview Property                                          | FALSE       | MULTIPOLYGON (((-76.71152 3… |
| 2058.45 | Baltimore city         | Riverside Wharf                                             | TRUE        | MULTIPOLYGON (((-76.71152 3… |
| 2058.46 | Baltimore city         | Wetzel Brothers                                             | FALSE       | MULTIPOLYGON (((-76.71152 3… |
| 2058.47 | Baltimore city         | 801 South Caroline Street                                   | TRUE        | MULTIPOLYGON (((-76.71152 3… |
| 2058.48 | Baltimore city         | Picorp Inc                                                  | FALSE       | MULTIPOLYGON (((-76.71152 3… |
| 2058.49 | Baltimore city         | Kane and Lombard                                            | FALSE       | MULTIPOLYGON (((-76.71152 3… |
| 2058.50 | Baltimore city         | CSX Chesapeake Avenue Lot                                   | TRUE        | MULTIPOLYGON (((-76.71152 3… |
| 2058.51 | Baltimore city         | 1440 Key Highway                                            | FALSE       | MULTIPOLYGON (((-76.71152 3… |
| 2058.52 | Baltimore city         | Warner Street Properties Brownfields                        | FALSE       | MULTIPOLYGON (((-76.71152 3… |
| 2058.53 | Baltimore city         | Carey Machinery and Supply                                  | FALSE       | MULTIPOLYGON (((-76.71152 3… |
| 2058.54 | Baltimore city         | Oldham Crossing                                             | TRUE        | MULTIPOLYGON (((-76.71152 3… |
| 2058.55 | Baltimore city         | Baltimore American Ice Co.                                  | FALSE       | MULTIPOLYGON (((-76.71152 3… |
| 2194    | Caroline County        | Former Famous Dry Cleaners                                  | TRUE        | MULTIPOLYGON (((-76.01505 3… |
| 2194.1  | Caroline County        | Old Town Barn                                               | TRUE        | MULTIPOLYGON (((-76.01505 3… |
| 2194.2  | Caroline County        | Rossnan Property, Goldsboro                                 | FALSE       | MULTIPOLYGON (((-76.01505 3… |
| 2468    | Somerset County        | Shellfish Seafood, Ltd.                                     | FALSE       | MULTIPOLYGON (((-75.95962 3… |
| 2468.1  | Somerset County        | Carvel Hall                                                 | FALSE       | MULTIPOLYGON (((-75.95962 3… |
| 2468.2  | Somerset County        | H&H Derby                                                   | FALSE       | MULTIPOLYGON (((-75.95962 3… |
| 2468.3  | Somerset County        | 11731 Somerset Avenue                                       | TRUE        | MULTIPOLYGON (((-75.95962 3… |
| 3008    | Carroll County         | Southern States Grist Mill                                  | FALSE       | MULTIPOLYGON (((-77.31116 3… |
| 3008.1  | Carroll County         | Castle Farms                                                | FALSE       | MULTIPOLYGON (((-77.31116 3… |
| 3008.2  | Carroll County         | 7520 Main Street                                            | TRUE        | MULTIPOLYGON (((-77.31116 3… |

``` r
st_join(brownfields_transform, counties_sf) # point join polygon = point
```

| site                                                        | is_archived | geometry                 | county                 |
|:------------------------------------------------------------|:------------|:-------------------------|:-----------------------|
| FNT Realty Cherry Hill                                      | FALSE       | POINT (-76.6335 39.2574) | Baltimore city         |
| Bush Valley Landfill                                        | FALSE       | POINT (-76.2619 39.4671) | Harford County         |
| 101 Garrett Street                                          | FALSE       | POINT (-76.6143 39.2376) | Baltimore city         |
| Northhampton, City of Largo                                 | TRUE        | POINT (-76.8279 38.8806) | Prince George’s County |
| Shellfish Seafood, Ltd.                                     | FALSE       | POINT (-75.688 38.2008)  | Somerset County        |
| Former PPG - Works No. 7 (Pittsburg Plate Glass)            | TRUE        | POINT (-78.7479 39.5914) | Allegany County        |
| Clipper Industrial Park                                     | FALSE       | POINT (-76.647 39.3318)  | Baltimore city         |
| Gunther Brewery                                             | FALSE       | POINT (-76.5662 39.2792) | Baltimore city         |
| Johns Hopkins University Bayview Research Center            | FALSE       | POINT (-76.5505 39.2919) | Baltimore city         |
| Southern States Grist Mill                                  | FALSE       | POINT (-76.9699 39.3646) | Carroll County         |
| Baltimore Museum of Industry                                | FALSE       | POINT (-76.6013 39.274)  | Baltimore city         |
| Boston at Conkling (2 Parcels)                              | FALSE       | POINT (-76.5644 39.2793) | Baltimore city         |
| 1645 Warner Street                                          | FALSE       | POINT (-76.6278 39.2721) | Baltimore city         |
| Former Famous Dry Cleaners                                  | TRUE        | POINT (-75.773 38.6937)  | Caroline County        |
| Frederick Parcel F                                          | FALSE       | POINT (-77.4085 39.4114) | Frederick County       |
| Parkin Street                                               | FALSE       | POINT (-76.6295 39.2857) | Baltimore city         |
| Tolkoff Warehouse                                           | FALSE       | POINT (-76.5662 39.2789) | Baltimore city         |
| Naval Ordance Station - Indian Head                         | FALSE       | POINT (-77.19 38.5834)   | Charles County         |
| Fort Detrick - USA                                          | FALSE       | POINT (-77.4246 39.4417) | Frederick County       |
| Cambridge Town Gas                                          | TRUE        | POINT (-76.0743 38.5688) | Dorchester County      |
| Highway Petroleum Inc                                       | FALSE       | POINT (-78.767 39.6289)  | Allegany County        |
| Cambrex Facility                                            | FALSE       | POINT (-76.5473 39.2952) | Baltimore city         |
| Beltsville Agricultural Research Center                     | FALSE       | POINT (-76.8887 39.0228) | Prince George’s County |
| Andrews Air Force Base                                      | FALSE       | POINT (-76.8741 38.8049) | Prince George’s County |
| Aberdeen Proving Grounds - Edgewood Area                    | FALSE       | POINT (-76.2869 39.349)  | Harford County         |
| Aberdeen Proving Grounds - Michaelsville Area               | FALSE       | POINT (-76.1877 39.4084) | Harford County         |
| Wilson Farm                                                 | FALSE       | POINT (-76.8638 38.9085) | Prince George’s County |
| Center for Aquatic Life and Conservation (CALC)             | TRUE        | POINT (-76.6171 39.2613) | Baltimore city         |
| Mid-Atlantic Wood Preservers                                | TRUE        | POINT (-76.6987 39.1617) | Anne Arundel County    |
| Hopkins Quarry                                              | FALSE       | POINT (-76.1276 39.6169) | Cecil County           |
| 5600 Lombard Street                                         | FALSE       | POINT (-76.5493 39.2954) | Baltimore city         |
| Old Town Barn                                               | TRUE        | POINT (-75.7726 38.6936) | Caroline County        |
| Castle Farms                                                | FALSE       | POINT (-76.861 39.5875)  | Carroll County         |
| Brock Steel Company And Larry Brock DBA Brock Equipment Co. | FALSE       | POINT (-78.7706 39.6312) | Allegany County        |
| Footer’s Dye Works (Canal Place)                            | FALSE       | POINT (-78.7627 39.6479) | Allegany County        |
| Carroll Camden Area                                         | FALSE       | POINT (-76.6261 39.2722) | Baltimore city         |
| 1301 Wicomico Street                                        | FALSE       | POINT (-76.6312 39.2766) | Baltimore city         |
| Fairfield Homes                                             | FALSE       | POINT (-76.5866 39.2356) | Baltimore city         |
| Chesapeake Machine                                          | FALSE       | POINT (-76.5612 39.2903) | Baltimore city         |
| Hiken Brothers                                              | FALSE       | POINT (-76.5649 39.2881) | Baltimore city         |
| Frankford Gardens Shopping Center                           | TRUE        | POINT (-76.54 39.3246)   | Baltimore city         |
| Summerfield Extended Stay Hotel                             | FALSE       | POINT (-76.8465 38.9143) | Prince George’s County |
| Campbell Soup Property                                      | TRUE        | POINT (-75.5787 38.0674) | Worcester County       |
| Frederick Parcel G                                          | FALSE       | POINT (-77.4069 39.4106) | Frederick County       |
| 3515 Dolfield Avenue                                        | TRUE        | POINT (-76.6742 39.3341) | Baltimore city         |
| USA Fort George G. Meade                                    | FALSE       | POINT (-76.7884 39.0689) | Anne Arundel County    |
| Tri-State Oil                                               | TRUE        | POINT (-75.3897 38.1796) | Worcester County       |
| Brandywine DRMO Salvage Yard                                | FALSE       | POINT (-76.8457 38.6991) | Prince George’s County |
| Former Southern Can Company                                 | FALSE       | POINT (-76.5686 39.306)  | Baltimore city         |
| 3700 Potee Street                                           | FALSE       | POINT (-76.612 39.2376)  | Baltimore city         |
| 4400 Reisterstown Road                                      | FALSE       | POINT (-76.6693 39.3399) | Baltimore city         |
| CSX Chesapeake and Shell                                    | FALSE       | POINT (-76.5889 39.2367) | Baltimore city         |
| CSX Shell and Patapsco                                      | FALSE       | POINT (-76.5845 39.2328) | Baltimore city         |
| Fairfield Mixed Residential I                               | FALSE       | POINT (-76.5814 39.2378) | Baltimore city         |
| Fort McHenry Shipyard                                       | FALSE       | POINT (-76.5813 39.2672) | Baltimore city         |
| 806 North Haven Street                                      | FALSE       | POINT (-76.5637 39.3002) | Baltimore city         |
| Seton Business Park                                         | FALSE       | POINT (-76.7081 39.3464) | Baltimore city         |
| Malt Mill Building                                          | TRUE        | POINT (-76.565 39.2814)  | Baltimore city         |
| Maryland Sand, Gravel and Stone                             | FALSE       | POINT (-75.8965 39.6168) | Cecil County           |
| Honeywell Inc.                                              | FALSE       | POINT (-76.5757 38.9871) | Anne Arundel County    |
| University of Maryland - Hagerstown Center                  | FALSE       | POINT (-77.7191 39.6414) | Washington County      |
| 921-925 Fort Avenue                                         | TRUE        | POINT (-76.6011 39.271)  | Baltimore city         |
| Hagers Shoe (Cannon Shoe Factory)                           | FALSE       | POINT (-77.7204 39.6437) | Washington County      |
| Sauer Dump                                                  | FALSE       | POINT (-76.4526 39.2702) | Baltimore County       |
| Ordnance Products                                           | FALSE       | POINT (-75.9233 39.6273) | Cecil County           |
| 1236 & 1240 West Pratt Street                               | FALSE       | POINT (-76.5998 39.2887) | Baltimore city         |
| Lester’s Garage                                             | FALSE       | POINT (-75.6255 38.3716) | Wicomico County        |
| Carvel Hall                                                 | FALSE       | POINT (-75.8298 37.9988) | Somerset County        |
| Triumph Industrial Park/WL Gore                             | FALSE       | POINT (-75.8529 39.6154) | Cecil County           |
| American Brewery - Brewhouse Parcel                         | TRUE        | POINT (-76.5871 39.3093) | Baltimore city         |
| American Visionary Arts Museum                              | FALSE       | POINT (-76.6068 39.2795) | Baltimore city         |
| Havre de Grace Fireworks                                    | FALSE       | POINT (-76.1187 39.552)  | Harford County         |
| Spectron                                                    | FALSE       | POINT (-75.8764 39.6907) | Cecil County           |
| Phipps Construction                                         | FALSE       | POINT (-76.5549 39.3156) | Baltimore city         |
| Central Chemical - Hagerstown (Site)                        | FALSE       | POINT (-77.7228 39.6571) | Washington County      |
| 848 High Street                                             | TRUE        | POINT (-76.0778 39.2188) | Kent County            |
| Byrd Park                                                   | FALSE       | POINT (-75.4018 38.1732) | Worcester County       |
| Ionics, Incorporated                                        | TRUE        | POINT (-75.8385 39.6105) | Cecil County           |
| Woodlawn Landfill                                           | FALSE       | POINT (-76.0868 39.6418) | Cecil County           |
| Leonardtown Wharf                                           | FALSE       | POINT (-76.6373 38.2869) | St. Mary’s County      |
| Rossnan Property, Goldsboro                                 | FALSE       | POINT (-75.7848 39.0359) | Caroline County        |
| Phillips Packing                                            | FALSE       | POINT (-76.0681 38.5608) | Dorchester County      |
| Connelly Container                                          | FALSE       | POINT (-76.0621 38.5532) | Dorchester County      |
| Banjo Lane                                                  | FALSE       | POINT (-76.0627 39.0451) | Queen Anne’s County    |
| Former Waterford Caseworks                                  | TRUE        | POINT (-76.6299 39.275)  | Baltimore city         |
| Southern Maryland Wood Treating                             | TRUE        | POINT (-76.5921 38.3644) | St. Mary’s County      |
| Limestone Road Site                                         | FALSE       | POINT (-78.7186 39.6245) | Allegany County        |
| Route 7 Chem Dump Site                                      | FALSE       | POINT (-75.8874 39.6041) | Cecil County           |
| Frederick Parcels J and K                                   | FALSE       | POINT (-77.4014 39.414)  | Frederick County       |
| Acme Business Park - Rosemont                               | FALSE       | POINT (-76.5881 39.3112) | Baltimore city         |
| Fairfield Mixed Residential II                              | FALSE       | POINT (-76.5784 39.2378) | Baltimore city         |
| Shannon Drive                                               | FALSE       | POINT (-76.555 39.315)   | Baltimore city         |
| Trinco Industrial Park - 18 Lots                            | FALSE       | POINT (-75.8547 39.6203) | Cecil County           |
| Frederick Cooperative                                       | FALSE       | POINT (-77.4092 39.4108) | Frederick County       |
| Middletown Fuel Depot                                       | FALSE       | POINT (-77.5458 39.4412) | Frederick County       |
| Gilbert Property - 4 Parcels                                | FALSE       | POINT (-76.0925 39.5544) | Harford County         |
| Penns Marina                                                | FALSE       | POINT (-76.0848 39.5428) | Harford County         |
| Riegel Scrap Property                                       | FALSE       | POINT (-76.0856 39.5424) | Harford County         |
| Hampton Business Park                                       | FALSE       | POINT (-76.8525 38.8833) | Prince George’s County |
| Cordova Elementary School                                   | FALSE       | POINT (-75.9968 38.8791) | Talbot County          |
| Tidewater Tractor                                           | FALSE       | POINT (-76.0634 38.9382) | Talbot County          |
| Patuxent River Naval Air Station                            | FALSE       | POINT (-76.4569 38.2809) | St. Mary’s County      |
| Key Highway Shipyard                                        | TRUE        | POINT (-76.6056 39.2776) | Baltimore city         |
| Pat Blox Property                                           | FALSE       | POINT (-76.5636 39.3007) | Baltimore city         |
| Former Sacred Heart Hospital                                | FALSE       | POINT (-78.759 39.6553)  | Allegany County        |
| Society Cleaners                                            | FALSE       | POINT (-76.5453 39.2877) | Baltimore city         |
| Ridgley Cove                                                | TRUE        | POINT (-76.6253 39.2725) | Baltimore city         |
| Aviation Station                                            | FALSE       | POINT (-76.4151 39.3364) | Baltimore County       |
| McHenry Property                                            | FALSE       | POINT (-77.4052 39.4135) | Frederick County       |
| 7520 Main Street                                            | TRUE        | POINT (-76.9699 39.3672) | Carroll County         |
| Alliant Techsystems, Inc./Windermere Group, LLC             | TRUE        | POINT (-76.573 38.9872)  | Anne Arundel County    |
| H&H Derby                                                   | FALSE       | POINT (-75.7032 38.2023) | Somerset County        |
| Addison Road                                                | TRUE        | POINT (-76.896 38.8893)  | Prince George’s County |
| Kane Street                                                 | FALSE       | POINT (-76.5328 39.2949) | Baltimore city         |
| Frederick Parcel D                                          | FALSE       | POINT (-77.4068 39.4122) | Frederick County       |
| Windsor Manor Road Site                                     | TRUE        | POINT (-76.7892 38.7239) | Prince George’s County |
| Conectiv Ocean City District Office                         | TRUE        | POINT (-75.223 38.3281)  | Worcester County       |
| Waterview Property                                          | FALSE       | POINT (-76.6276 39.2563) | Baltimore city         |
| Chestertown Gas Co.                                         | FALSE       | POINT (-76.0758 39.2146) | Kent County            |
| Riverside Wharf                                             | TRUE        | POINT (-76.6014 39.2729) | Baltimore city         |
| Wetzel Brothers                                             | FALSE       | POINT (-76.5863 39.2976) | Baltimore city         |
| Collins Electric/Johnson Property                           | TRUE        | POINT (-76.3068 38.9927) | Queen Anne’s County    |
| 801 South Caroline Street                                   | TRUE        | POINT (-76.5963 39.2821) | Baltimore city         |
| Industrial Towel Supply, Inc.                               | TRUE        | POINT (-76.8431 39.1)    | Prince George’s County |
| Picorp Inc                                                  | FALSE       | POINT (-76.5339 39.2967) | Baltimore city         |
| Former Crop Production Services                             | TRUE        | POINT (-76.0674 39.204)  | Kent County            |
| 68th Street Dump/ East Baltimore Dumping Complex            | FALSE       | POINT (-76.5222 39.3081) | Baltimore County       |
| Industrial Enterprises                                      | FALSE       | POINT (-76.5151 39.3065) | Baltimore County       |
| Kane and Lombard                                            | FALSE       | POINT (-76.5354 39.2947) | Baltimore city         |
| Dwyer Property                                              | FALSE       | POINT (-75.8444 39.6174) | Cecil County           |
| D & B Products                                              | TRUE        | POINT (-76.0783 38.7238) | Talbot County          |
| U.S. Coast Guard - Curtis Bay                               | FALSE       | POINT (-76.5692 39.2001) | Anne Arundel County    |
| Anne Arundel County Landfill                                | TRUE        | POINT (-76.6022 39.1872) | Anne Arundel County    |
| CSX Chesapeake Avenue Lot                                   | TRUE        | POINT (-76.5981 39.2404) | Baltimore city         |
| 11731 Somerset Avenue                                       | TRUE        | POINT (-75.6929 38.2034) | Somerset County        |
| Lexington Park Site                                         | FALSE       | POINT (-76.4524 38.2652) | St. Mary’s County      |
| Salisbury City Yard/North Prong                             | FALSE       | POINT (-75.6031 38.3714) | Wicomico County        |
| 407 Anne Street                                             | FALSE       | POINT (-75.5915 38.3711) | Wicomico County        |
| 1440 Key Highway                                            | FALSE       | POINT (-76.6003 39.2725) | Baltimore city         |
| Chesapeake Publishing Company Elkton                        | FALSE       | POINT (-75.8383 39.6151) | Cecil County           |
| Easton Gas & Light Co.                                      | TRUE        | POINT (-76.078 38.7739)  | Talbot County          |
| National Park Seminary (North of Linden Lane)               | FALSE       | POINT (-77.0547 39.0113) | Montgomery County      |
| Warner Street Properties Brownfields                        | FALSE       | POINT (-76.6273 39.2729) | Baltimore city         |
| MP Moller, Inc. (Blue Mountain Woodworks)                   | TRUE        | POINT (-77.7209 39.6496) | Washington County      |
| Litton Industries                                           | FALSE       | POINT (-76.9276 38.9783) | Prince George’s County |
| Carey Machinery and Supply                                  | FALSE       | POINT (-76.5688 39.3203) | Baltimore city         |
| Oldham Crossing                                             | TRUE        | POINT (-76.5573 39.2904) | Baltimore city         |
| Baltimore American Ice Co.                                  | FALSE       | POINT (-76.6515 39.294)  | Baltimore city         |
| Property 3                                                  | FALSE       | POINT (-77.4099 39.4126) | Frederick County       |
| Bear Creek Sediments                                        | FALSE       | POINT (-76.4926 39.2427) | Baltimore County       |

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
