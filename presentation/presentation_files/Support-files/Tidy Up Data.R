# This script is intended to show how we tidy up our data

# Loading required package

library(tidyverse)
library(tidyr)
library(purrr)

# Loading data

London <- read_csv("data/London.csv")

# This function is intended to remove any letter after the numbers in London$region. i.e:W1A -> W1
# This code may takes longer than others.
posremo <- function(postcode) {
  temp = 0
  for(index in c( 1 : (str_length(postcode)))){
    i = substr(postcode, index, index)
    if(!is.na(as.numeric(i))){
      temp = temp+1
    }
    if(is.na(as.numeric(i)) & temp > 0){
      postcode = str_remove(postcode, i)
    }
  }
  return(postcode)
}

# Separate the Outward Code and the Inward Dode in the Postal Code

London <- London%>%
  filter(`City/County` == "London")%>%
  separate(`Postal Code` , c("region","subregion"), " ")%>%
  mutate(
    region = map_chr(region, posremo)
  )

# Divide the whole London into 4 different large regions. The standard of dividing them is available in the presentation.

central <- c("WC","EC","N1","E1","E2","SE1","SW1","W1","NW1")

subcentral <- c("N6","N19","N7","N4","N5","N16","E5","E8","E9","E3","E14","SE16","SE8","SE14","SE4","SE17","SE15","SE5","SE11","SW4","SW8","SW9","SW11","SW3","SW10","SW5","SW7","W2","W8","W9","W11","NW3","NW5","NW6","NW8")

suburban <- c("N3","N2","N10","N22","N8","N17","N15","E17","E10","E11","E20","E15","E7","E12","E6","E13","E16","SE10","SE7","SE3","SE13","SE6","SE23","SE22","SE24","SE21","SE26","SE27","SW2","SW16","SW12","SW17","SW18","SW6","W6","W14","W12","W10","NW10","NW2","NW11")

London <- London%>%
  mutate(
    large_region = case_when(
      region %in% central ~ "A-Central",
      region %in% subcentral ~ "B-Middle",
      region %in% suburban ~ "C-Outer",
      !(region %in% central | region %in% subcentral | region %in% suburban) ~ "D-Further Outer"
    )
  )

# Add price per sq ft to the data

London <- London%>%
  mutate(
    price_per_sq_ft = Price/`Area in sq ft`
  )

# Remove unnecessary columns and write the data

Fixed_London = select(London, -c(7,8,12))
write_csv(Fixed_London, path = "data/Fixed-London.csv")