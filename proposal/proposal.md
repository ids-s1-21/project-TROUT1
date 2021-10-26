Project proposal
================
TROUT1

``` r
library(tidyverse)
library(broom)
```

## 1. Introduction

In this project we will explore how factors such as: Location, House
type, Area and Number of bathrooms influence the price of properties in
London. We will then use this information to identify the most
affordable places to stay given a set of conditions.

[Here is the dataset we plan on
using.](https://www.kaggle.com/arnavkulkarni/housing-prices-in-london)

This dataset contains 11 variables. Although a couple of these variables
are redundant (like the ‘\#’ variable, the ‘Property Name’ variable and
the ‘Postal Code’ variable).

The variables in this dataset are: ‘\#’, ‘Property Name’, ‘Price’,
‘House Type’, ‘Area in sq ft’, ‘No. of Bedrooms’, ‘No. of Bathrooms’,
‘No. of Receptions’, ‘Location’, ‘City/County’, ‘Postal Code’. All of
these are self explanatory except ‘\#’ which is an id for each listing.

Each row in this dataset is a listing for a property.

From the Metadata on the dataset’s kaggle page the data was obtained
through Web Scraping.

## 2. Data

``` r
London <- read_csv("../data/London.csv")
glimpse(London)
```

    ## Rows: 3,480
    ## Columns: 11
    ## $ ...1                <dbl> 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, …
    ## $ `Property Name`     <chr> "Queens Road", "Seward Street", "Hotham Road", "Fe…
    ## $ Price               <dbl> 1675000, 650000, 735000, 1765000, 675000, 420000, …
    ## $ `House Type`        <chr> "House", "Flat / Apartment", "Flat / Apartment", "…
    ## $ `Area in sq ft`     <dbl> 2716, 814, 761, 1986, 700, 403, 1548, 560, 1308, 6…
    ## $ `No. of Bedrooms`   <dbl> 5, 2, 2, 4, 2, 1, 4, 1, 3, 2, 6, 6, 5, 2, 2, 6, 3,…
    ## $ `No. of Bathrooms`  <dbl> 5, 2, 2, 4, 2, 1, 4, 1, 3, 2, 6, 6, 5, 2, 2, 6, 3,…
    ## $ `No. of Receptions` <dbl> 5, 2, 2, 4, 2, 1, 4, 1, 3, 2, 6, 6, 5, 2, 2, 6, 3,…
    ## $ Location            <chr> "Wimbledon", "Clerkenwell", "Putney", "Putney", "P…
    ## $ `City/County`       <chr> "London", "London", "London", "London", "London", …
    ## $ `Postal Code`       <chr> "SW19 8NY", "EC1V 3PA", "SW15 1QL", "SW15 1LP", "S…

## 3. Data analysis plan
