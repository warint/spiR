
#' sqs_spi_symbol
#'
#' @description This function allows you to find and search the right indicator code from the Social Progress Index you want to use.
#'
#' If no argument is filed, all indicators will be displayed.
#'
#' @param INDICATOR A social indicator from the Social Progress Index.
#'
#' @return Indicator code from the Social Progress Index.
#' @export
#' @import gsheet
#'
#'
#'@seealso \code{\link{sqs_spi_country}} for the SPI's country code and \code{\link{sqs_spi_data}} to collect data when you have both the indicator and the country code.
#'
#' @examples
#' sqs_spi_symbol("electricity")
#' AllIndicators <- sqs_spi_symbol()
sqs_spi_symbol <- function(INDICATOR){

  SPI_Indicators <- gsheet2tbl("https://docs.google.com/spreadsheets/d/1_nQ9mQU_4J0KDRc4_TMzTsJHMYBqLwwnPaMC5BVhkGc/edit#gid=400714513")

  if (missing(INDICATOR)) {

    SPI_Indicators

  } else {

    SPI_Indicators[grep(INDICATOR,SPI_Indicators$indicator_name),]
  }

}
