#install.packages("rvest")
#install.packages("tidyverse")
#install.packages("devtools")
#rm(list = ls()) 

#Installs deeplr package which translates commune descriptions to english
library(devtools)
#devtools::install_github("zumbov2/deeplr")

library(rvest)
library(tidyverse)
library(deeplr)

#API key for DeepL
my_key <- paste0("31a358cf-b8d0-793f-1ce4-c187513da695:fx")

###############################################################################
#Part 1: Scrape main page with all commune data
###############################################################################

#Specify the website
communes_url <- read_html("https://fr.wikipedia.org/wiki/Communes_du_canton_de_Genève")

#Get table with housing data
communes_table <- communes_url %>% 
  html_element(xpath = '//*[@id="mw-content-text"]/div[1]/table[1]') %>%
  html_table()

#Remove unwanted rows & columns from communes_table
communes_table <- communes_table[-c(46, 47), ]
communes_table$`N° OFS[1]` <- NULL

#Rename columns
names(communes_table)[1] <- "Commune"
names(communes_table)[2] <- "Population (2018)"
names(communes_table)[3] <- "Surface Area (km^2)"
names(communes_table)[4] <- "Population Density (habitant/km^2)"

#Get links of communes
communes_links <- communes_url %>% 
  html_nodes("td:nth-child(1) a") %>%
  html_attr("href")
communes_links <- as.data.frame(communes_links)

#Fix & remove links from communes_links
communes_links <- communes_links[-c(46:131), ]
communes_links <- paste0("https://fr.wikipedia.org", communes_links)
communes_links <- as.data.frame(communes_links)

#Combine data
communes_data <- data.frame(communes_table, communes_links)

#Rename columns
names(communes_data)[5] <- "link"

###############################################################################
#Part 2: Scrape Commune pages
###############################################################################

#Create new dataframe with only commune names and links
#name_link <- communes_data
#name_link$Population..2018. <- NULL
#name_link$Surface.Area..km.2. <- NULL
#name_link$Population.Density..habitant.km.2. <- NULL

i <- 1

commune_desc <- list()

###############################################################################
#Commune 1

url_var <- communes_links %>% slice(i)
commune_url <- paste0(url_var)
commune_page <- read_html(commune_url)

commune_desc1 <- commune_page %>% 
  html_element("p:nth-child(7)") %>% 
  html_text2()
commune_desc1

commune_desc2 <- commune_page %>% 
  html_element("p:nth-child(8)") %>% 
  html_text2()
commune_desc2

commune_desc[i] <- paste0(commune_desc1, 
                          " ", commune_desc2)
commune_desc

i <- i + 1

###############################################################################
#Commune 2

url_var <- communes_links %>% slice(i)
commune_url <- paste0(url_var)
commune_page <- read_html(commune_url)

commune_desc1 <- commune_page %>% 
  html_element("p:nth-child(8)") %>% 
  html_text2()
commune_desc1

commune_desc2 <- commune_page %>% 
  html_element("p:nth-child(10)") %>% 
  html_text2()
commune_desc2

commune_desc3 <- commune_page %>% 
  html_element("p:nth-child(11)") %>% 
  html_text2()
commune_desc3

commune_desc[i] <- paste0(commune_desc1, 
                          " ", commune_desc2, 
                          " ", commune_desc3)
commune_desc

i <- i + 1

###############################################################################
#Commune 3

url_var <- communes_links %>% slice(i)
commune_url <- paste0(url_var)
commune_page <- read_html(commune_url)

commune_desc1 <- commune_page %>% 
  html_element("p:nth-child(6)") %>% 
  html_text2()
commune_desc1

commune_desc2 <- commune_page %>% 
  html_element("p:nth-child(7)") %>% 
  html_text2()
commune_desc2

commune_desc[i] <- paste0(commune_desc1, 
                          " ", commune_desc2)
commune_desc

i <- i + 1

###############################################################################
#Commune 4

url_var <- communes_links %>% slice(i)
commune_url <- paste0(url_var)
commune_page <- read_html(commune_url)

commune_desc1 <- commune_page %>% 
  html_element("p:nth-child(6)") %>% 
  html_text2()
commune_desc1

commune_desc2 <- commune_page %>% 
  html_element("p:nth-child(7)") %>% 
  html_text2()
commune_desc2

commune_desc3 <- commune_page %>% 
  html_element("p:nth-child(8)") %>% 
  html_text2()
commune_desc3

commune_desc[i] <- paste0(commune_desc1, 
                          " ", commune_desc2, 
                          " ", commune_desc3)
commune_desc

i <- i + 1

###############################################################################
#Commune 5

url_var <- communes_links %>% slice(i)
commune_url <- paste0(url_var)
commune_page <- read_html(commune_url)

commune_desc1 <- commune_page %>% 
  html_element("p:nth-child(10)") %>% 
  html_text2()
commune_desc1

commune_desc2 <- commune_page %>% 
  html_element("p:nth-child(11)") %>% 
  html_text2()
