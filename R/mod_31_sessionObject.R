#' Session Object module

#' Session Object module UI
#'
#' Defines the UI for the Session Object module
#'
#' @param id to be used to namespace the module
#'
#' @return the module UI, as a tagList
#'
#' @export
tab_sessionObject_ui <- function(id) {

  ns <- NS(id)

  tagList(
    h3("Session Object",
       class = "tab-title"),
    
    fluidRow(
      column(
        width = 6,
        box(
          title = "Apps, Clients, Servers, Sessions",
          status = "danger",
          icon = icon("info-circle"),
          solidHeader = TRUE,
          closable = TRUE,
          collapsible = TRUE,
          width = NULL
        ), #end box
        
        box(
          title = "Making the most of sessions",
          status = "danger",
          icon = icon("info-circle"),
          solidHeader = TRUE,
          closable = TRUE,
          collapsible = TRUE,
          width = NULL,
          p("onDisconnect, userData etc.")
        ) #end box
      ), #end column
      column(
        width = 6,
        box(
          title = "Under the hood of the session object",
          status = "danger",
          icon = icon("info-circle"),
          solidHeader = TRUE,
          closable = TRUE,
          collapsible = TRUE,
          width = NULL
        ), #end box
        
        box(
          title = "DfE-Specific advice",
          status = "danger",
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

#' Session Object module server
#'
#' Defines the server logic for the Session Object module
#'
#' @param id to be used to namespace the module
#' @param appData the appData reactiveValues object, defined in server.R and available
#' to all modules
#'
#' @return the module server, returned from a moduleServer function call
#'
#' @export
tab_sessionObject_server <- function(id,
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
