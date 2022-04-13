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
      class = "tab-title"
    ),
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
          p(
            "In shiny, the HTML code will mostly be generated using shiny functions such as", code_block("fluidPage()"), code_block("p()"),
            "and the various", code_block("*input()"), "and", code_block("render*()"), "functions."
          ),
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
        ), # end box

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
          p(
            "There are essentially limitless ways to structure a shiny app, as you could always even write the custom HTML to achieve
            the layout you desire, but typically (in my experience at least) it will usually boil down to whether a dashboard structure
            makes sense or not. If it does, you can make use of the", code_block("shinydashboard", T), "and",
            code_block("shinydashboardPlus", T), "packages to speed up your development, if not you will probably use a vanilla shiny",
            code_block("fluidPage()"), "or", code_block("navbarPage()"), "layout and have more design choices to make about how to structure
            pages and navigation etc."
          ),
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
            as an argument to that. Take the example app below (adapted from an RStudio example app):"),
          code_snippet(c(
            "library(shiny)",
            "",
            "ui <- navbarPage('Navbar!',",
            "                 tabPanel('Plot',",
            "                          sidebarLayout(",
            "                            sidebarPanel(",
            "                              radioButtons('plotType', 'Plot type',",
            "                                           c('Scatter'='p', 'Line'='l')",
            "                              )",
            "                            ),",
            "                            mainPanel(",
            "                              plotOutput('plot')",
            "                            )",
            "                          )",
            "                 ),",
            "                 tabPanel('Summary'),",
            "                 navbarMenu('More')",
            ")",
            "",
            "server <- function(input, output, session) {",
            "  ",
            "  output$plot <- renderPlot({",
            "    plot(cars, type=input$plotType)",
            "  })",
            "  ",
            "}",
            "",
            "shinyApp(ui, server)"
          )),
          p("This app has the basic shiny styling (see sample below):"),
          tags$img(src = "img/simple_app_notheme.png",
                   width = "100%"),
          p("But by using", code_block("bslib", T), "you can change the look and feel with just one line of code,
            added to the", code_block("navbarPage()"), "call:"),
          code_snippet(c(
            "...",
            "ui <- navbarPage('Navbar!',",
            "                 theme = bslib::bs_theme(bootswatch = 'lux') # add theme",
            "                 tabPanel('Plot',",
            "                          ..."
          )),
          p("Resulting in app that looks slightly more appealing:"),
          tags$img(src = "img/simple_app_luxtheme.png",
                   width = "100%"),
          p("Admittedly, in this example app the changes aren't radical (mostly just the font, some colouring and 
            the behaviour of the navbar buttons), but for more complex apps you can see how powerful it would be 
            to overhaul the general look and feel with a single line of code."),
          p("Additionally, you specify your own custom theme with the various arguments to", code_block("bs_theme()"),
            "as opposed to a pre-made bootswatch theme (like the example above). If you choose this route you have far 
            more control and can even adjust your theme using a real time editor via the", code_block("bs_themer()"), 
            "function.")
        ) # end box
      ), # end column
      column(
        width = 6,
        box(
          title = "How to add CSS to your app",
          status = "success",
          icon = icon("info-circle"),
          solidHeader = TRUE,
          closable = TRUE,
          collapsible = TRUE,
          width = NULL,
          p("There are three main ways you can add custom styles to your app. This tutorial will not cover CSS syntax, but will assume
            you have a working knowledge of how to style HTML elements using CSS."),
          h4("1. Separate CSS file"),
          p("This is the best way to add custom CSS to your app. It involves keeping all your styling contained into a single file
            or collection of files, away from the logic of your app. It also makes it far easier to maintain consistent styles across
            your entire app. To include a file in your app, you should store it in the www/ folder (see 1.5 - Structuring an app)."),
          p("Assuming you have created a CSS file called 'styles.css' and stored it in your www/ folder, you then simply need to add
            the following code to your UI:"),
          code_snippet(c("tags$head(tags$link(href = 'styles.css', rel = 'stylesheet', type = 'text/css'))")),
          p("This will make any styles available to your app."),
          hr(),
          h4("Per-element styling"),
          p("A quicker but far more messy way to style an element is to include it directly, using the 'style' argument to the element (
            where it is available). For example, it can be used on a 'div' to style everything within it:"),
          code_snippet(c("tags$div(",
                         "    style = 'font-size:40px; font-weight:bold;',",
                         "    p('This text will be large and bold')",
                         ")")),
          p("Alternatively, you can include class definitions using", code_block("tags$style()"), ", e.g.:"),
          code_snippet(c("tags$style('",
                       "    .blue-stuff {",
                       "        color: blue;",
                       "    }",
                       "    ",
                       "    .red-stuff {",
                       "        color: red;",
                       "    }'",
                       ")")),
          hr(),
          h4("Dynamically add CSS"),
          p("This is rarer and should only be used in specific cases, but the shinyjs package can be used to add a class to an object
            after the app has been launched. See example below (using tags$style() css from above):"),
          code_snippet(c("ui <- fluidPage(",
                         "    shinyjs::useShinyjs(),",
                         "    tags$style('",
                         "        .blue-stuff {",
                         "            color: blue;",
                         "        }",
                         "        ",
                         "        .red-stuff {",
                         "            color: red;",
                         "        }'",
                         "    ),",
                         "    p('This is the text', id = 'my-text'),",
                         "    actionButton('red', 'Make red'),",
                         "    actionButton('blue', 'Make blue')",
                         ")",
                         "",
                         "server <- function(input, output) {",
                         "    observeEvent(input$red, {",
                         "        shinyjs::removeClass(id = 'my-text', class = 'blue-stuff')",
                         "        shinyjs::addClass(id = 'my-text', class = 'red-stuff')",
                         "    })",
                         "    observeEvent(input$blue, {",
                         "        shinyjs::removeClass(id = 'my-text', class = 'red-stuff')",
                         "        shinyjs::addClass(id = 'my-text', class = 'blue-stuff')",
                         "    })",
                         "}",
                         "",
                         "shinyApp(ui = ui, server = server)"))
        ), # end box

        box(
          title = "Getting {sass}y",
          status = "success",
          icon = icon("info-circle"),
          solidHeader = TRUE,
          closable = TRUE,
          collapsible = TRUE,
          width = NULL,
          
          p("Once you have mastered adding CSS to your app, you can begin to make use of SASS (Syntactically
            Awesome Style Sheets) - a CSS extension language described as 'CSS with superpowers'. All SASS is, 
            is a way to make managing large/complex CSS sheets easier, by adding various useful things such as:
            allowing you to set variables, nest your styles and use partial styles (among other things). SASS
            then generates the final CSS stylesheet automatically. Helpfully, there is an R package allowing you 
            to make use of SASS in your shiny apps with almost no additional effort required - the package is called", 
            code_block("sass", T)),
          p("View the code at the top of the app_ui() function for this package to get an idea of how to use", 
            code_block("sass", T), "in this proposed workflow.")
        ) # end box
      ) # end column
    ) # end fluidRow
  ) # end tagList
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
