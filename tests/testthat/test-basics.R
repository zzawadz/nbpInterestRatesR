context("Basics")

test_that("Get NBP interest rates",
{
  x = nbp_interest_rates()
  expect_s3_class(x, "xts")

})

test_that("Get max loan interest rate",
{
  x = nbp_max_loan()
  expect_s3_class(x, "xts")
})

test_that("Get max loan interest rate",
{
  x = nbp_interest_rates()
  expect_error(nbp_expand_daily(x, "1998-01-01"))

  expect_s3_class(nbp_expand_daily(x), "xts")
})

test_that("Expand to dataframe",
{
  x = nbp_interest_rates()

  xx = nbp_xts2tbl(x)
  expect_equal(class(xx[["date"]]),"Date")
})
