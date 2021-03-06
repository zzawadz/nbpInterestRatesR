% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/functions.R
\name{nbp_max_loan}
\alias{nbp_max_loan}
\title{Maximum interest rates for loans in Poland}
\usage{
nbp_max_loan()
}
\value{
This function returns a time series in xts format with values of maximum interest rate for loans in Poland.
}
\description{
Get time series with the maximum interest rates for loans in Poland.
}
\details{
Before 2016-01-01 maximum interest rate for loans in Poland was defined as a 4 * lombard rate. After that date it is defined as a 2 * reference rate + 3.5.
}
\examples{

tail(nbp_max_loan())

}
