% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/graphs.R
\name{draw_libsize_qq}
\alias{draw_libsize_qq}
\title{Q-Q Plot of Library Sizes}
\usage{
draw_libsize_qq(object, color = "grey", linetype = "dashed")
}
\arguments{
\item{object}{(\code{AnyHermesData})\cr input.}

\item{color}{(\code{string})\cr color of Q-Q line.}

\item{linetype}{(\code{string})\cr line type of  Q-Q line.}
}
\value{
The \code{ggplot} object with the Q-Q Plot.
}
\description{
\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#experimental}{\figure{lifecycle-experimental.svg}{options: alt='[Experimental]'}}}{\strong{[Experimental]}}

This creates a Q-Q plot of the library sizes of the \link{AnyHermesData} object.
}
\examples{
result <- hermes_data
draw_libsize_qq(result)
draw_libsize_qq(result, color = "blue", linetype = "solid")

# We can also add sample names as labels.
library(ggrepel)
draw_libsize_qq(result) + geom_text_repel(label = colnames(result), stat = "qq")
}
