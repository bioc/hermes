% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/draw_scatterplot.R
\name{draw_scatterplot}
\alias{draw_scatterplot}
\title{Scatterplot for Gene Expression Values}
\usage{
draw_scatterplot(
  object,
  assay_name,
  x_spec,
  y_spec,
  color_var = NULL,
  facet_var = NULL,
  smooth_method = c("lm", "loess", "none")
)
}
\arguments{
\item{object}{(\code{AnyHermesData})\cr input.}

\item{assay_name}{(\code{string})\cr selects assay from input.}

\item{x_spec}{(\code{GeneSpec})\cr gene specification for the x-axis.}

\item{y_spec}{(\code{GeneSpec})\cr gene specification for the y-axis.}

\item{color_var}{(\code{string} or \code{NULL})\cr optional color variable, taken
from input sample variables.}

\item{facet_var}{(\code{string} or \code{NULL})\cr optional faceting variable, taken
from input sample variables.}

\item{smooth_method}{(\code{string})\cr smoothing method to use, either linear
regression line (\code{lm}), local polynomial regression (\code{loess}) or \code{none}.}
}
\value{
The \code{ggplot} scatterplot.
}
\description{
\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#experimental}{\figure{lifecycle-experimental.svg}{options: alt='[Experimental]'}}}{\strong{[Experimental]}}

This produces a scatterplot of two genes or gene signatures.
}
\examples{
object <- hermes_data
g <- genes(object)

draw_scatterplot(
  object,
  assay_name = "counts",
  facet_var = NULL,
  x_spec = gene_spec(c(A = g[1])),
  y_spec = gene_spec(g[2]),
  color = "RACE"
)

object2 <- object \%>\%
  add_quality_flags() \%>\%
  filter() \%>\%
  normalize()
g2 <- genes(object2)

draw_scatterplot(
  object2,
  assay_name = "tpm",
  facet_var = "SEX",
  x_spec = gene_spec(g2[1:10], colMeans, "Mean"),
  y_spec = gene_spec(g2[11:20], colMedians, "Median"),
  smooth_method = "loess"
)
}
