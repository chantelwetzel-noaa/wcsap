# Calculate recreational importance

Summarize and format recreational catch data to be used along with
recreational importance scores to calculate the 'pseudo revenue' by
species for the recreational fishery. The function currently uses an
existing csv file with previously calculated recreational importance to
access existing relative weights for each species and state. In the
future this should be modified in the future to use a stand-alone file
containing the recreational species weights by state that should be
saved in the "data" folder.

## Usage

``` r
summarize_rec_importance(
  rec_catch,
  species,
  rec_importance,
  assess_year,
  last_assess_year = 2025
)
```

## Arguments

- rec_catch:

  R data object created by filter_gemm function with only recreational
  catches by state.

- species:

  R data object that contains a list of species names to calculate
  assessment prioritization. The csv file with the list of species names
  should be stored in the data-raw folder ("species_names.csv")

- rec_importance:

  R data object with the species importance scoring by state. A CSV file
  with the state-specific species importance scores

- assess_year:

  R data object with the assessment year by species from the
  data-processed/assess_year_ssc_rec.csv.

- last_assess_year:

  Numeric value for the most recent assessment year.

## Author

Chantel Wetzel

## Examples

``` r
if (FALSE) { # \dontrun{
summarize_rec_importance(
    file_name <- "CTE002-2016---2020.csv",
    years <- 2016:2020,
    species_file <-  "species_names.csv"
)
} # }

```
