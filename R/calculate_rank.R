#' Calculate the assessment prioritization rank by species based upon all the factors.
#'
#' @param fishing_mortality Output from summarize_fishing_mortality function
#' @param commercial_importance Output from summarize_revenue for commercial fisheries
#' @param tribal_importance Output from summarize_revenue for tribal fisheries
#' @param recreational_importance Output from summarize_rec_importance function
#' @param ecosystem Output from summarize_ecosytem function
#' @param stock_status Output from summarize_stock_status function
#' @param assessment_frequency Output from summarize_frequency function
#' @param constituent_demand Output from summarize_const_demand function
#' @param new_information Output from summarize_new_information function
#' @param rebuilding Output from summarize_rebuilding function
#'
#' @author Chantel Wetzel
#' @export
#'
#'
calculate_rank <- function(
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
) {
  # 1 Fishing Mortality
  # 2 Commercial Importance
  # 3 Tribal Importance
  # 4 Recreational Importance
  # 5 Ecosystem
  # 6 Stock Status
  # 7 Assessment Frequency
  # 8 Constituent Demand
  # 9 New Information
  # 10 Rebuilding

  overall_rank <- data.frame(
    Species = fishing_mortality$Species,
    Total_Score = NA,
    fishing_mortality = fishing_mortality$Factor_Score,
    commercial_importance = commercial_importance$Factor_Score,
    tribal_importance = tribal_importance$Factor_Score,
    recreational_importance = recreational_importance$Factor_Score,
    ecosystem = ecosystem$Factor_Score,
    stock_status = stock_status$Factor_Score,
    assessment_frequency = assessment_frequency$Factor_Score,
    constituent_demand = constituent_demand$Factor_Score,
    new_information = new_information$Factor_Score,
    rebuilding = rebuilding$Factor_Score
  )

  overall_rank <- overall_rank |>
    dplyr::mutate(
      Total_Score = round(
        fishing_mortality *
          0.08 +
          commercial_importance * 0.21 +
          tribal_importance * 0.05 +
          recreational_importance * 0.09 +
          ecosystem * 0.05 +
          stock_status * 0.08 +
          assessment_frequency * 0.18 +
          constituent_demand * 0.11 +
          new_information * 0.05 +
          rebuilding * 0.10,
        2
      ),
      Rank = rank(-Total_Score, ties.method = "min")
    ) |>
    dplyr::arrange(dplyr::desc(Total_Score)) |>
    dplyr::relocate(Rank, .before = Total_Score) |>
    dplyr::arrange(Species, .locale = "en")

  utils::write.csv(
    overall_rank,
    "data-processed/11_overall_rank.csv",
    row.names = FALSE
  )
  return(overall_rank)
}
