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
    h3("Visualisation with r2d3",
       class = "tab-title")
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
