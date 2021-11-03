#' treant htmlwidget
#'
#' interface to the Treant javascript package
#' 
#' @param structure a list of lists denoting the structure of the tree to be built
#'
#' @export
treant <- function(structure, width = NULL, height = NULL) {

  # forward options using x
  x = list(
    chart = list(
      container = "",
      rootOrientation = "NORTH",
      nodeAlign = "BOTTOM",
      connectors = list(
        type = "step"
      ),
      node = list(
        HTMLclass = "treant-node",
        collapsable = TRUE
      )
    ),
    
    nodeStructure = structure
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'treant',
    x,
    width = width,
    height = height,
    package = 'advancedShiny'
  )
}

#' Define treant tree node
#' 
#' Helper function for defining tree structure, helps
#' to create trees/nodes with less code
#' 
#' @param name the name of the node
#' @param desc the description of the node
#' @param children a list of children nodes
#' 
#' @export
node <- function(name, desc, children = NULL, ...) {
  list(
    text = list(name = name,
                desc = desc),
    ...,
    children = children
  )
}

#' Shiny bindings for treant
#'
#' Output and render functions for using treant within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a treant
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name treant-shiny
#'
#' @export
treantOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'treant', width, height, package = 'advancedShiny')
}

#' @rdname treant-shiny
#' @export
renderTreant <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, treantOutput, env, quoted = TRUE)
}
