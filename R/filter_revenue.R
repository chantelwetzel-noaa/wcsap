#' Filter out and identify tribal and non-tribal records
#'
#' @param data PacFIN CompFT data table
#' @param type Default NULL. To filter and mark tribal records type = "tribal"
#'
#' @author Chantel Wetzel
#' @export
#'
filter_revenue <- function(data, type = NULL) {
  if (type == "tribal") {
    data_filtered <- data |>
      dplyr::filter(FLEET_CODE == "TI")
  } else {
    data_filtered <- data |>
      dplyr::filter(FLEET_CODE != "TI")
  }
  return(data_filtered)
}
