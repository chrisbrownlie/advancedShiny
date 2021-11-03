#' Visualisation with plotly module

#' Visualisation with plotly module UI
#'
#' Defines the UI for the Visualisation with plotly module
#'
#' @param id to be used to namespace the module
#'
#' @return the module UI, as a tagList
#'
#' @export
tab_visualisationPlotly_ui <- function(id) {

  ns <- NS(id)

  tagList(
    h3("Visualisation with plotly",
       class = "tab-title"),
    
    fluidRow(
      column(
        width = 6,
        box(
          title = "What is plotly? and what is Plotly? and what is {plotly}?",
          status = "black",
          icon = icon("info-circle"),
          solidHeader = TRUE,
          closable = TRUE,
          collapsible = TRUE,
          width = NULL,
          p("short version: Plotly created plotly which can be accessed via {plotly}")
        ), #end box
        
        box(
          title = "The full extent of interaction and customisability",
          status = "black",
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
          title = "{plotly} vs {ggplot2}",
          status = "black",
          icon = icon("info-circle"),
          solidHeader = TRUE,
          closable = TRUE,
          collapsible = TRUE,
          width = NULL
        ), #end box
        
        box(
          title = "Some examples",
          status = "black",
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

#' Visualisation with plotly module server
#'
#' Defines the server logic for the Visualisation with plotly module
#'
#' @param id to be used to namespace the module
#' @param appData the appData reactiveValues object, defined in server.R and available
#' to all modules
#'
#' @return the module server, returned from a moduleServer function call
#'
#' @export
tab_visualisationPlotly_server <- function(id,
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