commune_desc2

commune_desc3 <- commune_page %>% 
  html_element("p:nth-child(12)") %>% 
  html_text2()
commune_desc3

commune_desc[i] <- paste0(commune_desc1, 
                          " ", commune_desc2, 
                          " ", commune_desc3)
commune_desc

i <- i + 1

###############################################################################
#Commune 6

url_var <- communes_links %>% slice(i)
commune_url <- paste0(url_var)
commune_page <- read_html(commune_url)

commune_desc1 <- commune_page %>% 
  html_element("p:nth-child(7)") %>% 
  html_text2()
commune_desc1

commune_desc2 <- commune_page %>% 
  html_element("p:nth-child(8)") %>% 
  html_text2()
commune_desc2

commune_desc3 <- commune_page %>% 
  html_element("p:nth-child(9)") %>% 
  html_text2()
commune_desc3

commune_desc[i] <- paste0(commune_desc1, 
                          " ", commune_desc2, 
                          " ", commune_desc3)
commune_desc

i <- i + 1

###############################################################################
#Commune 7

url_var <- communes_links %>% slice(i)
commune_url <- paste0(url_var)
commune_page <- read_html(commune_url)

commune_desc1 <- commune_page %>% 
  html_element("p:nth-child(10)") %>% 
  html_text2()
commune_desc1

commune_desc2 <- commune_page %>% 
  html_element("p:nth-child(11)") %>% 
  html_text2()
commune_desc2

commune_desc[i] <- paste0(commune_desc1, 
                          " ", commune_desc2)
commune_desc

i <- i + 1

###############################################################################
#Commune 8

url_var <- communes_links %>% slice(i)
commune_url <- paste0(url_var)
commune_page <- read_html(commune_url)

commune_desc1 <- commune_page %>% 
  html_element("p:nth-child(8)") %>% 
  html_text2()
commune_desc1

commune_desc2 <- commune_page %>% 
  html_element("p:nth-child(9)") %>% 
  html_text2()
commune_desc2

commune_desc3 <- commune_page %>% 
  html_element("p:nth-child(10)") %>% 
  html_text2()
commune_desc3

commune_desc[i] <- paste0(commune_desc1, 
                          " ", commune_desc2, 
                          " ", commune_desc3)
commune_desc

i <- i + 1

###############################################################################
#Commune 9

url_var <- communes_links %>% slice(i)
commune_url <- paste0(url_var)
commune_page <- read_html(commune_url)

commune_desc1 <- commune_page %>% 
  html_element("p:nth-child(11)") %>% 
  html_text2()
commune_desc1

commune_desc2 <- commune_page %>% 
  html_element("p:nth-child(12)") %>% 
  html_text2()
commune_desc2

commune_desc3 <- commune_page %>% 
  html_element("p:nth-child(13)") %>% 
  html_text2()
commune_desc3

commune_desc[i] <- paste0(commune_desc1, 
                          " ", commune_desc2, 
                          " ", commune_desc3)
commune_desc

i <- i + 1

###############################################################################
#Commune 10

url_var <- communes_links %>% slice(i)
commune_url <- paste0(url_var)
commune_page <- read_html(commune_url)

commune_desc1 <- commune_page %>% 
  html_element("p:nth-child(6)") %>% 
  html_text2()
commune_desc1

commune_desc2 <- commune_page %>% 
  html_element("p:nth-child(7)") %>% 
  html_text2()
commune_desc2

commune_desc3 <- commune_page %>% 
  html_element("p:nth-child(8)") %>% 
  html_text2()
commune_desc3

commune_desc4 <- commune_page %>% 
  html_element("p:nth-child(9)") %>% 
  html_text2()
commune_desc4

commune_desc[i] <- paste0(commune_desc1, 
                          " ", commune_desc2, 
                          " ", commune_desc3, 
                          " ", commune_desc4)
commune_desc

i <- i + 1

###############################################################################
#Commune 11

url_var <- communes_links %>% slice(i)
commune_url <- paste0(url_var)
commune_page <- read_html(commune_url)

commune_desc1 <- commune_page %>% 
  html_element("p:nth-child(7)") %>% 
  html_text2()
commune_desc1

commune_desc2 <- commune_page %>% 
  html_element("p:nth-child(8)") %>% 
  html_text2()
commune_desc2

commune_desc3 <- commune_page %>% 
  html_element("p:nth-child(9)") %>% 
  html_text2()
commune_desc3

commune_desc[i] <- paste0(commune_desc1, 
                          " ", commune_desc2, 
                          " ", commune_desc3)
commune_desc

i <- i + 1

###############################################################################
#Commune 12

url_var <- communes_links %>% slice(i)
commune_url <- paste0(url_var)
commune_page <- read_html(commune_url)

commune_desc1 <- commune_page %>% 
  html_element("p:nth-child(7)") %>% 
  html_text2()
commune_desc1

