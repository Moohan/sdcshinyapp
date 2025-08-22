# ------------------------------------------------------------------------------
# Script Name : 3-01_filtering.R
# Purpose     : Filter data in Shiny app
# Last Update : 22 Aug 2025
# Author      : Robert Mitchell
# Posit Version: 4.4.2
# ------------------------------------------------------------------------------

# 1. Data Storage ----
unprocessed <- shiny::reactiveValues(data = NULL)

shiny::observeEvent(input$Unprocess_Store, {
  shiny::validate(shiny::need(App_data$values, "There is no input data"))

  if (!"Serial" %in% colnames(App_data$values)) {
    shinyalert::shinyalert("No serial number provided.", "Please re-add serial number for storage.", type = "error")
    shiny::validate(shiny::need(App_data$values$Serial, "There is no Serial Number"))
  } else {
    shinyalert::shinyalert("Unprocessed data stored successfully.", "Filtering can now occur.", type = "success")
  }

  unprocessed$data <- App_data$values
})

# 2. Filtering Process ----
filter <- character(0)
shiny::makeReactiveBinding("aggregFilterObserver")
aggregFilterObserver <- list()

shiny::observeEvent(input$addFilter, {
  shiny::validate(shiny::need(App_data$values, "There is no input data"))

  if (is.null(unprocessed$data) || !"Serial" %in% colnames(App_data$values)) {
    shinyalert::shinyalert("Missing prerequisites", "Please re-add serial number and store unprocessed data.", type = "error")
    shiny::validate(
      shiny::need(App_data$values$Serial, "There is no Serial Number"),
      shiny::need(unprocessed$data, "There is no input data")
    )
  }

  add <- input$addFilter
  filterId <- paste0("Filter_", add)
  colfilterId <- paste0("Col_Filter_", add)
  rowfilterId <- paste0("Row_Filter_", add)
  clearFilterId <- paste0("Clear_Filter_", add)

  headers <- names(App_data$values)[-1]

  shiny::insertUI(
    selector = '#placeholderFilter',
    ui = shiny::tags$div(
      id = filterId,
      shiny::actionButton(clearFilterId, "Clear filter", style = "float: right;"),
      shiny::selectInput(colfilterId, "Choose Variable", choices = headers),
      shiny::selectInput(rowfilterId, "Select variable values to remove", choices = NULL, multiple = TRUE)
    )
  )

  shiny::observeEvent(input[[colfilterId]], {
    col <- input[[colfilterId]]
    values <- unique(App_data$values[[col]])
    shiny::updateSelectInput(session, rowfilterId, "Select variable values to remove", choices = values)
    aggregFilterObserver[[filterId]]$col <- col
    aggregFilterObserver[[filterId]]$rows <- NULL
  })

  shiny::observeEvent(input[[rowfilterId]], {
    aggregFilterObserver[[filterId]]$rows <- input[[rowfilterId]]
  })

  shiny::observeEvent(input[[clearFilterId]], {
    shiny::removeUI(selector = paste0('#', filterId))
    aggregFilterObserver[[filterId]] <- NULL
  })
})

# 3. Data Visualisation ----
output$filtered_data <- DT::renderDataTable({
  cb <- htmlwidgets::JS('function(){debugger;HTMLWidgets.staticRender();}')
  dataSet <- App_data$values

  invisible(lapply(aggregFilterObserver, function(filter) {
    dataSet <- dataSet[!(dataSet[[filter$col]] %in% filter$rows), ]
  }))

  App_data$values <- dataSet
  sdcshinyapp::Table_Render(App_data$values, cb)
})

# 4. Storage of Removed Data ----
removed_values <- shiny::reactiveValues(removed_data = NULL)

shiny::observeEvent(input$store_data, {
  if (!"Serial" %in% colnames(App_data$values)) {
    shinyalert::shinyalert("No serial number attached to data.", "Please re-add serial number for storage.", type = "error")
    shiny::validate(shiny::need(App_data$values$Serial, "There is no Serial Number"))
  }

  shiny::validate(shiny::need(unprocessed$data, "There is no input data"))

  shinyalert::shinyalert("Filtered data successfully stored", type = "success")
  removed_values$removed_data <- dplyr::anti_join(unprocessed$data, App_data$values, by = "Serial")
  unprocessed$data <- NULL
})

# 5. Re-add Removed Data ----
shiny::observeEvent(input$re_add_data, {
  if (is.null(removed_values$removed_data) || !"Serial" %in% colnames(App_data$values)) {
    shinyalert::shinyalert("Missing data or serial number", "Please re-add serial number and store filtered values.", type = "error")
    shiny::validate(
      shiny::need(App_data$values$Serial, "There is no Serial Number"),
      shiny::need(removed_values$removed_data, "There is no filtered values removed")
    )
  }

  shinyalert::shinyalert("Filtered data successfully re-added.", type = "success")

  temp <- App_data$values
  App_data$values <- rbind(temp, removed_values$removed_data) |> dplyr::arrange(Serial)
  removed_values$removed_data <- NULL
})

# END OF SCRIPT ----
