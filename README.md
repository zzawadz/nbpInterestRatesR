[![Project Status: Active - The project has reached a stable, usable
state and is being actively
developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![Travis-CI Build
Status](https://travis-ci.org/zzawadz/nbpInterestRatesR.svg?branch=master)](https://travis-ci.org/zzawadz/nbpInterestRatesR)
[![AppVeyor Build
Status](https://ci.appveyor.com/api/projects/status/github/zzawadz/nbpInterestRatesR?branch=master&svg=true)](https://ci.appveyor.com/project/zzawadz/nbpInterestRatesR)
[![Coverage
Status](https://img.shields.io/codecov/c/github/zzawadz/nbpInterestRatesR/master.svg)](https://codecov.io/github/zzawadz/nbpInterestRatesR?branch=master)

Installation:
=============

    # devtools
    devtools::install_github("zzawadz/nbpInterestRatesR")

    # Or you can use pacman:
    pacman::p_load_gh("zzawadz/nbpInterestRatesR")

Usage:
======

### Interest rates from NBP website:

    pacman::p_load_gh("zzawadz/nbpInterestRatesR")

    tail(get_nbp_interest_rates())

    ##             ref  lom  dep  red
    ## 2013-03-07 3.25 4.75 1.75 3.50
    ## 2013-05-09 3.00 4.50 1.50 3.25
    ## 2013-06-06 2.75 4.25 1.25 3.00
    ## 2013-07-04 2.50 4.00 1.00 2.75
    ## 2014-10-09 2.00 3.00 1.00 2.25
    ## 2015-03-05 1.50 2.50 0.50 1.75

    # reference rate:
    tail(get_nbp_interest_rates("ref"))

    ##             ref
    ## 2013-03-07 3.25
    ## 2013-05-09 3.00
    ## 2013-06-06 2.75
    ## 2013-07-04 2.50
    ## 2014-10-09 2.00
    ## 2015-03-05 1.50

### Maximum interest rate for loans in Poland

    tail(get_max_loan())

    ##            maxLoan
    ## 2013-05-09      18
    ## 2013-06-06      17
    ## 2013-07-04      16
    ## 2014-10-09      12
    ## 2015-03-05      10
    ## 2016-01-01      10

### Utility functions:

    # get data:
    ret = get_nbp_interest_rates()

    # Convert xts to tbl and keep the date
    tail(xts2tbl(ret))

    ## # A tibble: 6 x 5
    ##   date         ref   lom   dep   red
    ##   <date>     <dbl> <dbl> <dbl> <dbl>
    ## 1 2013-03-07  3.25  4.75 1.75   3.50
    ## 2 2013-05-09  3.00  4.50 1.50   3.25
    ## 3 2013-06-06  2.75  4.25 1.25   3.00
    ## 4 2013-07-04  2.50  4.00 1.00   2.75
    ## 5 2014-10-09  2.00  3.00 1.00   2.25
    ## 6 2015-03-05  1.50  2.50 0.500  1.75

    # expand to daily data:
    tail(expand_daily(ret))

    ##            ref lom dep  red
    ## 2018-06-08 1.5 2.5 0.5 1.75
    ## 2018-06-09 1.5 2.5 0.5 1.75
    ## 2018-06-10 1.5 2.5 0.5 1.75
    ## 2018-06-11 1.5 2.5 0.5 1.75
    ## 2018-06-12 1.5 2.5 0.5 1.75
    ## 2018-06-13 1.5 2.5 0.5 1.75
