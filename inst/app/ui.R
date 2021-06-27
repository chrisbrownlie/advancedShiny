## Using shinydashboard structure

# Chore: convert the Sass styling sheet to CSS so it can be called in dashboardBody below
sass::sass(
  sass::sass_file(system.file("app/www/styling.scss", package = "advancedShiny")),
  output = system.file("app/www/styling.css", package = "advancedShiny")
)

# Header definition
header <- shinydashboard::dashboardHeader(title = "R Shiny")

# Sidebar definition
sidebar <- shinydashboard::dashboardSidebar(
  shinydashboard::sidebarMenu(

    shinydashboard::menuItem(
      "About this app",
      tabName = "0_about_this_app"
    ),

    # Section 1 'How Shiny Works'
    shinydashboard::menuItem(
      "1 - How shiny works",
      startExpanded = TRUE,

      shinydashboard::menuSubItem(
        "1.1 - What is shiny, actually?",
        tabName = "1_1_what_is_shiny"
      ),

      shinydashboard::menuSubItem(
        "1.2 - Understanding reactivity",
        tabName = "1_2_understanding_reactivity"
        ),

      shinydashboard::menuSubItem(
        "1.3 - Using reactivity",
        tabName = "1_3_using_reactivity"
        ),

      shinydashboard::menuSubItem(
        "1.4 - Controlling reactivity",
        tabName = "1_4_controlling_reactivity"
        ),

      shinydashboard::menuSubItem(
        "1.5 - Structuring an app",
        tabName = "1_5_structuring_an_app"
        ),

      shinydashboard::menuSubItem(
        "1.6 - Shiny modules",
        tabName = "1_6_shiny_modules"
        )
      ),

    # Section 2 'Making it pretty'
    shinydashboard::menuItem(
      "2 - Making it pretty",
      startExpanded = TRUE,

      shinydashboard::menuSubItem(
        "2.1 - Improving UI with CSS",
        tabName = "2_1_improving_ui_with_css"
      ),

      shinydashboard::menuSubItem(
        "2.2 - Improving UX with JS",
        tabName = "2_2_improving_ux_with_js"
      ),

      shinydashboard::menuSubItem(
        "2.3 - The attali-verse",
        tabName = "2_3_the_attali_verse"
      ),

      shinydashboard::menuSubItem(
        "2.4 - Extending shiny",
        tabName = "2_4_extending_shiny"
      ),

      shinydashboard::menuSubItem(
        "2.5 - Custom shiny inputs",
        tabName = "2_5_custom_shiny_inputs"
      )
    ),

    # Section 3 'Improvements & Graphics'
    shinydashboard::menuItem(
      "3 - Improvements & Graphics",
      startExpanded = TRUE,

      shinydashboard::menuSubItem(
        "3.1 - The session object",
        tabName = "3_1_the_session_object"
      ),

      shinydashboard::menuSubItem(
        "3.2 - Tracking usage",
        tabName = "3_2_tracking_usage"
      ),

      shinydashboard::menuSubItem(
        "3.3 - Advanced viz 1 (plotly)",
        tabName = "3_3_advanced_vis_1_plotly"
      ),

      shinydashboard::menuSubItem(
        "3.4 - Advanced viz 2 (r2d3)",
        tabName = "3_4_advanced_vis_2_r2d3"
      ),

      shinydashboard::menuSubItem(
        "3.5 - Error handling & debugging",
        tabName = "3_5_error_handling_and_debugging"
      ),

      shinydashboard::menuSubItem(
        "3.6 - Optimisation",
        tabName = "3_6_optimisation"
      )
    ),

    # References & Materials
    shinydashboard::menuItem(
      "References & Further Materials",
      tabName = "4_references"
    )

  )
)

# Body definition
body <- shinydashboard::dashboardBody(

  tags$head(

    # Include custom CSS
    tags$link(href = "styling.css", rel = "stylesheet", type = "text/css"),
  ),

  # Use custom dashboard theme designed using fresh (see R/fct_themes.R)
  fresh::use_theme(get_shinydashboard_theme()),

  # Include clipboard.js for copying code snippets
  tags$script(src = "clipboard.min.js"),
  tags$script(src = "initiate_clipboard.js"),

  # Call each module UI which will contain the definition for each tab
  shinydashboard::tabItems(


    # Section 0 - the landing page
    shinydashboard::tabItem(
      "0_about_this_app",
      tab_info_ui("info")
    ),

    # Section 1 - How Shiny Works
    shinydashboard::tabItem(
      "1_1_what_is_shiny",
      tab_whatIsShiny_ui("whatIsShiny")
    ),

    shinydashboard::tabItem(
      "1_2_understanding_reactivity",
      tab_understandingReactivity_ui("understandingReactivity")
    ),

    shinydashboard::tabItem(
      "1_3_using_reactivity",
      tab_usingReactivity_ui("usingReactivity")
    ),

    shinydashboard::tabItem(
      "1_4_controlling_reactivity",
      tab_controllingReactivity_ui("controllingReactivity")
    ),

    shinydashboard::tabItem(
      "1_5_structuring_an_app",
      tab_appStructure_ui("appStructure")
    ),

    shinydashboard::tabItem(
      "1_6_shiny_modules",
      tab_shinyModules_ui("shinyModules")
    ),


    # Section 2 - Making it pretty
    shinydashboard::tabItem(
      "2_1_improving_ui_with_css",
      tab_usingCSS_ui("usingCSS")
    ),

    shinydashboard::tabItem(
      "2_2_improving_ux_with_js",
      tab_usingJS_ui("usingJS")
    ),

    shinydashboard::tabItem(
      "2_3_the_attali_verse",
      tab_attaliverse_ui("attaliverse")
    ),

    shinydashboard::tabItem(
      "2_4_extending_shiny",
      tab_extendingShiny_ui("extendingShiny")
    ),

    shinydashboard::tabItem(
      "2_5_custom_shiny_inputs",
      tab_customInputs_ui("customInputs")
    ),

    # Section 3 - Improvements & Analytics
    shinydashboard::tabItem(
      "3_1_the_session_object",
      tab_sessionObject_ui("sessionObject")
    ),

    shinydashboard::tabItem(
      "3_2_tracking_usage",
      tab_trackingUsage_ui("trackingUsage")
    ),

    shinydashboard::tabItem(
      "3_3_advanced_vis_1_plotly",
      tab_visualisationPlotly_ui("visualisationPlotly")
    ),

    shinydashboard::tabItem(
      "3_4_advanced_vis_2_r2d3",
      tab_visualisationR2D3_ui("visualisationR2D3")
    ),

    shinydashboard::tabItem(
      "3_5_error_handling_and_debugging",
      tab_errorHandling_ui("errorHandling")
    ),

    shinydashboard::tabItem(
      "3_6_optimisation",
      tab_optimisation_ui("optimisation")
    ),

    shinydashboard::tabItem(
      "4_references",
      tab_references_ui("references")
    )


  )

)


#' Combine elements to create UI
ui <- shinydashboardPlus::dashboardPage(title = "Intermediate & Advanced R Shiny",
                                        header = header,
                                        sidebar = sidebar,
                                        body = body)
