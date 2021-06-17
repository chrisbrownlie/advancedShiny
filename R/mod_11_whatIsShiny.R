#' What Is Shiny? module

#' What Is Shiny? module UI
#'
#' Defines the UI for the What Is Shiny? module
#'
#' @param id to be used to namespace the module
#'
#' @return the module UI, as a tagList
#'
#' @importFrom shinydashboardPlus box
#'
#' @export
tab_whatIsShiny_ui <- function(id) {

  ns <- NS(id)

  tagList(
    h3("What Is Shiny?",
       class = "tab-title"),
    fluidRow(
      column(
        width = 4,
        box(
          title = "The Basics",
          icon = icon("font"),
          status = "info",
          solidHeader = TRUE,
          closable = TRUE,
          collapsible = TRUE,
          width = NULL,
          p("As you are probably aware, shiny is an R package which allows you to build web applications.
          Although the term 'web application' seems fairly straightforward, it is worth being clear about
            what this means."),
          p("Websites are, at their simplest, a set of files on a computer, which have been made available
          for other computers to view. They are static, follow certain protocols and always look the same
          unless the underlying files are explicitly changed.
          A web app, on the other hand, is a full computer program (application) which can be accessed through a web browser.
          The benefits of this mean that web apps are far more flexible and dynamic, responding to user actions and rendering
            pages 'on the fly'. The vast majority of what we call 'websites' are in fact web apps (Google, Facebook etc.)."),
          p("The front end of most web apps are developed using HTML, Javascript and CSS, as these are supported by pretty
          much all web browsers. So the short answer to 'What is shiny?', is '", tags$i(strong("an R to {HTML-Javascript-CSS} translator", .noWS = "outside"), .noWS = "outside"), "'.
          The magic of being able to write R code which gets transformed into a web app written in a completely different language,
            is what makes shiny so powerful.")
          ),
        box(
          title = "A Team Effort (Frameworks)",
          icon = icon("object-ungroup"),
          status = "info",
          solidHeader = TRUE,
          closable = TRUE,
          collapsible = TRUE,
          width = NULL,
          p("As well as the package dependencies you can see on the right, shiny also relies on two other frameworks, Bootstrap and jQuery."),

          p(a("Bootstrap", href = "https://getbootstrap.com/"), "is an 'open source, front-end toolkit' (written in HTML, CSS and Javascript), which lets you build responsive user interfaces quickly
          and easily. The Bootstrap repository is the one of the top-10 most starred on Github, which gives some indication as to its popularity. One of the most
          common layouts for shiny apps uses the", code_block("fluidPage()"), ",", code_block("fluidRow()"), ", and", code_block("column()"), " functions. All of these -
            along with many other shiny UI functions - are simply layered on top of a Bootstrap function (e.g.", code_block("fluidPage()"), " is analogous
            to Bootstrap's", code_block("bootstrapPage()"), "function."),

          p(a("jQuery", href = "https://jquery.com/"), "is a javascript package which allows interaction with HTML elements of a webpage, with simpler syntax than pure javascript. This is used to power
            much of the interactive elements you see in shiny. These are implemented with javascript and jQuery was used to make this process easier."),

          p("You can try this for yourself by running a basic shiny app using the code below: "),

          code_snippet(c("library(shiny)",
                         "",
                         "ui <- fluidPage(p('Hello, world'))",
                         "",
                         "server <- function(input, output) { }",
                         "",
                         "shinyApp(ui, server)")),

          p("Upon loading the app, open your browsers development tools (on Google Chrome, right click and click 'Inspect'). This will show you the HTML code that
            shiny has generated for your app. If you open up the header element you can see the dependencies being used (see below), which are:"),
          tags$ol(
            tags$li("jQuery"),
            tags$li("shiny (the custom css and javascript elements included in the package)"),
            tags$li("Bootstrap 3")
          ),
          tags$img(src = "img/shiny_dependencies.png",
                   width = "100%")
          ),

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
            tags$li("What shiny does, at its simplest, is translate R code to HTML (and JS and CSS)"),
            tags$li("A shiny app uses functionality from 25 other packages too, each addressing their own specific problem"),
            tags$li("The most important of these are httpuv, htmltools and jsonlite"),
            tags$li("shiny also relies on Bootstrap and jQuery as a minimum")
          )
        )
        ), #end column1-4

      column(
        width = 8,

        box(
          title = "A Team Effort (R Packages)",
          icon = icon("users"),
          status = "info",
          solidHeader = TRUE,
          closable = TRUE,
          collapsible = TRUE,
          width = NULL,
          p("When you install and use shiny, you are in fact using a collection of separate, interlinked R packages which
            has shiny at its core. Below you can see which packages are currently imported by shiny and what they do,
            arranged very roughly (and subjectively) in order of significance/usefulness:"),
          tags$ul(
            tags$li(code_block("httpuv", T),
                    tags$ul(
                      tags$li("Arguably the most important package dependency in terms of how shiny actually works"),
                      tags$li("Designed to be used as a 'building block' for R package web frameworks, of which", code_block("shiny", T), "is the most popular (but not the only, e.g.",
                              code_block("ambriorix", T), "and", code_block("fiery", T)),
                      tags$li("Can initiate a web server in R that can handle HTTP requests and open a websocket (connection between the users computer and the server)"),
                      tags$li("Essentially does all the heavy lifting when it comes to", tags$i("communication between the client (user) and server"))
                    )
            ),

            tags$li(code_block("htmltools", T),
                    tags$ul(
                      tags$li("Perhaps the second most important package for how shiny works, this is used to convert R code into HTML"),
                      tags$li("If httpuv is the core of a shiny app's server, htmltools is the core of a shiny app's UI")
                    )
            ),

            tags$li(code_block("jsonlite", T),
                    tags$ul(
                      tags$li("If httpuv is the core of the server and htmltools is essential in creating the UI, jsonlite is the magician behind interactivity in shiny apps"),
                      tags$li("Or rather, javascript is the magician but the only way for R and javascript to communicate is via JSON, which is generated in R using jsonlite"),
                      tags$li("R and Javascript communicate via websockets (see the box below 'The app process') and jsonlite allows this to happen")
                    )),

            tags$li(code_block("R6", T),
                    tags$ul(
                      tags$li("Package for building classes and implementing object-oriented programming in R"),
                      tags$li("An alternative to built in Reference Classes (RC) in R. R6 is simpler and more efficient so was preferred for shiny"),
                      tags$li("Most of the fundamental R objects underlying a shiny app are R6 classes (the reactive log, reactive environment, shiny session etc.)")
                    )
            ),

            tags$li(code_block("cachem", T),
                    tags$ul(
                      tags$li("Enables storing of key-value pairs in an on-memory or on-disk cache"),
                      tags$li("Automatically prunes to make sure memory usage doesn't get too high"),
                      tags$li("Outputs of reactive objects (e.g. plots) are cached, so that they don't update periodically when inputs remain the same
                              (explained more in the next section 'the reactive graph')")
                    )
            ),

            tags$li(code_block("digest", T),
                    tags$ul(
                      tags$li("Contains one main function -", code_block("digest::digest()"), "- which creates a cryptographical hash of any R object"),
                      tags$li("This was used whenever a unique ID needs to be assigned to something, e.g. when a user uploads a file the temporary filename is constructed using digest"),
                      tags$li("Was used to create keys for objects stored in the cache using", code_block("cachem", T)),
                      tags$li("In the latest (unreleased) version of shiny (v1.6.0.900), this has been replaced by", code_block("rlang::hash()"), "which does the same thing.",
                              code_block("rlang", T), "is an RStudio package, whereas", code_block("digest", T), "is not.")
                      )
            ),

            tags$li(code_block("rlang", T), ": a sort of translation package for base R and tidy R. Contains functions for tidy evaluation and improvements on base object types"),

            tags$li(code_block("bslib", T), ": the most recently added dependency, allows usage of Bootstrap 4 (and soon 5) in shiny apps"),

            tags$li(code_block("later", T), ": used to execute code after a set amount of time (e.g. the", code_block("invalidateLater()"), "function. Crucially it allows time-specific
                              delays which do not block R from completing other tasks."),

            tags$li(code_block("promises", T), ": a package for asynchronous programming in R. Since shiny v1.1.0, support was added to reactive elements to allow using promises to speed up apps"),

            tags$li(code_block("fastmap", T), ": an efficiency package, which makes some small improvements to storage of data structures to address the problem of memory leakage that R suffers from"),

            tags$li(code_block("commonmark", T), ": used to convert markdown to other formats like HTML and LaTeX, powers the", code_block("shiny::markdown()"), "function"),

            tags$li(code_block("mime", T), ": used to infer a filetype (MIME type) from an extension (i.e. when a user uploads a file)"),

            tags$li(code_block("withr", T), ": a useful package that helps working with functions that have side effect. Includes helpers which mean you can run functions and be sure they will never affect the global environment"),

            tags$li(code_block("crayon", T), ": for outputting messages with coloured, formatted code."),

            tags$li(code_block("glue", T), ": package for concatenating and working with strings"),

            tags$li(code_block("xtable", T), ": used to render tables with", code_block("renderTable()")),

            tags$li(code_block("sourcetools", T), ": fast reading and parsing of R code, comparable to readr."),

            tags$li(code_block("commonmark", T), ": used to convert markdown to other formats like HTML and LaTeX, powers the", code_block("shiny::markdown()"), "function"),

            tags$li(code_block("ellipsis", T), ": used for checking arguments that have been supplied to functions with the ellipsis. E.g. ensure ellipsis arguments are unused if they are just
                              included 'for future expansion'"),

            tags$li(code_block("grDevices", T), ": base R package that allows for controlling of multiple graphics 'devices' - used for rendering plots with", code_block("renderPlot()")),

            tags$li(code_block("lifecyle", T), ": used to indicate function lifecycles (e.g. 'experimental', 'maturing', 'deprecated')"),

            tags$li(code_block("methods", T), ",", code_block("utils", T), ",", code_block("tools", T), ": base R packages that respectively: enable S3 and S4 classes;
                    enable various utility functions; and provide tools for package development.")


          )
        ), # end box

        box(
          title = "The Lifecycle of a Shiny App",
          icon = icon("heartbeat"),
          status = "info",
          solidHeader = TRUE,
          closable = TRUE,
          collapsible = TRUE,
          width = NULL,
          p("So what actually happens when you run", code_block("runApp()", noWS = "after"), "? In other words, if you have a deployed shiny
            app and someone opens it up (which causes runApp() to be executed), what happens? Well, the following things happen:"),
          tags$ol(
            tags$li(code_block("shiny::shinyApp()"), "is called, which returns a shiny app object composed of a server function and the UI.
                    The UI has to be formatted to be a function returning an HTTP response, as requested by httpuv."),
            tags$li(code_block("shiny::startApp()"), "is called, which creates HTTP and websocket (WS) handlers.",
                    tags$ul(
                      tags$li("To make shiny interactive, R must be able to talk to Javascript and this can be done with traditional HTTP requests."),
                      tags$li("However, with a traditional HTTP request model: a connection is opened; the client sends a request; this is processed by the server and a
                      response returned;", tags$i("and then the connection is closed."), "This is inefficient for this R-JS communication, where there could be
                              hundreds if not thousands of actions to be executed in the course of an app session (and therefore hundreds of connections opened and closed)."),
                      tags$li("Websockets are an advanced solution to this which allow what is essentially a secure, constant, bi-directional connection between a client and server (Javascript and R)."),
                      tags$li("This means that over the course of an app session, R and Javascript can communicate quickly and efficiently, passing messages as JSON (which is a format both languages understand)."),
                      tags$li("The websocket handlers created in this step are responsible for controlling the websocket behaviour after the app starts."),
                      tags$li("This step is necessary to allow communication between R and JS.")
                    )
            ),
            tags$li(code_block("httpuv::startServer()"), "is called, which starts the HTTP server and opens the websocket connection."),
            tags$li("If the R code does not contain errors, the server returns the Shiny UI HTML code to the client (user)."),
            tags$li("The HTML code is received and interpreted by the client web browser."),
            tags$li("The HTML page is rendered. It is an exact mirror of the initially provided ui.R code"),
            tags$li("Any interactivity in the app is executed by communications between R and Javascript, formatted as JSON and passed via the
                    established websocket.")
          )
        ) # end box
      ) #end column5-12
    ) #end fluidRow
  ) #end tagList

}

#' What Is Shiny? module server
#'
#' Defines the server logic for the What Is Shiny? module
#'
#' @param id to be used to namespace the module
#' @param appData the appData reactiveValues object, defined in server.R and available
#' to all modules
#'
#' @return the module server, returned from a moduleServer function call
#'
#' @export
tab_whatIsShiny_server <- function(id,
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
