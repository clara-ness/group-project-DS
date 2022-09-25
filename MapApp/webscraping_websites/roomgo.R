#install.packages("rvest")
#install.packages("tidyverse")
#rm(list = ls()) 
#install.packages("sjmisc")

library(rvest)
library(tidyverse)
library(sjmisc)


i <- 1

all_data <- data.frame(Description=character(),
                       Price=character(), 
                       Location=character(), 
                       Link=character(),
                       stringsAsFactors=FALSE) 

roomgo_prices_numeric <- vector()
roomgo_locations_only_communes_string <- vector()


Communes <- c('Aire-la-Ville',
              'Anières',
              'Avully',
              'Avusy',
              'Bardonnex',
              'Bellevue',
              'Bernex',
              'Carouge',
              'Cartigny',
              'Céligny',
              'Chancy',
              'Chêne-Bougeries',
              'Chêne-Bourg',
              'Choulex',
              'Collex-Bossy',
              'Collonge-Bellerive',
              'Cologny',
              'Confignon',
              'Corsier',
              'Dardagny',
              'Genève',
              'Genthod',
              'Le Grand-Saconnex',
              'Gy',
              'Hermance',
              'Jussy',
              'Laconnex',
              'Lancy',
              'Meinier',
              'Meyrin',
              'Onex',
              'Perly-Certoux',
              'Plan-les-Ouates',
              'Pregny-Chambésy',
              'Présinge',
              'Puplinge',
              'Russin',
              'Satigny',
              'Soral',
              'Thônex',
              'Troinex',
              'Vandoeuvres',
              'Vernier',
              'Versoix',
              'Veyrier')

for (i in 1:10){
  
  roomgo <- paste0("https://www.roomgo.ch/romandie/colocation-geneve-genf?page=", i, "#room-ads-area")
  
  #Specify the website
  roomgo <- read_html(roomgo)
  
  
  #Prepare sections
  roomgo_sections <- roomgo %>% html_elements(".listing_item")
  #roomgo_sections
  
  
  #Description of housing
  roomgo_titles <- roomgo_sections %>%
    html_element("div.grey.heading.heading--small.heading-bold.margin-bottom-2") %>%
    html_text2()
  #roomgo_titles
  
  
  #Price of housing
  roomgo_prices <- roomgo_sections %>%
    html_element("div.listing_item_price") %>%
    html_text2()
  #Clean roomgo_prices
  roomgo_prices <- gsub(" CHF / Mois", "",roomgo_prices)
  roomgo_prices <- gsub("'", "",roomgo_prices)
  
  #Transform prices into numeric
  roomgo_prices_numeric <- append(roomgo_prices_numeric,as.numeric(roomgo_prices))
  class(roomgo_prices_numeric)
  
  
  #Location of housing
  roomgo_locations <- roomgo_sections %>%
    html_element("span.listing_item_address") %>%
    html_text2()
  #roomgo_locations
  
  
  #Link to webpage of housing
  roomgo_links <- roomgo_sections %>%
    html_node("a") %>%
    html_attr("href")
  #roomgo_links
  roomgo_links <- paste("https://www.roomgo.ch",roomgo_links,sep = "")
  
  #Put the data in a table
  roomgo_data <- data.frame(desc = roomgo_titles, 
                            prix = roomgo_prices_numeric, 
                            lieu = roomgo_locations, 
                            link = roomgo_links,
                            stringsAsFactors=FALSE)
  
  all_data <- rbind(all_data, roomgo_data)
  i <- i+1
}

#all_data

#From the complete address in characters, we output only the communes
x<- nrow(all_data)
h<-1
j<-1

for (j in 1:x) {
  #all_data[j, 3] <- as.String(all_data[j, 3])
  for (h in 1:45) {
    if (str_contains(all_data[j, 3], Communes[h]) == TRUE) {
      all_data[j, 3] <- Communes[h]
    } else if(str_contains(all_data[j, 3],'Vessy')) {
      all_data[j,3]<- Communes[45]
    } else if(str_contains(all_data[j, 3],'Châtelaine')) {
      all_data[j,3]<- Communes[43]
    } else if(str_contains(all_data[j, 3],'Pâquis-Nations')) {
      all_data[j,3]<- Communes[21]
    }else if(str_contains(all_data[j, 3],'Eaux-Vives')) {
      all_data[j,3]<- Communes[21]
    }else if(str_contains(all_data[j, 3],'Champel')) {
      all_data[j,3]<- Communes[21]
    }else if(str_contains(all_data[j, 3],'Saint-Jean - Charmilles')) {
      all_data[j,3]<- Communes[21]
    }else{
      h <- h + 1
    }
  }
}
all_data

save(all_data,file="MapApp/webscraping_websites/roomgo.Rda")