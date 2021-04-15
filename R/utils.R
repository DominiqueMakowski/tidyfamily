#' @importFrom lubridate as_date year month day
.family_date <- function(date, format = "%d %b %Y"){
  if(is.na(date)) {
    year <- NA
    month <- NA
    day <- NA
    text <- "Unknown"

  } else if(is.numeric(date)) {
    year <- date
    month <- NA
    day <- NA
    text <- as.character(year)

  } else {
    date <- lubridate::as_date(date)
    year <- lubridate::year(date)
    month <- lubridate::month(date)
    day <- lubridate::day(date)
    text <- format(date, format)
  }
  list(year = year, month = month, day = day, text = text)
}
