#' Using Javascript module

#' Using Javascript module UI
#'
#' Defines the UI for the Using Javascript module
#'
#' @param id to be used to namespace the module
#'
#' @return the module UI, as a tagList
#'
#' @export
tab_usingJS_ui <- function(id) {

  ns <- NS(id)

  tagList(
    h3("Using Javascript",
       class = "tab-title"),
    
    fluidRow(
      column(
        width = 6,
        box(
          title = "What is Javascript?",
          status = "warning",
          icon = icon("info-circle"),
          solidHeader = TRUE,
          closable = TRUE,
          collapsible = TRUE,
          width = NULL,
          
          p("As mentioned in tab 1.1 ('What is shiny, actually?'), Javascript is one of the three languages of the web
            that shiny code gets converted into. The way I like to think about it is that Javascript handles how objects
            move and interact with the user. In reality, Javascript is a very powerful programming language that can be
            used in a plethora of ways."),
          
          p("As has already been stated by others before me, Javascript really is the best way you can take your Shiny skills from
            decent to world-class. Proper use of Javascript is, in my opinion, the number one way to improve user experience in
            your app. When it comes down to it, user experience is almost always the one key metric for how successful an app is. If
            a user can't get what they need from an app or faces unnecessary complications and hurdles to doing so, it doesn't matter
            how pretty it looks or how many complicated concepts it implements, they simply won't use it."),
          
          p("Javascript is more complicated than its two companions in shiny web development (HTML and CSS), but is far more
            powerful as a result. Many of the core concepts of Javascript have parallels in R - or most other programming languages 
            for that matter (variables, functions, conditionals etc.)."),
          
          
          h5("This tab will not discuss the technicalities of using Javascript in any depth, as there are already fantastic resources available elsewhere:"),
          tags$ul(
            tags$li("See", tags$a("here for a basic introduction to Javascript.", href = "https://developer.mozilla.org/en-US/docs/Learn/Getting_started_with_the_web/JavaScript_basics#what_is_javascript")),
            tags$li("See",  tags$a("here for a slightly more in-depth tutorial.", href = "https://unleash-shiny.rinterface.com/survival-kit-javascript.html#programming-with-js-basis")),
            tags$li("See", tags$a("here for a more detailed discussion of how to use JS in production shiny apps.", href = "https://engineering-shiny.org/using-javascript.html"))
          ),
          
          p("Instead, this tab will focus on trying to explain practically why you might want to look into using JS or ways to get started.")
        ), #end box
        
        box(
          title = "Some cool use cases for adding JS to your app",
          status = "warning",
          icon = icon("info-circle"),
          solidHeader = TRUE,
          closable = TRUE,
          collapsible = TRUE,
          width = NULL,
          
          p("This is just some of the ways I've used Javascript in an app or you might want to (this list is far from exhaustive):"),
          
          tags$ul(
            tags$li("To monitor whether a user makes changes so that when they try to close the app they get a popup saying 'you have unsaved changes'"),
            tags$li("To animate an element of the page when a user hovers their mouse over it"),
            tags$li("To speed up the reactivity of your UI using e.g.", code_block("shinyjs", T)),
            tags$li("To create custom interactive, animated graphics using e.g.", code_block("r2d3", T)),
            tags$li("To insert a custom API into your app to allow communication with other programs/services"),
            tags$li("To identify a user's browser information to enable customise your app based on viewing device")
          )
          
        ) #end box
      ), #end column
      column(
        width = 6,
        box(
          title = "How to add javascript to your app",
          status = "warning",
          icon = icon("info-circle"),
          solidHeader = TRUE,
          closable = TRUE,
          collapsible = TRUE,
          width = NULL,
          
          p("As with CSS, there are two main ways to add JS to your app: the clean way and the messy way."),
          
          h6("The messy way"),
          p("Javascript code can be added directly inline to your app, using", code_block("shiny::JS()"), "or", code_block("tags$script('{javascript code}')")),
          
          h6("The clean way"),
          p("You can keep your Javascript code in a separate file(s) in the www/ folder and include them using", code_block("shiny::includeScript()"),
            "or", code_block("tags$link(src = 'myscript.js')"))
        ), #end box
        
        box(
          title = "shinyjs",
          status = "warning",
          icon = icon("info-circle"),
          solidHeader = TRUE,
          closable = TRUE,
          collapsible = TRUE,
          width = NULL,
          
          p("One of the best ways to get started using Javascript in your shiny apps is to leverage the powerful and lightweight", code_block("shinyjs", T),
            "package. Created by", tags$a("Dean Attali", href = "https://github.com/daattali", .noWS = 'outside'), ", it wraps several useful Javascript
            actions into neat R functions. This allows you to introduce Javascript functionality to your app without even having to learn the language
            to begin with!"),
          
          p("For a full list of what shinyjs provides, see the", tags$a("documentation site", href = "https://deanattali.com/shinyjs/"), "but see below
            just a couple of examples."),
          
          h6("Hiding/disabling elements"),
          p("This is probably what I use shinyjs for the most, quickly and easily hiding, unhiding and disabling elements. There are many situations
            where you want to take the ability to do something out of your users' hands for a period of time. The shinyjs functions make this very easy.
            See an example below. Notice the use of", code_block("hidden()"), "to ensure the element starts in a hidden state - there is an equivalent",
            code_block("disabled"), "function too for starting an element in a disabled state."),
          code_snippet(c("library(shiny)",
                         "library(shinyjs)",
                         "",
                         "ui <- fluidPage(",
                         "    useShinyjs(),",
                         "    hidden(p('some sample text', id = 'txt')),",
                         "    actionButton('show', 'Show text'),",
                         "    actionButton('hide', 'Hide text'),",
                         "    actionButton('disable', 'Disable hiding/showing'),",
                         "    actionButton('enable', 'Enable hiding/showing')",
                         ")",
                         "",
                         "server <- function(input, output) {",
                         "    observeEvent(input$show, {",
                         "        show('txt')",
                         "    })",
                         "    observeEvent(input$hide, {",
                         "        hide('txt')",
                         "    })",
                         "    observeEvent(input$disable, {",
                         "        disable('show')",
                         "        disable('hide')",
                         "    })",
                         "    observeEvent(input$enable, {",
                         "        enable('show')",
                         "        enable('hide')",
                         "    })",
                         "}",
                         "",
                         "shinyApp(ui, server)")),
          
          h6("Delaying events"),
          p("There are multiple ways to delay reactivity in shiny (see 1.4 - Controlling reactivity), but shinyjs provides yet another way to
            simply control the flow and timing of events in your app, using the", code_block("delay"), "function."),
          p("See an example of this below:"),
          code_snippet(c("library(shiny)",
                         "library(shinyjs)",
                         "",
                         "ui <- fluidPage(",
                         "    useShinyjs(),",
                         "    p('some sample text', id = 'txt'),",
                         "    actionButton('hide3', 'Hide text for 3 seconds'),",
                         "    actionButton('hide1', 'Wait 3 seconds, then hide text for 1 second'),",
                         ")",
                         "",
                         "server <- function(input, output) {",
                         "    observeEvent(input$hide3, {",
                         "        hide('txt')",
                         "        delay(3000, show('txt'))",
                         "    })",
                         "    observeEvent(input$hide1, {",
                         "        delay(3000, hide('txt'))",
                         "        delay(4000, show('txt')) # important: delay time is from when observer first runs",
                         "    })",
                         "}",
                         "",
                         "shinyApp(ui, server)"))
        ) #end box
      ) #end column
    ) #end fluidRow
    
  )

}

#' Using Javascript module server
#'
#' Defines the server logic for the Using Javascript module
#'
#' @param id to be used to namespace the module
#' @param appData the appData reactiveValues object, defined in server.R and available
#' to all modules
#'
#' @return the module server, returned from a moduleServer function call
#'
#' @export
tab_usingJS_server <- function(id,
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
