# ------------------------------------------------------------------------------
# Script Name : 4_disclosure_methods.R
# Purpose     : UI for Disclosure Methods Tab
# Last Update : 22 Aug 2025
# Author      : Robert Mitchell
# Posit Version: 4.4.2
# ------------------------------------------------------------------------------

# Create 3. SDC Methods Tab ----
shiny::tabPanel(
  title = "3. SDC Methods",
  shiny::navlistPanel(
    id = "methods",
    widths = sb_width,

    # Rounding
    source("2_UI_Scripts/4-01_rounding.R", local = TRUE)$value,

    # Swapping
    source("2_UI_Scripts/4-02_swapping.R", local = TRUE)$value,

    # Suppression
    source("2_UI_Scripts/4-03_suppression.R", local = TRUE)$value
  )
)

# END OF SCRIPT ----
