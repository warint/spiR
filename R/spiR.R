

# Loading data
url <- paste0("https://warin.ca/datalake/spiR/SPI_data.csv")
path <- file.path(tempdir(), "temp.csv")
curl::curl_download(url, path)
csv_file <- file.path(paste0(tempdir(), "/temp.csv"))
SPI_data <- readr::read_csv(csv_file)


# Loading indicators
url <- paste0("https://warin.ca/datalake/spiR/SPI_indicator.csv")
path <- file.path(tempdir(), "temp.csv")
curl::curl_download(url, path)
csv_file <- file.path(paste0(tempdir(), "/temp.csv"))
SPI_indicator <- readr::read_csv(csv_file)

# Creating the default values for the function query
# IF an entry is missing, all the observations of this variable will be displayed

spi_country <- base::unique(SPI_data$country_code)
spi_year <- base::unique(SPI_data$year)
spi_indicator <- base::unique(SPI_data$indicator_code)


# Function 1: Data collection

#' spir_data
#'
#' @description This function allows you to find and display the Social Progress Index data according to the selected parameters.
#' If no arguments are filled, all data will be displayed.
#'
#' @param country Countries' ISO code.
#' @param years Years for which you want data.
#' @param indicators Indicators from the Social Progress Index.
#' @import gsheet
#' @import dplyr
#' @import reshape2
#' @return Data for the country, indicator and year requested.
#' @export
#'
#' @seealso \code{\link{spir_indicator}} for the SPI's indicator symbol and \code{\link{spir_country}} for the country's ISO code.
#'
#' @examples
#' myData<- spir_data(country = c("USA", "FRA"), years = "2018", )
#' myData<- spir_data(country = c("USA", "FRA"), year = c("2018", "2019"), indicators = "SPI")
#' myData<- spir_data("USA", "2019", c("SPI", "FOW"))
#' myData<- spir_data(, "2018", )
#' myData<- spir_data("USA", "2017", )
#' myData<- spir_data("USA", , )
#' myData<- spir_data(, , )
#' myData<- spir_data()


spir_data <- function(country = spi_country,
                     years = spi_year,
                     indicators = spi_indicator) {
  country_code <- year <- indicator_code <- NULL
  out <- dplyr::filter(SPI_data,
                       country_code %in% country,
                       year %in% years,
                       indicator_code %in% indicators)
  return(out)
}


# Function 1 (deprecated): Data collection

#' sqs_spi_data (deprecated)
#'
#' @description This function allows you to find and display the Social Progress Index data according to the selected parameters.
#' If no arguments are filled, all data will be displayed. This function will be removed in the next version and replaced by the simpler function 'spir_data()'
#'
#' @param country Countries' ISO code.
#' @param years Years for which you want data.
#' @param indicators Indicators from the Social Progress Index.
#' @import gsheet
#' @import dplyr
#' @import reshape2
#'
#' @name spiR_data-deprecated
#'
#' @return Data for the country, indicator and year requested.
#' @export
#'
#' @seealso \code{\link{spir_indicator}} for the SPI's indicator symbol and \code{\link{spir_country}} for the country's ISO code.
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


sqs_spi_data <- function(country = spi_country,
                      years = spi_year,
                      indicators = spi_indicator) {
  .Deprecated(msg = "'sqs_spi_data()' will be removed in the next version and replaced by the simpler function 'spir_data()'")

  # In the next version, we will uncomment the next line:
  # .Defunct(msg = "'sqs_spi_data()' has been removed from this package and replaced with 'spir_data()'")

  country_code <- year <- indicator_code <- NULL
  out <- dplyr::filter(SPI_data,
                       country_code %in% country,
                       year %in% years,
                       indicator_code %in% indicators)
  return(out)
}



# Function 2: Indicators' symbols query
# If the user does not know the code of an indicator, s.he has access to the answer in natural language through this query

#' spir_indicator
#'
#' @description This function allows you to find and search the right indicator code from the Social Progress Index you want to use.
#' If no argument is filed, all indicators will be displayed.
#' @param indicators An indicator from the Social Progress Index.
#'
#' @return Indicator code from the Social Progress Index.
#' @export
#' @seealso \code{\link{spir_country}} for the SPI's country code and \code{\link{spir_data}} to collect data when you have both indicator and country code.
#'
#' @examples
#'myIndicator <- spir_indicator()
#'myIndicator <- spir_indicator(indicators = "mortality")
#'myIndicator <- spir_indicator("mortality")



spir_indicator <- function(indicators) {
  spi_indicators_natural_language <- SPI_indicator
  if (missing(indicators)) {
    spi_indicators_natural_language
  } else {
    spi_indicators_natural_language[grep(indicators, spi_indicators_natural_language$indicator_name, ignore.case = TRUE), ]
  }
}