commune_desc2 <- commune_page %>% 
  html_element("p:nth-child(8)") %>% 
  html_text2()
commune_desc2

commune_desc3 <- commune_page %>% 
  html_element("p:nth-child(9)") %>% 
  html_text2()
commune_desc3

commune_desc[i] <- paste0(commune_desc1, 
                          " ", commune_desc2, 
                          " ", commune_desc3)
commune_desc

i <- i + 1

###############################################################################
#Commune 13

url_var <- communes_links %>% slice(i)
commune_url <- paste0(url_var)
commune_page <- read_html(commune_url)

commune_desc1 <- commune_page %>% 
  html_element("p:nth-child(8)") %>% 
  html_text2()
commune_desc1

commune_desc2 <- commune_page %>% 
  html_element("p:nth-child(9)") %>% 
  html_text2()
commune_desc2

commune_desc3 <- commune_page %>% 
  html_element("p:nth-child(10)") %>% 
  html_text2()
commune_desc3

commune_desc4 <- commune_page %>% 
  html_element("p:nth-child(11)") %>% 
  html_text2()
commune_desc4

commune_desc[i] <- paste0(commune_desc1, 
                          " ", commune_desc2, 
                          " ", commune_desc3, 
                          " ", commune_desc4)
commune_desc

i <- i + 1

###############################################################################
#Commune 14

url_var <- communes_links %>% slice(i)
commune_url <- paste0(url_var)
commune_page <- read_html(commune_url)

commune_desc1 <- commune_page %>% 
  html_element("p:nth-child(6)") %>% 
  html_text2()
commune_desc1

commune_desc2 <- commune_page %>% 
  html_element("p:nth-child(7)") %>% 
  html_text2()
commune_desc2

commune_desc[i] <- paste0(commune_desc1, 
                          " ", commune_desc2)
commune_desc

i <- i + 1

###############################################################################
#Commune 15

url_var <- communes_links %>% slice(i)
commune_url <- paste0(url_var)
commune_page <- read_html(commune_url)

commune_desc1 <- commune_page %>% 
  html_element("p:nth-child(7)") %>% 
  html_text2()
commune_desc1

commune_desc2 <- commune_page %>% 
  html_element("p:nth-child(8)") %>% 
  html_text2()
commune_desc2

commune_desc3 <- commune_page %>% 
  html_element("p:nth-child(9)") %>% 
  html_text2()
commune_desc3

commune_desc4 <- commune_page %>% 
  html_element("p:nth-child(10)") %>% 
  html_text2()
commune_desc4

commune_desc[i] <- paste0(commune_desc1, 
                          " ", commune_desc2, 
                          " ", commune_desc3, 
                          " ", commune_desc4)
commune_desc

i <- i + 1

###############################################################################
#Commune 16

url_var <- communes_links %>% slice(i)
commune_url <- paste0(url_var)
commune_page <- read_html(commune_url)

commune_desc1 <- commune_page %>% 
  html_element("p:nth-child(8)") %>% 
  html_text2()
commune_desc1

commune_desc2 <- commune_page %>% 
  html_element("p:nth-child(9)") %>% 
  html_text2()
commune_desc2

commune_desc3 <- commune_page %>% 
  html_element("p:nth-child(10)") %>% 
  html_text2()
commune_desc3

commune_desc[i] <- paste0(commune_desc1, 
                          " ", commune_desc2, 
                          " ", commune_desc3)
commune_desc

i <- i + 1

###############################################################################
#Commune 17

url_var <- communes_links %>% slice(i)
commune_url <- paste0(url_var)
commune_page <- read_html(commune_url)

commune_desc1 <- commune_page %>% 
  html_element("p:nth-child(9)") %>% 
  html_text2()
commune_desc1

commune_desc2 <- commune_page %>% 
  html_element("p:nth-child(10)") %>% 
  html_text2()
commune_desc2

commune_desc3 <- commune_page %>% 
  html_element("p:nth-child(11)") %>% 
  html_text2()
commune_desc3

commune_desc[i] <- paste0(commune_desc1, 
                          " ", commune_desc2, 
                          " ", commune_desc3)
commune_desc

i <- i + 1

###############################################################################
#Commune 18

url_var <- communes_links %>% slice(i)
commune_url <- paste0(url_var)
commune_page <- read_html(commune_url)

commune_desc1 <- commune_page %>% 
  html_element("p:nth-child(8)") %>% 
  html_text2()
commune_desc1

commune_desc2 <- commune_page %>% 
  html_element("p:nth-child(9)") %>% 
  html_text2()
commune_desc2

commune_desc[i] <- paste0(commune_desc1, 
                          " ", commune_desc2)
commune_desc

i <- i + 1

###############################################################################
#Commune 19

url_var <- communes_links %>% slice(i)
commune_url <- paste0(url_var)
commune_page <- read_html(commune_url)

commune_desc1 <- commune_page %>% 
  html_element("p:nth-child(7)") %>% 
  html_text2()
