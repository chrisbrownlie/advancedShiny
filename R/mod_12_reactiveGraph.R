#' Reactive Graph module

#' Reactive Graph module UI
#'
#' Defines the UI for the Reactive Graph module
#'
#' @param id to be used to namespace the module
#'
#' @return the module UI, as a tagList
#'
#' @importFrom shinydashboardPlus box
#'
#' @export
tab_reactiveGraph_ui <- function(id) {

  ns <- NS(id)

  tagList(
    h3("Reactive Graph",
       class = "tab-title"),
    
    fluidRow(
      column(
        width = 6,
        
        box(
          title = "Pull or Push?",
          status = "maroon",
          closable = TRUE,
          collapsible = TRUE,
          icon = icon("crow"),
          width = NULL,
          solidHeader = TRUE,
          p("The concept of reactivity in an R shiny app is almost magical, in the sense that it makes you believe R works on a push basis.
            When you click a button, it feels like that button sends a notification to shiny and then shiny executes something (e.g.
            a popup that says 'Success!'). In reality though, this is not how R works at all. Consider the following code:"),
          code_snippet(c("a <- 1",
                         "a + 1 # (2)",
                         "a <- 5")),
          p("The value of", code_block("a + 1"), "does not automatically update so as far as R is concerned, it is still 2. To update is simple though,
            we simply run the code again"),
          code_snippet(c("a <- 1",
                         "a + 1 # (2)",
                         "a <- 5",
                         "a + 1 # (6)")),
          p("So values are not automatically updated when their dependencies change, we have to tell R to recalculate the value instead. R can retrieve
            the value of 'a' to calculate a + 1, but it will not know if 'a' later changes value."),
          p("As mentioned above, this isn't what we see in shiny where the flow of information seems to be reversed, so how is it doing this?"),
          
          p("To best understand, consider the '4 maxims of reactivity'", a("(see the RStudio overview of reactivity for more info):", 
                                                                           href = "https://shiny.rstudio.com/articles/understanding-reactivity.html")),
          tags$ol(
            tags$li("R expressions update themselves, if you ask",
                    tags$ul(
                      tags$li("So all we really need for reactivity, is to check every so often whether something needs updating and to recalculate it if it does."),
                      tags$li("Although clicking a button can't send a message to tell a value to update, we can keep checking whether the button has been pressed or not,
                              and execute the relevant code if it has.")
                      )
                    ),
            tags$li("Nothing needs to happen instantly",
                    tags$ul(
                      tags$li("Human perception isn't quick enough to notice a delay of microseconds."),
                      tags$li("To make things look instantaneous, you can just recalculate everything every few microseconds."),
                      tags$li("If the inputs haven't changed then the app will remain the same but if they have, then the new values appear after an imperceptible delay."),
                      tags$li("This is essentially how shiny works, but recalculating", tags$i("everything"), "every few microseconds would be hugely inefficient
                      and lead to a very slow app, so shiny also uses an alert system to identify", tags$i("which"), "calculations
                              need to be rerun.")
                    )),
            tags$li("The app must do as little as possible",
                    tags$ul(
                      tags$li("Without a supercomputer, calculating everything every few microseconds would lead to long delays and unresponsive apps."),
                      tags$li("So instead, every few microseconds shiny will check all the expressions to see which are out of date and rerun only those."),
                      tags$li("If the inputs to a value have not changed, the expression doesn't need to be rerun and so this saves a lot of computation time."),
                      tags$li("Every few microseconds, if inputs have changed then any expressions which use those inputs become", tags$i(strong("invalidated")), "and 
                              shiny recalculates their values."),
                      tags$li("This recalculation is called a", tags$i(strong("flush"), .noWS = "after"), ".")
                    )),
            tags$li("Think carrier pigeons, not electricity",
                    tags$ul(
                      tags$li("This alert system uses two special object classes, ", code_block("reactivevalues"), "and", code_block("observers", noWS = "after"), "."),
                      tags$li("What is special about these is that if an observer uses a reactivevalue, it registers a", tags$i(strong("reactive context")), "with the reactivevalue
                       which contains a", tags$i(strong("callback")), "for that observer."),
                      tags$li("All a reactive context is, is a notification that says 'every time you (the reactivevalue), change your value, you need to tell the server to execute this 
                      callback', where the callback is just an R command. In a shiny app, the callback is", tags$i("always"), "the command: 'recalculate this observer'."),
                      tags$li("The analogy RStudio use is of carrier pigeons. When an observer registers a context with a reactivevalue, it gives the reactivevalue a carrier pigeon.
                              Then whenever the reactivevalue changes its value, the pigeon (context) flies to the server and delivers a message (the callback). The server then reads 
                              the callback 'rerun this observer', and recalculates the value of the observer."),
                      tags$li("So if a reactivevalue has changed, its callback is placed in the server queue and every few microseconds, the server just executes anything in the queue.
                              This saves the server having to recalculate everything every time or even decide what needs to be recalculated."),
                      tags$li("Another important point is that reactive contexts are one-shot. Once a callback has been sent to the server, the context that sent it is destroyed. Then whenever
                              an observer is recalculated, it creates a new context with the reactivevalue. This is important in making sure shiny does as little as possible 
                              (see the box on the right)."),
                      tags$li("It is also important to note that a single reactivevalue can have multiple contexts, if multiple observers use it. Then when its value changes, it puts all of those
                              callbacks in the servers queue. Note that the order of these is more or less random, which is why observers must be independent of each other.")
                      )
                    )
            ),
          p("So a simplified example of how reactivity in shiny works is:"),
          tags$ol(
            tags$li("An", code_block("observer"), "is created (e.g. a bar chart) which relies on a", code_block("reactivevalue"), "(e.g. input$number_of_bars)."),
            tags$li("On app startup, shiny tries to create the bar chart but realises that it relies on input$number_of_bars, so it retrieves this value, which is 3 to begin
                    with, and plots the chart."),
            tags$li("At the same time, a", tags$i("reactive context"), "is registered with the reactivevalue (the renderPlot() function will do this), which contains 
                    a", tags$i("callback"), "that simply says 'plot the bar chart again'"),
            tags$li("The shiny server starts checking every few microseconds whether anything has changed and it needs to initiate a flush."),
            tags$li("After a while, the user changes input$number_of_bars from 3 to 5."),
            tags$li("The reactive context associated with input$number_of_bars then places the callback for the bar chart into the server's queue (and any other contexts
                    associated with input$number_of_bars do the same for their callbacks)."),
            tags$li("On the next check a few microseconds later, the server sees there is something in the queue and so initiates a flush."),
            tags$li("This flush involves executing the callback 'plot the bar chart again', so it does this."),
            tags$li("It realises the bar chart depends on input$number_of_bars, and so it retrieves that value and sees that it is 5, then plots the chart."),
            tags$li("At the same time, a", tags$i("reactive context"), "is registered with the reactivevalue, which contains a", tags$i("callback"), "that simply says 
                    'plot the bar chart again' (same as step 3)"),
            tags$li("The new bar chart appears some microseconds after the user changed input$number_of_bars to 5 and so the change appears almost instantaneous."),
            tags$li("On its next check a few microseconds later, the server sees that the queue is now empty and so returns to a resting state where it continues to check the
                    queue every few microseconds.")
          )
        ), # end box
        
        box(
          title = "Graphing It",
          status = "maroon",
          closable = TRUE,
          collapsible = TRUE,
          icon = icon("project-diagram"),
          width = NULL,
          solidHeader = TRUE,
          p("")
        ) # end box
      ), # end column
      
      column(
        width = 6,
        
        box(
          title = "Laziness FTW",
          status = "maroon",
          closable = TRUE,
          collapsible = TRUE,
          icon = icon("bed"),
          width = NULL,
          solidHeader = TRUE,
          p("The box on the left gives one way to understand reactivity. Another important concept which may help to contextualise the process is to realise that
            shiny apps use declarative rather than imperative programming."),
          tags$ul(
            tags$li(strong("Imperative programming"), "means that you tell the code to do something and it does it. For example when you 
                    run", code_block("print('Hello, world')"), "you are issuing a specific command that is carried out immediately."),
            tags$li(strong("Declarative programming"), "on the other hand, involved specifying constraints and more high-level 'recipes' for
                    how to do something, and then relying on something or someone else to decide when to translate that into action.")
          ),
          p("When we create an output in shiny, for example using a render*() function, we are not issuing a command that is carried out immediately.
            We are creating a 'recipe' that tells shiny 'this is how you create this output'. That recipe may be followed once, twice, many times or even never.
            The point is, we leave it up to shiny to decide when and how to do this."),
          p("The benefit of using declarative programming is that shiny can be as lazy as possible and only calculate something if and when it is required. You can
            see this in action in the example app below:"),
          
          code_snippet(c("library(shiny)",
                         "",
                         "ui <- fluidPage(",
                         "    textInput('first_name', 'Your name:'),",
                         "    textOutput('my_name')",
                         ")",
                         "",
                         "server <- function(input, output) {",
                         "",
                         "output$myname <- renderText({",
                         "    print('This is executing now')",
                         "    paste0('My name is ', input$first_name)",
                         "})",
                         "",
                         "}",
                         "",
                         "shinyApp(ui, server)")),
          
          p("Note that there is a typo, the output is called 'myname' in the server instead of 'my_name'. This means that the code in the renderText() call 
            is", tags$i("never run", .noWS = "after"), ". You can verify this because you will see no 'This is executing now's in the R console either."),
          p("Now try fixing the typo and changing it to 'my_name'. You will see that it works as expected now and every time you type a name, the print
            statement is executing and the text output changes correctly. Note that the renderText code is not run", tags$i("every time you type a letter"), "-
            which is what we'd expect based on everything we learned in the box to the left. This is by design and another example of how shiny uses laziness to
            improve efficiency (more on this in the next tab 'Controlling reactivity'."),
          br(),
          p("One consequence of this designed laziness is that", tags$i(strong("reactive dependencies are dynamic"), .noWS = "after"), "."),
          p("Consider the two observe() calls below:"),
          code_snippet(c("observe({",
                         "if (input$a > 1) {",
                         "print(input$a + 5)",
                         "} else {",
                         "print(input$b)",
                         "})",
                         "",
                         "",
                         "observe({",
                         "a <- input$a",
                         "b <- input$b",
                         "if (a > 1) {",
                         "print(a + 5)",
                         "} else {",
                         "print(b)",
                         "})")),
          p("While these observers look equivalent, there is a subtle but important difference. The second observer will", strong("always"), "depend on both input$a
            and input$b, whereas the first observer will only depend on input$b", strong("if input$a <= 1", .noWS = "after"), ". Consider the situation where input$a
            is set to 5 and then input$b is changed multiple times. The second observer will recalculate (the same value) several times, because it depends on input$b,
            whereas the first observer will not have registered the dependency on input$b because the value of input$a is greater than one. This means that the first
            observer will not recalculate unnecessarily if input$b is changed multiple times and will only recalculate when input$a is changed. If input$a is changed to 
            0, then a dependency on input$b will be created. This rendering of reactive dependencies on the fly is an important design feature as it allows even more laziness
            and improves shiny's efficiency drastically. Understanding this feature can make a big difference in speeding up your own apps, if you try to ensure that dependencies
            are only established when they are needed.")
        ),
        
        box(
          title = "reactlog",
          status = "maroon",
          closable = TRUE,
          collapsible = TRUE,
          icon = icon("toilet"),
          width = NULL,
          solidHeader = TRUE
        )
        
      )
      
    ) # end fluidRow
  ) # end tagList

}

#' Reactive Graph module server
#'
#' Defines the server logic for the Reactive Graph module
#'
#' @param id to be used to namespace the module
#' @param appData the appData reactiveValues object, defined in server.R and available
#' to all modules
#'
#' @return the module server, returned from a moduleServer function call
#'
#' @export
tab_reactiveGraph_server <- function(id,
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