# Function 2 (deprecated): Indicators' symbols query
# If the user does not know the code of an indicator, s.he has access to the answer in natural language through this query

#' sqs_spi_indicator(deprecated)
#'
#' @description This function allows you to find and search the right indicator code from the Social Progress Index you want to use.
#' If no argument is filed, all indicators will be displayed. This function will be removed in the next version and replaced by the simpler function 'spir_indicator()'
#'
#' @param indicators An indicator from the Social Progress Index.
#'
#' @return Indicator code from the Social Progress Index.
#' @export
#' @seealso \code{\link{spir_country}} for the SPI's country code and \code{\link{spir_data}} to collect data when you have both indicator and country code.
#'
#' @name spiR_indicator-deprecated
#'
#' @examples
#'myIndicator <- sqs_spi_indicator()
#'myIndicator <- sqs_spi_indicator(indicators = "mortality")
#'myIndicator <- sqs_spi_indicator("mortality")

sqs_spi_indicator <- function(indicators) {
  .Deprecated(msg = "'sqs_spi_indicator()' will be removed in the next version and replaced by the simpler function 'spir_indicator()'")

  # In the next version, we will uncomment the next line:
  # .Defunct(msg = "'sqs_spi_indicator()' has been removed from this package and replaced with 'spir_indicator()'")

  spi_indicators_natural_language <- SPI_indicator
  if (missing(indicators)) {
    spi_indicators_natural_language
  } else {
    spi_indicators_natural_language[grep(indicators, spi_indicators_natural_language$indicator_name, ignore.case = TRUE), ]
  }
}



# Function 3: Countries' code reconciliation
# If the user does not know the ISO code of a country, s.he has access to the answer in natural language through this query

#' spir_country
#'
#' @description This function allows you to find and search the right country code associated with the Social Progress Index's Data.
#' If no argument is filed, all indicators will be displayed.
#'
#' @param country The name of the country.
#'
#' @return Country's ISO code.
#'
#' @export
#' @seealso \code{\link{spir_indicator}} for the SPI's indicators and \code{\link{spir_data}} to collect data when you have both indicator and country code.
#' @examples
#'mycountry <- spir_country()
#'mycountry <- spir_country(country = "Canada")
#'mycountry <- spir_country("Canada")
#'

spir_country <- function(country) {
  spi_countries_natural_language <- unique(SPI_data[, 2:3])
  if (missing(country)) {
    spi_countries_natural_language
  } else {
    spi_countries_natural_language[grep(country, spi_countries_natural_language$country_name, ignore.case = TRUE), ]
  }
}

# Function 3 (deprecated): Countries' code reconciliation
# If the user does not know the ISO code of a country, s.he has access to the answer in natural language through this query

#' sqs_spi_country (deprecated)
#'
#' @description This function allows you to find and search the right country code associated with the Social Progress Index's Data.
#' If no argument is filed, all indicators will be displayed. This function will be removed in the next version and replaced by the simpler function 'spir_country()'
#'
#' @param country The name of the country.
#' @name spiR_country-deprecated
#' @return Country's ISO code.
#' @export
#'
#' @seealso \code{\link{spir_indicator}} for the SPI's indicators and \code{\link{spir_data}} to collect data when you have both indicator and country code.
#' @examples
#'mycountry <- sqs_spi_country()
#'mycountry <- sqs_spi_country(country = "Canada")
#'mycountry <- sqs_spi_country("Canada")
#'

sqs_spi_country <- function(country) {
  .Deprecated(msg = "'sqs_spi_country()' will be removed in the next version and replaced by the simpler function 'spir_country()'")

  # In the next version, we will uncomment the next line:
  # .Defunct(msg = "'sqs_spi_country()' has been removed from this package and replaced with 'spir_country()'")
  spi_countries_natural_language <- unique(SPI_data[, 2:3])
  if (missing(country)) {
    spi_countries_natural_language
  } else {
    spi_countries_natural_language[grep(country, spi_countries_natural_language$country_name, ignore.case = TRUE), ]
  }
}

# Function 4: Visualization

#' spir_visual
#'
#' @description This function allows you to create 2 types of visuals: bar and line charts.
#' @param chart Type of charts.
#' @param indicator An indicator from the Social Progress Index.
#' @param years A chosen year
#' @param title Chart title, set by default to TRUE
#'
#' @return Chosen Graph
#'
#' @import dplyr
#' @import ggplot2
#' @import ggsci
#' @import lubridate
#'
#' @export
#'
#' @examples
#'spir_visual(chart = "bar_1", indicator = "SPI", years = "2020")

