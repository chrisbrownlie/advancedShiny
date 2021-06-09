#' Info module

#' Info module UI
#'
#' Defines the UI for the Info module
#'
#' @param id to be used to namespace the module
#'
#' @return the module UI, as a tagList
#'
#' @import htmltools
#' @importFrom shinydashboardPlus box
#' @importFrom shiny fluidRow column icon
#'
#' @export
tab_info_ui <- function(id) {

  ns <- NS(id)

  tagList(
    h3("Info",
       class = "tab-title"),
    fluidRow(
      column(
        width = 6,
        box(
          title = "Purpose of this app",
          solidHeader = TRUE,
          width = NULL,
          icon = icon("info-circle"),
          status = "info",

          p("This app is designed to introduce beginner and intermediate R Shiny users to some more advanced concepts, techniques and methods.",
            "The initial goal is for this app to serve as a companion to three DfE Coffee & Coding sessions, which will talk through some of the
            ideas and hopefully introduce R Shiny developers in the department to some new shiny solutions and possibilities."),

          p("This project (the app and accompanying talks) will", tags$b("not"), "cover every single thing that R Shiny has to offer. Additionally,
            although the name implies all topics are at least intermediate level, some are more straightforward and every effort will be made to
            ensure the content can be understood by those who are fairly new to R Shiny."),

          p("A basic knowledge of R and R Shiny is assumed, however. For a beginners introduction to either of these, see the official documentation and get
            started guide, or check out the", tags$a("Coffee & Coding sharepoint page",
                                                     href = "https://educationgovuk.sharepoint.com/sites/sarpi/g/AC/Coffee%20and%20Coding.aspx"),
            "as there has been previous beginner-level talks on these two topics.")
        )
      ),

      column(
        width = 6,
        box(
          title = "Using the app",
          solidHeader = TRUE,
          width = NULL,
          icon = icon("book"),
          status = "info",

          p("As you can see, the app has been structured in a similiar fashion to a bookdown site, with sequential chapters that can be accessed
            using the navigation sidebar. The content has been arranged into three broad categories, which will roughly correspond with the
            Coffee & Coding sessions to be delivered. The topics are", tags$b("not"), "arranged in order of difficulty, but a logical order has
            been decided upon and we have tried to put simple or more fundamental concepts earlier on in each section. Feel free to look through
            each tab in order or to jump around and look at only the parts which interest you."),

          p("Where possible, code snippets will be provided which you can copy and paste to try out some of the methods showcased here. The full
            repository for this app will also be available so you can check out the full code if you want to (link will be provided below at a later
            date). The app has been structured as an R package (see section 1.5 for more info), so you can clone the repository and run the app
            yourself with the code below."),

          code_snippet(c("remotes::install_github('chrisbrownlie/advancedShiny')",
                         "advancedShiny::run_IAS_app()"))
        )
      )
    ),

    fluidRow(
      column(
        width = 12,
        box(
          title = "Contributions",
          solidHeader = TRUE,
          width = NULL,
          icon = icon("users"),
          status = "purple",

          p("This app was developed by:"),
          tags$ul(
            tags$li(
              tags$a("Chris Brownlie", href = "mailto:christopher.brownlie@education.gov.uk")
              ),
            tags$li(
              tags$a("Cameron Race", href = "mailto:cameron.race@education.gov.uk")
              ),
            tags$li(
              tags$a("Linda Bennett", href = "mailto:linda.bennett@education.gov.uk")
            )
          ),
          p("If you wish to add or expand upon this app, please contact one of the above to discuss.")
        )
      )
    )
  )

}

#' Info module server
#'
#' Defines the server logic for the Info module
#'
#' @param id to be used to namespace the module
#' @param appData the appData reactiveValues object, defined in server.R and available
#' to all modules
#'
#' @return the module server, returned from a moduleServer function call
#'
#' @export
tab_info_server <- function(id,
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
