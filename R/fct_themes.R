#' Custom shinydashboard theme
#'
#' Customise some visual elements of the dashboard using the *fresh* package.
#' This function returns a theme which is passed to use_theme, in the dashboardBody
#' element of the UI.
#'
#' @return a shinydashboard theme created using fresh::create_theme
#'
#' @export
get_shinydashboard_theme <- function() {

  fresh::create_theme(
    fresh::adminlte_color(
      light_blue = "#434C5E"
    ),
    fresh::adminlte_sidebar(
      width = "300px"
    ),
    fresh::adminlte_global(
      content_bg = "#FFF",
      box_bg = "#D8DEE9",
      info_box_bg = "#D8DEE9"
    )
  )

}
