# -------------------------------------------------------------------------
# Script Name : App.R
# Purpose     : Launch the Statistical Disclosure Control (SDC) App
# Last Update : 01 Aug 2025
# Author      : Robert Mitchell
# R Version   : 4.4.2
# -------------------------------------------------------------------------

# 1. Set up PHS Branding ----

# Define 'not in' operator
`%notin%` <- Negate(`%in%`)

# Enable shiny alerts
shinyalert::useShinyalert(force = TRUE)

# Load PHS branding theme
source("1_Global_Scripts/phs_branding.R")

# 2. Define UI ----

ui <- source("2_UI_Scripts/ui.R", local = TRUE)$value

# 3. Define Server Logic ----

server <- source("3_Server_Scripts/server.R", local = TRUE)$value

# 4. Run the App ----

shiny::shinyApp(ui, server)

# END OF SCRIPT ----
