# App server
server <- function(input, output, session) {

  # Create a reactiveValues object to act as the app's data store. This will
  # be passed to all modules. It is a reactiveValues object so any changes will
  # instantly be visible to all modules. It has the same uses as the session$userData
  # environment, but this method is preferred as it is more explicit.
  appData <- reactiveValues()


  # Call the module server for each tab
  tab_info_server("info",
                  appData = appData)

  # Section 1 - How shiny works
  tab_whatIsShiny_server("whatIsShiny",
                         appData = appData)

  tab_reactiveGraph_server("reactiveGraph",
                           appData = appData)

  tab_controllingReactivity_server("controllingReactivity",
                                   appData = appData)

  tab_reactiveObjects_server("reactiveObjects",
                             appData = appData)

  tab_appStructure_server("appStructure",
                          appData = appData)

  tab_shinyModules_server("shinyModules",
                          appData = appData)

  # Section 2 - Making it pretty
  tab_usingCSS_server("usingCSS",
                      appData = appData)

  tab_usingJS_server("usingJS",
                     appData = appData)

  tab_attaliverse_server("attaliverse",
                         appData = appData)

  tab_extendingShiny_server("extendingShiny",
                            appData = appData)

  tab_customInputs_server("customInputs",
                          appData = appData)

  # Section 3 - Improvements & Analytics
  tab_sessionObject_server("sessionObject",
                           appData = appData)

  tab_trackingUsage_server("trackingUsage",
                           appData = appData)

  tab_visualisationPlotly_server("visualisationPlotly",
                                 appData = appData)

  tab_visualisationR2D3_server("visualisationR2D3",
                               appData = appData)

  tab_errorHandling_server("errorHandling",
                           appData = appData)

  tab_optimisation_server("optimisation",
                          appData = appData)

  # Section 4 - References
  tab_references_server("references",
                        appData = appData)

}
