#' App Structure module

#' App Structure module UI
#'
#' Defines the UI for the App Structure module
#'
#' @param id to be used to namespace the module
#'
#' @return the module UI, as a tagList
#'
#' @export
tab_appStructure_ui <- function(id) {

  ns <- NS(id)

  tagList(
    h3("App Structure",
       class = "tab-title"),
    
    fluidRow(
      
      column(
        width = 4,
        
        box(
          title = "Disclaimer",
          solidHeader = TRUE,
          width = NULL,
          closable = FALSE,
          collapsible = TRUE,
          icon = icon("exclamation"),
          status = "warning",
          
          p("This tab will give you some ideas and tips on how to structure an R Shiny app. The suggestions
            here are not absolute rules and the approach outlined is an opinionated one - feel free to pick
            the bits you like and ignore the bits you don't."),
          p("Some key aspects of this structure have been chosen specifically with a complex shiny project in mind,
            so if you are only building a very simple app many of the suggestions may not apply. That said, it won't
            hurt to follow the guidelines here so that you are well prepared if your project does grow unexpectedly 
            (as they often tend to!)."),
          p("This tab will make reference to", tags$i("shiny modules"), "as they are an important part of the
            recommended workflow set out in the following two tabs. See section 1.6 for more info about them if
            you aren't familiar."),
          p("The package containing this very app follows the framework set out in this tab and the following one.
            Feel free to check out the code to see an example of it in action!")
        )
      ),
      column(
        width = 8,
        
        
        box(
          title = "Package it up",
          solidHeader = TRUE,
          width = NULL,
          closable = TRUE,
          collapsible = TRUE,
          icon = icon("box"),
          status = "teal",
          
          p("The first piece of advice is: structure your project as an R package. There are many reasons for doing this,
            namely:"),
          tags$ul(
            tags$li("A logical folder structure and separation of R code from other objects"),
            tags$li("Easier management of dependencies and sharing your app"),
            tags$li("Forces you to make everything a function, which has loads of benefits, like making it easier to implement testing and QA"),
            tags$li("Conceptually your app becomes a single contained entity rather than a project which combines a shiny app with a set
                    of additional R scripts (a slightly more abstract point but to me this is very important!)")
          ),
          p("The best way to create an R package is beyond the scope of this app, but there are some links in the References & Further Materials
            section which cover creating an R package. If you're a DfE colleague, there was also previously a C&C talk covering exactly this, presented by
            Mr Jacob Scott (link here).")
          
        )
      )
    ), # end fluidRow
    
    fluidRow(
      column(
        width = 12,
        
        
        box(
          title = "Everything has a home",
          solidHeader = TRUE,
          width = NULL,
          closable = TRUE,
          collapsible = TRUE,
          icon = icon("sun"),
          status = "teal",
          p("Below you can see how a shiny project might be structured in practice. The text in italics gives a brief description of each element."),
          p(tags$b("Blue boxes represent folders and can be clicked to expand and see contents. Black boxes represent individual files.")),
          treantOutput(ns("package_directory_vis"),
                       height = "200%"),
          footer = "This interactive graph is a htmlwidget built into the advancedShiny package 
          using the Treant javascript package. See section 2.4 'Extending shiny' for more details."
        )
      )
    ),
    
    fluidRow(
      column(
        width = 6,
        
        box(
          title = "A rose by any other name",
          solidHeader = TRUE,
          width = NULL,
          closable = TRUE,
          collapsible = TRUE,
          icon = icon("signature"),
          status = "teal",
          
          p("The naming conventions in the R/ folder above are largely inspired by those proposed in the
            golem R package framework. They assume that you are a) structuring your app as a package and b)
            are using shiny modules throughout your app."),
          p("The rules for the naming convention proposed here are as follows:"),
          tags$ul(
            tags$li("All modules (in the case of e.g. a shiny dashboard these are likely to each correspond to a tab)
                    are numbered in order of where they are in the app and given a short name. For example, if the first
                    tab in your app is an info tab, you would define the module UI and server in the 'mod_01_info.R' script."),
            tags$li("All functions are defined in scripts which are named for the module the function is used in. For example,
                    if in your info module, you have a series of functions for importing data, these would be defined in
                    'mod_01_info_fct_importData.R'. This makes it immediately clear that the script contains functions for
                    importing data and that those functions are used in the info module."),
            tags$li("Any functions which are either not used in a module, or are used in multiple modules and it doesn't
                    make sense to associate them with a single module, can use the same naming conventions but without
                    the module prefix. For example, if the import data functions from above where used in various modules
                    they could be kept in a script named 'fct_importData.R' instead."),
            tags$li("Any utility functions (simple/helper functions that do not perform important business logic and are potentially
                    optional) go in scripts prefixed with 'utils_'. For example, you may have some functions for formatting text like
                    e.g. as_money(). These could go in utils_formatting.R."),
            tags$li("Your app UI and app server go in app_ui.R and app_server.R respectively.")
          ),
          
          p("To see this in action, you can view the", tags$a("source code for this very package.", href = "https://github.com/chrisbrownlie/advancedShiny"),
            "As mentioned in the disclaimer above, this is just one opinionated way of structuring and naming an app, so feel free to 
            take what works for you and ignore what doesn't. What is most important is that others can understand your
            structure and easily navigate your code.")
        ),
        
        box(
          title = "DfE-Specific",
          status = "teal",
          icon = icon("building"),
          solidHeader = TRUE,
          closable = TRUE,
          collapsible = TRUE,
          width = NULL,
          p("There are a few final points to bear in mind if you are a DfE colleague and the app you are developing
            as a package is to be deployed to our internal RStudio Connect servers."),
          h4("Deployment Pipeline"),
          p("Our deployment pipeline determines the content you are deploying based on the contents of your project. This 
            means that if your root folder doesn't contain either an app.R file or ui.R & server.R files, the deployment
            will fail as it will not recognise that you are deploying a shiny app. To get around this, include an app.R
            file that calls a function from your package. This function must return a shiny app as an object. The easiest
            way to do this is to use", code_block("shiny::shinyAppDir()"), "in your run_app() function, so it might look
            like this:"),
          code_snippet(c("run_app <- function() {",
                         "    if (interactive()) {",
                         "        # interactive()=TRUE when function is run from the console",
                         "",
                         "        shiny::runApp(appDir = system.file('app', package = 'myPackage'))",
                         "    } else {",
                         "        # interactive()=FALSE when being sourced (i.e. when deployed)",
                         "",
                         "        shiny::shinyAppDir(appDir = system.file('app', package = 'myPackage'))",
                         "    }",
                         "}")),
          p("and your app.R file should look like this:"),
          code_snippet(c("pkgload::load_all() # roughly equivalent to library(myPackage)",
                         "myPackage::run_app()")),
          
          h4("Dependencies"),
          p("As with any app that is deployed to our RSConnect servers, it must be dependency-managed using", code_block("renv", T), ". Contrastingly,
            R packages manage dependencies using roxygen documentation and a DESCRIPTION file."),
          p("This can cause some confusion and issues when deploying apps to RSConnect, but as long as you keep on top of both methods you should be fine. When you want
            to use a package in your app's functions, you must:"),
          tags$ol(
            tags$li("Import that package somewhere in your roxygen comments with @import, @importFrom or @rawNamespace, and/or specify it in your code directly with [package]::"),
            tags$li("Add the package to your package's DESCRIPTION file, under Depends or Imports"),
            tags$li("Run devtools::document()"),
            tags$li("Add the package to your renv lockfile (i.e by installing the package and running renv::snapshot()")
          )
        )
        
      ),

      column(
        width = 6,
        
        box(
          title = "Sharing is caring",
          solidHeader = TRUE,
          width = NULL,
          closable = TRUE,
          collapsible = TRUE,
          icon = icon("gifts"),
          status = "teal",
          
          p("As has been mentioned elsewhere on this tab, it is highly recommended that you use shiny modules to
            partition your app into logical, manageable chunks. This is covered in more detail in the next tab,
            but for those who already know about modules and have used them before, this box will cover something
            that can cause issues if you don't have a plan in place to deal with it - sharing data between modules.
            This is being addressed here because although it largely relates to modules, it is a design choice to
            be made when structuring your app and the method proposed here is again opinionated so feel free to
            ignore it or come up with your own solution."),
          p(tags$i("If you have not used modules before, check the next section and then return here!")),
          p("Sharing data between modules can become tricky when working with reactive values, because although
            you can pass reactive arguments to modules and return reactive objects, it quickly becomes difficult to
            understand how and why values are updating in some modules and not others."),
          p("The solution proposed here makes use of the fact that a) reactiveValues() lists are R6 objects and b)
            this means they use reference semantics and are not copy-on-modify."),
          p("What this means is that when you create a reactiveValues list and then pass it as an argument to a
            module, the module simply receives a pointer to that reactive list in memory, rather than a separate copy
            of it. So if you have a single reactiveValues list with all your important app data in, you can just
            pass this list to each module and they will all be immediately aware of changes to the list, regardless
            of where the change originates from."),
          p("In practice, I would suggest you always specify a reactiveValues list called e.g. app_data in your app server
            function, and then pass it as an argument to each module. This list can then be used to store anything which
            might be required by multiple modules e.g. datasets, information about the user/session, theme/colour options
            that the user can change etc.")
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
            tags$li("Structure your app as an R package"),
            tags$li("Use shiny modules (see next tab)"),
            tags$li("Use a consistent naming convention that distinguishes between the different core components of your app"),
            tags$li("Use reactiveValues to share data between modules")
          )
        )
      ) # end column
    ) # end fluidRow
  ) # end tagList

}

#' App Structure module server
#'
#' Defines the server logic for the App Structure module
#'
#' @param id to be used to namespace the module
#' @param appData the appData reactiveValues object, defined in server.R and available
#' to all modules
#'
#' @return the module server, returned from a moduleServer function call
#'
#' @export
tab_appStructure_server <- function(id,
                                    appData) {

  moduleServer(
    id,
    function(input,
             output,
             session,
             appData = appData) {

      # Alias the namespace function for ease of use
      ns <- session$ns
      
      # Visualise package structure
      package_structure <- node(
        "myPackage/",
        "Your package's root directory",
        collapsed = TRUE,
        list(
          node("R/", 
               "Folder containing the definitions of all R functions for your package",
               collapsed = TRUE,
               list(
                 node("app_server.R and app_ui.R",
                      "Contain the server and UI of your app respectively",
                      HTMLclass = "treant-node-script"),
                 node("run_app.R",
                      "Contains a run_app() function, that launches the shiny app by default, or optionally returns a shiny.appobj 
                      object instead (see DfE-Specific below for why this is important)",
                      HTMLclass = "treant-node-script"),
                 node("fun_***.R", 
                      "All scripts starting fun_*** contain important functions for your app",
                      HTMLclass = "treant-node-script"),
                 node("mod_***.R",
                      "All scripts starting mod_*** each contain a module for your app (See section 1.6 for more info)",
                      HTMLclass = "treant-node-script"),
                 node("utils_***.R",
                      "All scripts starting utils_*** contain utility function which don't perform any 'business logic'",
                      HTMLclass = "treant-node-script"),
                 node("widget_***.R",
                      "All scripts starting with widget_*** each define an htmlwidget",
                      HTMLclass = "treant-node-script")
               )
          ),
          node("inst/",
               "Folder containing the app itself and anything that needs to be accessible to functions",
               collapsed = TRUE,
               list(
                 node("app/",
                      "Folder containing your app",
                      collapsed = TRUE,
                      list(
                        node("ui.R",
                             "Script which calls mypackage::app_ui()",
                             HTMLclass = "treant-node-script"),
                        node("server.R",
                             "Script which calls mypackage::app_server()",
                             HTMLclass = "treant-node-script"),
                        node("global.R",
                             "The global script for your app",
                             HTMLclass = "treant-node-script"),
                        node("www/",
                             "Folder containing anything that needs to be accessible from your app e.g. images, css stylesheet, custom javascript function etc.",
                             collapsed = TRUE,
                             list(
                               node("img/",
                                    "Images used in your app"),
                               node("js/",
                                    "Javascript used in your app"),
                               node("css/",
                                    "Stylesheets used in your app"),
                               node("gif/",
                                    "Gifs and videos used in your app")
                             ))
                      )),
                 node("htmlwidgets/",
                      "Folder containing any widgets"),
                 node("static/",
                      "Folder containing anything that is used in the package outside of the app (e.g. images in the README)"),
                 node("extdata/",
                      "(Optional) Folder containing any static external data like excel/csv files or example datasets"),
                 node("sql/",
                      "(Optional) Folder containing any sql scripts relevant to the app/package")
               )
          ),
          node("man/",
               "Folder containing documenation automatically created by roxygen"),
          node("tests/",
               "Folder containing all tests for your package and app",
               collapsed = TRUE,
               list(
                 node("testthat/",
                      "Folder for testthat unit tests"),
                 node("shinytest/",
                      "Folder for shinytest app tests")
               )),
          node("NAMESPACE",
               "File automatically created with roxygen",
               HTMLclass = "treant-node-script"),
          node("DESCRIPTION",
               "File containing the name, description and dependencies of your package",
               HTMLclass = "treant-node-script"),
          node("README.md",
               "File containing information about the project, and the package including how to get started",
               HTMLclass = "treant-node-script"),
          node("NEWS.md",
               "(Optional) File containing info on what changes with each subsequent version of the package",
               HTMLclass = "treant-node-script"),
          node("TODO.md",
               "(Optional) File containing a list of tasks to do",
               HTMLclass = "treant-node-script")
        )
      )
      output$package_directory_vis <- renderTreant({
        treant(package_structure)
      })

    }
  )

}
