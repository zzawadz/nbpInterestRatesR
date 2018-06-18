[![Project Status: Active - The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![Travis-CI Build
Status](https://travis-ci.org/zzawadz/nbpir.svg?branch=master)](https://travis-ci.org/zzawadz/nbpir)
[![AppVeyor Build
Status](https://ci.appveyor.com/api/projects/status/github/zzawadz/nbpir?branch=master&svg=true)](https://ci.appveyor.com/project/zzawadz/nbpir)
[![Coverage
Status](https://img.shields.io/codecov/c/github/zzawadz/nbpir/master.svg)](https://codecov.io/github/zzawadz/nbpir?branch=master)

Installation:
=============

    # devtools
    devtools::install_github("zzawadz/nbpir")

    # Or you can use pacman:
    pacman::p_load_gh("zzawadz/nbpir")

Usage:
======

### Interest rates from NBP website:

    pacman::p_load_gh("zzawadz/nbpir")

    tail(nbp_interest_rates())

    ##               ref    lom    dep    red
    ## 2013-03-07 0.0325 0.0475 0.0175 0.0350
    ## 2013-05-09 0.0300 0.0450 0.0150 0.0325
    ## 2013-06-06 0.0275 0.0425 0.0125 0.0300
    ## 2013-07-04 0.0250 0.0400 0.0100 0.0275
    ## 2014-10-09 0.0200 0.0300 0.0100 0.0225
    ## 2015-03-05 0.0150 0.0250 0.0050 0.0175

    # reference rate:
    tail(nbp_interest_rates("ref"))

    ##               ref
    ## 2013-03-07 0.0325
    ## 2013-05-09 0.0300
    ## 2013-06-06 0.0275
    ## 2013-07-04 0.0250
    ## 2014-10-09 0.0200
    ## 2015-03-05 0.0150

### Maximum interest rate for loans in Poland

    tail(nbp_max_loan())

    ##            maxLoan
    ## 2013-05-09    0.18
    ## 2013-06-06    0.17
    ## 2013-07-04    0.16
    ## 2014-10-09    0.12
    ## 2015-03-05    0.10
    ## 2016-01-01    7.03

### Utility functions:

    # get data:
    ret = nbp_interest_rates()

    # Convert xts to tbl and keep the date
    tail(nbp_xts2tbl(ret))

    ## # A tibble: 6 x 5
    ##   date          ref    lom     dep    red
    ##   <date>      <dbl>  <dbl>   <dbl>  <dbl>
    ## 1 2013-03-07 0.0325 0.0475 0.0175  0.0350
    ## 2 2013-05-09 0.0300 0.0450 0.0150  0.0325
    ## 3 2013-06-06 0.0275 0.0425 0.0125  0.0300
    ## 4 2013-07-04 0.0250 0.0400 0.0100  0.0275
    ## 5 2014-10-09 0.0200 0.0300 0.0100  0.0225
    ## 6 2015-03-05 0.0150 0.0250 0.00500 0.0175

    # expand to daily data:
    tail(nbp_expand_daily(ret))

    ##              ref   lom   dep    red
    ## 2018-06-13 0.015 0.025 0.005 0.0175
    ## 2018-06-14 0.015 0.025 0.005 0.0175
    ## 2018-06-15 0.015 0.025 0.005 0.0175
    ## 2018-06-16 0.015 0.025 0.005 0.0175
    ## 2018-06-17 0.015 0.025 0.005 0.0175
    ## 2018-06-18 0.015 0.025 0.005 0.0175
