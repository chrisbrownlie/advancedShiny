% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fct_code.R
\name{code_snippet}
\alias{code_snippet}
\title{Include code snippets}
\usage{
code_snippet(vec)
}
\arguments{
\item{vec}{a character vector of code (one element per line) to be shown}
}
\value{
a HTML string which can be inserted directly into the UI of the app, showing the
code as a formatted snippet along with a 'Copy' button
}
\description{
Generate formatted markdown with a copy to clipboard button to allow users to
copy code to their clipboard.
}
