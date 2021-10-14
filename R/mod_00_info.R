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
        width = 8,
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
        ),
        
        box(
          title = "Shiny Ladder of Enlightenment",
          solidHeader = TRUE,
          width = NULL,
          icon = icon("swimming-pool"),
          status = "info",
          
          p("In a talk at Shiny Dev Con 2016, Joe Cheng (creator of shiny and CTO at RStudio) proposed a (semi-serious) 'Ladder 
            of Enlightenment' for shiny. The ladder gives an idea of different levels of understanding of shiny and how it works
            (particularly how reactivity works).
            The ladder is as follows:"),
          tags$ol(
            tags$li("Has used 'output' and 'input'"),
            tags$li("Has used reactive expressions (", code_block("reactive()", noWS = "outside"), ")"),
            tags$li("Has used", code_block("observe()"), "and/or ", code_block("observeEvent()", noWS = "outside"), ". 
                    Has written reactive expressions that depend on other reactive expressions. Has used", code_block("isolate()"),
                    "properly."),
            tags$li("Can", tags$i("confidently"), "say when to use", code_block("reactive()"), "vs. ", code_block("observe()", noWS = "outside"),
                    ". Has used ", code_block("invalidateLater()", noWS = "outside"), "."),
            tags$li("Writes higher-order reactives (functions that have reactive expressions as input parameters and return values)."),
            tags$li("Understands that reactive expressions are monads.")
          ),
          p("It is assumed that if you are using this app you are at least at step 1 and probably higher."),
          p("Much of the first section of this app, particularly tabs 1.2-1.4 (Understanding, Using and Controlling reactivity) will cover steps 2-4 (and briefly touch on 5)."),
          p("As Joe commented in his talk, there are probably only a handful of people in the world who are at step 6 (himself
            and Hadley (Wickham) being two of them). This is because reaching this step would require both expert knowledge of maths
            and computing, as well as deep understanding of shiny internals and how the package was built. As such this won't be spoken
            about here. If you're wondering what monads are, I would suggest you don't(!) - if you really want to know you can google 'what
            are monads' and come back here once you've emerged from the rabbit hole!")
        )
      ),

      column(
        width = 4,
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
                         "library(advancedShiny)",
                         "run_IAS_app()")),
          
          p(strong("Note that for any of the code examples which require reactivity, a mini example app will often be provided but if not you can enter a demo
            reactive state using:")),
          code_snippet(c("shiny::reactiveConsole(TRUE)"))
        ),
        
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
            )
          ),
          p("with contributions from:"),
          tags$ul(
          ),
          p("For more info or to contribute, contact one of the above.")
        ) #end box
      ) #end column
    ) #end fluidRow
  ) #end tagList

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
