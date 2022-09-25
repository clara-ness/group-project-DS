#install.packages("rvest")
#install.packages("tidyverse")
#rm(list = ls()) 

library(rvest)
library(tidyverse)

i <- 1

while (!is_empty(i)) {
  coloc_url <- paste0("http://www.colocataire.ch/page/", i, "/?s=colocation&sa=search&scat=7")
  
  #Specify the website
  colocataire_url <- read_html(coloc_url)
  
  #Prepare sections
  colocataire_sections <- colocataire_url %>% html_elements(".post-block")
  #colocataire_sections
  
  #Description of housing
  colocataire_titles <- colocataire_sections %>%
    html_element("h3") %>%
    html_text2()
  #colocataire_titles
  
  #Price of housing
  colocataire_prices <- colocataire_sections %>%
    html_element("p.post-price") %>%
    html_text2()
  #colocataire_prices
  
  #Location of housing
  colocataire_locations <- colocataire_sections %>%
    html_element("span.dashicons-before.folder") %>%
    html_text2()
  #colocataire_locations
  
  #Date of posting of housing
  colocataire_date <- colocataire_sections %>%
    html_element("span.dashicons-before.clock") %>%
    html_text2()
  #colocataire_date
  
  #Link to webpage of housing
  colocataire_links <- colocataire_sections %>%
    html_node("a") %>%
    html_attr("href")
  #colocataire_links
  
  #Put the data in a table
  colocataire_data <- data.frame(desc = colocataire_titles, 
                                 prix = colocataire_prices, 
                                 lieu = colocataire_locations, 
                                 date = colocataire_date, 
                                 link = colocataire_links)
  
  #Not necessary but here just in case
  #assign(paste("page", i, sep = "_"), colocataire_data)
  
  if (i == 1)
  {
    all_data <- data.frame(matrix(, nrow=0, ncol=0))
  }
  
  all_data <- bind_rows(all_data, colocataire_data)
  
  #Get link for next page
  colocataire_url <- colocataire_url %>%
    html_nodes("a.next") %>%
    html_attr("href")
  colocataire_url
  colocataire_url <- gsub("http://www.colocataire.ch/page/", "", colocataire_url)
  colocataire_url <- gsub("s=colocation&sa=search&scat=7", "", colocataire_url)
  colocataire_url <- str_replace_all(colocataire_url, "[[:punct:]]", "")
  i <- as.numeric(colocataire_url)
}

all_data$lieu <- str_remove(all_data$lieu, ", recherche des colocataires")
all_data$lieu <- str_remove(all_data$lieu, ", Genève")
all_data$lieu <- str_remove(all_data$lieu, ", sous-location/échange")
all_data$prix <- str_remove(all_data$prix, "CHF ")

colocataire_data <- all_data

#Save data to rda file
save(colocataire_data, file="MapApp/webscraping_websites/colocataire.Rda")
