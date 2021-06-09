# NOTE: replace placeholders with module name: modTCx = Title Case; modCCx = camelCase

#' modTCx module

#' modTCx module UI
#'
#' Defines the UI for the modTCx module
#'
#' @param id to be used to namespace the module
#'
#' @return the module UI, as a tagList
#'
#' @export
tab_modCCx_ui <- function(id) {

  ns <- NS(id)

  tagList(
    h3("modTCx",
       class = "tab-title")
  )

}

#' modTCx module server
#'
#' Defines the server logic for the modTCx module
#'
#' @param appData the appData reactiveValues object, defined in server.R and available
#' to all modules
#'
#' @return the module server, returned from a moduleServer function call
#'
#' @export
tab_modCCx_server <- function(appData) {

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
