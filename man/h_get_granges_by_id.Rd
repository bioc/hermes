% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/connections.R
\name{h_get_granges_by_id}
\alias{h_get_granges_by_id}
\title{Conversion of \code{BioMart} Coordinates into \code{GRanges}}
\usage{
h_get_granges_by_id(coords, id)
}
\arguments{
\item{coords}{(\code{data.frame})\cr as returned by \code{biomaRt::getBM()}, containing the columns
\code{ensembl_gene_id}, \code{chromosome_name}, \code{exon_chrom_start}, \code{exon_chrom_end}.}

\item{id}{(\code{string})\cr single \code{Ensembl} gene ID to convert the coordinates for.}
}
\value{
\code{GRange} objects for the respective single gene ID.
}
\description{
\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#experimental}{\figure{lifecycle-experimental.svg}{options: alt='[Experimental]'}}}{\strong{[Experimental]}}

This function extracts the chromosome number, the start position and the end position of transcripts
in given \code{data.frame} with coordinates as returned by \code{biomaRt::getBM()} and converts
them to a \code{GRanges} object.
}
\examples{
if (interactive()) {
  mart <- biomaRt::useMart("ensembl", dataset = "hsapiens_gene_ensembl")
  attrs <- c(
    "ensembl_gene_id",
    "ensembl_exon_id",
    "chromosome_name",
    "exon_chrom_start",
    "exon_chrom_end"
  )
  coords <- biomaRt::getBM(
    filters = "entrezgene_id",
    attributes = attrs,
    values = c("11185", "10677"),
    mart = mart
  )
  h_get_granges_by_id(coords, "ENSG00000135407")
}
}
