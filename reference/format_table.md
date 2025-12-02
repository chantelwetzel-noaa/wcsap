# Combine management group to tables based on species names

Function to join the given table with the table that has the species
management groups. Replaces underscores in column names with spaces.

## Usage

``` r
format_table(x, man_groups)
```

## Arguments

- x:

  A factor dataframe

- man_groups:

  A dataframe containing the species management groups

## Value

Joined dataframe with edited column names

## Author

Chantel Wetzel