commune_desc1

commune_desc2 <- commune_page %>% 
  html_element("p:nth-child(8)") %>% 
  html_text2()
commune_desc2

commune_desc[i] <- paste0(commune_desc1, 
                          " ", commune_desc2)
commune_desc

i <- i + 1

###############################################################################
#Commune 20

url_var <- communes_links %>% slice(i)
commune_url <- paste0(url_var)
commune_page <- read_html(commune_url)

commune_desc1 <- commune_page %>% 
  html_element("p:nth-child(6)") %>% 
  html_text2()
commune_desc1

commune_desc2 <- commune_page %>% 
  html_element("p:nth-child(7)") %>% 
  html_text2()
commune_desc2

commune_desc3 <- commune_page %>% 
  html_element("p:nth-child(8)") %>% 
  html_text2()
commune_desc3

commune_desc[i] <- paste0(commune_desc1, 
                          " ", commune_desc2, 
                          " ", commune_desc3)
commune_desc

i <- i + 1

###############################################################################
#Commune 21

url_var <- communes_links %>% slice(i)
commune_url <- paste0(url_var)
commune_page <- read_html(commune_url)

commune_desc1 <- commune_page %>% 
  html_element("p:nth-child(14)") %>% 
  html_text2()
commune_desc1

commune_desc2 <- commune_page %>% 
  html_element("p:nth-child(15)") %>% 
  html_text2()
commune_desc2

commune_desc3 <- commune_page %>% 
  html_element("p:nth-child(16)") %>% 
  html_text2()
commune_desc3

commune_desc4 <- commune_page %>% 
  html_element("p:nth-child(17)") %>% 
  html_text2()
commune_desc4

commune_desc[i] <- paste0(commune_desc1, 
                          " ", commune_desc2, 
                          " ", commune_desc3, 
                          " ", commune_desc4)
commune_desc

i <- i + 1

###############################################################################
#Commune 22

url_var <- communes_links %>% slice(i)
commune_url <- paste0(url_var)
commune_page <- read_html(commune_url)

commune_desc1 <- commune_page %>% 
  html_element("p:nth-child(7)") %>% 
  html_text2()
commune_desc1

commune_desc2 <- commune_page %>% 
  html_element("p:nth-child(8)") %>% 
  html_text2()
commune_desc2

commune_desc[i] <- paste0(commune_desc1, 
                          " ", commune_desc2)
commune_desc

i <- i + 1

###############################################################################
#Commune 23

url_var <- communes_links %>% slice(i)
commune_url <- paste0(url_var)
commune_page <- read_html(commune_url)

commune_desc1 <- commune_page %>% 
  html_element("p:nth-child(8)") %>% 
  html_text2()
commune_desc1

commune_desc2 <- commune_page %>% 
  html_element("p:nth-child(9)") %>% 
  html_text2()
commune_desc2

commune_desc3 <- commune_page %>% 
  html_element("p:nth-child(10)") %>% 
  html_text2()
commune_desc3

commune_desc[i] <- paste0(commune_desc1, 
                          " ", commune_desc2, 
                          " ", commune_desc3)
commune_desc

i <- i + 1

###############################################################################
#Commune 24

url_var <- communes_links %>% slice(i)
commune_url <- paste0(url_var)
commune_page <- read_html(commune_url)

commune_desc1 <- commune_page %>% 
  html_element("p:nth-child(9)") %>% 
  html_text2()
commune_desc1

commune_desc2 <- commune_page %>% 
  html_element("p:nth-child(10)") %>% 
  html_text2()
commune_desc2

commune_desc3 <- commune_page %>% 
  html_element("p:nth-child(11)") %>% 
  html_text2()
commune_desc3

commune_desc[i] <- paste0(commune_desc1, 
                          " ", commune_desc2, 
                          " ", commune_desc3)
commune_desc

i <- i + 1

###############################################################################
#Commune 25

url_var <- communes_links %>% slice(i)
commune_url <- paste0(url_var)
commune_page <- read_html(commune_url)

commune_desc1 <- commune_page %>% 
  html_element("p:nth-child(6)") %>% 
  html_text2()
commune_desc1

commune_desc2 <- commune_page %>% 
  html_element("p:nth-child(7)") %>% 
  html_text2()
commune_desc2

commune_desc[i] <- paste0(commune_desc1, 
                          " ", commune_desc2)
commune_desc

i <- i + 1

###############################################################################
#Commune 26

url_var <- communes_links %>% slice(i)
commune_url <- paste0(url_var)
commune_page <- read_html(commune_url)

commune_desc1 <- commune_page %>% 
  html_element("p:nth-child(6)") %>% 
  html_text2()
commune_desc1

commune_desc2 <- commune_page %>% 
  html_element("p:nth-child(7)") %>% 
  html_text2()
commune_desc2

commune_desc[i] <- paste0(commune_desc1, 
                          " ", commune_desc2)
commune_desc

i <- i + 1

###############################################################################
#Commune 27

