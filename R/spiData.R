#' sqs_spi_data
#'
#'@description This function allows you to find and display the Social Progress Index data according to the selected parameters.
#'
#'If no arguments are filed, all data will be displayed.
#'
#' @param COUNTRY_CODE A country code associated to the Social Progress Index.
#' @param INDICATOR_CODE A Indicator code associated to the Social Progress Index.
#' @param YEAR A year for which you want data
#'
#' @return Data for the country, indicator and year requested
#' @export
#' @import dplyr gsheet
#'
#' @seealso \code{\link{sqs_spi_symbol}} for the SPI's indicator symbol and \code{\link{sqs_spi_country}} for the SPI's country code.
#' @examples
#'myData <- sqs_spi_data("CAN","AIC_4","2018")
#'DataFromAllYears <- sqs_spi_data("CAN","AIC_4",)
#'DataFromAllCountries <- sqs_spi_data(,"AIC_4","2018")
#'DataFromAllIndicators <- sqs_spi_data("CAB",,"2018")
sqs_spi_data <- function(COUNTRY_CODE,INDICATOR_CODE,YEAR){

  SPI_data <- gsheet2tbl("https://docs.google.com/spreadsheets/d/1_nQ9mQU_4J0KDRc4_TMzTsJHMYBqLwwnPaMC5BVhkGc/edit#gid=0")

  if ((missing(COUNTRY_CODE))&(missing(INDICATOR_CODE))) {

    SPI_data %>% filter(year == YEAR)

  } else if ((missing(COUNTRY_CODE))&(missing(YEAR))) {

    SPI_data %>% select(country,year,INDICATOR_CODE)

  } else if ((missing(INDICATOR_CODE))&(missing(YEAR))) {

    SPI_data %>% filter(code == COUNTRY_CODE)

  }else if (missing(COUNTRY_CODE)){

    SPI_data %>% filter(year == YEAR) %>% select(country,year,INDICATOR_CODE)

  } else if (missing(YEAR)) {

    SPI_data %>% filter(code == COUNTRY_CODE) %>% select(country,year,INDICATOR_CODE)

  } else if (missing(INDICATOR_CODE)) {

    SPI_data %>% filter(code == COUNTRY_CODE) %>% filter(year == YEAR)

  } else {

    SPI_data %>% filter (code == COUNTRY_CODE) %>% filter(year == YEAR) %>% select(country,year,INDICATOR_CODE)
  }

}
