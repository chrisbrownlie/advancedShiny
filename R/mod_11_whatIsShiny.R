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
          title = "The basics",
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
          A web app, on the other hand, is a full computer programm (application) which can be accessed through a web browser.
          The benefits of this mean that web apps are far more flexible and dynamic, responding to user actions and rendering
            pages 'on the fly'. The vast majority of what we call 'websites' are in fact web apps (Google, Facebook etc.)."),
          p("The front end of most web apps are developed using HTML, Javascript and CSS, as these are supported by pretty
          much all web browsers. So the short answer to 'What is shiny?', is '", tags$i("an R to 'HTML-Javascript-CSS' translator"), "'.
          The magic of being able to write R code which gets transformed into a web app written in a completely different language,
            is what makes shiny so powerful.")
          )
        ),
      column(
        width = 8,

        box(
          title = "A team effort",
          status = "info",
          solidHeader = TRUE,
          closable = TRUE,
          collapsible = TRUE,
          width = NULL,
          p("When you install and use shiny, you are in fact using a collection of separate, interlinked R packages which
            has shiny at its core. Below you can see what these packages are and what they do, arranged very roughly (and subjectively) in order of significance"),
          tags$ul(
            tags$li(code_block("httpuv", T),
                    tags$ul(
                      tags$li("Arguably the most important package dependency in terms of how shiny actually works - designed to be used as a 'building block' for other packages (like shiny) which enable you to build web applications"),
                      tags$li("Can initiate a web server in R that can handle HTTP requests and open a websocket (connection between the users computer and the server)"),
                      tags$li("Essentially does all the heavy lifting when it comes to", tags$i("communication between the client (user) and server"))
                    )
            ),

            tags$li(code_block("htmltools", T, href = "https://github.com/rstudio/htmltools"),
                    tags$ul(
                      tags$li("Perhaps the second most important package for how shiny works, is used to convert R code into HTML"),
                      tags$li("If httpuv is the core of a shiny app's server, htmltools is the core of a shiny app's UI")
                    )
            ),

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
                      tags$li("This is used whenever a unique ID needs to be assigned to something, e.g. when a user uploads a file the temporary filename is constructed using digest"),
                      tags$li("Used to create keys for objects stored in the cache using", code_block("cachem", T))
                      )
            ),


            tags$li(code_block("commonmark", T), "- used to convert markdown to other formats like HTML and LaTeX, powers the", code_block("shiny::markdown()"), "function"),

            tags$li(code_block("lifecyle", T), ": used to indicate function lifecycles (e.g. 'experimental', 'maturing', 'deprecated')"),

            tags$li(code_block("mime", T), ": used to infer a filetype (MIME type) from an extension (i.e. when a user uploads a file)"),

            tags$li(code_block("later", T), ": used to execute code after a set amount of time (e.g. the", code_block("invalidateLater()"), "function. Crucially it allows time-specific
                              delays which do not block R from completing other tasks."),

            tags$li(code_block("sourcetools", T), ": fast reading and parsing of R code, comparable to readr."),

            tags$li(code_block("ellipsis", T), ": used for checking arguments that have been supplied to functions with the ellipsis. E.g. ensure ellipsis arguments are unused if they are just
                              included 'for future expansion'"),

            tags$li(code_block("xtable", T), ": used to render tables with", code_block("renderTable()")),

            tags$li(code_block("grDevices", T), ": base R package that allows for controlling of multiple graphics 'devices' - used for rendering plots with", code_block("renderPlot()")),

            tags$li(code_block("methods", T), ",", code_block("utils", T), ",", code_block("tools", T), ": base R packages that respectively: enable S3 and S4 classes;
                    enable various utility functions; and provide tools for package development."),

            tags$li(code_block("jsonlite", T)),
            tags$li(code_block("promises", T)),
            tags$li(code_block("crayon", T)),
            tags$li(code_block("rlang", T)),
            tags$li(code_block("fastmap", T)),
            tags$li(code_block("withr", T)),
            tags$li(code_block("glue", T)),
            tags$li(code_block("bslib", T))


          )
        ) # end Box
      ) #end column
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