url_var <- communes_links %>% slice(i)
commune_url <- paste0(url_var)
commune_page <- read_html(commune_url)

commune_desc1 <- commune_page %>% 
  html_element("p:nth-child(7)") %>% 
  html_text2()
commune_desc1

commune_desc2 <- commune_page %>% 
  html_element("p:nth-child(8)") %>% 
  html_text2()
commune_desc2

commune_desc3 <- commune_page %>% 
  html_element("p:nth-child(9)") %>% 
  html_text2()
commune_desc3

commune_desc4 <- commune_page %>% 
  html_element("p:nth-child(10)") %>% 
  html_text2()
commune_desc4

commune_desc[i] <- paste0(commune_desc1, 
                          " ", commune_desc2, 
                          " ", commune_desc3, 
                          " ", commune_desc4)
commune_desc

i <- i + 1

###############################################################################
#Commune 28

url_var <- communes_links %>% slice(i)
commune_url <- paste0(url_var)
commune_page <- read_html(commune_url)

commune_desc1 <- commune_page %>% 
  html_element("p:nth-child(7)") %>% 
  html_text2()
commune_desc1

commune_desc2 <- commune_page %>% 
  html_element("p:nth-child(8)") %>% 
  html_text2()
commune_desc2

commune_desc3 <- commune_page %>% 
  html_element("p:nth-child(9)") %>% 
  html_text2()
commune_desc3

commune_desc4 <- commune_page %>% 
  html_element("p:nth-child(10)") %>% 
  html_text2()
commune_desc4

commune_desc[i] <- paste0(commune_desc1, 
                          " ", commune_desc2, 
                          " ", commune_desc3, 
                          " ", commune_desc4)
commune_desc

i <- i + 1

###############################################################################
#Commune 29

url_var <- communes_links %>% slice(i)
commune_url <- paste0(url_var)
commune_page <- read_html(commune_url)

commune_desc1 <- commune_page %>% 
  html_element("p:nth-child(6)") %>% 
  html_text2()
commune_desc1

commune_desc2 <- commune_page %>% 
  html_element("p:nth-child(7)") %>% 
  html_text2()
commune_desc2

commune_desc[i] <- paste0(commune_desc1, 
                          " ", commune_desc2)
commune_desc

i <- i + 1

###############################################################################
#Commune 30

url_var <- communes_links %>% slice(i)
commune_url <- paste0(url_var)
commune_page <- read_html(commune_url)

commune_desc1 <- commune_page %>% 
  html_element("p:nth-child(6)") %>% 
  html_text2()
commune_desc1

commune_desc2 <- commune_page %>% 
  html_element("p:nth-child(7)") %>% 
  html_text2()
commune_desc2

commune_desc[i] <- paste0(commune_desc1, 
                          " ", commune_desc2)
commune_desc

i <- i + 1

###############################################################################
#Commune 31

url_var <- communes_links %>% slice(i)
commune_url <- paste0(url_var)
commune_page <- read_html(commune_url)

commune_desc1 <- commune_page %>% 
  html_element("p:nth-child(7)") %>% 
  html_text2()
commune_desc1

commune_desc2 <- commune_page %>% 
  html_element("p:nth-child(8)") %>% 
  html_text2()
commune_desc2

commune_desc3 <- commune_page %>% 
  html_element("p:nth-child(9)") %>% 
  html_text2()
commune_desc3

commune_desc4 <- commune_page %>% 
  html_element("p:nth-child(10)") %>% 
  html_text2()
commune_desc4

commune_desc5 <- commune_page %>% 
  html_element("p:nth-child(11)") %>% 
  html_text2()
commune_desc5

commune_desc[i] <- paste0(commune_desc1, 
                          " ", commune_desc2, 
                          " ", commune_desc3, 
                          " ", commune_desc4, 
                          " ", commune_desc5)
commune_desc

i <- i + 1

###############################################################################
#Commune 32

url_var <- communes_links %>% slice(i)
commune_url <- paste0(url_var)
commune_page <- read_html(commune_url)

commune_desc1 <- commune_page %>% 
  html_element("p:nth-child(14)") %>% 
  html_text2()
commune_desc1

commune_desc2 <- commune_page %>% 
  html_element("p:nth-child(15)") %>% 
  html_text2()
commune_desc2

commune_desc3 <- commune_page %>% 
  html_element("p:nth-child(16)") %>% 
  html_text2()
commune_desc3

commune_desc4 <- commune_page %>% 
  html_element("p:nth-child(17)") %>% 
  html_text2()
commune_desc4

commune_desc5 <- commune_page %>% 
  html_element("p:nth-child(18)") %>% 
  html_text2()
commune_desc5

commune_desc6 <- commune_page %>% 
  html_element("p:nth-child(19)") %>% 
  html_text2()
commune_desc6

commune_desc[i] <- paste0(commune_desc1, 
                          " ", commune_desc2, 
                          " ", commune_desc3, 
                          " ", commune_desc4, 
                          " ", commune_desc5, 
                          " ", commune_desc6)
