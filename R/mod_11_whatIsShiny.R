#' What Is Shiny? module

#' What Is Shiny? module UI
#'
#' Defines the UI for the What Is Shiny? module
#'
#' @param id to be used to namespace the module
#'
#' @return the module UI, as a tagList
#'
#' @export
tab_whatIsShiny_ui <- function(id) {

  ns <- NS(id)

  tagList(
    h3("What Is Shiny?",
       class = "tab-title")
  )

}

#' What Is Shiny? module server
#'
#' Defines the server logic for the What Is Shiny? module
#'
#' @param id to be used to namespace the module
#' @param appData the appData reactiveValues object, defined in server.R and available
#' to all modules
#'
#' @return the module server, returned from a moduleServer function call
#'
#' @export
tab_whatIsShiny_server <- function(id,
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
