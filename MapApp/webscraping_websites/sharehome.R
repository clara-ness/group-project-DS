library(rvest)

#Specify the website
sharehome <- read_html("http://www.sharehome.ch/index.php?option=com_adsmanager&page=show_result&category_choose=http%3A%2F%2Fwww.sharehome.ch%2Findex.php%3Foption%3Dcom_adsmanager%26page%3Dshow_search%26catid%3D3%26Itemid%3D28&email=&ad_phone=&name=&ad_headline=&ad_text=&ad_rent=&ad_currency=&ad_city=&ad_district=&ad_zip=&ad_taille=&ad_furnished=&ad_citycentre=&order=&expand=&catid=3&Itemid=28")

#Prepare sections
sharehome_sections <- sharehome %>% html_elements(".adsmanager_table_description")
sharehome_sections

#Description of housing
sharehome_titles <- sharehome_sections %>%
  html_element("h2") %>%
  html_text2()
sharehome_titles<-gsub("\\s*\\([^\\)]+\\)","",sharehome_titles)
sharehome_titles     

#Price of housing

sharehome_prices<-'none' 


#Location of housing
sharehome_locations <- sharehome_sections %>%
  html_element(".adsmanager_cat") %>%
  html_text2()
sharehome_locations<-gsub(".*/|\\)","",sharehome_locations)
sharehome_locations


#Link to webpage of housing
sharehome_links <- sharehome_sections %>%
  html_node("a") %>%
  html_attr("href")


#Put the data in a table
sharehome_data <- data.frame(desc = sharehome_titles, prix = sharehome_prices, lieu = sharehome_locations, link = sharehome_links)
#View(sharehome_data)
save(sharehome_data,file="MapApp/webscraping_websites/sharehome.Rda")


