#' Shiny Modules module

#' Shiny Modules module UI
#'
#' Defines the UI for the Shiny Modules module
#'
#' @param id to be used to namespace the module
#'
#' @return the module UI, as a tagList
#'
#' @export
tab_shinyModules_ui <- function(id) {

  ns <- NS(id)

  tagList(
    h3("Shiny Modules",
       class = "tab-title")
  )

}

#' Shiny Modules module server
#'
#' Defines the server logic for the Shiny Modules module
#'
#' @param id to be used to namespace the module
#' @param appData the appData reactiveValues object, defined in server.R and available
#' to all modules
#'
#' @return the module server, returned from a moduleServer function call
#'
#' @export
tab_shinyModules_server <- function(id,
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
