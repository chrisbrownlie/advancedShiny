#' Attali-verse module

#' Attali-verse module UI
#'
#' Defines the UI for the Attali-verse module
#'
#' @param id to be used to namespace the module
#'
#' @return the module UI, as a tagList
#'
#' @export
tab_attaliverse_ui <- function(id) {

  ns <- NS(id)

  tagList(
    h3("Attali-verse",
       class = "tab-title"),
    
    fluidRow(
      column(
        width = 6,
        box(
          title = "Dean Attali",
          status = "navy",
          icon = icon("info-circle"),
          solidHeader = TRUE,
          closable = TRUE,
          collapsible = TRUE,
          width = NULL
        ), #end box
        
        box(
          title = "shinyalert",
          status = "navy",
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
          title = "shinycssloaders",
          status = "navy",
          icon = icon("info-circle"),
          solidHeader = TRUE,
          closable = TRUE,
          collapsible = TRUE,
          width = NULL
        ), #end box
        
        box(
          title = "...and the rest",
          status = "navy",
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

#' Attali-verse module server
#'
#' Defines the server logic for the Attali-verse module
#'
#' @param id to be used to namespace the module
#' @param appData the appData reactiveValues object, defined in server.R and available
#' to all modules
#'
#' @return the module server, returned from a moduleServer function call
#'
#' @export
tab_attaliverse_server <- function(id,
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
