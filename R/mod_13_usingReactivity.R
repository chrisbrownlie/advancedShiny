#' Using Reactivity module

#' Using Reactivity module UI
#'
#' Defines the UI for the Using Reactivity module
#'
#' @param id to be used to namespace the module
#'
#' @return the module UI, as a tagList
#'
#' @export
tab_usingReactivity_ui <- function(id) {

  ns <- NS(id)

  tagList(
    h3("Using Reactivity",
       class = "tab-title"),

    fluidRow(
      column(
        width = 12,
        box(
          title = "Values, Expressions & Observers",
          status = "navy",
          closable = TRUE,
          collapsible = TRUE,
          icon = icon("shapes"),
          width = NULL,
          solidHeader = TRUE,
          p("So far, in 'Understanding Reactivity' we gave a high-level overview of how reactivity works and the reactive graph. We
            spoke about reactive values and observers but did not go into any real detail about what these objects are and how they
            differ from each other. This will be addressed here, along with a discussion of two of the most powerful functions at the
            core of the shiny package: reactive() and observe()."),
          br(),
          p("There is some overlap and potential confusion with terminology being used, so the two points below will hopefully clarify what
            exactly these reactive objects are."),
          tags$ul(
            tags$li("All objects involved in reactivity are either reactive values, expressions or observers",
                    tags$ul(
                      tags$li("Reactive values are producers, created in response to e.g. user inputs"),
                      tags$li("Observers are consumers, which take in reactive values and provide some side effect (e.g. producing plots)"),
                      tags$li("The render*() functions are a special type of observer."),
                      tags$li("Reactive expressions are both consumers and producers (or alternatively, they are 'conductors'). They take in reactive values,
                              transform them in some way and then pass a reactive value on to other consumers. This is usually via a call to
                              reactive().")
                    )
            ),
            tags$li("As with most of the important elements of shiny, these are all implementations of R6 classes, which means they have",
                    tags$i("reference semantics", .noWS = "after"), ".",
                    tags$ul(
                      tags$li("Most objects in R have", tags$i("copy-on-modify"), "semantics, which means that as soon as you modify a
                              copy of a value, a new value is created in memory. We saw this in the previous tab (box 'Push or Pull?').
                              Consider the following example"),
                      code_snippet(c("a <- 2 # point 'a' at a value (2)",
                                     "b <- a # point 'b' to the same place as 'a' (the value of 2)",
                                     "b <- 4 # on modification the value is copied and then changed (to 4), 'b' now points at the new value so 'a' isn't affected",
                                     "print(a) # 2")),
                      tags$li("R6 classes use reference semantics, which means that the example above would now be (if R objects used
                              reference semantics):"),
                      code_snippet(c("a <- 2 # point 'a' at a value (2)",
                                     "b <- a # point 'b' to the same place as 'a' (the value of 2)",
                                     "b <- 4 # with reference semantics, b just updates the value it is pointing at (i.e. the same value 'a' is also pointing at)",
                                     "print(a) # 4")),
                      tags$li("This type of semantic is common in object-oriented programming and can be extremely useful for maintaining a global
                              state of certain objects. It gives a useful (but risky if you aren't careful) method of getting around R's lexical scoping.")
                    ))
          )
        ) #end box
      ) #end column
    ), #end fluidRow
    
    fluidRow(
      column(
        width = 6,
        box(
          title = "Reactive Values",
          status = "navy",
          closable = TRUE,
          collapsible = TRUE,
          icon = icon("pallet"),
          width = NULL,
          solidHeader = TRUE,
          p("Reactive values are pretty much what you'd expect from the name: values which can
            change over the course of a users interaction with an app."),
          p("There are two types of reactive value:",
            tags$ul(
              tags$li("A single reactive value, created by", code_block("reactiveVal()")),
              tags$li("A list of reactive values, created by", code_block("reactiveValues()"))
            ),
            "The two are interacted with slightly differently to get/set values"),
          code_snippet(c("x <- reactiveVal('something')",
                         "x('something else') # call like a function with single argument to set new value",
                         "x() # call like a function without any arguments to get its value",
                         "",
                         "",
                         "y <- reactiveValues(x = 'something')",
                         "# get and set reactiveValues like you would a list",
                         "y$x <- 10",
                         "y[['x']] <- 20",
                         "y$x",
                         "y[['x']]",
                         "# note that unlike a list, you cannot use single-bracket indexing for reactiveValues")),
          p("Despite this difference in interface, they behave exactly the same and can be used interchangeably."),
          br(),
          p("Most reactive values will come from the 'input' argument, which is essentially a reactiveValues list, with
            one key difference - it is read-only. The values in 'input' come from user interactions and so you cannot
            assign directly e.g."),
          code_snippet(c("input$my_text <- 'hello to you too'")),
          p("will cause an app to fail.")
        ),
        
        box(
          title = "Reactive Expressions",
          status = "navy",
          closable = TRUE,
          collapsible = TRUE,
          icon = icon("share-alt-square"),
          width = NULL,
          solidHeader = TRUE,
          p("Reactive expressions are those created with", code_block("reactive()"), "and have some important
            properties which are covered in more detail on the right."),
          p("Conceptually, a reactive expressions can be thought of as", tags$i("a recipe for how to calculate a variable."),
            "The code below tells shiny that 'the variable my_data can be created by taking the first n rows of the iris dataset
            and appending the last m rows'. In this example, you can imagine that n and m will be numeric inputs that the user
            can determine."),
          code_snippet(c("my_data <- reactive({",
                         "    rbind(head(iris, input$n), tail(iris, input$m))
                         })")),
          p("shiny will then identify which reactive values are needed for the recipe (n and m) and try its best to calculate that variable 
            only as much as it absolutely needs to (see 'Understanding reactivity')."),
          p("Reactive expressions are accessed in the same way as ", code_block("reactiveVal", noWS = "outside"), "'s are, by calling
            the expression as a function with no arguments. They cannot have their value be assigned because that would defeat the point
            of having a recipe."),
          code_snippet(c("my_data()"))
        ),
        
        box(
          title = "Observers",
          status = "navy",
          closable = TRUE,
          collapsible = TRUE,
          icon = icon("sitemap"),
          width = NULL,
          solidHeader = TRUE,
          p("Observers are 'terminal nodes' in the reactive graph, meaning they do not return a value (it is explicitly ignored) and instead 
            have some sort of side effect that alters the state of the app."),
          p("Observers run when they are created (i.e. when the app starts), so that shiny can determine its reactive dependencies. They are then executed
            every time any of their dependencies are invalidated."),
          p("All observers are powered by the same function: ", code_block("observe()", noWS = "outside"), "."),
          code_snippet(c("y <- reactiveVal(1)",
                         "",
                         "# no return value so not assigned to anything",
                         "observe({",
                         "    message('the value of y is', y())",
                         "})",
                         "",
                         "y(10)")),
          p("Outputs are a special type of observer, with two special properties:",
            tags$ol(
              tags$li("They are assigned to the 'output' object (e.g. ", code_block("output$my_plot <- ...", noWS = "outside"), ")"),
              tags$li("They have some ability to know whether they are visible or not (so they do not need to recalculate unless
                      they are visible (i.e. on the currently selected tab).")
            )),
          p("One very important point to note about observers is that", code_block("observe()"), "doesn't", tags$i("do"), "something, it", tags$i("creates"),
            "something. You can see this in action if you run the following code:"),
          code_snippet(c("y <- reactiveVal(2)",
                         "",
                         "observe({",
                         "    message('the value of y is ', y())",
                         "    observe({message('the value of y in here is', y())})",
                         "})",
                         "",
                         "y(3)",
                         "y(4)",
                         "y(5)"))
        )
      ), #end column
      
      column(
        width = 6,
        
        box(
          title = "reactive() vs observe()",
          status = "navy",
          closable = TRUE,
          collapsible = TRUE,
          icon = icon("angle-double-up"),
          width = NULL,
          solidHeader = TRUE,
          p("The question of when to use", code_block("reactive()"), "and when to use", code_block("observe()"), "in
            the process of building reactivity, is probably one of the most common obstacles when someone starts building
            shiny apps. It is also perhaps one of the most common mistakes made in shiny apps, mainly because it is usually",
            tags$i("possible"), "to achieve what you want to achieve with either of them, and often the two solutions will
            look on the surface as if they are identical, but one of them is always the better option."),
          p("There are", strong("two"), "important things to consider when choosing which type of expression you should use:"),
          
          h3("Eagerness"),
          p("You can see in the 'Reactive Expressions' box on the left, we've said that shiny will", tags$i("'try its best to calculate 
            that variable [i.e. reactive expression] only as much as it absolutely needs to'."), "You can also see in the 'Observers' box
            that", tags$i("observers will execute any time any of their dependencies are invalidated."), "These two sentences give you the
            first major distinction between reactive() and observe() - eagerness."),
          p("Reactive expressions, as mentioned, are", tags$i("recipes for how to calculate a variable"), "and shiny will try to execute that
            recipe as little as possible - they are", strong("'lazy'."), "This means that if you create a reactive() and never call it from anywhere, the code inside it will",
            tags$i("never be run."), "It also means that shiny will determine the fewest dependencies possible, take the following example:"),
          code_snippet(c("a <- reactiveVal(4)",
                         "b <- reactiveVal(10)",
                         "",
                         "c <- reactive({",
                         "    if (a() <= 5) {",
                         "        message('a is less than 5 and it is ', a())",
                         "    } else {",
                         "        message('a is more than 5 and b is ', b())",
                         "    }",
                         "})",
                         "",
                         "c() # a is less than 5 and it is 4",
                         "a(3)",
                         "# Now if we call c, it sees that a has changed so knows it needs to recalculate",
                         "c() # a is less than 5 and it is 3",
                         "",
                         "# But it doesn't bother 'seeing' anything else it does not know if b changes",
                         "b(12)",
                         "c() # Note there is no output because it thinks nothing has changed")),
          p("The example above integrates a second important distinction between reactive() and observe(), which is closely related to eagerness
            but slightly separate, and that is", tags$i("caching.")),
          p("In short, reactive() expressions are cached whereas observers do not return a value and so cannot be cached. What this means in practice
            is, if none of the dependencies (that shiny detects) of a reactive expression have changed, then the same value is returned and the code
            does not need to be run. The example above shows why this is important to know and is a perfect example of why", 
            strong("reactive expressions should never be used to perform side effects"), "(see below)."),
          
          h3("Side effects"),
          p("The other important consideration when choosing between", code_block("reactive()"), "and", code_block("observe()"),
            "is that of side effects."),
          p("There are two types of function in R, those that have side effects and those that don't.", 
            strong("A side effect is anything that anything that affects the world outside of the function (besides returning a value)."),
            "So for example:",
            code_snippet(c("mean(c(1,2,3)) # no side effect, simply returns a value",
                           "",
                           "write.csv(iris, 'iris.csv') # side effect of writing/creating a csv file",
                           "",
                           "function(a, b) {",
                           "    print('calculating') # this is a side effect!",
                           "    return(a+b)",
                           "}"))
          ),
          p(code_block("observe()"), "expressions", tags$i("cannot be called"), "and", tags$i("do not return a value."), "This means they are called explicitly for their side
            effects."),
          p(code_block("reactive()"), "expressions, on the other hand,", tags$i("cannot be called"), "and", tags$i("do return a value."), "This, combined with
            the point on Eagerness above, indicates why you", strong("should never use reactive() to implement a side effect")),
          p("The question of which of the two to use can be nicely boiled down to the following (courtesy of Joe Cheng):"),
          tags$ul(
            tags$li(code_block("reactive()"), "is for", strong("calculating values, without side effects.")),
            tags$li(code_block("observe()"), "is for", strong("performing actions, with side effects."))
          )
        )
        
      )
    ) # end fluidRow
  ) # end tagList

}

#' Using Reactivity module server
#'
#' Defines the server logic for the Using Reactivity module
#'
#' @param id to be used to namespace the module
#' @param appData the appData reactiveValues object, defined in server.R and available
#' to all modules
#'
#' @return the module server, returned from a moduleServer function call
#'
#' @export
tab_usingReactivity_server <- function(id,
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
