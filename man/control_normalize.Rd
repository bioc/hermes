% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/normalization.R
\name{control_normalize}
\alias{control_normalize}
\title{Control Settings for Counts Normalization}
\usage{
control_normalize(
  log = TRUE,
  lib_sizes = NULL,
  prior_count = 1,
  fit_type = "parametric"
)
}
\arguments{
\item{log}{(\code{flag})\cr whether \code{log2} values are returned, otherwise original scale is used.}

\item{lib_sizes}{(\code{NULL} or \code{counts})\cr library sizes, if \code{NULL} the vector with the sum of the
counts for each of the samples will be used.}

\item{prior_count}{(non-negative \code{number})\cr average count to be added to each observation to
avoid taking log of zero, used only when \code{log = TRUE}.}

\item{fit_type}{(\code{string})\cr method to estimate dispersion parameters
in Negative Binomial model, used only when \code{\link[=normalize]{normalize()}} methods include \code{vst} and/or \code{rlog}.
See \code{\link[DESeq2:estimateDispersions]{estimateDispersions}} for details.}
}
\value{
List with the above settings used to perform the normalization procedure.
}
\description{
\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#stable}{\figure{lifecycle-stable.svg}{options: alt='[Stable]'}}}{\strong{[Stable]}}

This control function allows for easy customization of the normalization settings.
}
\note{
To be used with the \code{\link[=normalize]{normalize()}} function.
}
\examples{
control_normalize()
control_normalize(log = FALSE, lib_sizes = rep(1e6L, 20))
}
