#' Controlling Reactivity module

#' Controlling Reactivity module UI
#'
#' Defines the UI for the Controlling Reactivity module
#'
#' @param id to be used to namespace the module
#'
#' @return the module UI, as a tagList
#'
#' @export
tab_controllingReactivity_ui <- function(id) {

  ns <- NS(id)

  tagList(
    h3("Controlling Reactivity",
       class = "tab-title")
  )

}

#' Controlling Reactivity module server
#'
#' Defines the server logic for the Controlling Reactivity module
#'
#' @param id to be used to namespace the module
#' @param appData the appData reactiveValues object, defined in server.R and available
#' to all modules
#'
#' @return the module server, returned from a moduleServer function call
#'
#' @export
tab_controllingReactivity_server <- function(id,
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
