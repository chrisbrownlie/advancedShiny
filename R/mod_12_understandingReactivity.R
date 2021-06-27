#' Understanding Reactivity module

#' Understanding Reactivity module UI
#'
#' Defines the UI for the Understanding Reactivity module
#'
#' @param id to be used to namespace the module
#'
#' @return the module UI, as a tagList
#'
#' @importFrom shinydashboardPlus box
#'
#' @export
tab_understandingReactivity_ui <- function(id) {

  ns <- NS(id)

  tagList(
    h3("Understanding Reactivity",
       class = "tab-title"),

    fluidRow(
      column(
        width = 6,

        box(
          title = "Reactive Programming",
          status = "maroon",
          closable = TRUE,
          collapsible = TRUE,
          icon = icon("react"),
          width = NULL,
          solidHeader = TRUE,
          p("Reactive programming is a paradigm that has been around for a while in software engineering and is based on 
            the concept of values which change over time in response to certain actions, and calculations that use these
            values (and therefore also return different outputs over time). Reactive programming is extremely common and the
            most widely-used example is a spreadsheet program. In a spreadsheet (e.g. Excel), you define relationships between
            cells, and if a cell's value gets updated or overwritten then everything that has a relationship with that cell also
            updates."),
          p("In shiny, reactive programming is what makes apps interactive. Users can change values and anything which relies
            on those values will be recalculated. The power of shiny is in the way it a) implements reactive programming in a
            language (R) that is inherently not reactive and b) how it determines the optimal way to execute recalculations
            involved in reactivity.")
        ),
        
        box(
          title = "Push or Pull?",
          status = "maroon",
          closable = TRUE,
          collapsible = TRUE,
          icon = icon("crow"),
          width = NULL,
          solidHeader = TRUE,
          p("The concept of reactivity in an R shiny app is almost magical, in the sense that it makes you believe R works on a push basis.
            When you click a button, it feels like that button sends a notification to R and then R executes something (e.g.
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
          p("As mentioned above, this isn't what we see in shiny where the flow of information seems to be reversed, so how is it doing this?")
          ),

        box(
          title = "The 4 Maxims",
          status = "maroon",
          closable = TRUE,
          collapsible = TRUE,
          icon = icon("square"),
          width = NULL,
          solidHeader = TRUE,
          p("To best understand reactivity, consider the '4 maxims of reactivity'", a("(see the RStudio overview of reactivity for more info):",
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
                      tags$li("This recalculation is called a", tags$i(strong("flush", .noWS = "after"), .noWS = "after"), ".")
                    )),
            tags$li("Think carrier pigeons, not electricity",
                    tags$ul(
                      tags$li("This alert system uses two special object classes, ", code_block("reactivevalues"), "and", code_block("observers", noWS = "after"), "."),
                      tags$li("What is special about these is that if an observer uses a reactivevalue, it registers a", tags$i(strong("reactive context")), "with the reactivevalue
                       which contains a", tags$i(strong("callback")), "for that observer."),
                      tags$li("All a reactive context is, is a notification that says 'every time you (the reactivevalue), change your value, I will tell the server to execute this
                      callback', where the callback is just a piece of R code. In a shiny app, the callback is", tags$i("always"), "the command: 'recalculate this observer'."),
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
          title = "reactlog",
          status = "maroon",
          closable = TRUE,
          collapsible = TRUE,
          icon = icon("toilet"),
          width = NULL,
          solidHeader = TRUE,
          p("The d3 animation to the right shows how we can visualise the reactive graph of a shiny app. It also gives some insight into how shiny knows what to
            recalculate and when."),
          p("For a simple app like the one given, it is not too difficult to picture this and understand what is going on, but for a much larger or more complex app
            this can quickly become too much to work out in your head. That is where the", code_block("reactlog", T), "package comes in."),
          p("Using", code_block("reactlog", T), "is very easy. The code below is a copy of the example app given on the right, but with a couple of lines of code
            included to enable reactlog."),
          code_snippet(c("#install.packages('reactlog')",
                         "library(shiny)",
                         "library(reactlog)",
                         "",
                         "reactlog_enable()",
                         "",
                         "ui <- fluidPage(",
                         "    numericInput('a', 'A', 1),",
                         "    numericInput('b', 'B', 1),",
                         "    numericInput('c', 'C', 1),",
                         "    textOutput('g'),",
                         "    textOutput('h')",
                         ")",
                         "",
                         "server <- function(input, output) {",
                         "",
                         "    d <- reactive({ input$a + input$b })",
                         "    e <- reactive({ input$b * 2 })",
                         "    f <- reactive({ input$c * 3 })",
                         "",
                         "    output$g <- renderText({ paste0('A + B is ', d()) })",
                         "    output$h <- renderText({ paste0('(2*B) + (3*C) is ', e() + f()) })",
                         "}",
                         "",
                         "shinyApp(ui, server)")),
          br(),
          p("Try running the code above, and changing the value of 'B' to 2, before closing the app. Then execute the following function:"),
          code_snippet(c("reactlog::reactlog_show()")),
          p("You will see something that very much resembles the d3 visualisation of the app's reactive graph (see 'Graphing It' on the right), but with some more information
            on names and timings. You can use the arrows in the top bar to step through each stage of reactive reasoning in much the same way."),
          tags$img(src = "img/simple_reactlog.png",
                   width = "100%"),
          br(),
          p("As mentioned above, this is a simple example and the image below shows what one small part of the reactlog looks like for a far more complex app.
            It is these situations that reactlog was designed for, to allow you to reason about what is happening at each stage of the reactive graph in your
            app."),
          br(),
          tags$img(src = "img/complex_reactlog_2.png",
                   width = "100%")
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
          p("The boxes on the left gives one way to understand reactivity. Another important concept which may help to contextualise the process is to realise that
            shiny apps use declarative rather than imperative programming."),
          tags$ul(
            tags$li(strong("Imperative programming"), "means that you tell the code to do something and it does it. For example when you
                    run", code_block("print('Hello, world')"), "you are issuing a specific command that is carried out immediately."),
            tags$li(strong("Declarative programming"), "on the other hand, involves specifying constraints and more high-level 'recipes' for
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
            which is what we'd expect based on everything we learned in the '4 Maxims' box. This is by design and another example of how shiny uses laziness to
            improve efficiency (more on this in the next tab 'Controlling reactivity')."),
          br(),
          p("Another example of designed laziness lies in a key part of shiny that often surprises people but works extremely well. It is often overlooked that",
            tags$i("shiny won't calculate an observer if it is not visible."), "This means that, by default, if your app has multiple tabs then shiny will only
            'flush' the outputs on the currently visible tab."),
          p("This drastically improves the speed of shiny apps, as there may be situations where a tab has an extremely long running output which is invlidated often,
            but if it is never viewed then it will never be calculated - meaning the rest of the app can run much faster. Note that this function of reactivity is not
            visualised in the animation below, but can easily be conceptualised as follows: at the calculation stage (e.g. Step 2) if the output G is on a hidden tab, it simply
            won't calculate and shiny will move on to the next output. This also means that any reactive expressions which are only used in G (i.e. F) won't be calculated either.
            You can see how - in a large, complex shiny app - this would make a huge difference."),
          hr(),
          p("One consequence of this designed laziness is that", tags$i(strong("reactive dependencies are dynamic"), .noWS = "outside"), ". In other words, shiny
            tries to minimise unnecessary dependencies by working out the minimum number of times it can get away with recalculating something."),
          p("Consider the two observe() calls below:"),
          code_snippet(c("observe({",
                         "    if (input$a > 1) {",
                         "        print(input$a + 5)",
                         "    } else {",
                         "        print(input$b)",
                         "    }",
                         "})",
                         "",
                         "",
                         "observe({",
                         "    a <- input$a",
                         "    b <- input$b",
                         "",
                         "    if (a > 1) {",
                         "        print(a + 5)",
                         "    } else {",
                         "        print(b)",
                         "    }",
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
          title = "Graphing It",
          status = "maroon",
          closable = TRUE,
          collapsible = TRUE,
          icon = icon("project-diagram"),
          width = NULL,
          solidHeader = TRUE,
          p("Reactive dependencies are dynamic (see box 'Laziness FTW'), but what are reactive dependencies? Well they are more or less what it says on the tin - if you
            have a variable or object which depends on a reactive value, it has a reactive dependency on that value. Take the below example:"),
          code_snippet(c("output$my_plot <- renderPlot({",
                         "    plot(runif(input$number_of_points))",
                         "})")),
          p("The my_plot output has a reactive dependency on input$number_of_points. If input$number_of_points changes, my_plot will have be to re-built"),
          p("Visualising how reactive objects and observers interact can help improve our understanding of reactivity in a shiny app, as well as provide
            a method for debugging reactivity. Consider the following trivial app:"),
          br(),
          code_snippet(c("library(shiny)",
                         "",
                         "ui <- fluidPage(",
                         "    numericInput('a', 'A', 1),",
                         "    numericInput('b', 'B', 1),",
                         "    numericInput('c', 'C', 1),",
                         "    textOutput('g'),",
                         "    textOutput('h')",
                         ")",
                         "",
                         "server <- function(input, output) {",
                         "",
                         "    d <- reactive({ input$a + input$b })",
                         "    e <- reactive({ input$b * 2 })",
                         "    f <- reactive({ input$c * 3 })",
                         "",
                         "    output$g <- renderText({ paste0('A + B is ', d()) })",
                         "    output$h <- renderText({ paste0('(2*B) + (3*C) is ', e() + f()) })",
                         "}",
                         "",
                         "shinyApp(ui, server)")),
          br(),
          p("Copy the code and run the app yourself to get an idea of what is going on. There are three reactive values (A, B and C), three reactive expressions/
            conductors (D, E and F), and two observers (G and H). If you are unsure on the difference between these three types of object, or what reactive() does
            exactly, take a look at the 'reactive() vs observe()' tab for more information."),
          br(),
          p("We can plot the reactive dependencies of our objects, in order to better understand our app and how shiny monitors each of these. The
            reactlog package was designed to do exactly this (see the box 'reactlog')."),
          p("The animation below shows what the reactive graph might look like when the graph is first initiated, and then the user changes the input 'B'. See",
            tags$a("this RStudio article, which heavily inspired the animation below.")),
          br(),
          strong("Click through the steps or click 'Play all' to cycle through the animations. The colour of a node represents its internal state: green = value is known/calculated;
                 orange = value is calculating; grey = value is invalidated (not calculated)"),
          hr(),
          r2d3::d3Output(ns("d3_reactiveGraph"),
                         height = "600px"),
          footer = h6("The animation above was created using d3.js & r2d3 (see section 3.4)")
        ), # end box


        box(
          title = "Summary",
          status = "teal",
          icon = icon("info-circle"),
          solidHeader = TRUE,
          closable = TRUE,
          collapsible = TRUE,
          width = NULL,
          p("So in summary:"),
          tags$ul(
            tags$li("R does not work on a push basis, so shiny reactivity works by frequently checking whether or not something has 
                    happened and recalculating if it has."),
            tags$li("shiny uses an alert system where reactive objects are", tags$i("invalidated"), "(indicating they have changed), 
                    which triggers a", tags$i("flush"), "(recalculation) of reactive values."),
            tags$li("Laziness is a key part of shiny's reactivity - it will figure out how to do the minimum amount of calculation possible."),
            tags$li("The reactive graph is how shiny knows what needs to be recalculated in a flush,", tags$i("reactive contexts"), "(dependencies)
                    are established between various reactive elements of an app."),
            tags$li("You can debug reactivity in your own apps by visualising the reactive graph, using the reactlog package.")
          )
        )
      ) # end column

    ) # end fluidRow
  ) # end tagList

}

#' Understanding Reactivity module server
#'
#' Defines the server logic for the Understanding Reactivity module
#'
#' @param id to be used to namespace the module
#' @param appData the appData reactiveValues object, defined in server.R and available
#' to all modules
#'
#' @return the module server, returned from a moduleServer function call
#'
#' @export
tab_understandingReactivity_server <- function(id,
                                     appData) {

  moduleServer(
    id,
    function(input,
             output,
             session,
             appData = appData) {

      # Alias the namespace function for ease of use
      ns <- session$ns


      # Reactive graph d3.js visualisation
      output$d3_reactiveGraph <- r2d3::renderD3({
        r2d3::r2d3(
          data = rjson::fromJSON(file = system.file("app/www/d3/reactive_graph_data.json", package = "advancedShiny")),
          script = system.file("app/www/d3/reactive_graph.js", package = "advancedShiny"),
          sizing = r2d3::sizingPolicy(padding = "10%")
        )
      })

    }
  )

}
