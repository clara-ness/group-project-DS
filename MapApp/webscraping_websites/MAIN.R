#rm(list = ls())

#Call all the files to scrape from the websites
source("MapApp/webscraping_websites/annibis2.R")
source("MapApp/webscraping_websites/colocataire_v2.R")
source("MapApp/webscraping_websites/comparis.r")
source("MapApp/webscraping_websites/Petites Annonces.R")
source("MapApp/webscraping_websites/realadvisor.r")
source("MapApp/webscraping_websites/roomlala.R")
source("MapApp/webscraping_websites/sharehome.R")
source("MapApp/webscraping_websites/Students.R")
source("MapApp/webscraping_websites/tutti.r")
source("MapApp/webscraping_websites/amanet.R")

#Save all rda files as one
source("MapApp/webscraping_websites/merge.R")