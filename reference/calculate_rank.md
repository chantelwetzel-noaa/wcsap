# Calculate the assessment prioritization rank by species based upon all the factors.

Calculate the assessment prioritization rank by species based upon all
the factors.

## Usage

``` r
calculate_rank(
  fishing_mortality,
  commercial_importance,
  tribal_importance,
  recreational_importance,
  ecosystem,
  stock_status,
  assessment_frequency,
  constituent_demand,
  new_information,
  rebuilding
)
```

## Arguments

- fishing_mortality:

  Output from summarize_fishing_mortality function

- commercial_importance:

  Output from summarize_revenue for commercial fisheries

- tribal_importance:

  Output from summarize_revenue for tribal fisheries

- recreational_importance:

  Output from summarize_rec_importance function

- ecosystem:

  Output from summarize_ecosytem function

- stock_status:

  Output from summarize_stock_status function

- assessment_frequency:

  Output from summarize_frequency function

- constituent_demand:

  Output from summarize_const_demand function

- new_information:

  Output from summarize_new_information function

- rebuilding:

  Output from summarize_rebuilding function

## Author

Chantel Wetzel
