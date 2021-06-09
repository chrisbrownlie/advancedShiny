#' Run the app
#'
#' Initiate an instance of the 'Intermediate & Advanced Shiny' app. If the current context is interactive,
#' (i.e. if the function is called from RStudio), this function will initiate the app stored in
#' inst/app with the runApp function. If the context is not interactive (i.e. the project is being sourced in RStudio
#' Connect after having been deployed), then the function will return a shiny.appobj object, using the function
#' shinyAppDir. This distinction is necessary to allow the app to be deployed.
#'
#' Note: an alias function 'l' is also provided to speed up workflow (after making changes, load them with 'Ctrl+Shift+L',
#' then launch the app with 'l()')
#'
#' @return either run the app as a side effect or return a shiny.appobj object
#'
#' @importFrom shiny runApp shinyAppDir
#'
#' @export
run_IAS_app <- function() {

  if (interactive()) {

    runApp(appDir = system.file("app",
                                package = "advancedShiny"))

  } else {

    shinyAppDir(appDir = system.file("app",
                                     package = "advancedShiny"))

  }

}

#' @export
l <- run_IAS_app
