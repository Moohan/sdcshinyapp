# ------------------------------------------------------------------------------
# Script Name : phs_branding.R
# Purpose     : Set up PHS Branding for Shiny App
# Last Update : 22 Aug 2025
# Author      : Robert Mitchell
# Posit Version: 4.1.2
# ------------------------------------------------------------------------------

# Folder containing PHS branding assets
fp_script <- glue::glue("www/")

# Sidebar width configuration
sb_width <- c(2, 10)

# Base64-encoded PHS logo for embedding
b64 <- base64enc::dataURI(file = glue::glue("{fp_script}phs_logo.png"))

# END OF SCRIPT ----
