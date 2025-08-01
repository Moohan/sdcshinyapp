# ------------------------------------------------------------------------------
# Script Name : 2_data_input.R
# Purpose     : Set up UI for the Main Tab used for uploading/processing input data
# Last Update : 01 Aug 2025
# Author      : Robert Mitchell
# Posit Version: 4.4.2
# ------------------------------------------------------------------------------

# Input Data Main Tab
shiny::tabPanel(
  "1. Input Data",
  shiny::navlistPanel(
    id = "tabset",
    widths = sb_width,

    # 1. Dummy Data Input Choice
    source("2_UI_Scripts/2-01_dummy_data_choice.R", local = TRUE)$value,

    # 2. File Upload
    source("2_UI_Scripts/2-02_file_upload.R", local = TRUE)$value,

    # 3. Data Processing
    source("2_UI_Scripts/2-03_var_convert.R", local = TRUE)$value,

    # 4. Post-Processing Summary
    source("2_UI_Scripts/2-04_post_proc_summary.R", local = TRUE)$value
  )
)

# END OF SCRIPT ----
