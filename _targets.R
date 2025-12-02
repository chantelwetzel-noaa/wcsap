library(targets)

# Create targets for all objects
# targets::tar_make(script = "_targets.R")
# Load existing targets
# targets::tar_load_everything()

# View network plots
# targets::tar_visnetwork(targets_only = TRUE)
# targets::tar_glimpse()

# Use the following commands to remove one or all files when getting errors
# targets::tar_delete("rank")
# targets::tar_destroy("all)

# Set target-specific options such as packages:
targets::tar_option_set(
  packages = c(
    "dplyr",
    "nwfscSurvey",
    "r4ss",
    "readr" #,
    #"westcoastdata"
  )
)

# Load in Rdata object for the WCGBT bio data
load("data-raw/bio_pull_all_NWFSC.Combo_2025-09-12.rdata")

# Source all functions in the R folder
targets::tar_source()
source(
  "C:/Users/chantel.wetzel/Documents/github/prioritization/data_summary/R/get_species_list.R"
)
source(
  "C:/Users/chantel.wetzel/Documents/github/prioritization/data_summary/R/clean_nwfsc_hkl.R"
)
source(
  "C:/Users/chantel.wetzel/Documents/github/prioritization/data_summary/R/clean_wcgbt_bio.R"
)
source(
  "C:/Users/chantel.wetzel/Documents/github/prioritization/data_summary/R/summarize_new_survey_information.R"
)

