# top_genes ----

test_that("top_genes function works as expected for HermesData with default counts assay", {
  object <- hermes_data
  result <- expect_silent(top_genes(object))
  expect_s4_class(result, "HermesDataTopGenes")
  expect_named(result, c("expression", "name"))
  expect_identical(result@summary_fun_name, "rowMeans")
  expect_identical(result@assay_name, "counts")
})

test_that("top_genes function works as expected for HermesData with another assay", {
  object <- hermes_data
  object_norm <- expect_silent(normalize(object))
  result <- expect_silent(top_genes(object_norm, assay_name = "cpm"))
  expect_s4_class(result, "HermesDataTopGenes")
})

test_that("top_genes function works as expected for RangedHermesData", {
  object <- expect_silent(HermesData(get_rse()))
  result <- expect_silent(top_genes(object))
  expect_s4_class(result, "HermesDataTopGenes")
  expect_named(result, c("expression", "name"))
  expect_identical(result@summary_fun_name, "rowMeans")
  expect_identical(result@assay_name, "counts")
})

test_that("top_genes function fails as expected with wrong assay choice", {
  object <- expect_silent(normalize(hermes_data))
  expect_error(top_genes(object, assay_name = 1))
  expect_error(top_genes(object, assay_name = c("counts", "cpm")))
})

test_that("top_genes function fails as expected with wrong summary function", {
  object <- expect_silent(normalize(hermes_data))
  expect_error(top_genes(object, summary_fun = "rowMeans"))
  expect_error(top_genes(object, summary_fun = sum))
  expect_error(top_genes(object, summary_fun = colMeans))
})

test_that("top_genes function fails as expected with when selection criteria are incorrect", {
  object <- expect_silent(hermes_data)
  expect_error(top_genes(object, n_top = 10L, min_threshold = 10))
  expect_error(top_genes(object, n_top = NULL, min_threshold = NULL))
  expect_error(top_genes(object, n_top = 0))
  expect_error(top_genes(object, min_threshold = 0))
  expect_error(top_genes(object, min_threshold = Inf))
  expect_error(top_genes(object, min_threshold = -1))
})

test_that("top_genes function works as expected with correct selection criteria", {
  object <- expect_silent(hermes_data)

  result1 <- expect_silent(top_genes(object, n_top = 5L))
  expect_identical(nrow(result1), 5L)

  result2 <- expect_silent(top_genes(object, min_threshold = 200))
  expect_true(min(result2$expression) > 200)
  expect_false(identical(result1, result2))
})

test_that("top genes gives the names of the genes in the correct order", {
  object <- hermes_data
  result <- expect_silent(top_genes(object, n_top = 5L))
  orig_names <- rownames(object)[1:5]
  ordered_names <- as.character(result$name)
  expect_false(identical(orig_names, ordered_names))
  total_cnts <- rowSums(counts(object))
  top_5_indices <- order(total_cnts, decreasing = TRUE)[1:5]
  expected_names <- rownames(object)[top_5_indices]
  expect_identical(ordered_names, expected_names)
})

# autoplot-HermesDataTopGenes ----

test_that("autoplot for HermesDataTopGenes works as expected with default options", {
  object <- top_genes(hermes_data)
  result <- autoplot(object)

  vdiffr::expect_doppelganger("autoplot for HermesDataTopGenes with default options", result)
})

test_that("autoplot for HermesDataTopGenes works as expected with custom options", {
  object <- top_genes(hermes_data)
  result <- autoplot(object, x_lab = "genes", y_lab = "mean count", title = "bla")

  vdiffr::expect_doppelganger("autoplot for HermesDataTopGenes with custom options", result)
})
