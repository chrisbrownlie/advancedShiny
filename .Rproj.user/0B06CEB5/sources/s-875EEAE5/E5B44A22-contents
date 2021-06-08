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
