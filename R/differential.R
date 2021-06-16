#' Limma/Voom Differential Expression Analysis
#'
#' This helper functions performs the differential expression analysis with the `voom`
#' method from the `limma` package (via [limma::voom()], [limma::lmFit()] and [limma::eBayes()])
#' for given counts in a [AnyHermesData] object and a corresponding `design` matrix.
#'
#' @param object (`AnyHermesData`)\cr input.
#' @param design (`matrix`)\cr design matrix.
#' @return A data frame with columns `log2_fc` (estimated log2 fold change),
#'   `stat` (moderated t-statistic), `p_val` (raw p-value), `adj_p_pval` (Benjamini-Hochberg 
#'   adjusted p-value).
#' 
#' @importFrom limma voom lmFit eBayes topTable
#' @export
#' 
#' @references 
#' \insertRef{limma_package}{hermes}
#' 
#' \insertRef{voom_method}{hermes}
#' 
#' @examples 
#' object <- HermesData(summarized_experiment)
#' design <- model.matrix(~ SEX, colData(object))
#' result <- h_diff_expr_voom(object, design)
#' head(result)
#' 
h_diff_expr_voom <- function(object, design) {
  assert_that(
    is_hermes_data(object),
    is.matrix(design),
    identical(dim(design), c(ncol(object), 2L))
  )
  voom_counts <- limma::voom(counts(object))
  lm_fit <- limma::lmFit(voom_counts, design)
  eb_stats <- limma::eBayes(lm_fit)
  top_tab <- limma::topTable(
    eb_stats, 
    coef = 2L, 
    number = Inf,  # Retain all genes.
    adjust.method = "BH",
    sort.by = "p"  # Sort by p-value.
  ) 
  with(
    top_tab,
    data.frame(
      log2_fc = logFC,
      stat = t,
      p_val = P.Value,
      adj_p_val = adj.P.Val,
      row.names = rownames(top_tab)
    )
  )
}

#' DESeq2 Differential Expression Analysis
#'
#' This helper functions performs the differential expression analysis with
#' [DESeq2::DESeq()] for a given [AnyHermesData] input and `design` matrix.
#'
#' @param object (`HermesData`)\cr input.
#' @param design (`matrix`)\cr design matrix.
#' @return A data frame with columns `log2_fc` (estimated log2 fold change),
#'   `stat` (Wald statistic), `p_val` (raw p-value), `adj_p_pval` (Benjamini-Hochberg adjusted p-value).
#' 
#' @importFrom DESeq2 DESeqDataSet DESeq results
#' @export
#' 
#' @references 
#' \insertRef{DESeq2_package}{hermes}
#' 
#' @examples
#' object <- HermesData(summarized_experiment)
#' design <- model.matrix(~ SEX, colData(object))
#' result <- h_diff_expr_deseq2(object, design)
#' head(result)
#' 
h_diff_expr_deseq2 <- function(object, design) {
  assert_that(
    is_hermes_data(object),
    is.matrix(design),
    identical(dim(design), c(ncol(object), 2L))
  )
  deseq_data <- DESeq2::DESeqDataSet(se = object, design = design)
  deseq_data_processed <- DESeq2::DESeq(deseq_data, quiet = TRUE)
  deseq_data_res <- DESeq2::results(deseq_data_processed)
  deseq_data_res_df <- as.data.frame(deseq_data_res)
  adj_pval_order <- order(deseq_data_res_df$padj)
  deseq_data_res_df_sorted <- deseq_data_res_df[adj_pval_order, ]
  with(
    deseq_data_res_df_sorted,
    data.frame(
      log2_fc = log2FoldChange,
      stat = stat,
      p_val = pvalue,
      adj_p_val = padj,
      row.names = rownames(deseq_data_res_df_sorted)
    )
  )
}