# End this file with a list of target objects.
list(
  list(
    # List of species
    targets::tar_target(
      species,
      readr::read_csv("data-raw/species_names.csv")
    ),
    # List of species to pull survey data for:
    targets::tar_target(
      survey_species,
      get_species_list()
    ),
    # File to record the assessment year and the SSC recommendations.  This file should be updated
    # by hand each cycle:
    targets::tar_target(
      last_assess_year_df,
      readr::read_csv("data-raw/assess_year_ssc_rec.csv")
    ),
    # prev_cycle used to reach into the archived folder for last cycle output
    targets::tar_target(
      prev_cycle,
      2024
    ),
    # Year option:
    # These years will be used to filter data to calculate recent averages for
    # GEMM data and fisheries revenue.
    targets::tar_target(
      recent_5_years,
      2020:2024
    ),
    # Range of years to calculate the average age of catch based upon recent
    # assessments:
    targets::tar_target(
      catage_years,
      2000:2024
    ),
    # Next assessment year:
    targets::tar_target(
      assessment_year,
      2027
    ),
    # Recent harvest specifications:
    # downloaded from: https://reports.psmfc.org/pacfin/f?p=501:5301:2460998972960:::::
    targets::tar_target(
      harvest_spex_data,
      readr::read_csv(
        "data-raw/GMT015-final_specifications-2020-2024.csv"
      )
    ),
    # Recent GEMM data:
    targets::tar_target(
      gemm_mortality_data,
      nwfscSurvey::pull_gemm(years = recent_5_years)
    ),
    # Future harvest specifications
    # downloaded from https://reports.psmfc.org/pacfin/f?p=501:530:2460998972960:INITIAL::::
    targets::tar_target(
      future_spex_data,
      readr::read_csv("data-raw/GMT008-harvest specifications-2027-28.csv")
    ),
    # Revenue information downloaded from PacFIN using QueryBuilder available online:
    targets::tar_target(
      revenue_data,
      readr::read_csv("data-raw/pacfin_commercial_revenue_11172025.csv")
    ),
    # Tribal importance which represents subsistence and cultural significance scoring:
    targets::tar_target(
      tribal_score_data,
      readr::read_csv("data-raw/tribal_score.csv")
    ),
    # Recreational importance by state:
    targets::tar_target(
      recreational_importance_scores,
      readr::read_csv("data-raw/recr_importance.csv")
    ),
    # Abundance and Assessment Frequency
    # This information is updated by summarize_stock_status() based on the most recent assessments
    targets::tar_target(
      abundance_prev_cycle,
      readr::read_csv("data-processed/2024/abundance_processed.csv")
    ),
    # Ecosystem top-down and bottom-up measures provided by Kristin Marshall:
    targets::tar_target(
      ecosystem_data,
      readr::read_csv("data-raw/ecosystem_data.csv")
    ),
    # Overfished Species: Data sheet that contains information about any overfished species
    targets::tar_target(
      overfished_data,
      readr::read_csv("data-raw/overfished_species.csv")
    ),
    # New research: spreadsheet that contains information about completed and in process research that
    # could be influential in a future assessment.
    # This spreadsheet needs to be updated by hand each cycle
    targets::tar_target(
      new_research,
      readr::read_csv("data-raw/new_research.csv")
    ),
    # Pull NWFSC WCGBTS data
    targets::tar_target(
      wcgbt_data,
      x,
    ),
    #targets::tar_target(
    #  wcgbt_data,
    #  westcoastdata::pull_wcgbts(
    #    dir = here::here("data-raw"),
    #    load = TRUE,
    #    species = survey_species
    #  )
    #),
    # NWFSC HKL Survey Data
    targets::tar_target(
      nwfsc_hkl_data,
      readr::read_csv("data-raw/nwfsc_hkl_DWarehouse_version_09032025.csv")
    )
  ),

  list(
    # Clean model files: only done once and then can be commented out
    #tar_target(
    #  clean_files,
    #  clean_model_files()
    #),
    # Apply year filters
    targets::tar_target(
      harvest_spex_filtered,
      filter_years(
        data = harvest_spex_data,
        years = recent_5_years
      )
    ),
    targets::tar_target(
      revenue_data_filtered,
      filter_years(
        data = revenue_data,
        years = recent_5_years
      )
    ),
    targets::tar_target(
      rec_catch_filtered,
      filter_gemm(
        data = gemm_mortality_data
      )
    ),
    # Commercial or Tribal Revenue Data Filter
    targets::tar_target(
      commercial_revenue_filtered,
      filter_revenue(
        data = revenue_data_filtered,
        type = "commercial"
      )
    ),
    targets::tar_target(
      tribal_revenue_filtered,
      filter_revenue(
        data = revenue_data_filtered,
        type = "tribal"
      )
    ),
    # Clean NWFSC WCGBT data
    tar_target(
      wcgbt_bio_cleaned,
      clean_wcgbt_bio(
        dir = here::here("data-raw"),
        species = survey_species,
        data = wcgbt_data
      )
    ),
    # Clean NWFSC HKL data
    tar_target(
      nwfsc_hkl_cleaned,
      clean_nwfsc_hkl(
        dir = here::here("data-raw"),
        species = survey_species,
        data = nwfsc_hkl_data
      )
    ),
    # 6 Stock Status
    targets::tar_target(
      stock_status,
      summarize_stock_status(
        abundance = abundance_prev_cycle,
        species = species,
        years = catage_years
      )
    )
  ),

  list(
    # Determine the new available survey data
    tar_target(
      new_survey_data,
      summarize_survey_new_information(
        dir = here::here("data-processed"),
        stock_year = last_assess_year_df,
        wcgbt = wcgbt_bio_cleaned,
        hkl = nwfsc_hkl_cleaned
      )
    ),
    # Update abundance based on the new assessments
    targets::tar_target(
      abundance_updated,
      readr::read_csv(here::here("data-processed", "abundance_processed.csv"))
    ),
    # 1 Fishing Mortality
    targets::tar_target(
      fishing_mortality,
      summarize_fishing_mortality(
        gemm_mortality = gemm_mortality_data,
        harvest_spex = harvest_spex_filtered,
        species = species
      )
    ),
    # 2 Commercial Revenue
    targets::tar_target(
      commercial,
      summarize_revenue(
        revenue = commercial_revenue_filtered,
        species = species,
        assess_year = last_assess_year_df
      )
    ),
    # 3 Tribal Importance
    targets::tar_target(
      tribal,
      summarize_revenue(
        revenue = tribal_revenue_filtered,
        species = species,
        tribal_score = tribal_score_data,
        assess_year = last_assess_year_df
      )
    )
  )
)
