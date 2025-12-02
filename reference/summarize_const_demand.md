# Calculations used for the "Const Demand" tab for assessment prioritization.

The values used in the constituent demand tab are primarily scored
qualitatively. This function will provide the state, gear, and sector
(commercial vs. recreational) differences across the states and
coastwide which then can be qualitatively used to input modifiers.

## Usage

``` r
summarize_const_demand(
  revenue_data,
  rec_importance_data,
  fishing_mortality,
  future_spex,
  species = species
)
```

## Arguments

- revenue_data:

  R data object for revenue data that has been filtered by year using
  [`filter_years()`](https://chantelwetzel-noaa.github.io/wcsap/reference/filter_years.md)
  from PacFIN that includes both commercial and tribal revenue
  (data-raw/pacfin_revenue.csv).

- rec_importance_data:

  R data object created by
  [`summarize_rec_importance()`](https://chantelwetzel-noaa.github.io/wcsap/reference/summarize_rec_importance.md)
  for tribal catch data.

- fishing_mortality:

  R data object created by
  [`summarize_fishing_mortality()`](https://chantelwetzel-noaa.github.io/wcsap/reference/summarize_fishing_mortality.md).

- future_spex:

  R data objected created from the csv file downloaded from PacFIN APEX
  report table 8 that provides potential harvest specifications for the
  upcoming harvest specification cycle. The csv file should be saved in
  the data-raw folder. Example: data-raw/GMT008-harvest
  specifications_alt2-2025.csv

- species:

  R data object that contains a list of species names to calculate
  assessment prioritization. The csv file with the list of species names
  should be stored in the data-raw folder ("species_names.csv")

## Author

Chantel Wetzel
