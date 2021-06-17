#' Include code snippets
#'
#' Generate formatted markdown with a copy to clipboard button to allow users to
#' copy code to their clipboard.
#'
#' @param vec a character vector of code (one element per line) to be shown
#'
#' @return a HTML string which can be inserted directly into the UI of the app, showing the
#' code as a formatted snippet along with a 'Copy' button
#'
#' @export
code_snippet <- function(vec) {
  HTML(
    paste0('<pre><code class="language-r" style="float:left;">',
         paste(vec, collapse = "\n"),
         '</code>',
         '<button id="codesnip" type="button" style="float:right;" class="btn btn-default action-button" data-clipboard-text="', paste(vec, collapse = "&#10;"), '">
         <i class="fa fa-clipboard" role="presentation" aria-label="clipboard icon"></i>
         Copy
         </button>
         </pre>')
  )
}


#' Render code i.e. package (or function) name
#'
#' Renders either a package name (as italics and formatted as code) or a function (formatted as code),
#' optionally include a link
#'
#' @param code the text to be formatted
#' @param pkg logical, if TRUE the output text will be italicised (representing a package name). If FALSE it
#' won't be italicised (representing a function name or arbitrary R code).
#' @param href optional link to include
#'
#' @return a HTML string which can be inserted directly into the UI of the app, showing the
#' code as formatted, (potentially) clickable text
#'
#' @import htmltools
#'
#' @export
code_block <- function(string,
                       pkg = FALSE,
                       href = NULL,
                       noWS = NULL) {
  if (length(href)) {
    if(pkg) {
      tags$a(tags$i(tags$code(string)), href = href, .noWS = noWS)
    } else {
      tags$a(tags$code(string), href = href, .noWS = noWS)
    }
  } else {
    if (pkg) {
      tags$i(tags$code(string), .noWS = noWS)
    } else {
      tags$code(string, .noWS = noWS)
    }
  }
}
