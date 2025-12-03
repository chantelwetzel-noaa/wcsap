#' Calculate score based upon rebuilding
#'
#' @param species R data object that contains a list of species names to calculate
#'   assessment prioritization.  The csv file with the list of species names should be
#'   stored in the data-raw folder ("species_names.csv")
#' @param overfished_data R data object of overfished species from data-raw/overfished_species.csv
#' @param stock_status R data object by the [summarize_stock_status()]
#' @param assessment_year The year for which species to be assessed are being selected based
#'   upon the prioritization process
#'
#' @author Chantel Wetzel
#' @export
#'
#'
summarize_rebuilding <- function(
  species,
  overfished_data,
  stock_status,
  assessment_year = 2027
) {
  overfished_df <- data.frame(
    Species = species[, 1],
    Rank = NA,
    Factor_Score = 0,
    Rebuilding_Target_Year = NA
  ) |>
    dplyr::rename(Species = speciesName)

  if (nrow(overfished_data) > 1 & overfished_data[, "Species"] != "none") {
    for (a in 1:nrow(overfished_data)) {
      find <- grep(
        overfished_data[a, "Species"],
        overfished_df[, "Species", ],
        ignore.case = TRUE
      )
      target <- overfished_data[a, "Ttarget"]
      score_based_on_time <- dplyr::case_when(
        target - assessment_year > 20 ~ 4,
        target - assessment_year <= 20 & target - assessment_year > 4 ~ 6,
        .default = 9
      )

      score <- dplyr::case_when(
        stock_status[find, "Trend"] == -1 ~ 10,
        .default = score_based_on_time
      )
      overfished_df[find, "Factor_Score"] <- score
      overfished_df[find, "Rebuilding_Target_Year"] <- target
    }
  }

  overfished_df <- overfished_df |>
    dplyr::mutate(
      Rank = rank(-Factor_Score, ties.method = "min")
    )
  overfished_df <- replace(overfished_df, overfished_df == "", NA)
  formatted_overfished <- format_all(x = overfished_df)
  readr::write_csv(
    formatted_overfished,
    here::here("data-processed", "10_rebuilding.csv")
  )
  return(overfished_df)
}
