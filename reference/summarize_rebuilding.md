# Calculate score based upon rebuilding

Calculate score based upon rebuilding

## Usage

``` r
summarize_rebuilding(
  species,
  overfished_data,
  stock_status,
  assessment_year = 2027
)
```

## Arguments

- species:

  R data object that contains a list of species names to calculate
  assessment prioritization. The csv file with the list of species names
  should be stored in the data-raw folder ("species_names.csv")

- overfished_data:

  R data object of overfished species from
  data-raw/overfished_species.csv

- stock_status:

  R data object by the
  [`summarize_stock_status()`](https://chantelwetzel-noaa.github.io/wcsap/reference/summarize_stock_status.md)

- assessment_year:

  The year for which species to be assessed are being selected based
  upon the prioritization process

## Author

Chantel Wetzel