commune_desc

i <- i + 1

###############################################################################
#Commune 33

url_var <- communes_links %>% slice(i)
commune_url <- paste0(url_var)
commune_page <- read_html(commune_url)

commune_desc1 <- commune_page %>% 
  html_element("p:nth-child(8)") %>% 
  html_text2()
commune_desc1

commune_desc2 <- commune_page %>% 
  html_element("p:nth-child(9)") %>% 
  html_text2()
commune_desc2

commune_desc[i] <- paste0(commune_desc1, 
                          " ", commune_desc2)
commune_desc

i <- i + 1

###############################################################################
#Commune 34

url_var <- communes_links %>% slice(i)
commune_url <- paste0(url_var)
commune_page <- read_html(commune_url)

commune_desc1 <- commune_page %>% 
  html_element("p:nth-child(7)") %>% 
  html_text2()
commune_desc1

commune_desc2 <- commune_page %>% 
  html_element("p:nth-child(8)") %>% 
  html_text2()
commune_desc2

commune_desc3 <- commune_page %>% 
  html_element("p:nth-child(9)") %>% 
  html_text2()
commune_desc3

commune_desc4 <- commune_page %>% 
  html_element("p:nth-child(10)") %>% 
  html_text2()
commune_desc4

commune_desc5 <- commune_page %>% 
  html_element("p:nth-child(11)") %>% 
  html_text2()
commune_desc5

commune_desc[i] <- paste0(commune_desc1, 
                          " ", commune_desc2, 
                          " ", commune_desc3, 
                          " ", commune_desc4, 
                          " ", commune_desc5)
commune_desc

i <- i + 1

###############################################################################
#Commune 35

url_var <- communes_links %>% slice(i)
commune_url <- paste0(url_var)
commune_page <- read_html(commune_url)

commune_desc1 <- commune_page %>% 
  html_element("p:nth-child(8)") %>% 
  html_text2()
commune_desc1

commune_desc2 <- commune_page %>% 
  html_element("p:nth-child(9)") %>% 
  html_text2()
commune_desc2

commune_desc[i] <- paste0(commune_desc1, 
                          " ", commune_desc2)
commune_desc

i <- i + 1

###############################################################################
#Commune 36

url_var <- communes_links %>% slice(i)
commune_url <- paste0(url_var)
commune_page <- read_html(commune_url)

commune_desc1 <- commune_page %>% 
  html_element("p:nth-child(7)") %>% 
  html_text2()
commune_desc1

commune_desc2 <- commune_page %>% 
  html_element("p:nth-child(8)") %>% 
  html_text2()
commune_desc2

commune_desc[i] <- paste0(commune_desc1, 
                          " ", commune_desc2)
commune_desc

i <- i + 1

###############################################################################
#Commune 37

url_var <- communes_links %>% slice(i)
commune_url <- paste0(url_var)
commune_page <- read_html(commune_url)

commune_desc1 <- commune_page %>% 
  html_element("p:nth-child(6)") %>% 
  html_text2()
commune_desc1

commune_desc2 <- commune_page %>% 
  html_element("p:nth-child(7)") %>% 
  html_text2()
commune_desc2

commune_desc[i] <- paste0(commune_desc1, 
                          " ", commune_desc2)
commune_desc

i <- i + 1

###############################################################################
#Commune 38

url_var <- communes_links %>% slice(i)
commune_url <- paste0(url_var)
commune_page <- read_html(commune_url)

commune_desc1 <- commune_page %>% 
  html_element("p:nth-child(7)") %>% 
  html_text2()
commune_desc1

commune_desc2 <- commune_page %>% 
  html_element("p:nth-child(8)") %>% 
  html_text2()
commune_desc2

commune_desc3 <- commune_page %>% 
  html_element("p:nth-child(9)") %>% 
  html_text2()
commune_desc3

commune_desc[i] <- paste0(commune_desc1, 
                          " ", commune_desc2, 
                          " ", commune_desc3)
commune_desc

i <- i + 1

###############################################################################
#Commune 39

url_var <- communes_links %>% slice(i)
commune_url <- paste0(url_var)
commune_page <- read_html(commune_url)

commune_desc1 <- commune_page %>% 
  html_element("p:nth-child(7)") %>% 
  html_text2()
commune_desc1

commune_desc[i] <- paste0(commune_desc1)
commune_desc

i <- i + 1

###############################################################################
#Commune 40

url_var <- communes_links %>% slice(i)
commune_url <- paste0(url_var)
commune_page <- read_html(commune_url)

commune_desc1 <- commune_page %>% 
  html_element("p:nth-child(6)") %>% 
  html_text2()
commune_desc1

#Special case due to bullet points
commune_desc2 <- commune_page %>% 
  html_element("ul:nth-child(7) > li:nth-child(1)") %>% 
  html_text2()
commune_desc2

