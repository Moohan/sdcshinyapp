# ------------------------------------------------------------------------------
# Script Name : 2-04_post_proc_summary.R
# Purpose     : Summarise data after processing
# Last Update : 22 Aug 2025
# Author      : Robert Mitchell
# Posit Version: 4.4.2
# ------------------------------------------------------------------------------

# 1. Generate Summary Tables ----

# Data Summary
output$process_summary_dist <- shiny::renderPrint({
  shiny::validate(shiny::need(!is.null(App_data$values), ""))
  summary(App_data$values)
})

# Missingness Summary
output$process_missing <- shiny::renderPrint({
  shiny::validate(shiny::need(!is.null(App_data$values), ""))
  (colSums(is.na(App_data$values)) / nrow(App_data$values)) * 100
})

# END OF SCRIPT ----
