#' Using CSS module

#' Using CSS module UI
#'
#' Defines the UI for the Using CSS module
#'
#' @param id to be used to namespace the module
#'
#' @return the module UI, as a tagList
#'
#' @export
tab_usingCSS_ui <- function(id) {

  ns <- NS(id)

  tagList(
    h3("Using CSS",
       class = "tab-title"),
    
    fluidRow(
      column(
        width = 6,
        box(
          title = "What is CSS?",
          status = "success",
          icon = icon("info-circle"),
          solidHeader = TRUE,
          closable = TRUE,
          collapsible = TRUE,
          width = NULL,
          
          p("In Section 1.1 'What is shiny, actually?', I described shiny as 'an R to {HTML-Javascript-CSS} translator', as
            these are the three core components of the front-end of most modern web apps. One way to decribe this triad is: HTML
            (HyperText Markup Language) provides the building blocks for your UI; Javascript determines what the building 
            blocks do and CSS (Cascading Style Sheets) determines what the blocks look
            like. This is perhaps an oversimplification (disclaimer: I am not a front-end dev or web designer!), but I think it
            gives a good practical understanding of how the three interact."),
          p("In shiny, the HTML code will mostly be generated using shiny functions such as", code_block("fluidPage()"), code_block("p()"),
            "and the various", code_block("*input()"), "and", code_block("render*()"), "functions."),
          p("The javascript in the app comes from many places, including the shiny package itself and this is discussed in 
            detail in other tabs. The CSS that comes bundled with shiny gives a generic, bland look and feel to the app so
            in order to spice things up, you must add your own CSS."),
          p("CSS can be used to specify the color, shape, size, shadow, background colour, spacing, padding and many other attributes of
            each individual element or type of element on your page."),
          br(),
          p("You can see some examples of CSS if you inspect any web app - including this one - by opening the developer tools (usually by
            right clicking and 'Inspect'). The picture below shows an example of what you might see:"),
          p("The pane on the left shows the HTML of the page and the pane on the right shows some of the styles specified by the CSS of the
            page."),
          tags$img(src = "img/html_css_inspected.png", width = "100%")
        ), #end box
        
        box(
          title = "{shinydashboard(Plus)} vs {bslib}/{thematic}",
          status = "success",
          icon = icon("info-circle"),
          solidHeader = TRUE,
          closable = TRUE,
          collapsible = TRUE,
          width = NULL,
          
          p(tags$i("Note: this box is not technically about CSS but what is discussed below is an important design choice for the developer
                   of a shiny app (as is CSS).")),
          
          p("When deciding what your app will look like, CSS gives you fine-tuned control over each object in your UI. Before you
            reach this point though there is often a key decision to be made: to dashboard or not to dashboard."),
          p("There are essentially limitless ways to structure a shiny app, as you could always even write the custom HTML to achieve
            the layout you desire, but typically (in my experience at least) it will usually boil down to whether a dashboard structure
            makes sense or not. If it does, you can make use of the", code_block("shinydashboard", T), "and", 
            code_block("shinydashboardPlus", T), "packages to speed up your development, if not you will probably use a vanilla shiny", 
            code_block("fluidPage()"), "or", code_block("navbarPage()"), "layout and have more design choices to make about how to structure
            pages and navigation etc."),
          p("To clarify, this advancedShiny app uses a dashboard layout - a header, a body (central pane) and a sidebar (navigation pane) which 
            allows you to switch between different named tabs, each one containing related information in structured boxes/sections. A 
            non-dashboard layout may consist of a single page, or multiple pages where the layout differs depending on which page is currently 
            visible, for example."),
          p("The shinydashboard package can be used (and has been used here) to get a dashboard-style look and feel to the app, providing
            functions for", code_block("dashboardPage()"), code_block("dashboardHeader()"), code_block("dashboardBody()"), "etc. Additionally
            the", code_block("shinydashboardPlus", T), "package extends this and gives more options such as closable and collapsible boxes,
            and more colours to use."),
          br(),
          p("If your app is not a dashboard layout, you can make use of the", code_block("bslib", T), "package which allows you to specify
            custom theming and use existing Bootstrap themes in your app.", code_block("bslib", T), "also makes it possible to use Bootstrap
            4 or 5, where shiny defaults to Bootstrap 3."),
          p("As", code_block("bslib", T), "is (like shiny) an RStudio package, it benefits from seamless integration with base shiny. All
            shiny's top-level layout functions (e.g. fluidPage), have a 'theme' parameter. So you can simply supply a function from bslib
            as an argument to that. Take the example below:")
          
        ) #end box
      ), #end column
      column(
        width = 6,
        box(
          title = "How to add CSS to your app",
          status = "success",
          icon = icon("info-circle"),
          solidHeader = TRUE,
          closable = TRUE,
          collapsible = TRUE,
          width = NULL
        ), #end box
        
        box(
          title = "Getting {sass}y",
          status = "success",
          icon = icon("info-circle"),
          solidHeader = TRUE,
          closable = TRUE,
          collapsible = TRUE,
          width = NULL
        ) #end box
      ) #end column
    ) #end fluidRow
  )# end tagList

}

#' Using CSS module server
#'
#' Defines the server logic for the Using CSS module
#'
#' @param id to be used to namespace the module
#' @param appData the appData reactiveValues object, defined in server.R and available
#' to all modules
#'
#' @return the module server, returned from a moduleServer function call
#'
#' @export
tab_usingCSS_server <- function(id,
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
