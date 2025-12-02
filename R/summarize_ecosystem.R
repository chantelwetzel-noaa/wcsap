#' Calculate ecosystem rank based upon Atlantis/Ecosim output
#'
#'
#' @param ecosystem_data R data objected created from a csv file with ecosystem
#'    scores by species based on Atlantis/Ecosim (data-raw/ecosystem_data.csv)
#'
#' @author Chantel Wetzel
#' @export
#'
#'
summarize_ecosystem <- function(
  ecosystem_data
) {
  # Top Down is the consumption values and bottom up is the consumer values
  modified_ecosystem <- ecosystem_data |>
    dplyr::mutate(
      Factor_Score = round(
        10 *
          (prop_consumption_scaled + prop_consumer_bio_scaled) /
          max(prop_consumption_scaled + prop_consumer_bio_scaled),
        2
      ),
      Rank = rank(-Factor_Score, ties.method = "min"),
      prop_consumption_scaled = round(prop_consumption_scaled, 2),
      prop_consumer_bio_scaled = round(prop_consumer_bio_scaled, 2)
    ) |>
    dplyr::rename(
      Species = species,
      Top_Down_Scaled = prop_consumption_scaled,
      Bottom_Up_Scaled = prop_consumer_bio_scaled
    ) |>
    dplyr::select(
      -functional_groups,
      -prop_consumer_bio_raw,
      -prop_consumption_raw
    ) |>
    dplyr::arrange(Species, .locale = "en") |>
    dplyr::relocate(Rank, .after = Species) |>
    dplyr::relocate(Factor_Score, .after = Rank)

  formatted_ecosystem <- format_all(x = modified_ecosystem)
  readr::write_csv(
    formatted_ecosystem,
    here::here("data-processed", "5_ecosystem.csv")
  )
  return(formatted_ecosystem)
}
