% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/functions.R
\name{nbp_expand_daily}
\alias{nbp_expand_daily}
\title{Expand xts do daily periodicity.}
\usage{
nbp_expand_daily(x, enddate = "today")
}
\arguments{
\item{x}{xts object}

\item{enddate}{last date.}
}
\value{
xts
}
\description{
Expand xts do daily periodicity.
}
\examples{

x = nbp_interest_rates()
tail(nbp_expand_daily(x))

}
