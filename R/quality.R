#' Control for Specified Quality Flags
#' 
#' @param min_cpm (`number`)\cr minimum CPM for each gene within the sample to pass.
#' @param min_readcount_prop (`proportion`)\cr minimum percentage of samples with acceptable read count of certain gene, default is 0.25.
#' @param min_corr (`proportion`)\cr minimum correlation of RNAseq results.
#' @param min_depth (`number`)\cr minimum library depth. 
#'   
#' @return List with the above criteria to flag observations.
#' 
#' @note To be used with the `add_quality_flags()` function.
#'
#' @importFrom tern is_proportion
#' @importFrom tern is_nonnegative_count
#' @export
#' 
#' @examples
#' control_quality()
#' control_quality(min_cpm = 5, min_readcount_prop = .001, min_corr = .1, min_depth = 3)
#'               
control_quality <- function(min_cpm = 1,
                            min_readcount_prop = 0.25,
                            min_corr = 0.5,
                            min_depth = NULL) {
  assert_that(
    is.number(min_cpm) && min_cpm >= 0,
    tern::is_proportion(min_readcount_prop),
    tern::is_proportion(min_corr),
    is.null(min_depth) || tern::is_nonnegative_count(min_depth)
  )  
  list(
    min_cpm = min_cpm,
    min_readcount_prop = min_readcount_prop,
    min_corr = min_corr,
    min_depth = min_depth
  )
}

#' Quality Control: Low Expression Flag
#'
#' @param object (`HermesData`) \cr input.
#' @param control (`list`) \cr list of settings used to perform the quality control procedure.
#'
#' @return A logical vector indicating whether each gene in HermesData object has low expression.
#' @export
#'
#' @importFrom edgeR cpm
#' @examples
#' object <- HermesData(summarized_experiment)
#' result <- h_low_expression_flag(object)
#' control <- control_quality(min_cpm = 5, min_readcount_prop = 0.5)
#' result <- h_low_expression_flag(object, control)
#' head(result)
#' 
h_low_expression_flag <- function(object, 
                                  control = control_quality()) {
  assert_that(
    is_hermes_data(object),
    utils.nest::is_fully_named_list(control)
  )
  cpm <- edgeR::cpm(counts(object))
  threshold_n_samples <- ceiling(ncol(cpm) * control$min_readcount_prop)
  n_samples_below_min_cpm <- rowSums(cpm <= control$min_cpm)
  n_samples_below_min_cpm > threshold_n_samples
}