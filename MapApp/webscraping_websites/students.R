#install.packages("rvest")
#install.packages("tidyverse")
#rm(list = ls()) 

library(rvest)
library(tidyverse)

#Specify the website
students_url <- read_html("https://www.students.ch/fr/logement/list/41")

#Get table with housing data
students_table <- students_url %>% 
  html_element(xpath = '//*[@id="col3_content"]/div/table') %>%
  html_table()

#Gets rid of empty & unwanted columns
students_table$'' <- NULL
students_table$Superficie <- NULL

#Rename columns
names(students_table)[1] <- "desc"
names(students_table)[2] <- "lieu"
names(students_table)[3] <- "date"
names(students_table)[4] <- "prix"

#Get links of housing
students_links <- students_url %>%
  html_nodes("td:nth-child(2) a") %>%
  html_attr("href")

#Combine students_table & students_links into one data frame
students_data <- data.frame(students_table, link = students_links)

#fix links to full ones
students_data$link <- paste0("https://www.students.ch", students_data$link)

#Reorder the columns of the data frame
students_data <- students_data[,c(1,4,2,3,5)]

#see the data
#view(students_data)

students_data2 <- as.data.frame(students_data)

save(students_data2,file="MapApp/webscraping_websites/students.Rda")
