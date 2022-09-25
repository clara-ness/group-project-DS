library(rvest)

#Specify the website
petitesannonces <- read_html("https://www.petitesannonces.ch/recherche/?tid=270108&q=colocation")

#Prepare sections
petitesannonces_sections <- petitesannonces %>% html_elements(".ele")
petitesannonces_sections

#Description of housing
petitesannonces_titles <- petitesannonces_sections %>%
  html_element(".ela.elht") %>%
  html_text2()
petitesannonces_titles

#Price of housing
petitesannonces_prices <- petitesannonces_sections %>%
  html_element(".ela.elsp") %>%
  html_text2()

petitesannonces_prices[is.na(petitesannonces_prices)]<-'none' 

#Location of housing
petitesannonces_locations <- petitesannonces_sections %>%
  html_element(".elm.elha") %>%
  html_text2()
petitesannonces_locations

#Link to webpage of housing
petitesannonces_links <- petitesannonces_sections %>%
  html_node("a") %>%
  html_attr("href")
petitesannonces_links=paste("https://www.petitesannonces.ch", petitesannonces_links,sep = "")
petitesannonces_links

#Put the data in a table
petitesannonces_data <- data.frame(desc = petitesannonces_titles, prix = petitesannonces_prices, lieu = petitesannonces_locations, link = petitesannonces_links)
save(petitesannonces_data,file="MapApp/webscraping_websites/petitesannonces.Rda")

