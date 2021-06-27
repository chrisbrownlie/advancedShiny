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
        width = 4,
        box(
          title = "Reactive Values",
          status = "navy",
          closable = TRUE,
          collapsible = TRUE,
          icon = icon("pallet"),
          width = NULL,
          solidHeader = TRUE
        ),
        
        box(
          title = "Reactive Expressions",
          status = "navy",
          closable = TRUE,
          collapsible = TRUE,
          icon = icon("share-alt-square"),
          width = NULL,
          solidHeader = TRUE
        ),
        
        box(
          title = "Observers",
          status = "navy",
          closable = TRUE,
          collapsible = TRUE,
          icon = icon("sitemap"),
          width = NULL,
          solidHeader = TRUE
        )
      ), #end column
      
      column(
        width = 8,
        
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
          p("{covered briefly in Laziness FTW, expand more}"),
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
