# Function to compare future ACLs to existing fishing mortality averages.

This function uses output from the summarize_fishing_mortality and the
summarize_frequency functions and hence should be only run after these
two functions. The manage_file is downloaded from PacFIN APEX future
harvest specifications table (GMT008). The draft harvest specification
ACLs should correspond to the current year plus two (e.g., 2022 + 2 =
2024 ACLs). The fishing_mort_file is the csv file created by the
summarize_fishing_mortality function where the average fishing mortality
across recent years is used to compare future ACLs against. The
freq_file is a csv file created by the summarize_frequency function
where the year of the last assessment will be found to be appending in
this output file.

## Usage

``` r
summarize_future_spex(future_spex, fishing_mort, frequency, species)
```

## Arguments

- future_spex:

  A csv file with OFLs and ACLs from the draft harvest specifications
  table in PacFIN APEX reporting online.

- fishing_mort:

  A csv file created by the summarize_fishing_mortality function.

- frequency:

  Suggested assessment frequency based upon biology. A csv file from the
  previous assessment prioritization assessment frequency tab. The csv
  file to be read is found in the data folder:
  data-raw/species_sigmaR_catage_main.csv

- species:

  CSV file in the data folder called "species_names.csv" that includes
  all the species to include in this analysis.

## Author

Chantel Wetzel
