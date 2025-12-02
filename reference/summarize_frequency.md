# Function to create the full assessment frequency tab.

Function to create the full assessment frequency tab.

## Usage

``` r
summarize_frequency(
  abundance,
  ecosystem,
  commercial,
  tribal,
  recreational,
  assessment_year = 2027
)
```

## Arguments

- abundance:

  R object of suggested assessment frequency based upon biology. A csv
  file from the previous assessment prioritization assessment frequency
  tab. The csv file to be read is found in the data folder:
  data-processessed/previous_cycle/abundance_processed.csv

- ecosystem:

  R data object created by
  [`summarize_ecosystem()`](https://chantelwetzel-noaa.github.io/wcsap/reference/summarize_ecosystem.md)
  for tribal catch data.

- commercial:

  R data object created by
  [`summarize_revenue()`](https://chantelwetzel-noaa.github.io/wcsap/reference/summarize_revenue.md)
  for commercial catch data.

- tribal:

  R data object created by
  [`summarize_revenue()`](https://chantelwetzel-noaa.github.io/wcsap/reference/summarize_revenue.md)
  for tribal catch data.

- recreational:

  R data object created by
  [`summarize_rec_importance()`](https://chantelwetzel-noaa.github.io/wcsap/reference/summarize_rec_importance.md)
  for tribal catch data.

- assessment_year:

  A numerical value of the current year the assessment prioritization is
  being conducted. This value is compared to the last year assessed
  values to provide species rotation in the ranking based on time since
  the last assessment.

## Author

Chantel Wetzel
