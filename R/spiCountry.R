#' sqs_spi_country
#'
#'@description This function allows you to find and search the right country code associated with the Social Progress Index's Data.
#'
#'If no argument is filed, all countries will be displayed.
#'
#' @param COUNTRY The name of the country starting with a capital letter.
#'
#' @return A country code
#' @export
#' @import gsheet
#'
#' @seealso \code{\link{sqs_spi_symbol}} for the SPI's indicator symbol and \code{\link{sqs_spi_data}} to collect data when you have both the indicator and the country code.
#'
#' @examples
#' sqs_spi_country("Canada")
#' AllCountries <- sqs_spi_country()
sqs_spi_country <- function(COUNTRY){

  SPI_data <- gsheet2tbl("https://docs.google.com/spreadsheets/d/1_nQ9mQU_4J0KDRc4_TMzTsJHMYBqLwwnPaMC5BVhkGc/edit#gid=0")
  SPI_country <- unique(SPI_data[,1:2])

  if (missing(COUNTRY)) {

    SPI_country

  } else {

    SPI_country[grep(COUNTRY,SPI_country$country),]
  }
}
