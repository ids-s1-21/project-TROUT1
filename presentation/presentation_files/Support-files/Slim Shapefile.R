# This file is to show how I slim the shapefile that is too large.
# You have to download the original shapefile to regenerate the slimed shapefile the file I did.

# You can download original shapefile
# from: https://data.london.gov.uk/dataset/ordnance-survey-code-point
# Then download "Code-Point London(shapefile)"
# Or use this link directly: 
# https://data.london.gov.uk/download/ordnance-survey-code-point/69919411-89c5-4dab-a345-1733a304fd39/Code-Point%20London%20(shapefile).zip
# This script takes about 15 min on my local Rstudio to run.
# (My laptop is MacBookPro 2019 with i9-9880H)

# Read the original file

London_map <- st_read("Your path to the original file", stringsAsFactors = FALSE)

# Since we are only considering London but not greater London, we need to
# filter all regions that are not in London.
# The following are the four large regions that we are considering. The 
# string in the list represents a District Code of a postcode.


central <- c("WC","EC","N1","E1","E2","SE1","SW1","W1","NW1")

subcentral <- c("N6","N19","N7","N4","N5","N16","E5","E8","E9","E3","E14","SE16","SE8",
                "SE14","SE4","SE17","SE15","SE5","SE11","SW4","SW8","SW9","SW11","SW3",
                "SW10","SW5","SW7","W2","W8","W9","W11","NW3","NW5","NW6","NW8")

suburban <- c("N3","N2","N10","N22","N8","N17","N15","E17","E10","E11","E20","E15","E7",
              "E12","E6","E13","E16","SE10","SE7","SE3","SE13","SE6","SE23","SE22","SE24",
              "SE21","SE26","SE27","SW2","SW16","SW12","SW17","SW18","SW6","W6","W14",
              "W12","W10","NW10","NW2","NW11")

other <- c("NW4","NW7","NW9","N9","N11","N12","N13","N14","N18","N20","N21","E4","E18",
           "SE28","SW18","SE9","SE2","SE12","SE19","SE20","SE25","SW19","SW20","SW13",
           "SW14","SW15","W3","W4","W5","W7","W13")

#This function can turn any Outward Code to District Code. e.g: W1X -> W1, SW1N -> SW1, N1 -> N1

posremo <- function(postcode) {
  temp = 0
  for(index in c( 1 : (str_length(postcode)))){
    i = substr(postcode, index, index)
    if(!is.na(as.numeric(i))){
      temp = temp+1
    }
    if(is.na(as.numeric(i)) & temp > 0){
      postcode = substr(postcode, 0,index-1)
    }
  }
  return(postcode)
}

# Since in the original shapefile, there are variables of geometry and postcode,
# so we need to generate the District Code for each postcode to match the data
# of our housing price data.
# Now we generate the District Code for each postcode in the original shapefile

cleaned_map <- London_map%>%
  mutate(
    Outward_code = substr(postcode, 0, nchar(postcode)-3),
    District_code = map_chr(Outward_code, posremo)
  )%>%
  # The following code was written before I find out ways to generate District
  # Code, so it might seems strange. But I am not going to change it since I
  # don't know what will happen if I change it.
  filter(
    substr(postcode,0,2) %in% c(central, subcentral, suburban, other) |
      substr(postcode,0,3) %in% c(central, subcentral, suburban, other) |
      substr(postcode,0,4) %in% c(central, subcentral, suburban, other)
  )

# Now import the housing price data we fixed before.

London <- read_csv("Fixed-London.csv")
mean_Price_Dictionary <- London%>%
  group_by(region)%>%
  summarise(
    Mean_Price = mean(price_per_sq_ft)
  )

# This function accepts a District Code and find if it present in the 
# mean_Price_Dictionary we generated before. In the dictionary, there are
# two columns: District Code and mean housing price per sq ft. If the given
# District Code match with one of the District Code in the dictionary, this
# function will return the corresponding mean housing price

find_mean_price <- function(District_code){
  result = NA
  for (row in c(1 : nrow(mean_Price_Dictionary))){
    if(mean_Price_Dictionary[row,1] == District_code){
      result = as.numeric(mean_Price_Dictionary[row,2])
    }
  }
  return(result)
}

# This process is more like emerging two datafames. However, in the shapefile,
# many columns can have the same District Code but different geometry information.
# (That's why we cannot just group them up and use a key to emerge the data)
# So we are going to use the function above and a map_dbl function to generate a
# new column for our shapefile.


cleaned_map <- cleaned_map%>%
  mutate(
    mean_price_per_sqft = map_dbl(District_code, find_mean_price)
  )%>%
  select(c(1,2,3,14,16))

# Now write the final file. You can customize

st_write(cleaned_map, "Fixed-London-Map.shp")
