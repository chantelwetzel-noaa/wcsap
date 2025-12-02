# Comparison between recent average mortality, OFLs, and ACLs.

The official recent average mortality should come from the GEMM rather
than PacFIN. The harvest_spex has all management quantities by species
across years but there are issues may need to be fixed by hand:

1.  Many rockfish species were missing "Rockfish" in their names and I
    had to correct them by hand due to grep issues when only the first
    name were used (e.g., China changed to China Rockfish).

2.  The file may contain area-specific OFLs or ACLs for longspine
    thornyhead, and shortspine thornyhead and the non-coastwide rows
    need to be deleted.

## Usage

``` r
summarize_fishing_mortality(
  gemm_mortality,
  harvest_spex,
  species = species,
  manage_quants = c("OVERFISHING_LIMIT", "ANNUAL_CATCH_LIMIT")
)
```

## Arguments

- gemm_mortality:

  Groundfish expanded multiyear mortality by species. R object created
  by
  [`nwfscSurvey::pull_gemm()`](https://rdrr.io/pkg/nwfscSurvey/man/pull_gemm.html).

- harvest_spex:

  R data objected filetered by year using
  [`filter_years()`](https://chantelwetzel-noaa.github.io/wcsap/reference/filter_years.md)
  containing historical groundfish harvest specifications OFLs, ABCs,
  and ACLs across years for West Coast groundfish. The data should be
  downloaded from PacFIN APEX report table 15 (or provided by Jason
  Edwards at PacStates) and should be stored in the data-raw folder
  (example: data-raw/GMT015-final specifications-2015 - 2023.csv)

- species:

  R data object that contains a list of species names to calculate
  assessment prioritization. The csv file with the list of species names
  should be stored in the data-raw folder ("species_names.csv")

- manage_quants:

  The names of the management quantities in the harvest_spex data object
  that defines the OFL and ACL. This vector is used to grep those
  columns. This allows to easily shift between the ABC and the ACL if
  needed.

## Details

2023 Notes of GMT 015 correction

1.  blue rockfish in Oregon - hand deleted the blue/deacon/black complex
    rows

2.  cowcod - hand deleted the south of 4010 rows and add in the ACLs by
    area

3.  lingcod - hand deleted WA-OR and 42-4010 rows

4.  starry and kelp - add rockfish to each

2023 future spex fixes

1.  delete s4010 cowcod

## Author

Chantel Wetzel
