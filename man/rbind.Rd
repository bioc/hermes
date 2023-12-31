% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/HermesData-methods.R
\name{rbind}
\alias{rbind}
\title{Row Binding of \code{AnyHermesData} Objects}
\arguments{
\item{...}{(\code{AnyHermesData})\cr objects to row bind.}
}
\value{
The combined \code{\link{AnyHermesData}} object.
}
\description{
\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#stable}{\figure{lifecycle-stable.svg}{options: alt='[Stable]'}}}{\strong{[Stable]}}

This method combines \code{\link{AnyHermesData}} objects with the same samples but different
features of interest (rows in assays).
}
\note{
\itemize{
\item Note that this just inherits
\code{\link[SummarizedExperiment:SummarizedExperiment-class]{SummarizedExperiment::rbind,SummarizedExperiment-method()}}. When binding a
\code{\link{AnyHermesData}} object with a \code{\link[SummarizedExperiment:RangedSummarizedExperiment-class]{SummarizedExperiment::SummarizedExperiment}}
object, then the result will be a
\code{\link[SummarizedExperiment:RangedSummarizedExperiment-class]{SummarizedExperiment::SummarizedExperiment}} object (the more general
class).
\item Note that we need to have unique gene IDs (row names) and the same prefix
across the combined object.
}
}
\examples{
a <- hermes_data[1:2542, ]
b <- hermes_data[2543:5085, ]
result <- rbind(a, b)
class(result)
}
\seealso{
\code{\link{cbind}} to column bind objects.
}