spir_visual <- function(chart = "bar_1", indicator = "SPI", years = max(SPI_data$year), title = TRUE){

  year <- value <- indicator_code <- country_name <- country_code <- NULL

  if(years > 2020 | years < 2011){
    stop("no available data for the requested year")
  }

  if(chart == "bar_1"){
    barchart1 <- SPI_data
    barchart1 <- dplyr::filter(barchart1, year == years)
    barchart1 <- dplyr::filter(barchart1, indicator_code == indicator)
    barchart1 <- dplyr::arrange(barchart1, desc(value))
    countries <- barchart1[1:9, 3]
    countries <- countries$country_code
    barchart1 <- dplyr::filter(barchart1, country_code %in% countries)
    barchart1$country_name <- factor(barchart1$country_name, levels = unique(barchart1$country_name)[order(barchart1$value)])
    barchart1$value <- format(round(barchart1$value, 2), nsmall = 2)
     if(title == TRUE){
       ggplot2::ggplot(data = barchart1, ggplot2::aes(x = country_name, y = value, fill = country_name)) +
         ggplot2::geom_col() +
         ggplot2::geom_text(ggplot2::aes(label=value), vjust=0.2, hjust = 1.1, colour = "white", size = 3.2, fontface = "bold") +
         ggplot2::ylab("")  +
         ggplot2::xlab("") +
         ggplot2::ggtitle(paste(unique(barchart1$indicator_name), "in", years)) +
         ggplot2::theme_minimal() +
         ggplot2::guides(fill=FALSE) +
         ggsci::scale_fill_uchicago() +
         ggplot2::theme(legend.position="none", plot.title = ggplot2::element_text(size=12))  +
         ggplot2::labs(fill = "Countries", caption="Source: Warin (2020) & Social Progress Index.") +
         ggplot2::coord_flip() +
         ggplot2::theme(axis.title.x=ggplot2::element_blank(),
               axis.ticks.x=ggplot2::element_blank(),
               axis.text.x=ggplot2::element_blank())
    } else {
      ggplot2::ggplot(data = barchart1, ggplot2::aes(x = country_name, y = value, fill = country_name)) +
        ggplot2::geom_col() +
        ggplot2::geom_text(ggplot2::aes(label=value), vjust=0.2, hjust = 1.1, colour = "white", size = 3.2, fontface = "bold") +
        ggplot2::ylab("")  +
        ggplot2::xlab("") +
        ggtitle("") +
        ggplot2::theme_minimal() +
        ggplot2::guides(fill=FALSE) +
        ggsci::scale_fill_uchicago() +
        ggplot2:: theme(legend.position="none", plot.title = ggplot2::element_text(size=12))  +
        ggplot2::labs(fill = "Countries", caption="Source: Warin (2020) & Social Progress Index.") +
        ggplot2::coord_flip() +
        ggplot2::theme(axis.title.x=ggplot2::element_blank(),
              axis.text.x=ggplot2::element_blank(),
              axis.ticks.x=ggplot2::element_blank())
    }
  } else if(chart == "line_1"){
    linechart1 <- SPI_data
    linechart1 <- dplyr::filter(linechart1, indicator_code == indicator)
    linechart1 <- dplyr::arrange(linechart1, desc(year), desc(value))
    countries <- linechart1[1:6, 3]
    countries <- countries$country_code
    linechart1 <- dplyr::filter(linechart1, country_code %in% countries)
    linechart1$year <- lubridate::ymd(linechart1$year, truncated = 2L)
    if(title == TRUE){
      ggplot2::ggplot(data = linechart1, ggplot2::aes(x = year, y = value, color = country_name, shape = country_name)) +
        ggplot2::geom_line() +
        ggplot2::geom_point(size = 2, stroke = 1) +
        ggplot2::ylab("")  +
        ggplot2:: xlab("") +
        ggplot2::ggtitle(paste0(unique(linechart1$indicator_name), ": \nEvolution of the ", max(SPI_data$year), " most represented countries")) +
        ggplot2::theme_minimal() +
        ggplot2::guides(fill=FALSE) +
        ggsci::scale_color_uchicago() +
        ggplot2::theme(legend.position="right", plot.title = ggplot2::element_text(size=12))  +
        ggplot2::labs(shape = "Countries", color = "Countries", caption="Source: Warin (2020) & Social Progress Index.")
    } else {
      ggplot2::ggplot(data = linechart1, ggplot2::aes(x = year, y = value, color = country_name, shape = country_name)) +
        ggplot2::geom_line() +
        ggplot2::ylab("")  +
        ggplot2::xlab("") +
        ggplot2::ggtitle("") +
        ggplot2::theme_minimal() +
        ggplot2::guides(fill=FALSE) +
        ggplot2::geom_point(size = 2, stroke = 1) +
        ggsci::scale_color_uchicago() +
        ggplot2::theme(legend.position="right", plot.title = ggplot2::element_text(size=12))  +
        ggplot2::labs(shape = "Countries", color = "Countries", caption="Source: Warin (2020) & Social Progress Index.")
    }
  } else{
    stop("invalid arguments")
  }
}

