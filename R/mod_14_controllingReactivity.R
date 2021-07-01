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
       class = "tab-title"),
    
    fluidRow(
      column(
        width = 6,
        box(
          title = "Stop...reactive time",
          status = "warning",
          closable = TRUE,
          collapsible = TRUE,
          icon = icon("stop-circle"),
          width = NULL,
          solidHeader = TRUE,
          
          p("Now that the previous two tabs have given a foundational understanding of what reactivity is and the
            key elements involved in making it possible, this tab will cover what to do when you want to control
            how reactivity works in your apps."),
          
          p("The first and most obvious thing to do to control reactivity is to stop it happening. There are several
            situations where you may want to do this, the most common being when you want to use several reactive values
            in a reactive calculation, but you only want to calculate them when one specific thing happens (e.g. a button 
            gets pressed). In this situation, you would use a variation on reactive() or observe(), namely:"),
          tags$ul(
            tags$li(code_block("eventReactive()")),
            "or",
            tags$li(code_block("observeEvent()"))
          ),
          p("These both rely on another function, which is the key to stopping reactivity, and that is: ", code_block("isolate()", noWS = "outside"), "."),
          br(),
          p("What", code_block("isolate()"), "does, is tell shiny 'I know this variable is reactive, but pretend it isn't'. So when the reactive
            graph is formed and shiny works out dependencies, it will simply treat the reactive variable as a fixed variable and
            there will be no reactive dependencies. Consider the example below:"),
          code_snippet(c("x <- reactiveVal(1)",
                         "y <- reactiveVal(4)",
                         "observe({",
                         "    message('x is ', x(), ', and y is ', y())",
                         "})",
                         "",
                         "observe({",
                         "    message('(isolating y)...x is ', x(), ' and y is ', isolate(y()))",
                         "})",
                         "",
                         "x(3) # both observers will run",
                         "y(3) # only the first observer will run")),
          p("Using isolate() removes the dependency for the second observer on 'y'."),
          p("Going back to observeEvent and eventReactive, they can both be used in the following way:"),
          code_block("function({trigger}, {response})"),
          p("With everything in the response being wrapped in isolate(), so the observer or reactive expression
            will only take dependencies on the contents of the trigger. This means that the following two observers
            are exactly identical:"),
          code_snippet(c("a <- reactiveVal(1)",
                         "b <- reactiveVal(2)",
                         "",
                         "observe({",
                         "    a()",
                         "    print(isolate(b()))",
                         "})",
                         "",
                         "observeEvent(a(), {",
                         "    print(b())",
                         ")}")),
          p("Or more generally..."),
          code_snippet(c("observeEvent(x, y)",
                         "# is exactly equivalent to",
                         "observe({",
                         "    x",
                         "    isolate(y)",
                         "})",
                         "",
                         "# and",
                         "",
                         "z <- eventReactive(x, y)",
                         "# is exactly equivalent to",
                         "z <- reactive({",
                         "    x",
                         "    isolate(y)",
                         "})"))
        )
        
      ), #end column
      
      column(
        width = 6,
        
        box(
          title = "Its all about timing",
          status = "warning",
          closable = TRUE,
          collapsible = TRUE,
          icon = icon("hourglass-half"),
          width = NULL,
          solidHeader = TRUE,
          
          p("The second way in which we might want to control reactivity more finely is to have something happen on a time-based cue rather than
            a user-action cue. There are two functions which can be extremely useful in this situation."),
          p("The function which will be of most use to the majority of shiny app developers is ", code_block("invalidateLater()", noWS = "outside"),
            ", which can be placed inside a reactive expression to tell shiny to execute something after a certain time delay."),
          p("Consider the example below, where the value of x will be printed every 2 seconds:"),
          code_snippet(c("x <- reactiveVal(2)",
                         "",
                         "observe({",
                         "    invalidateLater(2000)",
                         "    ",
                         "    print(isolate(x())) # using isolate() means this observer won't execute when x changes",
                         "})")),
          p("This can be used for example to monitor something within your app, checking every 5-10 seconds whether a condition has been
            met or not."),
          p("One thing to be wary of with invalidateLater is that if the expression within is too long, it will affect your app as the calculation -
            just like any other reactive calculation - will stop shiny being able to calculate anything else while it is running."),
          hr(),
          p("If we think about use-cases for the invalidateLater() function, one obvious situation that comes to mind is that of a 'live' dataset.
            If we have an app that is pointed at a dataset which changes frequently, we may want to check every x minutes whether it has changed and
            bring in the new dataset if it has."),
          p("We can use invalidateLater() to solve this problem, but there is a major downside to this. As I mentioned before, when shiny is performing
            an operation it (generally) cannot do anything else at the same time. If you are reading in a large dataset every few minutes this can have
            a significant impact on your app's performance. Luckily, there is another function which can help:", code_block("reactivePoll()")),
          p(code_block("reactivePoll()"), "works in a very similiar way to an observe(invalidateLater()) combination, but instead of taking just one
            expression to execute every x seconds, it takes two functions. The first is a 'checking' function which is run every x seconds, the second
            is the 'value' function, which is only executed if the checking function indicates something has changed."),
          p("What this means is, if you were looking a large, frequently-changing SQL table, you could use something like the example below:"),
          code_snippet(c("mydata <- reactivePoll(",
                         "    5000, # check every five seconds",
                         "    checkFunc = function() {",
                         "        dbGetQuery(conn, 'SELECT MAX(time_updated) FROM myschema.mydata')",
                         "    },",
                         "    valueFunc = function() {",
                         "        dbGetQuery(conn, 'SELECT * FROM myschema.mydata')",
                         "    })")),
          p("The example above creates a reactive dataset that will check every five seconds whether the most recent 'time_updated' has changed,
            and if it has changed then it will read in every row from the SQL table. In this example, you can use mydata() like you would any
            other reactive expression and be sure that the data you are seeing is never more than 5 seconds out of date.")
        )
      )
      
    ), # end fluidRow
    
    fluidRow(
      
      column(
        width = 12,
        
        box(
          title = "Hold and Give (but do it at the right time)",
          status = "warning",
          closable = TRUE,
          collapsible = TRUE,
          icon = icon("ellipsis-h"),
          width = NULL,
          solidHeader = TRUE,
          
          p("The final way in which we might want to control reactivity is to", tags$i("restrict"), "it.")
        )
      )
    )
    
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
