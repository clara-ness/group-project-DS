#install.packages("rvest")
#install.packages("tidyverse")
#rm(list = ls()) 

library(rvest)
library(tidyverse)

#Specify the website
amanet_url <- read_html("https://www.amanet.ch/colocation_geneve-r781182")

#Prepare sections
amanet_sections <- amanet_url %>% html_elements(".listing-card")
amanet_sections

#Description of housing
amanet_titles <- amanet_sections %>%
  html_element("h5") %>%
  html_text2()
amanet_titles

#Price of housing
amanet_prices <- amanet_sections %>%
  html_element("span.price.sclr") %>%
  html_text2()
amanet_prices

#Location of housing
amanet_locations <- amanet_sections %>%
  html_element("div.listitem-detail") %>%
  html_text2()
amanet_locations

#Link to webpage of housing
amanet_links <- amanet_sections %>%
  html_node("a") %>%
  html_attr("href")
amanet_links

#Put the data in a table
amanet_data <- data.frame(desc = amanet_titles, 
                          prix = amanet_prices, 
                          lieu = amanet_locations, 
                          link = amanet_links)

#Remove unwanted parts from amanet_data
amanet_data$prix <- str_remove(amanet_data$prix, " CHF")
amanet_data$lieu <- str_remove(amanet_data$lieu, "Genève - ")
amanet_data$lieu <- str_remove(amanet_data$lieu, ", Genève")

#Save data to rda file
save(amanet_data, file="MapApp/webscraping_websites/amanet.Rda")
