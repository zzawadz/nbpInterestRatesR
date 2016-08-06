#' Download interest rates from National Bank of Poland.
#'
#' This functions download various interest rates from NBP (National Bank of Poland) as a xts object.
#'
#' @param types DESCRIPTION.
#'
#' @return xts object.
#' @export
#' @importFrom xml2 read_xml xml_find_all xml_attr xml_parent
#' @importFrom lubridate ymd
#' @examples
#'
#' get_interest_rates("ref")
#' get_interest_rates(c("ref","lom"))
#'
get_interest_rates = function(types = c("ref","lom","dep","red"))
{
  xmlData = read_xml("http://www.nbp.pl/xml/stopy_procentowe_archiwum.xml")

  .get_rates = function(type = "ref")
  {
    dt = xml_find_all(xmlData, sprintf("//pozycja[@id='%s']", type))
    rates = as.numeric(gsub(xml_attr(dt, "oprocentowanie"), pattern = ",", replacement = "."))
    dates = xml_attr(xml_parent(dt), "obowiazuje_od")
    x = xts(rates, order.by = ymd(dates))
    colnames(x) = type
    x
  }

  allRes = lapply(types, .get_rates)
  Reduce(cbind, allRes)
}


#' Expand xts do daily periodicity.
#'
#' Expand xts do daily periodicity.
#'
#' @param x xts object
#' @param enddate last date.
#'
#' @importFrom xts xts
#' @importFrom zoo na.locf
#' @importFrom lubridate today ymd
#' @export
#' @return xts
#' @examples
#'
#' x = get_interest_rates()
#' expand_daily(x)
#'
expand_daily = function(x, enddate = "today")
{
  if(enddate == "today")
  {
    enddate = today()
  } else
  {
    enddate = ymd(enddate)
  }

  start = index(x)[1]
  x = x[paste(index(x)[1], enddate, sep = "/")]

  dates = seq(start, enddate, by = 1)
  dates = xts(seq_along(dates), order.by = dates)

  na.locf(cbind(dates, x)[,-1])
}



#' Convert xts to tibble.
#'
#' Adds column with dates to the first position to after conversion to tibble.
#'
#' @param x xts object.
#'
#' @export
#' @importFrom zoo index
#' @importFrom dplyr bind_cols data_frame as_data_frame
#' @return tbl_df object.
#' @examples
#'
#' x = get_interest_rates()
#' xts2tbl(x)
#'
#' dx = expand_daily(x)
#' xts2tbl(dx)
#'
#'
xts2tbl = function(x)
{
  dt = as_data_frame(x)
  bind_cols(data_frame(date = index(x)), dt)
}



#' Maximum interest rates for loans in Poland
#'
#' Get time series with the maximum interest rates for loans in Poland.
#'
#' @export
#' @return RETURN DESCRIPTION
#' @examples
#'
#' get_max_loan()
#'
get_max_loan = function()
{
  ir = get_interest_rates(c("ref","lom"))
  lom = (ir[,"lom"] * 4)["/2015"]
  colnames(lom) = "maxLoan"

  ref = cbind(ir[,"ref"]["2015/"],xts(NA, order.by = ymd("2016-01-01")))

  ref = (na.locf(ref[,1])["2016/"] + 3.5) * 2

  rbind(lom, ref)
}
