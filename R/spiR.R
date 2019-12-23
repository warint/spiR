
#' sqs_spi_data
#'
#' @description This function allows you to find and display the Social Progress Index data according to the selected parameters.
#' If no arguments are filled, all data will be displayed.
#'
#' @param country Countries' ISO code.
#' @param years Years for which you want data.
#' @param indicators Indicators from the Social Progress Index.
#'
#' @import gsheet
#' @import dplyr
#' @import reshape2
#'
#' @return Data for the country, indicator and year requested
#' @export
#'
#' @seealso \code{\link{sqs_spi_indicator}} for the SPI's indicator symbol and \code{\link{sqs_spi_country}} for the country's ISO code.
#'
#' @examples
#' myData<- sqs_spi_data(country = c("USA", "FRA"), years = "2018", )
#' myData<- sqs_spi_data(country = c("USA", "FRA"), year = c("2018", "2019"), indicators = "SPI")
#' myData<- sqs_spi_data("USA", "2019", c("SPI", "FOW"))
#' myData<- sqs_spi_data(, "2018", )
#' myData<- sqs_spi_data("USA", "2017", )
#' myData<- sqs_spi_data("USA", , )
#' myData<- sqs_spi_data(, , )
#' myData<- sqs_spi_data()
#'
#'
#

# Function 1: Data collection

sqs_spi_data <- function(country = data_long_country,
                         years = data_long_year,
                         indicators = data_long_indicator) {
  var_code <- var_year <- var_indicator <- NULL
  out <- dplyr::filter(data_long,
                       var_code %in% country,
                       var_year %in% years,
                       var_indicator %in% indicators)
  return(out)
}

spi_data <- gsheet::gsheet2tbl("https://docs.google.com/spreadsheets/d/1_nQ9mQU_4J0KDRc4_TMzTsJHMYBqLwwnPaMC5BVhkGc/edit#gid=0")

data_long <- reshape2::melt(spi_data,
                            # ID variables - all the variables to keep but not split apart on
                            id.vars = c("countryName", "code", "year"),
                            # The source columns
                            measure.vars = colnames(spi_data)[6:ncol(spi_data)],
                            # Name of the destination column that will identify the original
                            # column that the measurement came from
                            variable.name = "var_indicator",
                            value.name = "value"
)

base::names(data_long) = c("countryName", "var_code", "var_year", "var_indicator", "value")


# Creating the default values for the function query
# IF an entry is missing, all the observations of this variable will be displayed

data_long_country <- base::unique(data_long[, 2])
data_long_year <- base::unique(data_long[, 3])
data_long_indicator <- base::unique(data_long[, 4])



# Function 2: Indicators' symbols query
# If the user does not know the code of an indicator, s.he has access to the answer in natural language through this query

#' sqs_spi_indicator
#'
#' @description This function allows you to find and search the right indicator code from the Social Progress Index you want to use.
#' If no argument is filed, all indicators will be displayed.
#' @param indicators An indicator from the Social Progress Index.
#'
#' @return Indicator code from the Social Progress Index.
#' @export
#' @seealso \code{\link{sqs_spi_country}} for the SPI's country code and \code{\link{sqs_spi_data}} to collect data when you have both indicator and country code.
#'
#' @examples
#'myIndicator <- sqs_spi_indicator()
#'myIndicator <- sqs_spi_indicator(indicators = "mortality")
#'myIndicator <- sqs_spi_indicator("mortality")
#'


sqs_spi_indicator <- function(indicators) {
  spi_indicators_natural_language <- gsheet::gsheet2tbl("https://docs.google.com/spreadsheets/d/1_nQ9mQU_4J0KDRc4_TMzTsJHMYBqLwwnPaMC5BVhkGc/edit#gid=400714513")
  if (missing(indicators)) {
    spi_indicators_natural_language
  } else {
    spi_indicators_natural_language[grep(indicators, spi_indicators_natural_language$indicator_name, ignore.case = TRUE), ]
  }
}

# Function 3: Countries' code reconciliation
# If the user does not know the ISO code of a country, s.he has access to the answer in natural language through this query

#' sqs_spi_country
#' @description This function allows you to find and search the right country code associated with the Social Progress Index's Data.
#' If no argument is filed, all indicators will be displayed.
#'
#' @param country The name of the country.
#'
#' @return Country's ISO code.
#' @export
#' @seealso \code{\link{sqs_spi_indicator}} for the SPI's indicators and \code{\link{sqs_spi_data}} to collect data when you have both indicator and country code.
#' @examples
#'mycountry <- sqs_spi_country()
#'mycountry <- sqs_spi_country(country = "Canada")
#'mycountry <- sqs_spi_country("Canada")
#'


sqs_spi_country <- function(country) {
  spi_countries_natural_language <- unique(spi_data[, 1:2])
  if (missing(country)) {
    spi_countries_natural_language
  } else {
    spi_countries_natural_language[grep(country, spi_countries_natural_language$countryName, ignore.case = TRUE), ]
  }
}
