#' Visualisation with r2d3 module

#' Visualisation with r2d3 module UI
#'
#' Defines the UI for the Visualisation with r2d3 module
#'
#' @param id to be used to namespace the module
#'
#' @return the module UI, as a tagList
#'
#' @export
tab_visualisationR2D3_ui <- function(id) {

  ns <- NS(id)

  tagList(
    h3("Visualisation with r2d3 et al.",
       class = "tab-title"),
    
    fluidRow(
      column(
        width = 6,
        box(
          title = "What is d3? and what is {r2d3}?",
          status = "maroon",
          icon = icon("info-circle"),
          solidHeader = TRUE,
          closable = TRUE,
          collapsible = TRUE,
          width = NULL
        ), #end box
        
        box(
          title = "Complete control (examples)",
          status = "maroon",
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
          title = "{r2d3} vs {plotly} vs {ggplot2}",
          status = "maroon",
          icon = icon("info-circle"),
          solidHeader = TRUE,
          closable = TRUE,
          collapsible = TRUE,
          width = NULL
        ), #end box
        
        box(
          title = "Other JS plotting libraries",
          status = "maroon",
          icon = icon("info-circle"),
          solidHeader = TRUE,
          closable = TRUE,
          collapsible = TRUE,
          width = NULL,
          p("e.g. {leaflet}, {dygraphs}, {networkD3}, {echarts4r}, {highcharter}, {sigmajs}")
        ) #end box
      ) #end column
    ) #end fluidRow
  )

}

#' Visualisation with r2d3 module server
#'
#' Defines the server logic for the Visualisation with r2d3 module
#'
#' @param id to be used to namespace the module
#' @param appData the appData reactiveValues object, defined in server.R and available
#' to all modules
#'
#' @return the module server, returned from a moduleServer function call
#'
#' @export
tab_visualisationR2D3_server <- function(id,
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
