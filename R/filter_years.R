#' Filter data by year
#'
#' @param data Dataframe
#' @param years Vector of years to retain
#'
#' @author Chantel Wetzel
#' @export
#'
filter_years <- function(data, years) {
  year_column <- c("YEAR", "PACFIN_YEAR", "RECFIN_YEAR", "SPEX_YEAR")[
    c("YEAR", "PACFIN_YEAR", "RECFIN_YEAR", "SPEX_YEAR") %in% colnames(data)
  ]
  data[, "year"] <- data[, year_column]
  data_filtered <- data |>
    dplyr::filter(year %in% years)
  return(data_filtered)
}
