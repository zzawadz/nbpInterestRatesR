#' Download inflation data from NBP website.
#'
#' @param destination A character string with the name where the downloaded file is saved. Tilde-expansion is performed.
#' @param overwrite if true overwrites the file in the destination path.
#' @param ... other arguments passed to \code{\link{download.file}}
#'
#' @export
#' @importFrom utils download.file
#'
#' @examples
#'
#' path <- nbp_inflation_download()
#'
nbp_inflation_download <- function(destination = sprintf("inflation_nbp-%s.xls", Sys.Date()), overwrite = FALSE, ...) {

  if(!overwrite && file.exists(destination)) {
    warning("File exists!")
    return(destination)
  }
  download.file("http://www.nbp.pl/statystyka/bazowa/core.xls", destfile = destination, ...)
  return(destination)
}

#' Title
#'
#' @param path path to the file containing inflation data downloaded fromo NBP website. See the \code{\link{nbp_inflation_download}} function.
#' @param interval date interval. Can be monthly (default), quarterly or annual.
#' @param type select method of calculation. 'previous' (default) returns data in relation to the previous month. 'corresponding' returns the values in relation
#'        to the corresponding interval from previous year.
#'
#' @export
#'
#' @importFrom readxl read_excel
#' @importFrom stats setNames na.omit
#'
#' @examples
#'
#' path <- nbp_inflation_download()
#' nbp_read_inflation(path)
#' nbp_read_inflation(path, type = "corresponding")
#'
#' nbp_read_inflation(path, interval = "quarterly")
#' nbp_read_inflation(path, interval = "annual")
#'
nbp_read_inflation <- function(path, interval = c("monthly", "quarterly", "annual"), type = c("previous", "corresponding")) {

  interval <- setNames(1:3, c("monthly", "quarterly", "annual"))[interval[[1]]]


  get_data <- function(data, idx = 2:6) {
    data <- na.omit(data)

    date <- data[[1]]

    rawValue <- as.matrix(data[,idx])
    mode(rawValue) <- "numeric"

    if(is.numeric(date)) date <- as.Date(sprintf("%s-12-31", date))
    if(is.character(date)) {

      spl <- strsplit(date, split = "Q")
      year <- vapply(spl, "[[", "", 1)
      quarter <- vapply(spl, "[[", "", 2)
      date <- as.Date(sprintf("%s-%s", year, c("03-31", "06-30", "09-30", "12-31")[as.numeric(quarter)]))

    }

    result <- xts(rawValue, order.by = date)
    colnames(result) <- c("CPI", "NetAdministeredPrices", "NetMostVolatilePrices", "NetFoodEnergyPrices",  "TrimmedMean")
    result
  }

  if(interval == 3) type <- "corresponding"

  idx <- if(type[1] == "corresponding") 2:6 else 2:6 + 5

  data <- read_excel(path, interval, skip = 2)
  get_data(data, idx)
}
