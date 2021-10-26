Project proposal
================
TROUT1

``` r
library(tidyverse)
library(broom)
library(scales)
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

The final goal is to answer: “Does the number of bathroom affects the
price of the property?”

Response factor: The price of the property
(London*P**r**i**c**e*)*E**x**p**l**a**n**a**t**o**r**y**f**a**c**t**o**r* : *T**h**e**n**u**m**b**e**r**o**f**b**a**t**h**r**o**o**m**i**n**e**a**c**h**f**a**c**t**o**r*(*L**o**n**d**o**n*No. of
Bathrooms)

Here is a glimpse of the relation between those two factors

``` r
pound_in_M <- label_dollar(
  prefix = "£",
  suffix = "M",
  big.mark = ",",
  decimal.mark = "."
)
London%>%
  mutate( 
    price_in_M = Price/1000000
  )%>%  #We reduce the number of price into M(e.g.:£1000000->£1M)
  ggplot(aes(x = `No. of Bathrooms`, y = price_in_M))+
  geom_point()+
  geom_smooth(method = "lm")+
  scale_y_continuous(labels = pound_in_M)+
  labs(
    title = "Price vs No. of Bathroom plot, with regression line",
    subtitle = "For properties in London",
    x = "Number of bathrooms",
    y = "Price of property"
  )
```

    ## `geom_smooth()` using formula 'y ~ x'

![](proposal_files/figure-gfm/simple%20analysis-number%20of%20bathroom%20vs%20price-1.png)<!-- -->

The answer seems to be “Yes”, since the regression line does shows a
slope. But there are still a lot of problems with this plot: 1. The data
seems didn’t fit the data well 2. There are too many Confounding
variables, the place of the property, the aera of the property, etc.

Those are the problems we are going to solve in the following project.

If we really want to get the answer that “the number of bathrooms do
affect the price of the property”, we need to do those: 1. Get rid of
confounding variables (That will be the majority of the work we are
gonna do) 2. Show that there is a strong relationship between the number
of bathrooms and the price of the property
