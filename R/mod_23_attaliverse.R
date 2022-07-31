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
          width = NULL,
          
          p("In the previous tab, I introduced shinyjs as one of the best ways to get started using Javascript in your
            shiny apps. This package was created by an R guru by the name of Dean Attali. Dean runs an R Shiny consulting
            firm and has created several R packages specifically to enhance shiny apps and fill some of the gaps in base
            shiny functionality."),
          p("This collection of packages do not have an official name so I've (semi-seriously) referred to them as the 
            'Attali-verse'. There are several packages, each with their own specific use case - and I personally have found 
            some of them invaluable when creating interactive, user-friendly apps."),
          p("This tab introduces some of the most useful packages, because I believe that all shiny developers should at
            least be aware of them as they may make your life much, much easier."),
          p("See", tags$a("Dean's Github", href = "https://github.com/daattali"), "for more or to see all other packages.")
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
