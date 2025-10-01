#' Function to compare future ACLs to existing fishing mortality averages.
#'
#' This function uses output from the summarize_fishing_mortality and the summarize_frequency
#' functions and hence should be only run after these two functions. The manage_file
#' is downloaded from PacFIN APEX future harvest specifications
#' table (GMT008). The draft harvest specification ACLs should correspond to
#' the current year plus two (e.g., 2022 + 2 = 2024 ACLs). The fishing_mort_file
#' is the csv file created by the summarize_fishing_mortality function where
#' the average fishing mortality across recent years is used to compare future
#' ACLs against. The freq_file is a csv file created by the summarize_frequency function where
#' the year of the last assessment will be found to be appending in this output file.
#'
#'
#' @param future_spex A csv file with OFLs and ACLs from the draft harvest
#'   specifications table in PacFIN APEX reporting online.
#' @param fishing_mort A csv file created by the summarize_fishing_mortality function.
#' @param frequency Suggested assessment frequency based upon biology. A csv file from
#'   the previous assessment prioritization assessment
#'   frequency tab. The csv file to be read is found in the data folder:
#'   data-raw/species_sigmaR_catage_main.csv
#' @param species CSV file in the data folder called "species_names.csv" that includes
#'   all the species to include in this analysis.
#'
#' @author Chantel Wetzel
#' @export
#'
#'
summarize_future_spex <- function(
  future_spex,
  fishing_mort,
  frequency,
  species
) {
  targets <- future_spex
  fmort_data <- fishing_mort
  freq_data <- frequency

  fmort_data <- with(fmort_data, fmort_data[order(fmort_data[, "Species"]), ])
  freq_data <- with(freq_data, freq_data[order(freq_data[, "Species"]), ])

  mort_df <- data.frame(
    Species = species[, 1],
    Rank = NA,
    Factor_Score = NA,
    Modifier = NA,
    Average_Removals = NA,
    OFL = NA,
    ACL = NA,
    ACL_Attain_Percent = NA,
    Last_Assessed = freq_data[, "Last_Assess"]
  )

  for (sp in 1:nrow(species)) {
    key <- ss <- NULL
    name_list <- species[sp, species[sp, ] != -99]
    for (a in 1:length(name_list)) {
      key = c(key, grep(species[sp, a], fmort_data$Species, ignore.case = TRUE))

      ss <- c(
        ss,
        grep(species[sp, a], targets$STOCK_OR_COMPLEX, ignore.case = TRUE)
      )
    }

    # deal with multiple captures from complex species
    ss <- unique(ss)
    mort_df[sp, "OFL"] <- sum(targets[ss, "OFL"], na.rm = TRUE)
    mort_df[sp, "ACL"] <- sum(targets[ss, "ACL"], na.rm = TRUE)

    mort_df[sp, "Average_Removals"] <- fmort_data[key[1], "Average_Removals"]
  }

  mod_mort_df <- mort_df |>
    dplyr::mutate(
      ACL_Attain_Percent = Average_Removals / ACL,
      Factor_Score = dplyr::case_when(
        ACL_Attain_Percent <= 0.10 ~ 1,
        ACL_Attain_Percent > 0.10 & ACL_Attain_Percent <= 0.25 ~ 2,
        ACL_Attain_Percent > 0.25 & ACL_Attain_Percent <= 0.50 ~ 3,
        ACL_Attain_Percent > 0.50 & ACL_Attain_Percent[sp] <= 0.75 ~ 5,
        ACL_Attain_Percent > 0.75 & ACL_Attain_Percent[sp] <= 0.90 ~ 7,
        ACL_Attain_Percent > 0.90 & ACL_Attain_Percent[sp] <= 1.00 ~ 8,
        ACL_Attain_Percent > 1.00 & ACL_Attain_Percent[sp] <= 1.10 ~ 9,
        ACL_Attain_Percent > 1.10 ~ 10
      ),
      Modifier = dplyr::case_when(
        Factor_Score == 10 ~ 4,
        Factor_Score == 9 ~ 3,
        Factor_Score == 8 ~ 2,
        Factor_Score == 7 ~ 1,
        Factor_Score == 5 ~ 0,
        Factor_Score %in% c(4, 3, 2) ~ -1,
        .default = -2
      ),
      Rank = rank(Factor_Score, ties.method = "min")
    ) |>
    dplyr::arrange(Species, .locale = "en")

  formatted_mort_df <- format_all(x = mod_mort_df)
  readr::write_csv(
    formatted_mort_df,
    here::here("data-processed", "future_spex.csv")
  )
  return(formatted_mort_df)
}
