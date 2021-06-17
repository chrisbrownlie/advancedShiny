#' References & Further Materials module

#' References & Further Materials module UI
#'
#' Defines the UI for the References & Further Materials module
#'
#' @param id to be used to namespace the module
#'
#' @return the module UI, as a tagList
#'
#' @export
tab_references_ui <- function(id) {

  ns <- NS(id)

  tagList(
    h3("References & Further Materials",
       class = "tab-title")
  )

}

#' References & Further Materials module server
#'
#' Defines the server logic for the References & Further Materials module
#'
#' @param id to be used to namespace the module
#' @param appData the appData reactiveValues object, defined in server.R and available
#' to all modules
#'
#' @return the module server, returned from a moduleServer function call
#'
#' @export
tab_references_server <- function(id,
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
