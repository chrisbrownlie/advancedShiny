#' Error Handling & Debugging module

#' Error Handling & Debugging module UI
#'
#' Defines the UI for the Error Handling & Debugging module
#'
#' @param id to be used to namespace the module
#'
#' @return the module UI, as a tagList
#'
#' @export
tab_errorHandling_ui <- function(id) {

  ns <- NS(id)

  tagList(
    h3("Error Handling & Debugging",
       class = "tab-title"),
    
    fluidRow(
      column(
        width = 6,
        box(
          title = "With base R",
          status = "orange",
          icon = icon("info-circle"),
          solidHeader = TRUE,
          closable = TRUE,
          collapsible = TRUE,
          width = NULL,
          p("tryCatch(), withRestarts(), stop(), warning(), message(), browser()")
        ), #end box
        
        box(
          title = "With {shiny}",
          status = "orange",
          icon = icon("info-circle"),
          solidHeader = TRUE,
          closable = TRUE,
          collapsible = TRUE,
          width = NULL
        ) #end box
      ), #end column
      column(
        width = 6,
        box(
          title = "With {testthat} and {shinytest}",
          status = "orange",
          icon = icon("info-circle"),
          solidHeader = TRUE,
          closable = TRUE,
          collapsible = TRUE,
          width = NULL
        ), #end box
        
        box(
          title = "With {whereami}",
          status = "orange",
          icon = icon("info-circle"),
          solidHeader = TRUE,
          closable = TRUE,
          collapsible = TRUE,
          width = NULL
        ) #end box
      ) #end column
    ) #end fluidRow
  )

}

#' Error Handling & Debugging module server
#'
#' Defines the server logic for the Error Handling & Debugging module
#'
#' @param id to be used to namespace the module
#' @param appData the appData reactiveValues object, defined in server.R and available
#' to all modules
#'
#' @return the module server, returned from a moduleServer function call
#'
#' @export
tab_errorHandling_server <- function(id,
                                     appData) {

  moduleServer(
    id,
    function(input,
             output,
             session,
             appData = appData) {

      # Alias the namespace function for ease of use
      ns <- session$ns

    }
  )

}
