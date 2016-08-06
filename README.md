

[![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![Travis-CI Build Status](https://travis-ci.org/zzawadz/nbpInterestRatesR.svg?branch=master)](https://travis-ci.org/zzawadz/nbpInterestRatesR)

# Installation:


```r
# devtools
devtools::install_github("zzawadz/nbpInterestRatesR")

# Or you can use pacman:
pacman::p_load_gh("zzawadz/nbpInterestRatesR")
```

# Usage:

### Interest rates from NBP website:


```r
pacman::p_load_gh("zzawadz/nbpInterestRatesR")
options(max.print = 20)

get_interest_rates()
```

```
##              ref   lom  dep   red
## 1998-02-26 24.00 27.00   NA 24.50
## 1998-04-23 23.00 27.00   NA 24.50
## 1998-05-21 21.50 26.00   NA 23.50
## 1998-07-17 19.00 24.00   NA 21.50
## 1998-09-10 18.00 24.00   NA 21.50
##  [ reached getOption("max.print") -- omitted 68 rows ]
```

```r
options(max.print = 5)
# reference rate:
get_interest_rates("ref")
```

```
##              ref
## 1998-02-26 24.00
## 1998-04-23 23.00
## 1998-05-21 21.50
## 1998-07-17 19.00
## 1998-09-10 18.00
##  [ reached getOption("max.print") -- omitted 68 rows ]
```

### Maximum interest rate for loans in Poland


```r
options(max.print = 5)
get_max_loan()
```

```
##            maxLoan
## 1998-02-26     108
## 1998-04-23     108
## 1998-05-21     104
## 1998-07-17      96
## 1998-09-10      96
##  [ reached getOption("max.print") -- omitted 69 rows ]
```

### Utility functions:


```r
options(max.print = 30)

# get data:
ret = get_interest_rates()

# Convert xts to tbl and keep the date
xts2tbl(ret)
```

```
## # A tibble: 73 x 5
##          date   ref   lom   dep   red
##        <date> <dbl> <dbl> <dbl> <dbl>
## 1  1998-02-26  24.0  27.0    NA 24.50
## 2  1998-04-23  23.0  27.0    NA 24.50
## 3  1998-05-21  21.5  26.0    NA 23.50
## 4  1998-07-17  19.0  24.0    NA 21.50
## 5  1998-09-10  18.0  24.0    NA 21.50
##  [ reached getOption("max.print") -- omitted 5 rows ]
## # ... with 63 more rows
```

```r
# expand to daily data:
expand_daily(ret)
```

```
##              ref   lom  dep   red
## 1998-02-26 24.00 27.00   NA 24.50
## 1998-02-27 24.00 27.00   NA 24.50
## 1998-02-28 24.00 27.00   NA 24.50
## 1998-03-01 24.00 27.00   NA 24.50
## 1998-03-02 24.00 27.00   NA 24.50
## 1998-03-03 24.00 27.00   NA 24.50
## 1998-03-04 24.00 27.00   NA 24.50
##  [ reached getOption("max.print") -- omitted 6730 rows ]
```
