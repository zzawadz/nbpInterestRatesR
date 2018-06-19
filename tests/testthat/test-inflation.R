context("Inflation")

path <- nbp_inflation_download(tempfile(fileext = ".xls"))

test_that("NPB inflation monthly",
{
  m1 <- nbp_read_inflation(path)
  m2 <- nbp_read_inflation(path, type = "corresponding")

  expect_equal(m1["2001-01-01"][[1]], 100.788)
  expect_true(compare(m1["2001-01-01"][1,"TrimmedMean"][[1]], 100.406676046, tolerance = 0.00001)$equal)

  expect_equal(m2["2001-01-01"][[1]], 107.399)
  expect_true(compare(m2["2001-01-01"][1,"TrimmedMean"][[1]], 107.365310581, tolerance = 0.00001)$equal)
})

test_that("NPB inflation quarterly",
{
  m1 <- nbp_read_inflation(path, interval = "quarterly")
  m2 <- nbp_read_inflation(path, type = "corresponding", interval = "quarterly")

  expect_true(compare(m1["2001-03-31"][1,"CPI"][[1]], 101.371, tolerance = 0.00001)$equal)
  expect_true(compare(m1["2001-03-31"][1,"TrimmedMean"][[1]], 100.911854719196, tolerance = 0.00001)$equal)

  expect_true(compare(m2["2001-03-31"][1,"CPI"][[1]], 106.744, tolerance = 0.00001)$equal)
  expect_true(compare(m2["2001-03-31"][1,"TrimmedMean"][[1]], 107.064773959893, tolerance = 0.00001)$equal)
})

test_that("NPB inflation annual",
{
  m1 <- nbp_read_inflation(path, interval = "annual")
  m2 <- nbp_read_inflation(path, type = "corresponding", interval = "annual")

  expect_true(compare(m1["2001-12-31"][1,"CPI"][[1]], 105.475112416926, tolerance = 0.00001)$equal)
  expect_true(compare(m1["2001-12-31"][1,"TrimmedMean"][[1]], 105.611091681996, tolerance = 0.00001)$equal)

  expect_true(compare(m2["2001-12-31"][1,"CPI"][[1]], 105.475112416926, tolerance = 0.00001)$equal)
  expect_true(compare(m2["2001-12-31"][1,"TrimmedMean"][[1]], 105.611091681996, tolerance = 0.00001)$equal)
})

