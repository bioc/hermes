test_that("draw_barplot works when there are duplicate labels in gene spec", {
  skip_on_ci()

  genes <- gene_spec(c(A = "GeneID:11185", A = "GeneID:10677"), fun = colMeans)
  result <- draw_barplot(
    hermes_data,
    assay_name = "counts",
    x_spec = genes,
    facet_var = "SEX",
    fill_var = "AGE18"
  )
  expect_class(result, "ggplot")
})