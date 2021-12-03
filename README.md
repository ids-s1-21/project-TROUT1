How Various Factors Affect Housing Prices in London
================
TROUT1 (Zhixin & Sam & Josh)
2 Dec. 2021

# Summary

## Introduction:

In this project we will explore how factors such as: Location, House
type, Area and Number of Bedrooms influence the price of property in
London. The goal of our project is to identify which factors have the
greatest influence on the price of housing in London.

## About the data:

The dataset we used was obtained from Kaggle. According to the uploader
the information was obtained via web scraping. The variables we are
going to be focusing on in this project are, Region, Area and House
type.

X- ID of the property.

Property.Name- The name of the property.

Price- The price of the property.

House Type- The type of the house.

Area in sq ft- Aera in square feet of the property.

No. of Bedrooms- Number of bedrooms.

No. of Bathdrooms- Failure data column, please ignore.

No. of Receptions- Failure data column, please ignore.

Location- The name of the neighbourhood of the house.

City/County- The city or county the property located.

Postal Code- The postal code of the property

## Data Problems/Cleaning:

As you can see, a major issue with our dataset was that the values of
the variables ‘No. of Bedrooms’, ‘No. of Bathrooms’ and ‘No. of
Receptions’ were the same and so could not be used. We found that this
data corresponds to the ‘No. of Bedrooms’. As well as this we found that
the location variable does not have entries for each listing and that
the dataset contains houses from outside of London.

We cleaned our dataset in 5 steps.

1.  Filtering out all houses that are not in London.

2.  Removing the variables “No. of bathrooms” and “No. of receptions.”

3.  Creating variable: “price\_per\_sq\_ft” = “Price”/“Area in sq ft”

4.  Extracting the District Code from the “Postal Code” variable.

5.  Assigning each District code to one of the 4 large regions.

Dividing Rule:

Before we start our analysis we will expand on how we assigned each
property to one of 4 regions. We have chosen to divide the District
codes into 4 regions shown on the map below

Different marked colour represents different regions:

1.  Red represents group “A-Central”

2.  Blue represents group “B-Middle”

3.  Red represents group “C-Outer”

4.  Unmarked region represents group “D-Further outer”

What we expected to see is that: The closer to the city center, the more
expensive the land is. That is, we should observe a higher price per sq
ft in areas closer to the center.

## Data & Interpretation

We are curious if there is an outlier region in “Further Outer” that has
a higher housing price per sq ft than the “Outer” region which is
skewing our result. So we made a map to see the distribution of housing
prices. It seems that no such region exists. The housing price per sq ft
in “Further outer” is higher than “Outer” region in general.

## Map & Interpretation:

We are curious if there is an outlier region in “Further Outer” that has
a very high housing price per sq ft which is skewing our result. So we
made a map to see the distribution of housing prices. It seems that no
such region exists. The housing price per sq ft in “Further outer” is
higher than “Outer” region in general.

## Visualisations/Summary Statistics:

Prices grouped by region and type of housing

We thought that maybe the difference in mean price between the outer and
further outer regions was concentrated into one housing type. For
example, maybe the outer region has a large number of cheaper apartment
complexes, pulling its mean housing prices down . However it seems that
all popular housing types are on average more expensive in the further
outer region.

Table showing correlation between Area and Price over all large regions:

Firstly we did a simple area versus price graph over all regions
unfortunately the graph came out feeling cluttered due to severe
overplotting. So I instead used glance to create a table to show there
is a strong correlation between area and price of housing. We can tell
this as the graph has a relatively high adjusted r squared value of
0.575.

Table showing correlation between Area and Price over the Middle region:

Then we filtered the data to only 1 large region. The points seem to
follow a much clear correlation; this is proven from an increase in
adjusted r squared from 0.575 to 0.730 which shows that there is a much
stronger correlation between price and area when there is less regional
variance.

## Conclusion:

Generally as you move further from the center of London house prices and
price per square foot decreases. However our data tells us that on
average homes in the further outer sector are more expensive than houses
in the outer sector this did not fit with the trend and is likely due to
the prevalence of cheaper terrace housing in the outer region when
compared to the Further Outer region where you may see more suburban
detached family homes. There is a simplistic linear positive correlation
between the area and price of a home; this can be seen as the linear
regression model between the two has a relatively high adjusted r
squared value of 0.575 . When the points are plotted on a scatter plot
you can also see a clear positive correlation particularly when
filtering by region.

## Limitations with our data:

The data set was scraped poorly. It had repeated values under the number
of bathrooms,bedrooms and reception variables. After removing the number
of bathrooms and lobby variables our data set contained a limited amount
of data to manipulate. The data set only contained observations from
certain regions of London.Of the 82 regions with data points almost half
had under 20 data points. This makes our conclusions drawn about how
location affects house price less reliable. The data set gave limited
information on specifics of the properties for example if the houses
were terrace, detached or semi detached. As well as if the homes came
with any land or any amenities.

# Presentation

Our presentation can be found in “presentation.html”

# Data

Kulkarni, A., 2021. Housing Prices in London. \[online\] Kaggle.com.
<https://www.kaggle.com/arnavkulkarni/housing-prices-in-london>
\[Accessed 19 November 2021\].

# References

1.  Data.london.gov.uk. 2021. Ordnance Survey Code-Point Open – London
    Datastore. \[online\] Available at:
    <https://data.london.gov.uk/dataset/ordnance-survey-code-point>
    \[Accessed 29 November 2021\].
