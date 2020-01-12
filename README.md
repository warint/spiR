
<!-- README.md is generated from README.Rmd. Please edit that file -->

<!-- badges: start -->

[![Travis build
status](https://travis-ci.org/warint/spiR.svg?branch=master)](https://travis-ci.org/warint/spiR)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/warint/spiR?branch=master&svg=true)](https://ci.appveyor.com/project/warint/spiR)
<!-- badges: end -->

# ‘spiR’

# <img src="man/figures/LOGO.png" align="right" />

In 2015, The 17 United Nations’ Sustainable Development Goals were
adopted. ‘spiR’ is a wrapper of several open datasets published by the
Social Progress Imperative (<https://www.socialprogress.org/>),
including the Social Progress Index (a synthetic measure of human
development across the world). ‘spiR’‘s goal is to provide data to help
policymakers and researchers prioritize actions that accelerate social
progress across the world in the context of the Sustainable Development
Goals. The Social Progress Index proposes a new perspective on social
challenges and needed efforts to accelerate social progress in line with
the Sustainable Development Goals. In this context, the goal of ’spiR’
is to allow an easy connection with R to the Social Progress Index in
order to benefit from the “power of crowds.” ‘spiR’ is an R wrapper to
easily access the Social Progress Index datasets.

At the Social Progress Imperative, they define “social progress as the
capacity of a society to meet the basic human needs of its citizens,
establish the building blocks that allow citizens and communities to
enhance and sustain the quality of their lives, and create the
conditions for all individuals to reach their full potential. Improving
quality of life is a complex task and past efforts to measure progress
simply haven’t created a sufficiently nuanced picture of what a
successful society looks like. That’s why we created the Social Progress
Index. Rather than emphasizing traditional measurements of success like
income and investment, we measure 51 social and environmental indicators
to create a clearer picture of what life is really like for everyday
people. The index doesn’t measure people’s happiness or life
satisfaction, focusing instead on actual life outcomes in areas from
shelter and nutrition to rights and education. This exclusive focus on
measurable outcomes makes the index a useful policy tool that tracks
changes in society over time.”

The index measures the quality of life for 98% of the world’s
population. In its current version, the R client provides access to
global data. In further versions, this R client will include different
geographical levels: states, regions, cities and sometimes communities.

Three overarching dimensions are (1) Basic Human Needs, (2) Foundations
of Wellbeing, and (3) Opportunity. Within each dimension, there are four
components that further divide the indicators into thematic categories.
The index consists in 51 social and environmental variables, covering
the years 2014 to 2019.

To see a definition of the indicators, please visit this
[page](https://www.socialprogress.org/index/global/definitions/BHN/0/0).
See below to have access through ‘spiR’ to the whole list of indicators.

## Overview of the available data

Users can recreate in R impactful dashboards and visualizations as the
ones found on [www.socialprogress.org](http://www.socialprogress.org):
[click
here](https://www.socialprogress.org/?tab=2&code=NOR&embedded=true)

## Installation

You can install the current development version of ‘spiR’ with:

``` r
devtools::install_github("warint/spiR")
```

## How-To

### Step 1: Getting the country’s ISO code

A user needs to enter the ISO code of a country. To have access to this
code, the following function provides this information.

``` r
sqs_spi_country() # A list of all countries will be produced

sqs_spi_country(country = "Canada") # The ISO code for Canada will be produced

sqs_spi_country("Canada") # The ISO code for Canada will be produced
```

### Step 2: Getting the indicator’s code

A user needs to enter the code of the desired indicator. To do so, the
following function provides access to all the indicators of interest.

``` r
sqs_spi_indicator() # A list of all countries will be produced

sqs_spi_indicator(indicators = "mortality") # A list with all the variables including "mortlity" will be produced

sqs_spi_indicator("mortality") # A list with all the variables including "mortlity" will be produced
```

### Step 3: Getting the data

Once the user knows the ISO code and the indicator’s code, s.he can
collect the data in a very easy way through this
function:

``` r
sqs_spi_data(country = c("USA", "FRA"), year = c("2018", "2019"), indicators = "SPI") # It generates a data frame of the overall SPI indicator for the USA and France for the years 2018 and 2019

sqs_spi_data(country = c("USA", "FRA"), years = "2018", ) # It generates a data frame of all the indicators for the USA and France for the year 2018

sqs_spi_data("USA", "2019", c("SPI", "FOW")) # It generates a data frame of the SPI and FOW indicators for the USA in 2019

sqs_spi_data(, "2018", ) # It generates a data frame for all the countries and all the indicators for 2018

sqs_spi_data("USA", "2017", ) # It generates a data frame of all the indicators for the USA in 2017

sqs_spi_data("USA", , ) # It generates a data frame of all the indicators for all the years for the USA

sqs_spi_data(, , ) # It generates a data frame of the complete dataset

sqs_spi_data() # It generates a data frame of the complete dataset
```

### Cite ‘spiR’

To cite the ‘spiR’ package in your work:

Warin, T. (2019). “spiR: Client for the Social Progress Index. v0.1.0.”

``` r
@article{Warin2019,
author = "Thierry Warin",
title = "{spiR: An R Package for the Social Progress Index}",
year = "2019",
month = "12",
url = "https://figshare.com/articles/spiR_Client_for_Social_Progress_Index_Data/11421573",
doi = "10.6084/m9.figshare.11421573.v2"
}
```

### Why SQS ?

SQS stands for SKEMA Quantum Studio, a research and technological
development centre based in Montreal, Canada, that serves as the engine
room for the SKEMA Global lab in AI.

SKEMA Quantum Studio is also a state-of-the-art platform developed by
our team that enables scholars, students and professors to access one of
the most powerful analytical tools in higher education. By using data
science and artificial intelligence within the platform, new theories,
methods and concepts are being developed to study globalisation,
innovation and digital transformations that our society faces.

To learn more about the SKEMA Quantum Studio and the mission of the
SKEMA Global Lab in AI, please visit the following websites :
[SQS](https://quantumstudio.skemagloballab.io) ; [Global
Lab](https://skemagloballab.io/).

### Acknowledgments

The author would like to thank the Center for Interuniversity Research
and Analysis of Organizations (CIRANO, Montreal) for its support, as
well as Thibault Senegas, Marine Leroi and Martin Paquette at SKEMA
Global Lab in AI. The usual caveats apply.
