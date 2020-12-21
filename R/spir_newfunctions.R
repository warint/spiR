library(dplyr)
library(ggplot2)
library(ggsci)

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


# Function 2: Indicators' symbols query

spir_indicator <- function(indicators) {
  spi_indicators_natural_language <- SPI_indicator
  if (missing(indicators)) {
    spi_indicators_natural_language
  } else {
    spi_indicators_natural_language[grep(indicators, spi_indicators_natural_language$indicator_name, ignore.case = TRUE), ]
  }
}


# Function 3: Countries' code reconciliation

spir_country <- function(country) {
  spi_countries_natural_language <- unique(SPI_data[, 2:3])
  if (missing(country)) {
    spi_countries_natural_language
  } else {
    spi_countries_natural_language[grep(country, spi_countries_natural_language$country_name, ignore.case = TRUE), ]
  }
}



# Function 4: Visualization

spir_visual <- function(chart = "bar_1", indicator = "SPI", years = max(SPI_data$year), title = TRUE){
  
  if(years > 2020 | years < 2011){
    stop("no available data for the requested year")
  }
  
  if(chart == "bar_1"){
    barchart1 <- SPI_data
    barchart1 <- filter(barchart1, year == years)
    barchart1 <- filter(barchart1, indicator_code == indicator)
    barchart1 <- arrange(barchart1, desc(value))
    countries <- barchart1[1:9, 3]
    countries <- countries$country_code
    barchart1 <- dplyr::filter(barchart1, country_code %in% countries)
    barchart1$country_name <- factor(barchart1$country_name, levels = unique(barchart1$country_name)[order(barchart1$value)])
    barchart1$value <- format(round(barchart1$value, 2), nsmall = 2)
     if(title == TRUE){
      ggplot(data = barchart1, aes(x = country_name, y = value, fill = country_name)) +
        geom_col() +
        geom_text(aes(label=value), vjust=0.2, hjust = 1.1, colour = "white", size = 3.2, fontface = "bold") + 
        ylab("")  +
        xlab("") +
        ggtitle(paste(unique(barchart1$indicator_name), "in", years)) +
        theme_minimal() +
        guides(fill=FALSE) +
        scale_fill_uchicago() +
        theme(legend.position="none", plot.title = element_text(size=12))  + 
        labs(fill = "Countries", caption="Source: Warin (2020) & Social Progress Index.") + 
        coord_flip() +
         theme(axis.title.x=element_blank(),
               axis.ticks.x=element_blank(),
               axis.text.x=element_blank())
    } else {
      ggplot(data = barchart1, aes(x = country_name, y = value, fill = country_name)) +
        geom_col() +
        geom_text(aes(label=value), vjust=0.2, hjust = 1.1, colour = "white", size = 3.2, fontface = "bold") + 
        ylab("")  +
        xlab("") +
        ggtitle("") +
        theme_minimal() +
        guides(fill=FALSE) +
        scale_fill_uchicago() +
        theme(legend.position="none", plot.title = element_text(size=12))  + 
        labs(fill = "Countries", caption="Source: Warin (2020) & Social Progress Index.") + 
        coord_flip() +
        theme(axis.title.x=element_blank(),
              axis.text.x=element_blank(),
              axis.ticks.x=element_blank())
    }
  } else if(chart == "line_1"){
    linechart1 <- SPI_data
    linechart1 <- filter(linechart1, indicator_code == indicator)
    linechart1 <- arrange(linechart1, desc(year), desc(value))
    countries <- linechart1[1:6, 3]
    countries <- countries$country_code
    linechart1 <- dplyr::filter(linechart1, country_code %in% countries)
    linechart1$year <- lubridate::ymd(linechart1$year, truncated = 2L)
    if(title == TRUE){
      ggplot(data = linechart1, aes(x = year, y = value, color = country_name, shape = country_name)) +
        geom_line() + 
        geom_point(size = 2, stroke = 1) + 
        ylab("")  +
        xlab("") +
        ggtitle(paste0(unique(linechart1$indicator_name), ": \nEvolution of the ", max(SPI_data$year), " most represented countries")) +
        theme_minimal() +
        guides(fill=FALSE) +
        scale_color_uchicago() +
        theme(legend.position="right", plot.title = element_text(size=12))  + 
        labs(shape = "Countries", color = "Countries", caption="Source: Warin (2020) & Social Progress Index.")
    } else {
      ggplot(data = linechart1, aes(x = year, y = value, color = country_name, shape = country_name)) +
        geom_line() + 
        ylab("")  +
        xlab("") +
        ggtitle("") +
        theme_minimal() +
        guides(fill=FALSE) +
        geom_point(size = 2, stroke = 1) + 
        scale_color_uchicago() +
        theme(legend.position="right", plot.title = element_text(size=12))  + 
        labs(shape = "Countries", color = "Countries", caption="Source: Warin (2020) & Social Progress Index.")
    }
  } else{
    stop("invalid arguments")
  }
}

