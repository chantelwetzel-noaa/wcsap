#' Comparison between recent average mortality, OFLs, and ACLs.
#'
#' The official recent average mortality should
#' come from the GEMM rather than PacFIN.
#' The harvest_spex has all management quantities by species across years but
#' there are issues may need to be fixed by hand:
#' 1) Many rockfish species were missing "Rockfish" in their names and
#' I had to correct them by hand due to grep issues when only the first
#' name were used (e.g., China changed to China Rockfish).
#' 2) The file may contain area-specific OFLs or ACLs for longspine
#' thornyhead, and shortspine thornyhead and the non-coastwide rows need to be
#' deleted.
#'
#' 2023 Notes of GMT 015 correction
#' 1) blue rockfish in Oregon - hand deleted the blue/deacon/black complex rows
#' 2) cowcod - hand deleted the south of 4010 rows and add in the ACLs by area
#' 3) lingcod - hand deleted WA-OR and 42-4010 rows
#' 4) starry and kelp - add rockfish to each
#'
#' 2023 future spex fixes
#' 1) delete s4010 cowcod
#'
#' @param gemm_mortality Groundfish expanded multiyear mortality by species.
#'   R object created by [nwfscSurvey::pull_gemm()].
#' @param harvest_spex R data objected filetered by year using [filter_years()]
#'    containing historical groundfish harvest specifications OFLs, ABCs, and ACLs across
#'   years for West Coast groundfish. The data should be downloaded from PacFIN
#'   APEX report table 15 (or provided by Jason Edwards at PacStates) and should
#'   be stored in the data-raw folder (example: data-raw/GMT015-final specifications-2015 - 2023.csv)
#' @param species R data object that contains a list of species names to calculate
#'   assessment prioritization.  The csv file with the list of species names should be
#'   stored in the data-raw folder ("species_names.csv")
#' @param manage_quants The names of the management quantities in the harvest_spex data
#'   object that defines the OFL and ACL. This vector is used to grep those columns.
#'   This allows to easily shift between the ABC and the ACL if needed.
#'
#' @author Chantel Wetzel
#' @export
#'
summarize_fishing_mortality <- function(
  gemm_mortality,
  harvest_spex,
  species = species,
  manage_quants = c("OVERFISHING_LIMIT", "ANNUAL_CATCH_LIMIT")
) {
  data <- gemm_mortality
  spex <- harvest_spex

  mort_df <- data.frame(
    Species = species[, 1],
    Rank = NA,
    Factor_Score = NA,
    Average_Catches = NA,
    Average_OFL = NA,
    Average_OFL_Attainment = NA,
    Average_ACL = NA,
    Average_ACL_Attainment = NA
  )

  for (sp in 1:nrow(species)) {
    key <- ss <- ff <- NULL
    name_list <- species[sp, species[sp, ] != -99]

    for (a in 1:length(name_list)) {
      key <- c(key, grep(species[sp, a], data$species, ignore.case = TRUE))
      ss <- c(
        ss,
        grep(species[sp, a], spex$STOCK_OR_COMPLEX, ignore.case = TRUE)
      )
    }
    if (length(ss) == 0) {
      for (a in 1:length(name_list)) {
        init_string <- tm::removeWords(species[sp, a], " rockfish")
        ss <- c(
          ss,
          grep(init_string, spex$STOCK_OR_COMPLEX, ignore.case = TRUE)
        )
      }
    }

    ss <- unique(ss)
    key <- unique(key)

    sub_data <- data[key, ]
    mort_df[sp, "Average_Catches"] <- sum(
      sub_data$total_discard_with_mort_rates_applied_and_landings_mt
    ) /
      length(unique(data$year))

    if (length(ss) > 0) {
      temp_spex <- spex[ss, ]
      ind <- which(colnames(temp_spex) %in% c("SPEX_YEAR", manage_quants))
      temp_spex <- temp_spex[, ind]

      # Need to use sum rather than mean due to OFLs and ACLs under different names (e.g. Gopher and Black and Yellow)
      value <- apply(temp_spex[, 2:3], 2, sum, na.rm = TRUE)
      mort_df$Average_OFL[sp] <- value[manage_quants[1]] /
        length(unique(temp_spex$SPEX_YEAR))
      mort_df$Average_ACL[sp] <- value[manage_quants[2]] /
        length(unique(temp_spex$SPEX_YEAR))
    }
  }

  mort_df <- mort_df |>
    dplyr::mutate(
      Average_OFL_Attainment = round(Average_Catches / Average_OFL, 2),
      Average_ACL_Attainment = round(Average_Catches / Average_ACL, 2),
      Average_Catches = round(Average_Catches, 1),
      Average_OFL = round(Average_OFL, 1),
      Average_ACL = round(Average_ACL, 1),
      Factor_Score = dplyr::case_when(
        Average_OFL_Attainment <= 0.10 ~ 1,
        Average_OFL_Attainment > 0.10 & Average_OFL_Attainment <= 0.25 ~ 2,
        Average_OFL_Attainment > 0.25 & Average_OFL_Attainment <= 0.50 ~ 3,
        Average_OFL_Attainment > 0.50 & Average_OFL_Attainment <= 0.75 ~ 5,
        Average_OFL_Attainment > 0.75 & Average_OFL_Attainment <= 0.90 ~ 7,
        Average_OFL_Attainment > 0.90 & Average_OFL_Attainment <= 1.0 ~ 8,
        Average_OFL_Attainment > 1.00 & Average_OFL_Attainment <= 1.10 ~ 9,
        Average_OFL_Attainment > 1.10 ~ 10
      ),
      Rank = rank(-Factor_Score, ties.method = "min")
    )

  formatted_mort_df <- format_all(x = mort_df)
  fish_mort <- data.frame(
    Species = formatted_mort_df$Species,
    Factor_Score = formatted_mort_df$Factor_Score,
    Average_Catches = formatted_mort_df$Average_Catches
  )
  readr::write_csv(
    formatted_mort_df,
    here::here("data-processed", "1_fishing_mortality.csv")
  )
  return(fish_mort)
}