#Special case due to bullet points
commune_desc3 <- commune_page %>% 
  html_element("ul:nth-child(7) > li:nth-child(2)") %>% 
  html_text2()
commune_desc3

#Special case due to bullet points
commune_desc4 <- commune_page %>% 
  html_element("ul:nth-child(7) > li:nth-child(3)") %>% 
  html_text2()
commune_desc4

commune_desc5 <- commune_page %>% 
  html_element("p:nth-child(8)") %>% 
  html_text2()
commune_desc5

commune_desc6 <- commune_page %>% 
  html_element("p:nth-child(9)") %>% 
  html_text2()
commune_desc6

commune_desc[i] <- paste0(commune_desc1, 
                          " 1) ", commune_desc2, 
                          " 2) ", commune_desc3, 
                          " 3) ", commune_desc4, 
                          " ", commune_desc5, 
                          " ", commune_desc6)
commune_desc

i <- i + 1

###############################################################################
#Commune 41

url_var <- communes_links %>% slice(i)
commune_url <- paste0(url_var)
commune_page <- read_html(commune_url)

commune_desc1 <- commune_page %>% 
  html_element("p:nth-child(6)") %>% 
  html_text2()
commune_desc1

commune_desc2 <- commune_page %>% 
  html_element("p:nth-child(7)") %>% 
  html_text2()
commune_desc2

commune_desc[i] <- paste0(commune_desc1, 
                          " ", commune_desc2)
commune_desc

i <- i + 1

###############################################################################
#Commune 42

url_var <- communes_links %>% slice(i)
commune_url <- paste0(url_var)
commune_page <- read_html(commune_url)

commune_desc1 <- commune_page %>% 
  html_element("p:nth-child(7)") %>% 
  html_text2()
commune_desc1

commune_desc2 <- commune_page %>% 
  html_element("p:nth-child(8)") %>% 
  html_text2()
commune_desc2

commune_desc[i] <- paste0(commune_desc1, 
                          " ", commune_desc2)
commune_desc

i <- i + 1

###############################################################################
#Commune 43

url_var <- communes_links %>% slice(i)
commune_url <- paste0(url_var)
commune_page <- read_html(commune_url)

commune_desc1 <- commune_page %>% 
  html_element("p:nth-child(13)") %>% 
  html_text2()
commune_desc1

commune_desc2 <- commune_page %>% 
  html_element("p:nth-child(14)") %>% 
  html_text2()
commune_desc2

#Special case due to bullet points
commune_desc3 <- commune_page %>% 
  html_element("ul:nth-child(15) > li:nth-child(1)") %>% 
  html_text2()
commune_desc3

#Special case due to bullet points
commune_desc4 <- commune_page %>% 
  html_element("ul:nth-child(15) > li:nth-child(2)") %>% 
  html_text2()
commune_desc4

#Special case due to bullet points
commune_desc5 <- commune_page %>% 
  html_element("ul:nth-child(15) > li:nth-child(3)") %>% 
  html_text2()
commune_desc5

#Special case due to bullet points
commune_desc6 <- commune_page %>% 
  html_element("ul:nth-child(15) > li:nth-child(4)") %>% 
  html_text2()
commune_desc6

#Special case due to bullet points
commune_desc7 <- commune_page %>% 
  html_element("ul:nth-child(15) > li:nth-child(5)") %>% 
  html_text2()
commune_desc7

#Special case due to bullet points
commune_desc8 <- commune_page %>% 
  html_element("ul:nth-child(15) > li:nth-child(6)") %>% 
  html_text2()
commune_desc8

#Special case due to bullet points
commune_desc9 <- commune_page %>% 
  html_element("ul:nth-child(15) > li:nth-child(7)") %>% 
  html_text2()
commune_desc9

#Special case due to bullet points
commune_desc10 <- commune_page %>% 
  html_element("ul:nth-child(15) > li:nth-child(8)") %>% 
  html_text2()
commune_desc10

commune_desc11 <- commune_page %>% 
  html_element("p:nth-child(16)") %>% 
  html_text2()
commune_desc11

commune_desc12 <- commune_page %>% 
  html_element("p:nth-child(17)") %>% 
  html_text2()
commune_desc12

commune_desc13 <- commune_page %>% 
  html_element("p:nth-child(18)") %>% 
  html_text2()
commune_desc13

commune_desc[i] <- paste0(commune_desc1, 
                          " ", commune_desc2, 
                          " 1) ", commune_desc3, 
                          " 2) ", commune_desc4, 
                          " 3) ", commune_desc5, 
                          " 4) ", commune_desc6, 
                          " 5) ", commune_desc7, 
                          " 6) ", commune_desc8, 
                          " 7) ", commune_desc9, 
                          " 8) ", commune_desc10, 
                          " ", commune_desc11, 
                          " ", commune_desc12,
                          " ", commune_desc13)
commune_desc

i <- i + 1

###############################################################################
#Commune 44

