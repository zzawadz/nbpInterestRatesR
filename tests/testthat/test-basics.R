context("Basics")

test_that("Get NBP interest rates",
{
  x = get_nbp_interest_rates()
  expect_s3_class(x, "xts")

})

test_that("Get max loan interest rate",
{
  x = get_max_loan()
  expect_s3_class(x, "xts")
})

test_that("Get max loan interest rate",
{
  x = get_nbp_interest_rates()
  expect_error(expand_daily(x, "1998-01-01"))
})


