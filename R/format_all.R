#' Do all final formatting
#'
#'
#' @param x A factor data frame that contains species names to be renamed.
#' @param man_groups A data frame that contains the management group for
#'   each species
#' @returns The factor data frame with the species renamed
#' @author Chantel Wetzel
#' @export
#'
format_all <- function(
  x,
  man_groups = readr::read_csv(here::here(
    "data-raw",
    "species_management_groups.csv"
  ))
) {
  x_formatted <- format_species_names(x = x) |>
    dplyr::arrange(Species) |>
    format_table(man_groups = man_groups) |>
    dplyr::arrange(Rank)

  return(x_formatted)
}
