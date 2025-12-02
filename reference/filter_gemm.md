# Filter the GEMM data for select sectors

Filter the GEMM data for select sectors

## Usage

``` r
filter_gemm(
  data,
  sector = c("California Recreational", "Oregon Recreational", "Washington Recreational")
)
```

## Arguments

- data:

  Dataframe created by nwfscSurvey::pull_gemm

- sector:

  List of sectors to retain

## Author

Chantel Wetzel
