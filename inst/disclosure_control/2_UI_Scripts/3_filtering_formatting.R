# ------------------------------------------------------------------------------
# Script Name : 3_filtering_formatting.R
# Purpose     : UI for Filtering/Formatting Tab
# Last Update : 22 Aug 2025
# Author      : Robert Mitchell
# Posit Version: 4.4.2
# ------------------------------------------------------------------------------

# Create 2. Input Data Filtering/Formatting Tab ----
shiny::tabPanel(
  "2. Input Data Filtering/Formatting",
  shiny::navlistPanel(
    id = "tabset",
    widths = sb_width,

    # Filtering Section
    source("2_UI_Scripts/3-01_filtering.R", local = TRUE)$value,

    # Data Format Transform Section
    source("2_UI_Scripts/3-02_formatting.R", local = TRUE)$value
  )
)

# END OF SCRIPT ----
