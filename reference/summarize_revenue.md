# Calculate importance by revenue

Summarize and format commercial revenue data for insert into the
assessment prioritizaiton. Data are pulled from PacFIN filtering for
only "P" Council records and removing all tribal and research landing
revenue estimates. The data file includes the following columns from
PacFIN: AGENCY_CODE, COUNCIL_CODE, PACFIN_SPECIES_CODE,
PACFIN_SPECIES_COMMON_NAME, NOMINAL_TO_ACTUAL_PACFIN_SPECIES_CODE,
PACFIN_YEAR, FLEET_CODE, ROUND_WEIGHT_MTONS, AFI_EXVESSEL_REVENUE. The
AFI_EXVESSEL_REVENUE column adjusts for inflation and the
NOMINAL_TO_ACTUAL_PACFIN_SPECIES_CODE includes both nominal and species
specific records. Exvessel revenue is averaged over select years by
species and dollar values are output in the 1,000s.

## Usage

``` r
summarize_revenue(
  revenue,
  species,
  tribal_score = NULL,
  assess_year,
  last_assess_year = 2025
)
```

## Arguments

- revenue:

  R data object filtered by
  [`filter_revenue()`](https://chantelwetzel-noaa.github.io/wcsap/reference/filter_revenue.md)
  that contains ex-vessel revenue from PacFIN. A csv file should be
  saved in data-raw that is from PacFIN containing catch information by
  species (data-raw/pacfin_revenue.csv).

- species:

  R data object that contains a list of species names to calculate
  assessment prioritization. The csv file with the list of species names
  should be stored in the data-raw folder ("species_names.csv")

- tribal_score:

  R data object with tribal species importance by species if calculating
  revenue for the tribal fishery. The CSV should be saved in data-raw.
  The default is NULL which will calculate the revenue for the
  commercial fishery.

- assess_year:

  R data object with the assessment year by species from the
  data-raw/assess_year_ssc_rec.csv.

- last_assess_year:

  Numeric value for the most recent assessment year.

## Author

Chantel Wetzel
