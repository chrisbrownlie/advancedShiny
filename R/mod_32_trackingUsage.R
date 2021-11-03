#' Tracking Usage module

#' Tracking Usage module UI
#'
#' Defines the UI for the Tracking Usage module
#'
#' @param id to be used to namespace the module
#'
#' @return the module UI, as a tagList
#'
#' @export
tab_trackingUsage_ui <- function(id) {

  ns <- NS(id)

  tagList(
    h3("Tracking Usage",
       class = "tab-title"),
    
    fluidRow(
      column(
        width = 6,
        box(
          title = "Why might you want to track app usage?",
          status = "info",
          icon = icon("info-circle"),
          solidHeader = TRUE,
          closable = TRUE,
          collapsible = TRUE,
          width = NULL
        ), #end box
        
        box(
          title = "The manual way",
          status = "info",
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
          title = "The shinylogs way",
          status = "info",
          icon = icon("info-circle"),
          solidHeader = TRUE,
          closable = TRUE,
          collapsible = TRUE,
          width = NULL
        ), #end box
        
        box(
          title = "DfE-Specific advice",
          status = "info",
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

#' Tracking Usage module server
#'
#' Defines the server logic for the Tracking Usage module
#'
#' @param id to be used to namespace the module
#' @param appData the appData reactiveValues object, defined in server.R and available
#' to all modules
#'
#' @return the module server, returned from a moduleServer function call
#'
#' @export
tab_trackingUsage_server <- function(id,
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
