# Calculate score based upon new information and research

Calculate score based upon new information and research

## Usage

``` r
summarize_new_information(species, survey_data, assess_year, new_research)
```

## Arguments

- species:

  CSV file in the data folder called "species_names.csv" that includes
  all the species to include in this analysis.

- survey_data:

  Data frame of WCGBTS bds data from
  data-processed/all_nwfsc_survey_new_information.csv

- assess_year:

  R data object with the assessment year by species from the
  data-processed/assess_year_ssc_rec.csv

- new_research:

  R data object that contains new research to be considered scoring. New
  research by species contained in data-raw/new_research.csv.

## Author

Chantel Wetzel
