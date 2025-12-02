# Do all final formatting

Do all final formatting

## Usage

``` r
format_all(
  x,
  man_groups = readr::read_csv(here::here("data-raw", "species_management_groups.csv"))
)
```

## Arguments

- x:

  A factor data frame that contains species names to be renamed.

- man_groups:

  A data frame that contains the management group for each species

## Value

The factor data frame with the species renamed

## Author

Chantel Wetzel