url_var <- communes_links %>% slice(i)
commune_url <- paste0(url_var)
commune_page <- read_html(commune_url)

commune_desc1 <- commune_page %>% 
  html_element("p:nth-child(7)") %>% 
  html_text2()
commune_desc1

commune_desc2 <- commune_page %>% 
  html_element("p:nth-child(8)") %>% 
  html_text2()
commune_desc2

commune_desc3 <- commune_page %>% 
  html_element("p:nth-child(9)") %>% 
  html_text2()
commune_desc3

commune_desc[i] <- paste0(commune_desc1, 
                          " ", commune_desc2, 
                          " ", commune_desc3)
commune_desc

i <- i + 1

###############################################################################
#Commune 45

url_var <- communes_links %>% slice(i)
commune_url <- paste0(url_var)
commune_page <- read_html(commune_url)

commune_desc1 <- commune_page %>% 
  html_element("p:nth-child(13)") %>% 
  html_text2()
commune_desc1

commune_desc2 <- commune_page %>% 
  html_element("p:nth-child(14)") %>% 
  html_text2()
commune_desc2

commune_desc[i] <- paste0(commune_desc1, 
                          " ", commune_desc2)
commune_desc

i <- i + 1

#Save scraped commune descriptions in a data frame
commune_desc <- data.frame(matrix(unlist(commune_desc), nrow=45, byrow=TRUE),stringsAsFactors=FALSE)

###############################################################################
#Part 3: Scrape Commune Logos
###############################################################################
i <- 1

commune_logo <- list()

#Scrape logo for communes 1 to 34
for (i in 1:34) {
  url_var <- communes_links %>% slice(i)
  commune_url <- paste0(url_var)
  commune_page <- read_html(commune_url)
  
  commune_img <- commune_page %>%
    html_node(xpath = '//*[@id="mw-content-text"]/div[1]/table[1]/tbody/tr[3]/td/a/img') %>%
    html_attr('src')
  commune_img <- str_remove(commune_img, "//")
  
  commune_logo[i] <- paste0(commune_img)
}

#Scrape logo for commune 35
i <- 35
url_var <- communes_links %>% slice(i)
commune_url <- paste0(url_var)
commune_page <- read_html(commune_url)

commune_img <- commune_page %>%
  html_node(xpath = '//*[@id="mw-content-text"]/div[1]/table[1]/tbody/tr[2]/td/a/img') %>%
  html_attr('src')
commune_img <- str_remove(commune_img, "//")

commune_logo[i] <- paste0(commune_img)

#Scrape logo for communes 36 to 41
for (i in 36:41) {
  url_var <- communes_links %>% slice(i)
  commune_url <- paste0(url_var)
  commune_page <- read_html(commune_url)
  
  commune_img <- commune_page %>%
    html_node(xpath = '//*[@id="mw-content-text"]/div[1]/table[1]/tbody/tr[3]/td/a/img') %>%
    html_attr('src')
  commune_img <- str_remove(commune_img, "//")
  
  commune_logo[i] <- paste0(commune_img)
}

#Scrape logo for commune 42
i <- 42
url_var <- communes_links %>% slice(i)
commune_url <- paste0(url_var)
commune_page <- read_html(commune_url)

commune_img <- commune_page %>%
  html_node(xpath = '//*[@id="mw-content-text"]/div[1]/table[1]/tbody/tr[2]/td/a/img') %>%
  html_attr('src')
commune_img <- str_remove(commune_img, "//")

commune_logo[i] <- paste0(commune_img)

#Scrape logo for communes 43 to 45
for (i in 43:45) {
  url_var <- communes_links %>% slice(i)
  commune_url <- paste0(url_var)
  commune_page <- read_html(commune_url)
  
  commune_img <- commune_page %>%
    html_node(xpath = '//*[@id="mw-content-text"]/div[1]/table[1]/tbody/tr[3]/td/a/img') %>%
    html_attr('src')
  commune_img <- str_remove(commune_img, "//")
  
  commune_logo[i] <- paste0(commune_img)
}

#Save scraped commune logos in a data frame
commune_logo <- data.frame(matrix(unlist(commune_logo), nrow=45, byrow=TRUE),stringsAsFactors=FALSE)

###############################################################################
#Final touches
###############################################################################

#Merge commune_desc & commune_logo with communes_data
communes_data <- data.frame(communes_data, commune_desc, commune_logo)
names(communes_data)[6] <- "description"
names(communes_data)[7] <- "logo"
#View(communes_data)

communes_data$logo <- paste0("https://", communes_data$logo)

#Helps with the deeplr package
#deeplr::usage2(my_key)
#langs <- deeplr::available_languages2(my_key)
#as.data.frame(langs)

communes_data$description <- deeplr::translate2(
  text = communes_data$description,
  target_lang = "EN",
  auth_key = my_key)

#Save as .rda file
communes_data2 <- as.data.frame(communes_data)

save(communes_data2, file="MapApp/webscraping_websites/communes.Rda")
